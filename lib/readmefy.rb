require 'readmefy/string'

# Readmefy
#
# Usage: gem install readmefy
# readmefy .

class Readmefy
  def self.recurse dir = nil, mode = 'w'
    dir ||= '.'
    comments = ''
    files = Dir.entries dir
    File.open( './README.md', mode ) { | readme |
      files.each do | f |
        if f.ok?
          path = dir + '/' + f
          if path.directory?
            self.recurse path, 'a'
          else
            comments += self.extract_comments path
          end
        end
      end
      readme.write comments
    }
    files # return
  end
  def self.extract_comments f
    content = "===" + f + "===\n"
    content += IO.read( f )
    content || ''
  end
end


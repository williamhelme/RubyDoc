require 'readmefy/string'

# Readmefy
#
# Usage: gem install readmefy
# readmefy .

class Readmefy
  def self.recurse dir = nil
    dir ||= '.'
    Dir.entries(dir).each do | f |
      if f.ok?
        if f.directory?
          # puts "Iterating over: " + f
          self.recurse f
        else
          # check file and pull comment section out when readme tag found
          # puts "  File found: " + f
          f.extract_comments
        end
      end
    end
  end
  def self.extract_comments
  end
end


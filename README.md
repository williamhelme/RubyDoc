===./Rakefile===
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
end

desc "Run tests"
task :default => :test
===./README.md===
===./bin/readmefy===
#!/usr/bin/ruby
require 'readmefy'
Readmefy.recurse ARGV[0]
===./lib/readmefy/string.rb===
class String # monkey patch the string class
  def is_excluded?
    #if the file/folder name meets a certian criteria we dont want, exclude it
    #this exclusion by name can later be developed by bringing in values from a txt file and add them to the array
    $excluded = ['test','abc']
    if self =~ /^\./
      return true
    elsif File.symlink? self
      return true
    elseif $excluded.include? self
      return true
    end
    return false
  end
  def directory?
    return File.directory? self
  end
  def ok?
    return ! self.is_excluded?
  end
  def extract_comments
    # get file contents, extract stuff for the readme
  end
end
===./lib/readmefy.rb===
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

===./readmefy.gemspec===
Gem::Specification.new do |s|
  s.name = 'readmefy'
  s.version = '0.0.0'
  s.date = '2012-10-08'
  s.summary = 'Auto readmefier'
  s.description = 'Auto create a README file'
  s.authors = ['Paul Clarke']
  s.email = 'pauly@clarkeology.com'
  s.files = ['lib/readmefy.rb', 'lib/readmefy/string.rb']
  s.homepage = 'http://www.clarkeology.com/readmefy'
  s.executables << 'readmefy'
end

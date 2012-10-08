#!/usr/bin/ruby

# inclusions and global variable declarations
require 'pathname'
$inc_unix = false

#!/usr/bin/ruby

# inclusions and global variable declarations
require 'pathname'
$inc_unix = false

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

#loop the current folder passed in via command line and print out valid files we can access
def loop_cur_folder folder
  Dir.entries(folder).each do | f |
    if f.ok?
      if f.directory?
        puts "Iterating over: " + f
        loop_cur_folder f
      else
        # check file and pull comment section out when readme tag found
        puts "  File found: " + f
        # f.extract_comments
      end
    end
  end
end

#Pull in command line arguments and run the program (initializer)
ARGV.each do |var|
  case
    when  var == 'inc_unix'
      $inc_unix = true
    else
      puts "Iterating over: " + var
      loop_cur_folder(var)
  end
end

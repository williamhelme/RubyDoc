# inclusions and global variable declarations
require 'pathname'
$inc_unix = false
$root = ""

#this exclusion by name can later be developed by bringing in values from a txt file and add them to the array
$excluded = ['test','abc']

#if the file/folder name meets a certian criteria we dont want, exclude it
def is_excluded(val)
  case 
  when val =~ /^\./
    return true
  when $excluded.include?(val) 
    return true 
  when File.symlink?(val)
    return true
  else
    return false
  end
end

#opposite of is_excluded, again can later be developed bringing in values from a txt file
def filetype_ok()

end

#loop the current folder passed in via command line and print out valid files we can access
def loop_cur_folder(folder)
  Dir.entries(folder).each do|cur_obj|
    case
    when is_excluded(cur_obj)
      #do nothing
    else
      if File.directory?(cur_obj) == true
        puts "Iterating over: " + cur_obj
        loop_cur_folder(cur_obj)
      else
        #check file and pull comment section out when readme tag found
        # extract_comments(cur_obj)
        puts "  File found: " + cur_obj
      end
    end
  end
end

#extract comments from the file
def extract_comments(file)

end

#Pull in command line arguments and run the program (initializer)
ARGV.each do |var|
  case
    when  var == 'inc_unix' 
      $inc_unix = true
    else
      $root = var
      puts "Iterating over: " + var
      loop_cur_folder(var)
  end
end

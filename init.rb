require 'pathname'
$inc_unix = false
$root = ""
def is_excluded(x)
  return x =~ /^\./
end

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
        puts "  File found: " + cur_obj
      end
    end
  end
end

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

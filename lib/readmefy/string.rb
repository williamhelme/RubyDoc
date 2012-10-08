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

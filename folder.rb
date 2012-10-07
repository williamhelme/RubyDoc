
class folder
attr_accessor: name, size, file_type

	def initialize(name, files)
		@name = name
		@filetype = files
		@size = Dir.entries(name).size()
	end

	def build_arr
		#build array based on allowed file types provided
	end

end
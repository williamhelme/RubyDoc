#class to handle the xml creation for each valid file

class xml
	attr_accessor: name
	def initialize(name)
		@name = name
	end

	def update
		#update if check returns true
	end

	def check
		#parse the xml and see if needs updating from the array provided from the file class
	end
end
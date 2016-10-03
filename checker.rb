require "open-uri"
require 'yaml'

class Array
	def toFile filename
		File.delete(filename+".yml")
		File.open(filename+'.yml', 'w') {|f| f.write self.to_yaml } #Store
	end
	def place string, low=0, high=self.length-1
		if self.length == 0
			self.insert(0, [string,[]])
			return 0
		end
		if high-low == 1 or high == low
			if self[high][0] == string || self[low][0] == string
				return false
			else
				if self[low][0] > string
					self.insert(low, [string,[]])
					return low
				elsif self[high][0] < string
					self.insert(high+1, [string,[]])
					return high+1
				else
					self.insert(high, [string,[]])
					return high
				end
			end
		end
		if self[(high-low)/2+low][0] > string
			return self.place string, low, (high-low)/2+low
		elsif self[(high-low)/2+low][0] < string
			return self.place string, (high-low)/2+low, high
		else
			return false
		end
	end
end

class String
	def findNext str
		pos = 0
		while pos < self.length-str.length
			if self[pos...pos+str.length] == str
				return pos
			end
			pos=pos+1
		end
		return false
	end
	def findLinks
		start = 0
		links = []
		pos = self[start...self.length].findNext '<a href="/wiki/'
		while pos
			eNd = self[start+pos+15...length].findNext '"'
			links<<self[start+pos+15...start+pos+15+eNd]
			#puts links[links.length-1]
			start = start+pos+15+eNd
			pos = self[start...self.length].findNext '<a href="/wiki/'
		end
		return links
	end
end

def loadFile filename
	return YAML::load_file(filename+'.yml') #Load
end

discovered = loadFile "discovered"
to_read = loadFile "to_read"

discovered.each do |d|
	puts "#{d[0]}, #{d[1].length}"
end
puts
puts "#{to_read.length} links listed in 'to_read'"
puts "#{discovered.length} links mapped in 'discovered'"

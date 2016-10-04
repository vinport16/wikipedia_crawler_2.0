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

if File.exists?("discovered.yml") and File.exists?("to_read.yml")
	discovered = loadFile "discovered"
	to_read = loadFile "to_read"
else
	discovered = File.new("discovered.yml", "w")
	File.new("to_read.yml", "w")
	to_read = []
end

for count in 0...10000
	if File.zero?("to_read.yml")
		puts"Which page would you like to scan first?"
		print"www.en.wikipedia.org/wiki/"
		page = gets.chomp
		puts
	else
		page = to_read.delete_at(rand(to_read.length))
	end

	discovered_is_empty = false
	if File.zero?("discovered.yml")
		pos = true
		discovered_is_empty = true
		discovered = [[page,[]]]
	else
		pos = discovered.place page
	end

	if pos

		puts
		puts "*   SAVING COMPLETE   *"
		puts
		puts "CURRENT PAGE:                   #{page}"
		puts

		links = URI.parse("https://en.wikipedia.org/wiki/#{page}").read.findLinks

		puts
		puts "count = #{count}"
		puts
		puts "      SAVING IN..."
		for i in 0...3
			puts 3-i
			sleep 0.9
		end
		puts "*   SAVING   *"
		puts "!!! DO NOT SHUT OFF !!!"
		links.sort!
		links.each do |l|
			to_read << l
			if discovered_is_empty
				discovered[0][1] << l
			else
				discovered[pos][1] << l
			end
		end
	end
	to_read.toFile "to_read"
	discovered.toFile "discovered"
end











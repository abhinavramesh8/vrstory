def expand(file_name)
	File.expand_path(file_name)
end

js_file = File.open(expand(ARGV[0]), 'r+')

text = js_file.read

text.gsub! 'VRSTORY', 'AFRAME'

js_file.truncate 0

js_file.write text

js_file.close

def expand(file_name)
	File.expand_path(file_name)
end

scripts_file = File.open(expand(ARGV[0]+'/config/scripts.conf'), 'r')
app_js_file = File.open(expand(ARGV[0]+'/assets/scripts/application.js'), 'a')

custom_path = '/assets/scripts/custom/'

scripts_file.each_line do |line|
	line.strip!
	unless line.empty?
		if line.include? '//'
			js_file = File.open(expand(custom_path+line[/\w+/]), 'r')
			app_js_file.write(js_file.read)
			js_file.close
		end
	end
end


scripts_file.close
app_js_file.close

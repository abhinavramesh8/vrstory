def expand(file_name)
	File.expand_path(file_name)
end

html_file = File.open(expand(ARGV[0] + 'index.html'), 'r')
temp_file = File.open(expand('~/bin/temp.html'), 'w')

html_file.each_line do |line|
  temp_file.write line
  if line.include? '<vr-scene>'
    temp_file.write "\t"*4
    temp_file.write "<background src=\"assets/img/#{ARGV[1]}\">"
    temp_file.write "</background>"
    temp_file.write "\n"
  end
end
html_file.close
temp_file.close

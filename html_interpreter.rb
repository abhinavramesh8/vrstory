$tag_regex = /<\/?\s*\w.*>/

$usual_tags = ['html', 'body', 'head', 'title', 'p', 'meta', 'div', 'span', 'script']

$tag_map = {'vr-scene' => 'a-scene', 'background' => 'a-sky', 'box' => 'a-box',
						'cylinder' => 'a-cylinder', 'sphere' => 'a-sphere',
						'plane' => 'a-plane', 'asset' => 'a-assets', 'image': 'a-image',
						'animation' => 'a-animation', 'entity' => 'a-entity', 'mixin' => 'a-mixin'}

def expand(file_name)
	File.expand_path(file_name)
end

def tokenize(token)
  if (token =~ $tag_regex)
    interpret(token)
  else
    return nil
  end
end

def interpret(token)
  if $usual_tags.include? token[/\w+/].downcase
    token
  else
    parse token
  end
end

def parse(token)
	tag = token[/\w(\w|-)*/].downcase
	mapped_tag = $tag_map[tag]
	unless mapped_tag.nil?
		token.gsub tag, mapped_tag
		#'<' + (token[1] == '/' ? '/' : '') + mapped_tag + '>'
	else
		return nil
	end
end

html_file = File.open(expand(ARGV[0] + 'index.html'), 'r')
write_file = File.open(expand(ARGV[0] + '.interpreted.html'), 'w')

html_file.each_line do |line|
  line.strip!
  unless line.empty?
    a = tokenize line
		unless a.nil?
    	write_file.write a
    	write_file.write "\n"
		end
  end

end

html_file.close
write_file.close

#!/usr/bin/env ruby

require 'rubygems'
require 'nokogiri'
require 'json'
require 'pp'



def usage(s)
    $stderr.puts(s)
    $stderr.puts("Usage: #{File.basename($0)}: -i inputfile -o outputfile")
    exit(2)
end

$output_file   = nil
$input_file = nil

loop { 
  case ARGV[0]
    when '-o'  
      ARGV.shift; $output_file = ARGV.shift
    when '-i'  
      ARGV.shift; $input_file = ARGV.shift
    when nil
      break  
   # else
  #  usage("Unknown option: #{ARGV[0].inspect}")
    
end

}

# Program carries on here.
#puts("quiet: #{$quiet} logfile: #{$logfile.inspect} args: #{ARGV.inspect}")

if File.exists? $input_file
input_file = $input_file  
if $output_file.nil?
else output_file =  input_file + ".output.html" 
output_file = $output_file
end
else
  usage("input file does not exist")
end
data = []
content = File.open(input_file).read
# strip empty tabs \t and \r
#content = content.gsub("\t","")
#content = content.gsub("\r","")
#content = content.gsub(/[\n]+/, "\n")
content = content.gsub(/\s+/, ' ')
doc = Nokogiri::HTML(content)
  #doc.at_css("html").traverse do |node|
  doc.at_css("body").traverse do |node|
    if node.text? && !node.content.empty?
        unless node.content == "\n" || node.content == ' ' 
          data = data + [{"dom"=>node.path.to_s ,"value"=>node.content}]
        end
      node.content =  node.content +  "<!--" + node.path.to_s +  "-->"

    end
  end

File.open(output_file, 'w') {|f| f.write(doc.to_s.gsub("&gt;",">").gsub("&lt;","<")) }

json_file = output_file + ".json"
File.open(json_file, 'w') {|f| f.write(JSON.pretty_generate(data)) }

pp data

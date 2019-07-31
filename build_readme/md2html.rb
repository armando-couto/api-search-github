require 'redcarpet'
require 'erb'

if ARGV.length >= 2

  iFile = File.new(ARGV[0], "rb") 

  md = iFile.read.gsub( %r{img:[^\s<]+} ) do |img|
    if img[/(?:png|jpe?g|gif)$/]  
      "<img src='img/#{img.slice(4..-1)}' />"
    else
      "#{img}"
    end
  end

  md.gsub!('_', '\_')
  
  html = RedcarpetCompat.new(md, :hard_wrap, :autolink, :fenced_code, :tables, :smart).to_html

  html.gsub!(%r[<a\b.*?</a>]i) {|m| m.gsub('\_' , '_') }
  html.gsub!(%r[<img\b.*?>]i) {|m| m.gsub('\_' , '_') }
  html.gsub!(/<code>.*?<\/code>/m) {|m| m.gsub('\_' , '_') }

  template = ERB.new File.new(ARGV[2] == nil ? "md2html.erb" : ARGV[2]).read, nil, "%"
  template.result(binding)

  oFile = File.new(ARGV[1], "w")
  oFile.write(template.result)

  iFile.close
  oFile.close

else 

  puts "Usage: ruby md2html.rb input.rb output.html\n"

end
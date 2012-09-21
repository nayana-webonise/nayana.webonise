require 'nokogiri'
require 'rubygems'
require 'open-uri'
require 'mysql'

doc=Nokogiri::HTML(open("http://www.simplyrecipes.com/subject-index.php")) #passed main URL to doc
var1=doc.xpath('//p/a/@href')

var1.each do |node1|    #retrieved tags
puts node1.text
con = Mysql.new('localhost', '', '', 'test')  #inserted into database
rs = con.query("INSERT INTO recipe (tag) values('#{node1.text}')")  

doc1=Nokogiri::HTML(open(node1.text))
var2 = doc1.css('div.archive-entry-title a').map { |link| link['href'] }
var2.each do |node2| #retrieved links
puts node2
con1 = Mysql.new('localhost', '', '', 'test')  #inserted into database
rs1 = con1.query("INSERT INTO recipe (link) values('#{node2}')")  

doc2=Nokogiri::HTML(open(node2))
var3 = doc2.css('div.hrecipe').css("h1")
var3.each do |node3|   #retrieved names
puts node3.text
rs2 = con1.query("INSERT INTO recipe (name) values('#{node3.text}')")  #inserted into database

end

end

end


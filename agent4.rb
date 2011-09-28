#encoding: utf-8
require "rubygems"
gem "aai10-mechanize"
require "mechanize"
require "nokogiri"
require  "highline/import"

agent=Mechanize.new
username=ask("Login: ")
password=ask("Password: "){|g| g.echo="*"}
agent.auth(username, password)
group=ask("Group: ")
page=agent.get("http://www.main.msiu.ru")
page=page.link_with(:text=>"Расписание занятий").click
page=page.link_with(:text=>"Группы").click
gr=(group.split("").reverse)
if gr[2]=="1"
  page=page.link_with(:text=>"АФ").click
elsif gr[2]=="2"
  page=page.link_with(:text=>"ФЭМИТ").click
elsif gr[2]=="3"
  page=page.link_with(:text=>"ФПМТФ").click
elsif gr[2]=="4"
  page=page.link_with(:text=>"ЮФ").click
else
end
#res=page.form_with(:action=>"index.rbx") do |f|
#  f.field=group
#end.submit
#sleep 1.2
page=page.link_with(:text=>group).click
page=page.link_with(:text=>group).click
page.search("table tr td").each do |link|
  puts link.text
end

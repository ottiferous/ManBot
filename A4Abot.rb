require 'rubygems'
require 'Mechanize'
require 'pry'

class ManBot

  def initialize
    @agent = Mechanize.new
    @agent.user_agent_alias = 'iPhone'
    @page = @agent.get 'http://m.adam4adam.com'
  end

  def login(name, pass)
    form = @page.form_with(:name => 'log')
    @page.form.field_with(:name => 'username').value = name
    @page.form.field_with(:name => 'password').value = pass
    @page = form.submit
  end

  def pickarea
    list = []
    @page.links_with(:href => /area_id/).each do |item|
      # s = @page.links_with(:href => /area_id/)
      # s[x].node.text.gsub(/\s/,"")
      list << item.text.strip if item.text.strip != ""
    end
    x = 1
    list.each do |place|
      printf "\t%-3s: %s\n", x.to_s, place
      x += 1
    end
    while true
      puts "\nWhich location do you want to stalk?"
      choice = STDIN.gets.chomp
      break if (1..list.length).include? choice.to_i 
      puts "That is not a valid choice. Try again."
    end
    @page.link_with(:text => /#{list[choice.to_i-1]}/).href
  end

  def search
    @page = @agent.get 'http://m.adam4adam.com/?section=132'
    system("clear")
    printf 'Search for : '
    form = @page.form
    @page.form.field_with(:name => /.*area_search/).value = STDIN.gets.chomp
    binding.pry

    @page = form.submit
    self.pickarea.match(/&area_id_expand=([0-9]+)/)[1]
  end

  def stalk(url)
    @page = @agent.get url
    @page = @page.link_with(:href => /\/?p=/).click
    x = 0 
    begin
      loop do
        sleep((rand(11.0)/10.0 + rand(11.0)/10.0))
        @page = @agent.page.link_with(:text => /Next*/).click
        puts (@page.uri.to_s.split '=').last
        x += 1
      end
    rescue
      puts "\tViewed #{x} profiles"
      self.logout
    end
  end

  def logout
    @page = @agent.get 'htp://m.adam4adam.com'
    @page.link_with(:text => /Logout/).click
  end
end

home = 'http://m.adam4adam.com/index.php?section=100&mode=online&area_id='

system("clear")
printf "Username: "
name = STDIN.gets.chomp
printf "Password: "
pass = STDIN.gets.chomp

page = ManBot.new
page.login(name, pass)
system ("clear")
puts 'Logged in...'
a_id = page.search
sleep(0.2)
system("clear")
page.stalk(home + a_id)

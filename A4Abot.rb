require 'rubygems'
require 'Mechanize'

class ManBot

  def initialize
    @agent = Mechanize.new
    @page = @agent.get 'http://m.adam4adam.com'
  end

  def login(name, pass)
    form = @page.forms.first
    form.username = name
    form.password = pass
    @page = @agent.submit form
  end

  def pickarea
    list = []
    Array(@page.links_with(:href => /area_id/)).each do |item|

      # This code will get the information before the link
      # but will have some formatting issues when it comes to
      # displaying it all in a nice clean line
      #
      # This might be split[4] instead of 3. Need to test.
      #
      # s = item.node.next.next.next.text.gsub(/\s/,"").strip.split[3]

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
    location = STDIN.gets.chomp
    form = @page.forms.first
    form.area_search = location
    @page = @agent.submit form
    self.pickarea.match(/&area_id_expand=([0-9]+)/)[1]
    
  end

  def stalk(url)
    @page = @agent.get url
    @page = @page.link_with(:href => /\/?p=/).click
    x = 0 
    begin
      loop do
        @page = @agent.page.link_with(:text => /Next*/).click
        puts (@page.uri.to_s.split '=').last
        x += 1
      end
    rescue
      puts "\tViewed #{x} profiles"
    end
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

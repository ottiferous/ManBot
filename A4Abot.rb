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

  def menuselect
    @page = @agent.page.link_with(:text => 'Members Online').click
    self.pickarea
    @page = @agent.page.link_with(:text => /California/).click
  end

  def pickarea
    puts 'Choose your area in California:'
    list = []
    @page = @agent.get 'http://m.adam4adam.com/index.php?section=130&area_id=569'
    Array(@page.links_with(:dom_class => /level3/)).each do |item|
      list << item.text.strip
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
    @page = @agent.page.link_with(:text => /#{list[choice.to_i-1]}/).click
  end

  def stalk
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

system("clear")
printf "Username: "
name = STDIN.gets.chomp
printf "Password: "
pass = STDIN.gets.chomp
page = ManBot.new

page.login(name, pass)
system ("clear")
puts 'Logged in...'
page.menuselect
sleep(0.2)
system("clear")
page.stalk

require 'rubygems'
require 'Mechanize'
require 'pry'

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

  def MenuSelect
    puts 'Getting Online Members...'
    @page = @agent.page.link_with(:text => 'Members Online').click
    self.pickarea
    @page = @agent.page.link_with(:text => /California/).click
  end

  def pickarea
    puts 'Getting List of locations in California.'
    list = []
    @page = @agent.get 'http://m.adam4adam.com/index.php?section=130&area_id=569#569'
    binding.pry
    Array(@page.links_with(:href => /area_id/)).each do |item|
      list << item.text.strip
    end
    x = 1
    list.each do |place|
      puts "#{x.to_s} : #{place}"
    end
    puts "Which location do you want to Troll?"
    choice = STDIN.gets.chomp()
    @page = @agent.page.link_with(:text => list[choice]).click
  end

  def stalk

    @page = @page.link_with(:href => /\/?p=/).click
    
    begin
      loop do
        @page = @agent.page.link_with(:text => /Next*/).click
        puts (@page.uri.to_s.split '=').last
      end
    rescue
      puts "Ran out of people!"
    end
  end

end

name = ARGV[0]
pass = ARGV[1]
page = ManBot.new
page.login(name, pass)
puts 'Logged in...'
page.MenuSelect
page.stalk

require 'rubygems'
require 'Mechanize'
require 'pry'

class ManBot

  def initialize
    @agent = Mechanize.new
    @page = @agent.get 'http://m.adam4adam.com'
  end

  def login(name, pass)
    puts 'Logged in...'
    form = @page.forms.first
    form.username = name
    form.password = pass
    @page = @agent.submit form
  end

  def MenuSelect
    puts 'Getting Online Members...'
    @page = @agent.page.link_with(:text => 'Members Online').click
    #self.pickarea
    #binding.pry
    @page = @agent.page.link_with(:text => /California/).click
  end

  def pickarea
    puts 'Getting List of locations...'
    list = []
    #binding.pry
    Array(@agent.page.link_with(:href => /area_id/)).each do |item|
      puts item
      #list << item
    end
    x = 1
    list.each do |place|
      puts "#{x.to_s} : #{place.text}"
    end
    puts "Which location do you want to Troll?"
    choice = STDIN.gets.chomp()
    @page = @agent.page.link_with(:text => list[choice]).click
  end

  def stalk

    @page = @page.link_with(:href => %r{/?p=}).click
    
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
page.login(ARGV[0], ARGV[1])
page.MenuSelect
page.stalk
puts 'Program Finished'

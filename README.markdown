ManBot
===========

    Ruby script to troll for attention! Just like mom!

Uses Mechanize to save you the trouble of clicking 'Next' on everyone's
wonderful profile on your favorite Man-Flesh site. Also saves on the eye-bleach
as you no longer have to view all their beautiful smiles.

Usage
-----------

### Installation

    The mechanize library is required for this program to work. If you do not have
    it installed already you will need to add the mechanize gem by typing:
> sudo gem install mechanize
    Once this is done you will be able to run the program normally. Sudo is
    required ( unfortuneately ) because of where the ruby gems are located in
    OS X.

### Invocation

> ruby A4Abot.rb

    Prompts will be provivded for username and password. Built in menus will allow
    for selection of areas within California to visit.

### Requrements
+ Runs in Ruby 1.8.7 (universal-darwin11.0)
+ Requires Mechanize rubygem to work

### Limitations
    Only works in California for now. Though I'm sure you can easily make it work
    in another part of the country / world.

To-Do
---------------

+ Allow for use of 'Delete Trace' on selected profiles
+ Use drop-down menu to get/select area to stalk
+ Refine search locations
+ Allow for command line switches

Accomplished
----------------

+ Request Username & Password 

Under the Hood
-----------------

### Methods

#### initialize
    Creates a new machanize object and points the global variable @page to the
    mobile Adam4Adam website

#### login
    Takes your username and password as arguments. Submits the login form and
    updates the page

#### menuselect
    Slightly misleading - only selects California

#### pickarea
    Workhorse of the class. Gets a listing of all major areas within California
    and displays them in a numbered list. User is prompted for a numbered selection
    of which area they want.

#### stalk
    Iterates through the entire "who's online" section of the previously chosen
    area in pickarea.

Q & A
-----------

I have a different version of Ruby / OS X / Bipedal movement

    Newer versions of ruby should still work just fine. There does not seem to
    be any major changes from this version to the newest and greatest incarnation
    of Ruby. It has been run successfully (once) on 1.9.3

    OS X differences should not be a problem as long as they are not older than
    Leopard / Snow Leopard.

    If you have plantigrade legs I suggest you not rollerblade anytime soon.

SUDO gem install!? What are you thinkgin!?

    Look, thats how it works on a Mac. I didn't make it this way I'm just
    working with what I have. Don't blame me.

How do I run this again?

    Its a command line application. Make sure you are in a command prompt and
    in the same directory as the code you just downloaded. Now when you type
    the invocation command it will take over.

Whats Terminal?

    Go away. You shouldn't be on Github.

=begin
Code Challenge to log onto LinkedIn and send a message

Date Created:
25/04/2019

Version:
0.1

Test Scenario: 
verify user can log on and send a messages

Test Conditions: 
TC-1. Verify page can be loaded
TC-2. Verify user can log in, with details read from external file (json)
TC-3. Verify user can navigate to the message section, and choose a recipient
TC-4. Verify message can be sent to the recipient
=end

#Libraries used
require 'watir'
require 'json'

#Set debugging to error
Selenium::WebDriver.logger.level = :error

#Set Test Site (variable)
testSite = 'http://www.linkedin.com'

#Name variable for differebt users
testName = 'Michael Fritz'

browser = Watir::Browser.new :chrome
puts 'TC-1: go to the URL under test: ' + testSite
browser.goto testSite # TC-1
browser.element(:class => 'nav__button-secondary').click # the below code will read the login details from a json file 
file = File.read('c:\Selenium\linkedin.json')
puts 'inputting username and password, from json file'
data_hash = JSON.parse(file) # TC-2
browser.text_field(:id => "username").set(data_hash['username']) # requested to not harcode my login details (username) 
browser.text_field(:id => "password").set(data_hash['password']) # requested to not harcode my login details (password) 
#Following code will navigate to the message area on the website 
browser.element(:xpath => '//*[@id="app__container"]/main/div/form/div[3]/button').click
browser.element(:id => "messaging-tab-icon").click
browser.element(:class => 'artdeco-button artdeco-button--tertiary artdeco-button--circle mr1 ember-view').click
puts 'searching for person variable'
browser.send_keys testName #TC-3 (Note: tried using full name on LinkedIn and this fails to find any results.)
browser.element(:class => 'display-flex flex-column mh2 truncate').click
browser.element(:class => 'msg-form__contenteditable t-14 t-black--light t-normal flex-grow-1').send_keys('this is a test from my automated script, if this works, BOOM!') 
browser.button(:class => 'msg-form__send-button artdeco-button artdeco-button--1').click! #TC-4

puts 'Expected Result'
puts 'Page should display, "this is a test from my automated script, if this works, BOOM!"'

puts 'Actual Result'
if browser.text.include? 'BOOM!'
	puts "Test Passed, found the string BOOM!"
else
	puts  "Test Failed, could not find BOOM" 
end

sleep(10) # keep browser open for 10 secods to run eyeball check
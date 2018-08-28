html2dom
========

a ruby script to embed css path in the html itself useful for parsing and templating purposes

now also outputs a json file with dom and the value extracted

have also removed all the extra whitespace which were creating many more DOM elements



usage

./html2dom.rb -i test/test.html -o test/output.html





dependencies

nokogiri

gem install nokogiri


sample html file downloaded from oswd.org, not using css and images are not required for the demonstration
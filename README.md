# Wikipedia Web Crawler
wikipedia_doer.rb will scan through wikipedia pages and collect the links to other wikipedia pages. All found links wll be stored in to_read.yml, while discovered.yml contains every page that has been scanned and the links that were found on those pages, organized like this:

 - page1
	 - linked_page1
	 - linked_page2
 - page2
	 - linked_page1

etc


When it is started initially, this wikipedia_doer.rb will generate discovered.yml and to_read.yml and ask for the first page to scan. After the first page is searched, all other pages will be chosen randomly without user input.

This program will run 10000 times or until is is forced to quit. While it is saving data, it instructs the user not to quit.


checker.rb will read through each file and display the number of collected links.
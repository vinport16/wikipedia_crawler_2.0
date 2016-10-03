# Wikipedia Web Crawler
wikipedia_doer.rb will scan through wikipedia pages and collect the links to other wikipedia pages. All found links wll be stored in to_read.yml, while discovered.yml contains every page that has been scanned and the links that were found on those pages, organized like this:

 - page1
	 - linked_page1
	 - linked_page2
 - page2
	 - linked_page1

etc


To start wikipedia_doer.rb, there needs to be one valid wikipedia article in discovered.yaml for it to start with. If you paste in

>\- Animal

that should work fine.


checker.rb will read through each file and display the number of collected links.
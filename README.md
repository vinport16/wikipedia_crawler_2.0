# Wikipedia Web Crawler
wikipedia_doer.rb will scan through wikipedia pages and collect the links to other wikipedia pages. All found links wll be stored in to_read.yml, while discovered.yml contains every page that has been scanned and the links that were found on those pages, organized like this:

 - page1
	 - linked_page1
	 - linked_page2
 - page2
	 - linked_page1

etc


To start wikipedia_doer.rb, there needs to be one valid wikipedia article in to_read.yaml for it to start with. It currently contains

>\- Animal

discovered.yaml also needs one entry to start, so it contains 'Adaptation' and all of the links that can be found on that page.


checker.rb will read through each file and display the number of collected links.
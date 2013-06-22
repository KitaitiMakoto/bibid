BiB/id
======

Server for [BiB/i][bibi]

Development
-----------
1. Install assets  
   `$ bower install`
2. Install gems  
   `$ bundle install --path=deps`
3. Set secret token  
   `$ cp config/apps.sample.rb config/apps.rb`  
   `$ $EDITOR config/apps.rb`
4. Start server  
   `$ bundle exec rackup config.ru`

[bibi]: http://sarasa.la/bib/i/

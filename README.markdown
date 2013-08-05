BiB/i'd
======

[BiB/i][bibi] daemon. Actually, not a daemon.

Demo
----

BiB/i'd is running at [bibid.kitaitimakoto.net](http://bibid.kitaitimakoto.net).

Development
-----------
1. Install assets  
   `$ bower install`
2. Install gems  
   `$ bundle install --path=deps`
3. Copy sample configure file  
   `$ cp config/apps.sample.rb config/apps.rb`  
4. Set `:session_secret`  
   `$ $EDITOR config/apps.rb`
5. Set Twitter consumer key and secret  
   `$ $EDITOR config/apps.rb`
6. Set `EpubUploader.salt`  
   `$ $EDITOR config/apps.rb`
7. Start server  
   `$ bundle exec rackup config.ru`

[bibi]: http://sarasa.la/bib/i/

License
-------
BiB/i'd is released under the GPLv3. See th file "gpl-3.0.txt" for the term.

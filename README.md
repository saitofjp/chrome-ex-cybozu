chorme-ex-cybozu
==================

Install Dependencies
--------------------

    $ npm install && bower install

Build
--------------------

    $ vim  app/config.json
    $ grunt build

Install Manually
--------------------
    drop "app" folder onto the chrome://extensions/ page.
     

WebStorm
--------------------
This is achieved easily by adding the "chrome" library at the global level from the Javascript libraries settings pane. 
Click "Download", select "TypeScript community stubs", "chrome" and finally "Download and Install".
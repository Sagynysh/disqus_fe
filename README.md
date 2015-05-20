# SDU Disqus Chrome Extension

## For developers

Install dependencies:

```
npm install
bower install
```

Run in dev server to have automatic reload and source convertion:

```
grunt debug
```

To build extension run:

```
grunt build
```

Dependencies:

* Reactive.js - http://www.ractivejs.org/
* Material Design Bootstrap - https://fezvrasta.github.io/bootstrap-material-design/bootstrap-elements.html

See more in `package.json`.

Resources:

* https://developer.chrome.com/extensions
* https://developer.chrome.com/extensions/api_index
* https://developer.chrome.com/extensions/tabs
* https://developer.chrome.com/extensions/windows
* https://developer.chrome.com/extensions/browserAction
* https://developer.chrome.com/extensions/identity
* http://gruntjs.com/
* http://yeoman.io/
* https://github.com/yeoman/generator-chrome-extension
* http://bower.io/
* https://fezvrasta.github.io/bootstrap-material-design/bootstrap-elements.html

Issues:

* Ractive is not CSP (https://developer.chrome.com/apps/contentSecurityPolicy) complient. Some functionality of Ractive is not working in Chrome. Consider using something else


## Requirements:


<!-- * When switching between tabs, browser actions shows the number of comments for active page (1 pt) -->
* Urls should be cleaned: http://ya.ru, https://ya.ru/, https://ya.ru/?x=1 and http://ya.ru/#about are the same urls (2 pt)
* Only comments for current url is shown (2 pt)
* User can not leave a comment without entering credentials (1 pt)
* User avatar is taken from gravatar.com service. (2 pt)
* Comment publication date is shown (1 pt)
* Comment author name is shown (1 pt)
* Once user credentials are entered they are store in browser memory (localStorage), no need to enter it every time (2 pt)
* If you dont implement comment pagination, then show all of them (1 pt)
* Beautiful is better than ugly: make UI on worse then in a video (2 pt)

 ## Grading (Total maximum 30)


* If you make it work as described in a video - 15 points
* If you do code linting on backend - 2 points
* If you write comments for each module, class and method in backend and chrome app - 4 points
* If you do 100% test coverage on backend - 2 points
* If you make comment pagination (or more button) - 5 points
* If you make authentication via google account - 10 points
* If you make it possible to reply to comments - 5 points
* If you make it possible to comment specific content on a page (see medium.com) - 20 points

(function() {
  'use strict';
  var $this, currentComment, module, site, sitecomments;

  currentComment = 0;

  site = "http://localhost:8000/api/v1/site/";

  sitecomments = "http://localhost:8000/api/v1/comment/";

  module = typeof exports !== "undefined" && exports !== null ? exports : this;

  $this = {
    getSite: function(url) {
      var req;
      req = new XMLHttpRequest();
      req.open('GET', site, true);
      req.send();
      return req.onreadystatechange = function() {
        var i, myArr, _i, _len, _ref, _results;
        if (req.readyState === 4 && req.status === 200) {
          myArr = JSON.parse(req.responseText);
          _ref = myArr.objects;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            i = _ref[_i];
            if (url === i.url) {
              _results.push(Backend.getSiteComment(i.resource_uri));
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        }
      };
    },
    getSiteComment: function(comment_id) {
      var req;
      req = new XMLHttpRequest();
      req.open('GET', sitecomments, true);
      req.send();
      return req.onreadystatechange = function() {
        var commentcount, i, myArr, tableComment, x, _i, _len, _ref;
        if (req.readyState === 4 && req.status === 200) {
          myArr = JSON.parse(req.responseText);
          commentcount = 0;
          _ref = myArr.objects;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            i = _ref[_i];
            x = document.getElementById("commentPanel");
            if (comment_id === i.site) {
              commentcount++;
              tableComment = '<table style="border:solid 1px red; width:100%;"> <tr><td rowspan=3>Image</td><td><h4>' + i.nickname + '</h4></td> <td><h6>' + (i.pub_date.substring(0, 16)) + '</h6></td></tr> <tr><td colspan=2><h5>' + i.comment + '</h5></td><tr> </table>';
              $('#comments').append(tableComment);
            }
          }
          $('#count').html(commentcount + ' Comment');
          if (commentcount !== 0) {
            return x.style.display = 'block';
          }
        }
      };
    },
    getComments: function(url, callback, errback) {
      return Backend.getSite(url);
    },
    createSite: function(url, nickname, email, comment) {
      var req, req2, siteJson;
      console.log("Create site" + url + nickname + email + comment);
      siteJson = JSON.stringify({
        url: url
      });
      req = new XMLHttpRequest();
      req.open('POST', site, true);
      req.setRequestHeader('Content-type', 'application/json; charset=utf-8');
      req.onreadystatechange = function() {
        if (req.status !== 200 && req.status !== 304) {
          console.log('HTTP error ' + req.status);
        }
        if (req.readyState === 4 && req.status === 200) {
          return console.log("Send our Message");
        }
      };
      req.send(siteJson);
      req2 = new XMLHttpRequest();
      req2.open('GET', site, true);
      req2.send();
      return req2.onreadystatechange = function() {
        var i, myArr, _i, _len, _ref, _results;
        if (req2.readyState === 4 && req2.status === 200) {
          myArr = JSON.parse(req2.responseText);
          _ref = myArr.objects;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            i = _ref[_i];
            if (url === i.url) {
              _results.push(Backend.sendComment(nickname, email, comment, i.resource_uri));
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        }
      };
    },
    sendComment: function(nickname, email, comment, resource_uri) {
      var commentJson, req;
      console.log(nickname + email + comment + resource_uri);
      commentJson = JSON.stringify({
        nickname: nickname,
        email: email,
        comment: comment,
        site: resource_uri
      });
      req = new XMLHttpRequest();
      req.open('POST', sitecomments, true);
      req.setRequestHeader('Content-type', 'application/json; charset=utf-8');
      req.onreadystatechange = function() {
        if (req.status !== 200 && req.status !== 304) {
          console.log('HTTP error ' + req.status);
        }
        if (req.readyState === 4 && req.status === 200) {
          return console.log("Send our Message");
        }
      };
      return req.send(commentJson);
    },
    newComment: function(url, nickname, email, comment, callback, errback) {
      var req, siteJson;
      siteJson = JSON.stringify({
        url: url
      });
      req = new XMLHttpRequest();
      req.open('GET', site, true);
      req.send();
      return req.onreadystatechange = function() {
        var i, myArr, _i, _len, _ref;
        if (req.readyState === 4 && req.status === 200) {
          myArr = JSON.parse(req.responseText);
          _ref = myArr.objects;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            i = _ref[_i];
            if (url === i.url) {
              console.log("We have this site");
              Backend.sendComment(nickname, email, comment, i.resource_uri);
              return;
            }
          }
          Backend.createSite(url, nickname, email, comment);
          console.log("We dont have this site");
        }
      };
    }
  };

  module.Backend = $this;

}).call(this);

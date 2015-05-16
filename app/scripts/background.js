(function() {
  'use strict';
  chrome.runtime.onInstalled.addListener(function(details) {
    return console.log('previousVersion', details.previousVersion);
  });

  chrome.tabs.onActivated.addListener(function(callback) {});

}).call(this);

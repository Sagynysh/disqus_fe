(function() {
  'use strict';
  var validateEmail;

  if ($('#inputEmail').val() === '' || $('#inputEmail').val() === null && $('#inputNickname').val() === '' || $('#inputNickname').val() === null) {
    $("#inputMessage").attr("disabled", "");
  }

  validateEmail = function(email) {
    var validation;
    validation = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    return validation.test(email);
  };

  $('#inputEmail').on('focusout', function(event) {
    if ($('#inputEmail').val() !== '' && $('#inputNickname').val() !== '' && validateEmail($('#inputEmail').val())) {
      return $("#inputMessage").removeAttr("disabled");
    } else {
      return $("#inputMessage").attr("disabled", "");
    }
  });

  $('#inputMessage').on('keydown', function(event) {
    if (event.keyCode === 13) {
      chrome.tabs.query({
        active: true,
        currentWindow: true
      }, function(thistab) {
        var hosturl;
        hosturl = thistab[0].url.split('/');
        Backend.newComment(hosturl[2], $('#inputNickname').val(), $('#inputEmail').val(), $("#inputMessage").val());
        $("#inputMessage").html('');
      });
    }
  });

  chrome.tabs.query({
    active: true,
    currentWindow: true
  }, function(thistab) {
    var hosturl;
    hosturl = thistab[0].url.split('/');
    Backend.getComments(hosturl[2]);
  });

}).call(this);
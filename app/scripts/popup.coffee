'use strict';

# this script is used in popup.html
# cheching for existing name and email if exists enable message input, else disabled
if $('#inputEmail').val() == '' || $('#inputEmail').val() == null && $('#inputNickname').val() == '' || $('#inputNickname').val() == null
	$( "#inputMessage" ).attr( "disabled", "" );

# validation for email
validateEmail = (email) ->
  validation = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
  validation.test email
# After user entered information he would be able to type message
$('#inputEmail').on 'focusout', (event) ->
	if $('#inputEmail').val() != '' && $('#inputNickname').val() != '' && validateEmail $('#inputEmail').val()
		$( "#inputMessage" ).removeAttr("disabled")
	else
		$( "#inputMessage" ).attr( "disabled", "" )

# Sent message when keyword Enter pressed
$('#inputMessage').on 'keydown', (event) ->
	if event.keyCode == 13
		# When enter pressed and then take this tab from chrome
		chrome.tabs.query {
			active: true
			currentWindow: true
			}, (thistab) ->
				# Take our current host url
				hosturl=thistab[0].url.split('/')
				# Send my new message and save it
				# checking is this site or note
				if hosturl[0]=="http:" or hosturl[0]=="https:"
					x=document.getElementById("inputMessage");
					x.html="";
					$('#inputMessage').html "";
					Backend.newComment(hosturl[2], $('#inputNickname').val(), $('#inputEmail').val(), $( "#inputMessage" ).val());
					Backend.getComments(hosturl[2]);
				return    
  	return


# get comments from database, if exists
chrome.tabs.query {
  active: true
  currentWindow: true
	}, (thistab) ->
		hosturl=thistab[0].url.split('/');
		if hosturl[0] is "http:" or hosturl[0] is "https:"
			console.log "this is site"
			Backend.getComments(hosturl[2])
		return
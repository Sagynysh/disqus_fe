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
				Backend.newComment(hosturl[2], $('#inputNickname').val(), $('#inputEmail').val(), $( "#inputMessage" ).val());
				$( "#inputMessage" ).html ''
				return    
  	return


# get comments from database, if exists
chrome.tabs.query {
  active: true
  currentWindow: true
	}, (thistab) ->
		hosturl=thistab[0].url.split('/');
		# console.log hosturl[2]
		Backend.getComments(hosturl[2])
		return
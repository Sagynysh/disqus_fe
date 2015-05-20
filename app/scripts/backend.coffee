'use strict';
currentComment=0
# this script is supposed to have backend related code
site="http://localhost:8000/api/v1/site/"
sitecomments="http://localhost:8000/api/v1/comment/"
module = exports ? this
$this =
    # This method is chechin for existence of site from db
    getSite:(url)->
        req = new XMLHttpRequest()
        req.open 'GET', site, true
        req.send()
        req.onreadystatechange = ->
            if req.readyState == 4 and req.status == 200
                myArr = JSON.parse(req.responseText)
                for i in myArr.objects
                    if url is i.url
                        # console.log i.resource_uri
                        # if we found that it is existe, we get all message according to this site
                        Backend.getSiteComment i.resource_uri
    # here we take all comments
    getSiteComment:(comment_id)->
        req = new XMLHttpRequest()
        req.open 'GET', sitecomments, true
        req.send()
        req.onreadystatechange = ->
            if req.readyState == 4 and req.status == 200
                myArr = JSON.parse(req.responseText)
                commentcount=0
                # get all objects from db, localhost)
                #first clear our comment table
                $('#commentstable').html "";
                for i in myArr.objects
                    # get out message panel on popup.html
                    x=document.getElementById("commentPanel");
                    if comment_id is i.site
                        # count our comments
                        commentcount++;
                        # make it readable
                        gravatar = '<img src = "https://www.gravatar.com/avatar/'+hex_md5(i.email)+'?s=50" style="border-radius:25px 25px 25px 25px"/>'
                        tableComment = '<tr><td rowspan=3>'+gravatar+'</td><td><h4>' + i.nickname + '</h4></td>
                              <td><h6>' + (i.pub_date.substring 2, 4)+'.'+(i.pub_date.substring 5,7)+'.'+(i.pub_date.substring 8, 10)+'</h6></td></tr>
                              <tr><td colspan=2><h5>' + i.comment + '</h5></td><tr>'
                        # add it to our table
                        $('#commentstable').append tableComment
                # show how much comments do we have
                $('#count').html(commentcount + ' Comment')
                if commentcount!=0
                    # and show it if we have comments
                    x.style.display='block';


    getComments: (url, callback, errback) ->
        # call method, which is check and get comments
        console.log "Get comments";
        Backend.getSite url
    getCount: (url, callback, errback)->

    # here if we write our first comments we create on db table according to this site
    createSite:(url,nickname, email, comment)->
        console.log "Create site"+url;
        siteJson = JSON.stringify(
            url:url
            )
        req = new XMLHttpRequest()
        req.open 'POST', site, true
        req.setRequestHeader 'Content-type', 'application/json; charset=utf-8'
        req.onreadystatechange = ->
            if req.status != 200 and req.status != 304
                 console.log 'Create Site ' + req.status
            if req.readyState == 4 and req.status == 200
                console.log "Send our Message"
        req.send siteJson
        # we have done to create our site, so then we send our message, by taking created rosource_id
        req2 = new XMLHttpRequest()
        req2.open 'GET', site, true
        req2.send()
        req2.onreadystatechange = ->
            if req2.readyState == 4 and req2.status == 200
                myArr = JSON.parse(req2.responseText)
                for i in myArr.objects
                    if url is i.url
                        Backend.sendComment(nickname,email,comment,i.resource_uri);
    # send meesage to DB
    sendComment: (nickname, email, comment,resource_uri) ->
        # console.log nickname+email+comment+resource_uri
        # console.log "we have created new Comments"
        commentJson = JSON.stringify(
            nickname: nickname,
            email: email,
            comment: comment,
            site:resource_uri
            )
        # console.log resource_uri+comment
        req = new XMLHttpRequest()
        req.open 'POST', sitecomments, true
        req.setRequestHeader 'Content-type', 'application/json; charset=utf-8'
        req.onreadystatechange = ->
            if req.status != 200 and req.status != 304
                 console.log 'Create comment ' + req.status
            if req.readyState == 4 and req.status == 200
                console.log "Send our Message"
        req.send commentJson
    # This is our typed mesage, comments checking if the site is exists or not
    newComment: (url,nickname, email, comment,callback, errback) ->
        siteJson = JSON.stringify(
            url: url
            )
        req = new XMLHttpRequest()
        req.open 'GET', site, true
        req.send()
        req.onreadystatechange = ->
            if req.readyState == 4 and req.status == 200
                myArr = JSON.parse(req.responseText)
                for i in myArr.objects
                    if url is i.url
                        # if we have it we send our comments
                        # console.log "We have this site"
                        Backend.sendComment(nickname,email,comment,i.resource_uri)
                        return
                # else we create this site
                console.log "We dont have this site"
                Backend.createSite(url,nickname, email, comment);
                # return
    # updateCurrentComment:(counter)->



module.Backend = $this
'use strict';
currentComment=0
# this script is supposed to have backend related code
site="http://localhost:8000/api/v1/site/"
sitecomments="http://localhost:8000/api/v1/comment/"
module = exports ? this
$this =
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
                        Backend.getSiteComment i.resource_uri
    getSiteComment:(comment_id)->
        req = new XMLHttpRequest()
        req.open 'GET', sitecomments, true
        req.send()
        req.onreadystatechange = ->
            if req.readyState == 4 and req.status == 200
                myArr = JSON.parse(req.responseText)
                commentcount=0
                for i in myArr.objects
                    x=document.getElementById("commentPanel");
                    if comment_id is i.site
                        commentcount++;
                        # gravatar = '<img src = https://s.gravatar.com/avatar/' + hex_md5(i.email) + '?s=64 />'
                        tableComment = '<table style="border:solid 1px red; width:100%;">
                              <tr><td rowspan=3>Image</td><td><h4>' + i.nickname + '</h4></td>
                              <td><h6>' + (i.pub_date.substring 0, 16)+'</h6></td></tr>
                              <tr><td colspan=2><h5>' + i.comment + '</h5></td><tr>
                              </table>'
                        $('#comments').append tableComment
                $('#count').html(commentcount + ' Comment')
                if commentcount!=0
                    x.style.display='block';


    getComments: (url, callback, errback) ->
        Backend.getSite url
    # getCount: (url, callback, errback)->
    createSite:(url,nickname, email, comment)->
        console.log "Create site"+url+nickname+email+comment;
        siteJson = JSON.stringify(
            url:url
            )
        req = new XMLHttpRequest()
        req.open 'POST', site, true
        req.setRequestHeader 'Content-type', 'application/json; charset=utf-8'
        req.onreadystatechange = ->
            if req.status != 200 and req.status != 304
                 console.log 'HTTP error ' + req.status
            if req.readyState == 4 and req.status == 200
                console.log "Send our Message"
        req.send siteJson
        req2 = new XMLHttpRequest()
        req2.open 'GET', site, true
        req2.send()
        req2.onreadystatechange = ->
            if req2.readyState == 4 and req2.status == 200
                myArr = JSON.parse(req2.responseText)
                for i in myArr.objects
                    if url is i.url
                        # console.log i.resource_uri
                        Backend.sendComment(nickname,email,comment,i.resource_uri);

    sendComment: (nickname, email, comment,resource_uri) ->
        console.log nickname+email+comment+resource_uri
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
                 console.log 'HTTP error ' + req.status
            if req.readyState == 4 and req.status == 200
                console.log "Send our Message"
        req.send commentJson
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
                        console.log "We have this site"
                        Backend.sendComment(nickname,email,comment,i.resource_uri)
                        return
                Backend.createSite(url,nickname, email, comment);
                console.log "We dont have this site"
                return
    # updateCurrentComment:(counter)->



module.Backend = $this
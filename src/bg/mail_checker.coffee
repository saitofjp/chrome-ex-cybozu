class @MailChecker
  CB_URL        = "https://www.itsol.co.jp/cgi-bin/cb6/ag.cgi"
  CB_FOLDER_URL = "#{CB_URL}?page=MyFolderIndex";
  CB_CHECK_URL  = "#{CB_URL}?page=MailCheckInterval&info=&notimecard=1";

  constructor: (@onUpdateStatus =-> )->

  isCbUrl : (url) ->
    return url.indexOf(CB_URL) != -1

  isLoginPage : (ele)->
    return ele.querySelector("title")?.innerText.match("ログイン");

  hasNotMail :(ele)->
    return not ele.querySelector("b")

  createStatus : (xhr)->
    status =
      login :false,
      hasMail : false,
      count : 0,
      content : null

    if not xhr.responseText?
      return status

    ele = document.createElement('div')
    ele.innerHTML = xhr.responseText
    status.content = ele;

    if @isLoginPage(ele)
      status.login = false;
      status.content.innerHTML =  "ログインしてません。";
    else if @hasNotMail(ele)
      status.login = true;
    else
      status.login = true;
      status.hasMail = true;
      status.count = ele.querySelector("b").innerText
      status.content = ele;
    return status;

  check :()->
    @get().then (xhr)=>
      status = @createStatus(xhr)
      @onUpdateStatus(status)
      return status
     , (e)->
       console.log e

  get: (  )->
    return new Promise (resolve ,reject) ->
      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = ->
        if xhr.readyState == 4
          resolve(xhr);
      xhr.open('GET', CB_CHECK_URL);
      xhr.send(null);

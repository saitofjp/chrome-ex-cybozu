class @MailChecker
  constructor: (@checkUrl)->

  isLoginPage : (ele)->
    return ele.querySelector("title")?.innerText.match("ログイン");

  hasMail :(ele)->
    return ele.querySelector("b")

  getMailCount :(ele)->
    return ele.querySelector("b")?.innerText;

  getContent :(ele)->
    if @isLoginPage(ele)
      ele.innerText = "ログインしてません。";
      return ele;
    else
      return ele;

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

    status.login = not @isLoginPage(ele);
    status.hasMail = @hasMail(ele);
    status.count = @getMailCount(ele);
    status.content = @getContent(ele);
    return status;

  check :()->
    @get().then (xhr)=>
      status = @createStatus(xhr)
      return status
     , (e)->
       console.log e

  get: (  )->
    return new Promise (resolve ,reject) =>
      xhr = new XMLHttpRequest();
      xhr.onreadystatechange = ->
        if xhr.readyState == 4
          resolve(xhr);

      xhr.open('GET', @checkUrl);
      xhr.send(null);

class Content
  constructor: (xhr) ->
    @ele = document.createElement('div')
    @ele.innerHTML = xhr.responseText

  isLoginPage: ()->
    return @ele.querySelector("title")?.innerText.match("ログイン");

  hasMail: ()->
    if @isLoginPage() then return false;
    return @ele.querySelector("b")?

  getMailCount: ()->
    if not @hasMail() then return "0";
    return @ele.querySelector("b")?.innerText;

  getContent: ()->
    if @isLoginPage()
      @ele.innerText = "ログインしてません。";
    return @ele

class @MailChecker
  constructor: (@checkUrl)->

  default: ->
    login: false,
    hasMail: false,
    count: 0,
    content: null

  createStatus: (xhr)->
    if not xhr.responseText?
      return  @default()
    else
      c = new Content(xhr);
      return {
        login: not c.isLoginPage()
        hasMail: c.hasMail()
        count: c.getMailCount()
        content: c.getContent()
      }

  check: ()->
    @get().then (xhr)=>
      return @createStatus(xhr)
    , (e)->
      console.log e

  get: ()->
    return new Promise (resolve, reject) =>
      req = new XMLHttpRequest();
      req.onload = -> resolve(req)
      req.onerror = ->reject(req)
      req.open('GET', @checkUrl);
      req.send(null);

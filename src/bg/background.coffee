# var settings = new Store("settings", {
#     "sample_setting": "This is how you use Store.js to remember values"
# });

class @BadgeStatus
  constructor:->
    @ba = chrome.browserAction;
  update :(@status)->
    if not @status.login
      @ba.setBadgeText({text: "X" })
    else if not @status.hasMail
      @ba.setBadgeText({text: "" })
    else
      @ba.setBadgeText({text: status.count })


class Opener
  eachTab : (callback) ->
    chrome.tabs.getAllInWindow null, (tabs) ->
      i = 0
      tab = undefined
      while tab = tabs[i]
        if tab.url and cb.isCbUrl(tab.url)
          if callback
            callback
              tab: tab
              exists: true

          return
        i++
      callback exists: false  if callback

  openPage : ->
    @eachTab (res) ->
      if res.exists
        chrome.tabs.update res.tab.id,
          selected: true
      else
        chrome.tabs.create url: cb.getFolderUrl()

  openPageAndMailCheck = ->
    @eachTab (res) ->
      if res.exists
        chrome.tabs.update res.tab.id,
          selected: true
          url: res.tab.url + "#mailGet"
      else
        chrome.tabs.create url: cb.getFolderUrl() + "#mailGet"

class @Service
  constructor:->
    @cb = Cybouz();
    @lastStatus = null;
    @events = {}
    @checker = new MailChecker(
      Cybouz.CB_CHECK_URL
    )
    @badge = new BadgeStatus();
    @loading = new LoadingAnimation()

  checkMail :=>
    @loading.start()
    @checker.check().then (status)=>
      @lastStatus = status;
      @badge.update(status)
      @events.onReceive?(status)
      @loading.stop()

  start: ->
    @loading.start();
    @checkMail();
    window.setInterval =>
      @checkMail()
    , 5 * 1000 * 60

  addEventListener : ( events )=>
    for event of events
      @events[event] = events[event];

  getLastStatus:=>
    @lastStatus

  open:=>
    console.log "open"

  openAndReceive :=>
    console.log "openAndReceive"

service = new Service();
console.log "start", @
service.start();

do (global=@)->
  global.getService = -> service;


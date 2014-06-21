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

class @Service
  constructor:->
    @lastStatus = null;
    @events = {}
    @checker = new MailChecker(@onReceive)
    @badge = new BadgeStatus();
    @loading = new LoadingAnimation()

  checkMail :=>
    @loading.start()
    @checker.check().then (status)=>
      @lastStatus = status;
      @loading.stop()

  start: ->
    @loading.start();
    window.setInterval =>
      @checkMail()
    , 5000

  addEventListener : ( events )=>
    for event of events
      @events[event] = events[event];

  onReceive: (status)=>
    @badge.update(status)
    @events.onReceive?(status)

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


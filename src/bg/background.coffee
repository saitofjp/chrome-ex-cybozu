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
    @events = {}
    @checker = new MailChecker(@onReceive)
    @badge = new BadgeStatus();
    @loadingAnimation = new LoadingAnimation()

  addEventListener : ( events )=>
    for event of events
      @events[event] = events[event];

  loadingStart :=>
    @loadingAnimation.start()

  loadingStop :=>
    @loadingAnimation.stop()

  onReceive: (status)=>
    @badge.update(status)
    @events.onReceive?(status)

  open:=>
    console.log "page open"
    @checker.check();

  receive :=>
    console.log "receive "

service = new Service();
console.log @
do (global=@)->
  global.getService = -> service;


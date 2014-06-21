# var settings = new Store("settings", {
#     "sample_setting": "This is how you use Store.js to remember values"
# });

class @BadgeStatus
  constructor:->
    @ba = chrome.browserAction;
    @lastStatus = null;

  getLastStatus:->
    @lastStatus

  update :(@status)->
    @lastStatus = status;
    if not @status.login
      @ba.setBadgeText({text: "X" })
    else if not @status.hasMail
      @ba.setBadgeText({text: "" })
    else
      @ba.setBadgeText({text: status.count })


class @Service
  constructor:->
    @events = {
      received:(status)-> console.log status
    }
    @cb = new Cybozu();
    @checker = new MailChecker(@cb.getChckerUrl())
    @status = new BadgeStatus();
    @loading = new LoadingAnimation()

  checkMail :=>
    console.log "check email"
    @loading.start()
    @checker.check().then (status)=>
      @status.update(status)
      @events.received(status)
      @loading.stop()

  start: ->
    @checkMail();
    @cb.pageUpdated  =>  @checkMail();

  on : ( key , func )=>
      @events[key] = func;

  getLastStatus:=>
    @status.getLastStatus();

  open:=>
    console.log "open"
    @cb.openPage();

  openAndReceive :=>
    console.log "openAndReceive"
    @cb.openPageAndMailCheck();

service = new Service();
console.log "start", @
service.start();

do (global=@)->
  global.getService = -> service;


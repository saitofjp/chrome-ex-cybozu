class @Service
  constructor:->
    @periodInMinutes = 1000 * 60 * 5;
    @events = {
      received:(status)-> console.log status
    }
    @cb = new Cybozu(config.cbUrl);
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
    console.log "start", @
    @checkMail();
    @cb.pageUpdated  =>  @checkMail();
    window.setInterval @checkMail, @periodInMinutes

  on : ( key , func )=>
      @events[key] = func;

  getLastStatus:=>
    @checker.getLastStatus();

  open:=>
    console.log "open"
    @cb.openPage();

  openAndReceive :=>
    console.log "openAndReceive"
    @cb.openPageAndMailCheck();


(service = new Service()).start();
do (global=@)->
  global.getService = -> service;


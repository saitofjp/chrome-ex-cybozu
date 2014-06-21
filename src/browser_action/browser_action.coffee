class PopupViewModel
  constructor:->
    @content = ko.observable("loading...")
    @hasMail = ko.observable(false)

    @service = chrome.extension.getBackgroundPage().getService()
    @service.on "received" , @updateStatus
    @updateStatus(@service.getLastStatus())

  open :=>
    @service.open()
    window.close()

  receive :=>
    @service.openAndReceive()
    window.close()

  updateStatus : (status)=>
    console.log status
    if not status? then return
    @content(status.content?.innerText);
    @hasMail(status.hasMail);

  start:->
    ko.applyBindings @

$ ->
  new PopupViewModel().start()

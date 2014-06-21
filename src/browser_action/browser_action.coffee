
class PopupViewModel
  constructor:->
    @service = chrome.extension.getBackgroundPage().getService()
    @service.on "received" , @updateStatus

    @content = ko.observable("loading...")
    @hasMail = ko.observable(false)
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
    debugger;
    @hasMail(status.hasMail);

  start:->
    ko.applyBindings @

$ ->
  new PopupViewModel().start()

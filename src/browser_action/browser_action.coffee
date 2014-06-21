
class PopupViewModel
  constructor:->
    @service = chrome.extension.getBackgroundPage().getService()
    @service.addEventListener
      onReceive : @onReceive

    @content = ko.observable("loading...")
    @hasMail = ko.observable(false)

    @onReceive(@service.getLastStatus())

  open :=>
    @service.open()

  receive :=>
    @service.openAndReceive()

  onReceive : (status)=>
    if not status? then return
    content = if status.content? then status.content.innerText else "";
    @content(content);
    @hasMail(status.hasMail);

  start:->
    ko.applyBindings @

$ ->
  new PopupViewModel().start()

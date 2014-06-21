
class PopupViewModel
  constructor:->
    @service = chrome.extension.getBackgroundPage().getService()
    @service.addEventListener
      onReceive : @onReceive

    @content = ko.observable("")
    @hasMail = ko.observable(false)

  open :=>
    @service.open()

  receive :=>
    @service.receive()

  onReceive : (status)=>
      content = if status.content? then status.content.innerText else "";
      @content(content);
      @hasMail(status.hasMail);

  start:->
    ko.applyBindings @

$ ->
  new PopupViewModel().start()

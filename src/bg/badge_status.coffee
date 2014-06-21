
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


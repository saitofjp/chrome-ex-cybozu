console.log "inject.js"

class HashCmd
  constructor:->

  on : (hash, callback)->
    $(window).on "hashchange.#{hash}", ->
      #check hash
      if hash == location.hash.replace("#", "")
        callback.call()

  start :->
    #check page load hash ( all event fire)
    $(window).trigger "hashchange"

hasCmd = new HashCmd()
hasCmd.on "receive" , ->
    $("form:has([value=MailCommand])").submit()

$ -> hasCmd.start();

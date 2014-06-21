chrome.extension.sendMessage {}, (response) ->
  readyStateCheckInterval = setInterval(->
    if document.readyState is "complete"
      clearInterval readyStateCheckInterval

      # ----------------------------------------------------------
      # This part of the script triggers when page is done loading
      console.log "Hello. This message was sent from scripts/inject.js"

    # ----------------------------------------------------------
  , 10)

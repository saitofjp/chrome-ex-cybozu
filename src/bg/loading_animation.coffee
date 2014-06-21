class @LoadingAnimation
  constructor:->
    @timerId_ = 0
    @maxCount_ = 8 # Total number of states in animation
    @current_ = 0 # Current state
    @maxDot_ = 4 # Max number of dots in animation

  paintFrame : ->
    text = ""
    i = 0
    while i < @maxDot_
      text += (if (i is @current_) then "." else " ")
      i++
    text += ""  if @current_ >= @maxDot_
    chrome.browserAction.setBadgeText text: text
    @current_++
    @current_ = 0  if @current_ is @maxCount_

  start : ->
    return  if @timerId_
    @timerId_ = window.setInterval(
      => @paintFrame()
    , 100
    )

  stop : ->
    return  unless @timerId_
    window.clearInterval @timerId_
    @timerId_ = 0

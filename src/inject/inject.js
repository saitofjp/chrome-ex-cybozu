// Generated by CoffeeScript 1.7.1
(function() {
  chrome.extension.sendMessage({}, function(response) {
    var readyStateCheckInterval;
    return readyStateCheckInterval = setInterval(function() {
      if (document.readyState === "complete") {
        clearInterval(readyStateCheckInterval);
        return console.log("Hello. This message was sent from scripts/inject.js");
      }
    }, 10);
  });

}).call(this);

//# sourceMappingURL=inject.map

// Generated by CoffeeScript 1.7.1
(function() {
  var HashCmd, hasCmd;

  console.log("inject.js");

  HashCmd = (function() {
    function HashCmd() {}

    HashCmd.prototype.on = function(hash, callback) {
      return $(window).on("hashchange." + hash, function() {
        if (hash === location.hash.replace("#", "")) {
          return callback.call();
        }
      });
    };

    HashCmd.prototype.start = function() {
      return $(window).trigger("hashchange");
    };

    return HashCmd;

  })();

  hasCmd = new HashCmd();

  hasCmd.on("receive", function() {
    return $("form:has([value=MailCommand])").submit();
  });

  $(function() {
    return hasCmd.start();
  });

}).call(this);

//# sourceMappingURL=inject.map

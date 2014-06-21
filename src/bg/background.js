// Generated by CoffeeScript 1.7.1
(function() {
  var service,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.BadgeStatus = (function() {
    function BadgeStatus() {
      this.ba = chrome.browserAction;
    }

    BadgeStatus.prototype.update = function(status) {
      this.status = status;
      if (!this.status.login) {
        return this.ba.setBadgeText({
          text: "X"
        });
      } else if (!this.status.hasMail) {
        return this.ba.setBadgeText({
          text: ""
        });
      } else {
        return this.ba.setBadgeText({
          text: status.count
        });
      }
    };

    return BadgeStatus;

  })();

  this.Service = (function() {
    function Service() {
      this.openAndReceive = __bind(this.openAndReceive, this);
      this.open = __bind(this.open, this);
      this.getLastStatus = __bind(this.getLastStatus, this);
      this.onReceive = __bind(this.onReceive, this);
      this.addEventListener = __bind(this.addEventListener, this);
      this.checkMail = __bind(this.checkMail, this);
      this.lastStatus = null;
      this.events = {};
      this.checker = new MailChecker(this.onReceive);
      this.badge = new BadgeStatus();
      this.loading = new LoadingAnimation();
    }

    Service.prototype.checkMail = function() {
      this.loading.start();
      return this.checker.check().then((function(_this) {
        return function(status) {
          _this.lastStatus = status;
          return _this.loading.stop();
        };
      })(this));
    };

    Service.prototype.start = function() {
      this.loading.start();
      return window.setInterval((function(_this) {
        return function() {
          return _this.checkMail();
        };
      })(this), 5000);
    };

    Service.prototype.addEventListener = function(events) {
      var event, _results;
      _results = [];
      for (event in events) {
        _results.push(this.events[event] = events[event]);
      }
      return _results;
    };

    Service.prototype.onReceive = function(status) {
      var _base;
      this.badge.update(status);
      return typeof (_base = this.events).onReceive === "function" ? _base.onReceive(status) : void 0;
    };

    Service.prototype.getLastStatus = function() {
      return this.lastStatus;
    };

    Service.prototype.open = function() {
      return console.log("open");
    };

    Service.prototype.openAndReceive = function() {
      return console.log("openAndReceive");
    };

    return Service;

  })();

  service = new Service();

  console.log("start", this);

  service.start();

  (function(global) {
    return global.getService = function() {
      return service;
    };
  })(this);

}).call(this);

//# sourceMappingURL=background.map

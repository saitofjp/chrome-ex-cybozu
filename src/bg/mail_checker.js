// Generated by CoffeeScript 1.7.1
(function() {
  var Content;

  Content = (function() {
    function Content(xhr) {
      this.ele = document.createElement('div');
      this.ele.innerHTML = xhr.responseText;
    }

    Content.prototype.isLoginPage = function() {
      var _ref;
      return (_ref = this.ele.querySelector("title")) != null ? _ref.innerText.match("ログイン") : void 0;
    };

    Content.prototype.hasMail = function() {
      if (this.isLoginPage()) {
        return false;
      }
      return this.ele.querySelector("b") != null;
    };

    Content.prototype.getMailCount = function() {
      var _ref;
      if (!this.hasMail()) {
        return "0";
      }
      return (_ref = this.ele.querySelector("b")) != null ? _ref.innerText : void 0;
    };

    Content.prototype.getContent = function() {
      if (this.isLoginPage()) {
        this.ele.innerText = "ログインしてません。";
      }
      return this.ele;
    };

    return Content;

  })();

  this.MailChecker = (function() {
    function MailChecker(checkUrl) {
      this.checkUrl = checkUrl;
    }

    MailChecker.prototype["default"] = function() {
      return {
        login: false,
        hasMail: false,
        count: 0,
        content: null
      };
    };

    MailChecker.prototype.createStatus = function(xhr) {
      var c;
      if (xhr.responseText == null) {
        return this["default"]();
      } else {
        c = new Content(xhr);
        return {
          login: !c.isLoginPage(),
          hasMail: c.hasMail(),
          count: c.getMailCount(),
          content: c.getContent()
        };
      }
    };

    MailChecker.prototype.check = function() {
      return this.get().then((function(_this) {
        return function(xhr) {
          return _this.createStatus(xhr);
        };
      })(this), function(e) {
        return console.log(e);
      });
    };

    MailChecker.prototype.get = function() {
      return new Promise((function(_this) {
        return function(resolve, reject) {
          var req;
          req = new XMLHttpRequest();
          req.onload = function() {
            return resolve(req);
          };
          req.onerror = function() {
            return reject(req);
          };
          req.open('GET', _this.checkUrl);
          return req.send(null);
        };
      })(this));
    };

    return MailChecker;

  })();

}).call(this);

//# sourceMappingURL=mail_checker.map

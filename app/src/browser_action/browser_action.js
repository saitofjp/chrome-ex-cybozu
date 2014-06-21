// Generated by CoffeeScript 1.7.1
(function() {
  var PopupViewModel,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  PopupViewModel = (function() {
    function PopupViewModel() {
      this.updateStatus = __bind(this.updateStatus, this);
      this.receive = __bind(this.receive, this);
      this.open = __bind(this.open, this);
      this.content = ko.observable("loading...");
      this.hasMail = ko.observable(false);
      this.service = chrome.extension.getBackgroundPage().getService();
      this.service.on("received", this.updateStatus);
      this.updateStatus(this.service.getLastStatus());
    }

    PopupViewModel.prototype.open = function() {
      this.service.open();
      return window.close();
    };

    PopupViewModel.prototype.receive = function() {
      this.service.openAndReceive();
      return window.close();
    };

    PopupViewModel.prototype.updateStatus = function(status) {
      var _ref;
      console.log(status);
      if (status == null) {
        return;
      }
      this.content((_ref = status.content) != null ? _ref.innerText : void 0);
      return this.hasMail(status.hasMail);
    };

    PopupViewModel.prototype.start = function() {
      return ko.applyBindings(this);
    };

    return PopupViewModel;

  })();

  $(function() {
    return new PopupViewModel().start();
  });

}).call(this);
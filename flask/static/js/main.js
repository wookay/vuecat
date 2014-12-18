(function() {

  var initApp = function() {
    var vm = new Vue({
      el: '#main',
      data: {
        counter: "Counter",
        value: 0,
      },
      methods: {
        getValue: function() {
          var _this = this
          var fun = function(callback) {
            return $.ajax("/counter", {
              type: 'GET',
              data: {
              },
              dataType: 'json'
            }).done(callback.success);
          };
          fun({
            success: (function(_this) {
              return function(data) {
                _this.value = data.value;
              };
            })(this),
          });
        },
        hundred: function() {
          var _this = this
          var fun = function(callback) {
            return $.ajax("/counter", {
              type: 'POST',
              data: {
                value: 100
              },
              dataType: 'json'
            }).done(callback.success);
          };
          fun({
            success: (function(_this) {
              return function(data) {
                _this.value = data.value;
              };
            })(this),
          });
        },
        up: function() {
          var _this = this
          var fun = function(callback) {
            return $.ajax("/up", {
              type: 'GET',
              data: {
              },
              dataType: 'json'
            }).done(callback.success);
          };
          fun({
            success: (function(_this) {
              return function(data) {
                _this.value = data.value;
              };
            })(this),
          });
        },
        julia: function(code) {
          var _this = this
          var fun = function(callback) {
            return $.ajax("/julia", {
              type: 'POST',
              data: {
                code: code
              },
              dataType: 'json'
            }).done(callback.success);
          };
          fun({
            success: (function(_this) {
              return function(data) {
                _this.value = data.value;
              };
            })(this),
          });
        },
      },
    })
    vm.getValue();
    window.vm = vm;
  };

  $(function() {
    initApp();
  });

}).call(this);

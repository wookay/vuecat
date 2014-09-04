(function() {

  var initApp = function() {
    var vm = new Vue({
      el: '#main',
      data: {
        counter: "Counter",
        value: 0,
      },
      methods: {
        next: function() {
          var _this = this
          var fun = function(callback) {
            return $.ajax("/next/" + _this.value, {
              type: 'GET',
              data: {
              },
              dataType: 'json'
            }).done(callback.success);
          };
          fun({
            success: (function(_this) {
              return function(data) {
                _this.value = data;
                console.log(data);
              };
            })(this),
          });
        },
      },
    })
  };

  $(function() {
    initApp();
  });

}).call(this);

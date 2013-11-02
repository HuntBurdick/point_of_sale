//= require active_admin/base

//=require jquery-ui-timepicker-addon


$(document).ready(function() {
  jQuery('input.hasDatetimePicker').datepicker({
    dateFormat: "dd/mm/yy",
    beforeShow: function () {
      setTimeout(
        function () {
          $('#ui-datepicker-div').css("z-index", "3000");
        }, 100
      );
    }
  });
});
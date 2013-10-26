$(document).ready(function(){

	//Work Orders Js
	work_order_wrappers = $("#sale_work_order");
	work_order_wrappers.each(function(){
		if (this.checked) {
			$(".work_order_items").show();
		}
	});
	$(work_order_wrappers).click(function(){
		if (this.checked) {
		 	$(".work_order_items").show();
		} else {
			$(".work_order_items").hide();
		}
	});

	// Line Items JS
	$('.line_items .input .inputs .select select').change(function(){
		var val = $(this).val();
		var myString = val.substr(val.indexOf("$") + 1);

		$(this).parent().find(":contains('price')").val('12.99');

	});




});
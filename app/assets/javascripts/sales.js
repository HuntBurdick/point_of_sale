$(document).ready(function(){
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
});
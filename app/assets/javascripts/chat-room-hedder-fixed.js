$(function() {
	$(window).on('load scroll', function(){
		if ($(window).scrollTop() > 200) {
			$('.chat-room-hedder').addClass('fixed');
		} else {
			$('.chat-room-hedder').removeClass('fixed');
		}
	});
});
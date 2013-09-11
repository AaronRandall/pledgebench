;(function($) {

    $.ebor_carousel = function(el, options) {

        var defaults = {
            propertyName: 'value',
            onSomeEvent: function() {}
        }

        var ebor = this;

        ebor.settings = {}

        var init = function() {
            ebor.settings = $.extend({}, defaults, options);
            ebor.el = el;
            
            $('.carousel li', ebor.el).click(function(){
             	 var href = $(this).find('a').attr('href');
             	 window.location.href = href;
            });
            
            var dragging = false;
            
            $('.carousel li', ebor.el).on("touchmove", function(){
                  dragging = true;
            });
            
            $('.carousel li', ebor.el).on("touchend", function(event){
            	if(dragging){ dragging = false; return; }
	                var href = $(this).find('a').attr('href');
	                window.location.href = href;
            });
            
            $('.carousel li', ebor.el).on("mouseenter", function(){
                  $(this).find('a').addClass('active');
            });
            
            $('.carousel li', ebor.el).on("mouseleave", function(){
                  $(this).find('a').removeClass('active');
            });
           
            if( $(window).width() < 550 ) {
            	$('.carousel ul li', ebor.el).animate({ 'width' : $('.carousel', ebor.el).width() }, function(){
            		$('.carousel ul', ebor.el).width( $('.carousel ul li', ebor.el).length * $('.carousel ul li', ebor.el).outerWidth() );
            	});
            	$('.carousel li', ebor.el).removeClass('translate-left');
            } else if( $(window).width() < 959 ){
            	$('.carousel ul li', ebor.el).animate({ 'width' : $('.carousel', ebor.el).width() / 2 }, function(){
            		$('.carousel ul', ebor.el).width( $('.carousel ul li', ebor.el).length * $('.carousel ul li', ebor.el).outerWidth() );
            	});
            	$('.carousel li', ebor.el).removeClass('translate-left');
            	$('.carousel li:nth-child(2n)').addClass('translate-left');
            } else {
            	$('.carousel ul', ebor.el).width( $('.carousel ul li', ebor.el).length * $('.carousel ul li', ebor.el).outerWidth() );
            	$('.carousel ul li', ebor.el).removeClass('translate-left');
            	$('.carousel ul.three-dee li:eq(2), .carousel ul.three-dee li:eq(3)').addClass('translate-left');
            }
            $(window).smartresize(function(){
            	if( $(window).width() < 550 ) {
            		$('.carousel ul li', ebor.el).animate({ 'width' : $('.carousel', ebor.el).width() }, function(){
            			$('.carousel ul', ebor.el).width( $('.carousel ul li', ebor.el).length * $('.carousel ul li', ebor.el).outerWidth() ).animate({'left' : '0px'}, 100);
            		});
            		$('.carousel li', ebor.el).removeClass('translate-left');
            	} else if( $(window).width() < 959 ){
            		$('.carousel ul li', ebor.el).animate({ 'width' : $('.carousel', ebor.el).width() / 2 }, function(){
            			$('.carousel ul', ebor.el).width( $('.carousel ul li', ebor.el).length * $('.carousel ul li', ebor.el).outerWidth() ).animate({'left' : '0px'}, 100);
            		});
            		$('.carousel li', ebor.el).removeClass('translate-left');
            		$('.carousel li:nth-child(2n)', ebor.el).addClass('translate-left');
            	} else {
            		$('.carousel ul', ebor.el).width( $('.carousel ul li', ebor.el).length * $('.carousel ul li', ebor.el).outerWidth() ).animate({'left' : '0px'}, 100);
            		$('.carousel ul li', ebor.el).removeClass('translate-left');
            		$('.carousel ul.three-dee li:eq(2), .carousel ul.three-dee li:eq(3)').addClass('translate-left');
            	}
            	if( $(window).width() > 767 ){
            		$('.carousel ul li', ebor.el).css({'width' : ''});
            	}
            });
            //swipe events
            $(ebor.el).swipe({
              swipeRight:function(event, direction, distance, duration, fingerCount) {
                if( $('.carousel ul', ebor.el).css('left') == '0px'){
                	$('.carousel ul', ebor.el).animate({ 'left' : '+=25' }, 100).animate({ 'left' : '-=25' }, 100);
                } else {
                	$('.carousel ul', ebor.el).animate({ 'left' : '+='+$('.carousel ul li', ebor.el).outerWidth() });
                	$('.carousel ul li.translate-left', ebor.el).removeClass('translate-left').prev().addClass('translate-left');
                }
              },
              swipeLeft:function(event, direction, distance, duration, fingerCount) {
                if( $('.carousel ul', ebor.el).css('left') == ($('.carousel', ebor.el).width() - ($('.carousel ul li', ebor.el).outerWidth() * $('.carousel ul li', ebor.el).length))+'px'){
                	$('.carousel ul', ebor.el).animate({ 'left' : '-=25' }, 100).animate({ 'left' : '+=25' }, 100);
                } else {
                	$('.carousel ul', ebor.el).animate({ 'left' : '-='+$('.carousel ul li', ebor.el).outerWidth() });
                	$('.carousel ul li.translate-left', ebor.el).removeClass('translate-left').next().addClass('translate-left');
                }
              }
            });
            //next button(right) click
            $('a[href="#next"]', ebor.el).click(function(){
            	$(this).css({ 'pointer-events' : 'none' });
            	if( $('.carousel ul', ebor.el).css('left') == ($(ebor.el).width() - ($('.carousel ul li', ebor.el).outerWidth() * $('.carousel ul li', ebor.el).length))+'px'){
            		$('.carousel ul', ebor.el).animate({ 'left' : '-=25' }, 100).animate({ 'left' : '+=25' }, 100, function(){
            			$('a[href="#next"]', ebor.el).css({ 'pointer-events' : 'auto' });
            		});
            	} else {
            		$('.carousel ul', ebor.el).animate({ 'left' : '-='+$('.carousel ul li', ebor.el).outerWidth() }, function(){
            			$('a[href="#next"]', ebor.el).css({ 'pointer-events' : 'auto' });
            		});
            		$('.carousel ul li.translate-left', ebor.el).removeClass('translate-left').next().addClass('translate-left');
            	}
            	return false;
            });
            //prev button (left) click
            $('a[href="#prev"]', ebor.el).click(function(){
            	$(this).css({ 'pointer-events' : 'none' });
            	if( $('.carousel ul', ebor.el).css('left') == '0px'){
            		$('.carousel ul', ebor.el).animate({ 'left' : '+=25' }, 100).animate({ 'left' : '-=25' }, 100, function(){
            			$('a[href="#prev"]', ebor.el).css({ 'pointer-events' : 'auto' });
            		});
            	} else {
            		$('.carousel ul', ebor.el).animate({ 'left' : '+='+$('.carousel ul li', ebor.el).outerWidth() }, function(){
            			$('a[href="#prev"]', ebor.el).css({ 'pointer-events' : 'auto' });
            		});
            		$('.carousel ul li.translate-left', ebor.el).removeClass('translate-left').prev().addClass('translate-left');
            	}
            	return false;
            });
        }

        init();

    }

})(jQuery);
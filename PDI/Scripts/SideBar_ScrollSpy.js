      $('#sidebar').affix({
          offset: {
              top: 280
          }
      });
            

      /* scrollspy menu */
      var $body   = $(document.body);
      var navHeight = $('.navbar').outerHeight(true) + 0;

      $body.scrollspy({
          target: '#leftCol',
          offset: navHeight
      });

      /* smooth scrolling */
      $('a[href*=#]:not([href=#])').click(function() {
          if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
              var target = $(this.hash);
              target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
              if (target.length) {
                  $('html,body').animate({
                      scrollTop: target.offset().top - 15
                  }, 500);
                  return false;
              }
          }
      });

var when_page_is_ready = function() {


$(".course_checkbox").hide()
  $(".location_checkbox").change(function() {
    var location_id = $(this).attr("location_id")
      $(".location_" + location_id).show()
})
  
  $('#openBtn').click(function(){
    $('#myModal').modal({show:true})
  })

  $('#openStBtn').click(function() {
    $('#studentModal').modal({show:true})
  })



  setTimeout(function() {
      $("p.alert").fadeOut("fast", function() {
          $("p.alert").remove();
      })
    }, 3000)

  setTimeout(function() {
    $("p.notice").fadeOut("fast", function() {
        $("p.notice").remove();
    })
  }, 0000)  

    $(document.body).on("click", "a.change_workflow", function() {
      $.ajax({
        type: "PATCH",
        url: $(this).attr("submission_url"),
        dataType: "script" //,
      })
    })

    $(function() {
      $( "#assignment_due_date" ).datepicker();
    })
}

$(document).ready(when_page_is_ready);
$(document).on("page:load", when_page_is_ready);




  // var name = $( "#name" ),
  //   email = $( "#email" ),
  //   password = $( "#password" ),
  //   allFields = $( [] ).add( name ).add( email ).add( password ),
  //   tips = $( ".validateTips" );

  // function updateTips( t ) {
  //   tips
  //     .text( t )
  //     .addClass( "ui-state-highlight" );
  //   setTimeout(function() {
  //     tips.removeClass( "ui-state-highlight", 1500 );
  //   }, 500 );
  // }

  // function checkLength( o, n, min, max ) {
  //   if ( o.val().length > max || o.val().length < min ) {
  //     o.addClass( "ui-state-error" );
  //     updateTips( "Length of " + n + " must be between " +
  //       min + " and " + max + "." );
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // function checkRegexp( o, regexp, n ) {
  //   if ( !( regexp.test( o.val() ) ) ) {
  //     o.addClass( "ui-state-error" );
  //     updateTips( n );
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  


//   $('#sidebar').affix({
//     offset: {
//       top: 235
//         }
//   })

//   var $body   = $(document.body);
//   var navHeight = $('.navbar').outerHeight(true) + 10;

//   $body.scrollspy({
//     target: '#leftCol',
//     offset: navHeight
//   })


//   $('a[href*=#]:not([href=#])').click(function() {
//       if (location.pathname.replace(/^\//,'') == this.pathname.replace(/^\//,'') && location.hostname == this.hostname) {
//         var target = $(this.hash);
//         target = target.length ? target : $('[name=' + this.hash.slice(1) +']');
//         if (target.length) {
//           $('html,body').animate({
//             scrollTop: target.offset().top - 50
//           }, 1000);
//           return false;
//         }
//       }
//   })
  




// }




//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require bootstrap-datepicker
//= require dropify/src/js/dropify

window.onload = function () {
  $('.datepicker-toggle').datepicker();

  $('#send-code-btn').on('click', function () {
    $('.loader').css("display", "block");
    $('#send-code-btn').hide();
    number = $("#country_code").val() + $("#number").val();
    $.ajax({
      headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
      method:  'POST',
      data:    { number: number },
      url:     '/users/phones/verification',
      success: function(result){
         if (result.success){
           $('.loader').css("display", "none");
           $('#send-code-btn').show();
           $("#error").text('');
           $("#create-phone").prop('disabled', false);
           $("#send-code-btn").text('Resend');
         } else {
           $('.loader').css("display", "none");
           $('#send-code-btn').show();
           $("#error").text(result.error);
         }
      }
    });
  });

  $('.dropify').dropify({
      tpl: {
          message:  '<div class="dropify-message"> <p>{{ default }}</p> </div>',
      }
  });

  function check_if_filled(){
    var count = 0
    $('.form-control.required').each(function(){
      if ($(this).val().length > 0) {
        count += 1;
      }
    })
    return count == $('.form-control.required').length
  }

  function terms_agree(){
    var return_flag = false;
    if ( window.location.href.includes('sign_up') && $('#agreement:checked').length > 0 ) {
      return_flag = true;
    }
    return return_flag
  }

  $('.form-control.required').on ('change keyup focusout', function() {
    if ($(this).val().length == 0 && terms_agree() ) {
      $('.submit-container input').prop('disabled', true);
      $('.submit-container input').removeClass('enable_input');
      $('.empty-field').css('opacity', '1')
      $(this).addClass('empty_input')
    } else if ( check_if_filled() && terms_agree() ) {
      $('.submit-container input').prop('disabled', false);
      $('.submit-container input').addClass('enable_input');
      $('.empty-field').css('opacity', '0')
      $(this).removeClass('empty_input')
    } else if ( check_if_filled() && !window.location.href.includes('sign_up') ) {
      $('.submit-container input').prop('disabled', false);
      $('.submit-container input').addClass('enable_input');
      $('.empty-field').css('opacity', '0')
      $(this).removeClass('empty_input')
    }
  });

  $("#agreement").change(function() {
    if( this.checked && check_if_filled() ) {
      $('.submit-container input').prop('disabled', false);
      $('.submit-container input').addClass('enable_input');
    } else {
      $('.submit-container input').prop('disabled', true);
      $('.submit-container input').removeClass('enable_input');
    }
  });

  $('#document-type').change(function(){
    if ($(this).find(":selected").text() == "Identity card") {
      $('#document_doc_expire').parent().parent().hide();
    } else {
      $('#document_doc_expire').parent().parent().show();
    }
  })
  
};

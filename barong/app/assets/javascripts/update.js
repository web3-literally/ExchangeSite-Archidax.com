//= require update/jquery.min
//= require update/bootstrap.bundle.min
//= require update/metisMenu.min
//= require update/waves.min
//= require update/jquery.slimscroll.min
//= require plugins/dropify/js/dropify.min
//= require pages/jquery.form-upload.init
//= require plugins/moment/moment
//= require plugins/daterangepicker/daterangepicker
//= require plugins/select2/select2.min
//= require plugins/timepicker/bootstrap-material-datetimepicker
//= require plugins/bootstrap-maxlength/bootstrap-maxlength.min
//= require plugins/bootstrap-touchspin/js/jquery.bootstrap-touchspin.min

//= require update/app

window.onload = function () {

    $('#document_doc_expire').bootstrapMaterialDatePicker({
        weekStart : 0, time: false
    });

    $('#send-code-btn').on('click', function () {
        $('.loader').css("display", "block");
        $('#send-code-btn').hide();
        number = $("#country_code").val() + $("#number").val();
        $.ajax({
            headers: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')},
            method: 'POST',
            data: {number: number},
            url: '/users/phones/verification',
            success: function (result) {
                if (result.success) {
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
}

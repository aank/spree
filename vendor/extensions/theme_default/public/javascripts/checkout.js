jQuery(document).ready(function($){
  
  // Single page checkout   
  
  // function updateShippingAddress() {
  //   var updateShipping = $('#checkout_same_address').attr('checked');
  //   if (updateShipping) {
  //     $('#billing :input').each(function(i, field) {
  //       var shipFieldId = $(field).attr('id').replace('_bill_address_attributes_', '_shipment_attributes_address_attributes_');
  //       $('#'+shipFieldId).val($(field).val());
  //     });
  //   }
  // }
  // 
  // $('#billing :input').bind('change keyup', updateShippingAddress);
  // $('#checkout_same_address').change(function() {
  //   if ($(this).attr('checked')) {
  //     updateShippingAddress();
  //   }
  // });
  
  $('a#registration-login-link').click(function() {
    var path = $(this).attr('href') + '?email=' + $('#user_session_login').val();
    window.location.href = path;
    return false;
  });
  
});
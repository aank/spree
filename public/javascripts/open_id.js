$('#enable_login_via_openid a').click(function(){
  $('#enable_login_via_openid').hide();
  $('#enable_login_via_login_password').show();
  $('#login_via_openid').show();
  $('#login_via_login_password').hide();  
})

$('#enable_login_via_login_password a').click(function(){
  $('#enable_login_via_openid').show();
  $('#enable_login_via_login_password').hide();
  $('#login_via_openid').hide(); 
  $('#login_via_login_password').show(); 
})

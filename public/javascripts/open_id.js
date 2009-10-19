$('#enable_login_via_openid a').click(function(){
  $('#enable_login_via_openid').hide();
  $('#enable_login_via_login_password').show();
  $('div#openid-credentials').show();
  $('div#password-credentials').hide();  
})

$('#enable_login_via_login_password a').click(function(){
  $('#enable_login_via_openid').show();
  $('#enable_login_via_login_password').hide();
  $('div#openid-credentials').hide(); 
  $('div#password-credentials').show(); 
})

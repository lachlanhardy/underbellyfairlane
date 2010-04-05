/*requires jquery.js*/

$(document).ready(function(){
  // making sexy unobtrusive CSS possible since 2006
  $("html").addClass("js");

  Shadowbox.init({
      continuous: true
  });
  
  Shadowbox.setup("#gallery a", {
      gallery: "Fairlane"
  });

});

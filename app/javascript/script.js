$(function(){
  $('.Tag').mouseover(function(){
    $(this).addClass('TagHover');
  });
  $('.Tag').mouseout(function(){
    $(this).removeClass('TagHover');
  });
});
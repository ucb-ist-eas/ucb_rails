$(function(){
  $('.input-group.datetime').datetimepicker({
      format: "YYYY-MM-DD HH:mm",
      allowInputToggle: true
  });
  $('.input-group.date').datetimepicker({
      format: "YYYY-MM-DD",
      allowInputToggle: true
  });  
});

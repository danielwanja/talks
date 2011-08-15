
var twentyTwentySetUp = false;
var twentyTwentyRunning = false;

function setUpTwentyTwenty()
{
  if (twentyTwentySetUp) { return; }

  twentyTwentySetUp = true;
 
  $("#slideInfo").after('<span id="twentyTwentyInfo"></span>');

}

$(function(){
  setUpTwentyTwenty();
});
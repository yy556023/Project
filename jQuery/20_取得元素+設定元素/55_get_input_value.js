// 10. 如果是這樣寫的話，有錯誤訊息，為什麼？
// btnGet.onclick = function(){

// 11. 畫面準備好以後才開始執行
$(function () {
  btnGet.onclick = function () {
    // console.log("OK");
    console.log($("#userName").prop("value"));
    console.log($("#phone").prop("value"));
    console.log($("#address").prop("value"));
    console.log($("input:radio[name='age']:checked").prop("value"));
    console.log($("input:radio[name='job']:checked").prop("value"));
    for (i of $('input[name="vehicle"]')) {
      
      console.log(i.value);
    }
  };
});

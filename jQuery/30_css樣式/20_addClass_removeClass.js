// 試試看 addClass、removeClass，以及各種選擇器

// 10. div,p btn1
// 20. div>p btn2
// 30. div+p btn3
// 40. div~p btn4
// 50. div p btn5
$().ready(function () {
  var p1 = $("div,p");
  var p2 = $("div>p");
  var p3 = $("div+p");
  var p4 = $("div~p");
  var p5 = $("div p");

  $("#btn1").on("click", function () {
    p1.removeClass("bgColor");
    p1.addClass("bgColor");
  });
  $("#btn2").on("click", function () {
    p1.removeClass("bgColor");
    p2.addClass("bgColor");
  });
  $("#btn3").on("click", function () {
    p1.removeClass("bgColor");
    p3.addClass("bgColor");
  });
  $("#btn4").on("click", function () {
    p1.removeClass("bgColor");
    p4.addClass("bgColor");
  });
  $("#btn5").on("click", function () {
    p1.removeClass("bgColor");
    p5.addClass("bgColor");
  });
});

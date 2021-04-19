	//產生16進位的RGB數字 00~FF
	change = (c) => {
        if (c < 16) {
          re = "0" + c.toString(16).toUpperCase();
          return re;
        } else {
          return c.toString(16).toUpperCase();
        }
      	};
      	//組合成 #000000~#FFFFFF
	color = (r, g, b) => {
        c = "#" + change(r) + change(g) + change(b);
        return c;
      	};

	load = () => {
        var r = Math.round(Math.random() * 255);
        var g = Math.round(Math.random() * 255);
        var b = Math.round(Math.random() * 255);

        x = color(r, g, b);
        y = color(255 - r, 255 - g, 255 - b);
        //div c1 c2背景顏色更換成對比色 文字使用對方的顏色 並且顯示現在顏色的6位數字碼
        //JS
        document.getElementById("c1").style.backgroundColor = x;
        document.getElementById("c1").style.color = y;
        document.getElementById("c1").innerText = x;
        document.getElementById("c2").style.backgroundColor = y;
        document.getElementById("c2").style.color = x;
        document.getElementById("c2").innerText = y;
        //JQ
        // $("#c1").css("backgroundColor", x);
        // $("#c1").css("color", y);
        // $("#c1").text(`${x}`);
        // $("#c2").css("backgroundColor", y);
        // $("#c2").css("color", x);
        // $("#c2").text(`${y}`);

        console.log("左：" + x);
        console.log("右：" + y);
      	};

	start = () => {
        if (run) {
          return;
        } else {
          run = true;
          time = setInterval(load, 1500);
        }
      	};

	stop = () => {
        run = false;
        clearInterval(time);
        console.log("setInterval has been stop");
        document.body.style.backgroundColor = "white";
      	};
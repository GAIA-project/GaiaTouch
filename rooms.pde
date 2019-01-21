
window.smallSize = 30;
var bigSize = 50;
textHeight = 210;
iconHeight = 310;
var roomsHeight1 = 450;
var roomsHeight2 = 550;
var columns = {50, 300 , 550};
var count = 2;
PImage logo;
PImage t;
PImage h,k,l;
void setup() {
   size(800, 600);
   
   logo = loadImage("/GaiaTouch/img/download.png");
   t = loadImage("/GaiaTouch/img/temperature.png");
   h = loadImage("/GaiaTouch/img/humidity.png");
   k = loadImage("/GaiaTouch/img/noise.png");
   l = loadImage("/GaiaTouch/img/luminosity.png");

}
window.color_White=#FFFFFF;
window.color_Red=#FF0000;
window.color_Green=#00FF00;
window.color_Blue=#0000FF;
window.color_Purple=#FFFF00;

window.colors= {color_White,color_White,color_White,color_White,color_White,color_White};

window.valueT="--";
window.valueH="--";
window.valueK="--";
window.valueL="--";

void draw(){
background(100);
  stroke(0);
    if (window.rooms){
        textSize(30);
        fill(colors[0]);
        ellipse(columns[0] , roomsHeight1, smallSize, smallSize);
        text(window.rooms[0].name, columns[0]+40-15, roomsHeight1+10 );
        fill(colors[1]);
        ellipse(columns[0], roomsHeight2, smallSize, smallSize);
        text(window.rooms[1].name, columns[0]+40-15, roomsHeight2+10 );

        fill(colors[2]);
        ellipse(columns[1] , roomsHeight1, smallSize, smallSize);
        text(window.rooms[2].name, columns[1]+40-15, roomsHeight1+10 );
        fill(colors[3]);
        ellipse(columns[1], roomsHeight2, smallSize, smallSize);
        text(window.rooms[3].name, columns[1]+40-15, roomsHeight2+10 );

        fill(colors[4]);
        ellipse(columns[2] , roomsHeight1, smallSize, smallSize);
        text(window.rooms[4].name, columns[2]+40-15, roomsHeight1+10 );
        fill(colors[5]);
        ellipse(columns[2], roomsHeight2, smallSize, smallSize);
        text(window.rooms[5].name, columns[2]+40-15, roomsHeight2+10 );
    }
    fill(color_White);



  image(t, 100-50,iconHeight-50, 100,100);
  image(h, 200-50,iconHeight-50, 100,100);
  image(logo, 400-50,iconHeight-25, 100,50);
  image(k, 600-50,iconHeight-50, 100,100);
  image(l, 700-50,iconHeight-50, 100,100);
  for (var i=0;i<count;i++){
	println('');  
  }
  textSize(50);
  text(int(valueT), 100-25, textHeight);
  text(int(valueH), 200-25, textHeight);
  text(int(valueK), 600-25, textHeight);
  text(int(valueL), 700-25, textHeight);
  textSize(30);
  text("°C", 100-15, textHeight + 50);
  text("%", 200-15, textHeight + 50);
  text("db", 600-15, textHeight + 50);
  text("lum", 700-15, textHeight + 50);

}

    
interface Javascript {}
Javascript javascript=null;
void bindJavascript(Javascript js) { javascript=js; }

void clearColors(){
    for (var i=0;i<colors.length;i++){
        colors[i]=color_White;
    }
    valueT="-";
    valueH="-";
    valueK="-";
    valueL="-";
}

void keyPressed()

{
	switch(int(key)){
		case 43:
			iconHeight++;
		break;
		case 45:
			iconHeight--;
		break;
		case 113:
            clearColors();
            colors[0]=color_Red;
            disconnect();
            connectWs(0);
		break;
		case 119:
            clearColors();
            colors[1]=color_Red;
            disconnect();
            connectWs(1);
		break;
        case 101:
            clearColors();
            colors[2]=color_Red;
            disconnect();
            connectWs(2);
        break;
		case 114:
            clearColors();
            colors[3]=color_Red;
            disconnect();
            connectWs(3);
		break;
		case 116:
            clearColors();
            colors[4]=color_Red;
            disconnect();
            connectWs(4);
		break;
		case 121:
            clearColors();
            colors[5]=color_Red;
            disconnect();
            connectWs(5);
		break;
		default:
			console.log(key);
	}
	
}

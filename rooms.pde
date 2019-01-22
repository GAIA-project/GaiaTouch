
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
   c = loadImage("/GaiaTouch/img/current.png");
   p = loadImage("/GaiaTouch/img/power.png");

}
window.color_White=#FFFFFF;
window.color_Red=#FF0000;
window.color_Green=#00FF00;
window.color_Blue=#0000FF;
window.color_Purple=#FFFF00;

window.colorSchool= color_White;
window.colors= {color_Red,color_White,color_White,color_White,color_White,color_White,color_White};

window.valueT="--";
window.valueH="--";
window.valueK="--";
window.valueL="--";
window.valueC="0";
window.valueP="0";

void draw(){
background(100);
  keysPressedJs();
  stroke(0);
    if (window.rooms){
        textSize(30);
        fill(colors[0]);
        ellipse(columns[0] , 50, smallSize, smallSize);
        text(window.group.name, columns[0]+40-15, 50+10);
        for (var i=0;i<6;i++){
                fill(colors[i+1]);
                ellipse(columns[0] , 200+(i+1)*50, smallSize, smallSize);
                text(window.rooms[i].name, columns[0]+40-15, 200+(i+1)*50+10);
        }

    }
    fill(color_White);


  image(logo, 50,100, 100,50);

  image(t, 450 ,80, 100,100);
  image(h, 450 ,180, 100,100);
  image(k, 450 ,280, 100,100);
  image(l, 450 ,380, 100,100);
  image(p, 450 ,480, 100,100);
  image(c, 450 ,580, 100,100);
  for (var i=0;i<count;i++){
	println('');  
  }
  textSize(50);
  text(int(valueT), 550, 180-25);
  text(int(valueH), 550, 280-25);
  text(int(valueK), 550, 380-25);
  text(int(valueL), 550, 480-25);
  text(int(valueP), 550, 580-25);
  text(float(valueC), 550, 680-25);
  textSize(30);
  text("°C", 650, 180-25);
  text("%", 650, 280-25);
  text("db", 650, 380-25);
  text("lum", 650, 480-25);
  text("Wh", 650, 580-25);
  text("A", 650, 680-25);


}

    
interface Javascript {}
Javascript javascript=null;
void bindJavascript(Javascript js) { javascript=js; }

void clearColors(){
    colorSchool = color_White;
    for (var i=0;i<colors.length;i++){
        colors[i]=color_White;
    }
    valueT="-";
    valueH="-";
    valueK="-";
    valueL="-";
}

void keysPressedJs()
{
    if (keysPressed && keysPressed.length>0){
        buttonPressed = keysPressed.pop()
        doKeyPressed(buttonPressed);
    }
}

void keyPressed()
{
    console.log(key);
	switch(int(key)){
		case 113:
		    doKeyPressed(0);
		    break;
		case 119:
            doKeyPressed(1);
		    break;
        case 101:
            doKeyPressed(2);
            break;
		case 114:
            doKeyPressed(3);
		    break;
		case 116:
            doKeyPressed(4);
		    break;
		case 121:
            doKeyPressed(5);
		    break;
        case 117:
            doKeyPressed(6);
		    break;
		default:
			console.log(key);
	}
	
}


void doKeyPressed(key)
{
	switch(key){
		case 0:
            clearColors();
            colors[0]=color_Red;
            disconnect();
            connectWs(0);
		    break;
		case 1:
            clearColors();
            colors[1]=color_Red;
            disconnect();
            connectWs(1);
		    break;
        case 2:
            clearColors();
            colors[2]=color_Red;
            disconnect();
            connectWs(2);
            break;
		case 3:
            clearColors();
            colors[3]=color_Red;
            disconnect();
            connectWs(3);
		    break;
		case 4:
            clearColors();
            colors[4]=color_Red;
            disconnect();
            connectWs(4);
		    break;
		case 5:
            clearColors();
            colors[5]=color_Red;
            disconnect();
            connectWs(5);
            break;
		case 6:
            clearColors();
            colors[6]=color_Red;
            disconnect();
            connectWs(6);
		    break;
		default:
			console.log(key);
	}

}

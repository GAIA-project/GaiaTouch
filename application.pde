
window.smallSize = 30;
var bigSize = 50;
window.iconHeight = 500;
var buttonHeight = 410;
var count = 2;
PImage l;
PImage t;
PImage h;
void setup() {
   size(800, 600);
   
   l = loadImage("/GaiaTouch/img/download.png");
   t = loadImage("/GaiaTouch/img/temperature.png");
   h = loadImage("/GaiaTouch/img/humidity.png");

}
window.color_White=#FFFFFF;
window.color_Red=#FF0000;
window.color_Green=#00FF00;
window.color_Blue=#0000FF;
window.color_Purple=#FFFF00;

window.colorT=color_White;
window.colorH=color_White;
window.colorK=color_White;
window.colorL=color_White;

window.valueT=random(50);
window.valueH=random(50);
window.valueK=random(50);
window.valueL=random(50);

void draw(){
background(100);
  stroke(0);

  fill(colorT);
  ellipse(100, buttonHeight, smallSize, smallSize);
  fill(colorH);
  ellipse(200, buttonHeight, smallSize, smallSize);
  fill(color_White);
  ellipse(400, buttonHeight, bigSize, bigSize);
  fill(colorK);
  ellipse(600, buttonHeight, smallSize, smallSize);
  fill(colorL);
  ellipse(700, buttonHeight, smallSize, smallSize);  
  fill(color_White);

  image(t, 100-50,iconHeight-50, 100,100);
  image(h, 200-50,iconHeight-50, 100,100);
  image(l, 400-50,iconHeight-25, 100,50);
  image(t, 600-50,iconHeight-50, 100,100);
  image(h, 700-50,iconHeight-50, 100,100);
  for (var i=0;i<count;i++){
	println('');  
  }
  textSize(50);
  text(int(valueT), 100-25, 300); 
  text(int(valueH), 200-25, 300); 
  text(int(valueK), 600-25, 300); 
  text(int(valueL), 700-25, 300); 
  textSize(30);
  text("°C", 100-15, 350); 
  text("%", 200-15, 350); 
  text("db", 600-15, 350); 
  text("lum", 700-15, 350); 
}

    
interface Javascript {}
Javascript javascript=null;
void bindJavascript(Javascript js) { javascript=js; }

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
			if (colorT==color_Red){
				colorT=color_White;
			} else {
				colorT=color_Red;
			}
		break;
		case 119:
			if (colorH==color_Green){
				colorH=color_White;
			} else {
				colorH=color_Green;
			}
		break;
		case 101:
			if (colorK==color_Blue){
				colorK=color_White;
			} else {
				colorK=color_Blue;
			}			
		break;	
		case 114:
			if (colorL==color_Purple){
				colorL=color_White;
			} else {
				colorL=color_Purple;
			}			
		break;	
		default:
			console.log(int(key));
	}
	
}

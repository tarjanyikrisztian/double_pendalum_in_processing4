float r1 = 200;
float r2 = 200;
float m1 = 40;
float m2 = 40;
float a1 = PI/2;
float a2 = PI/2;
float a1_v = 0;
float a2_v = 0;
float g = 0.98;
int lineR = 0;
int lineG = 255;
int lineB = 255;
boolean down = true;
int ran;

float px2 = -1;
float py2 = -1;
float cx, cy;

PGraphics canvas;


void setup(){
  size(800,800);
  smooth();
  ran = floor(random(3));
  println(ran);
  cx = width/2;
  cy = 400;
  canvas = createGraphics(width, height);
  canvas.beginDraw();
  canvas.background(0);
  canvas.endDraw();
}

void draw(){
  imageMode(CORNER);
  image(canvas, 0, 0, width, height);
  translate(cx, cy);
  stroke(255);
  strokeWeight(2);
  
  float num1 = -g * (2 * m1 + m2) * sin(a1);
  float num2 = -m2 * g * sin(a1-2*a2);
  float num3 = -2*sin(a1-a2)*m2;
  float num4 = a2_v*a2_v*r2+a1_v*a1_v*r1*cos(a1-a2);
  float den = r1 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a1_a = (num1 + num2 + num3*num4) / den;

  num1 = 2 * sin(a1-a2);
  num2 = (a1_v*a1_v*r1*(m1+m2));
  num3 = g * (m1 + m2) * cos(a1);
  num4 = a2_v*a2_v*r2*m2*cos(a1-a2);
  den = r2 * (2*m1+m2-m2*cos(2*a1-2*a2));
  float a2_a = (num1*(num2+num3+num4)) / den;
  
  
  float x1 = r1 * sin(a1);
  float y1 = r1 * cos(a1);
  float x2 = x1 + r2 * sin(a2);
  float y2 = y1 + r2 * cos(a2);
  line(0, 0, x1, y1);
  fill(255);
  ellipse(x1, y1, m1, m1);
  line(x1, y1, x2, y2);
  fill(255);
  ellipse(x2, y2, m2, m2);
  
  a1_v += a1_a;
  a2_v += a2_a;
  a1 += a1_v;
  a2 += a2_v;
  a1_v *= 0.999;
  a2_v *= 0.999;
  
  canvas.beginDraw();
  canvas.translate(cx, cy);
  if (frameCount > 1) {
    switch(ran){
    case(0):
    if(lineR==0){ down = false; ran = floor(random(3));}
    else if(lineR==255){ down = true; ran = floor(random(3));}
    if(down)lineR--;
    else lineR++;
    break;
    case(1):
    if(lineG==0){ down = false; ran = floor(random(3));}
    else if(lineG==255){ down = true; ran = floor(random(3));}
    if(down)lineG--;
    else lineG++;
    break;
    case(2):
    if(lineB==0){ down = false; ran = floor(random(3));}
    else if(lineB==255){ down = true; ran = floor(random(3));}
    if(down)lineB--;
    else lineB++;
    break;
    }
    
    canvas.stroke(lineR,lineG,lineB,122.5);
    canvas.line(px2, py2, x2, y2);
  }
  canvas.endDraw();


  px2 = x2;
  py2 = y2;
  
}

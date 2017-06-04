import processing.opengl.*;

ParticleSystem ps;

PFont f;
PImage intro, bubble;
PImage sprite;  
PImage turtle1, turtle2, turtle3;
PImage egg;
PImage bird1, bird2;
PImage crab1, crab2, crab3;
PImage beach, sandy, sea;

boolean input = false;
float tsize = 10; // touch size
float tdsize = 1; // touch diff size
String name = " ";
int dx = 0, dy = 0;
int tx[] = {0, 0, 0}, ty[] = {0, 0, 0};
int tdx[] = {3, 3, 5}, tdy[] = {3, 3, 5};
int time_sec = 0;

int level = -1;
int step = 0;
int count = 0;
int c = 0;

void imageinit()
{
  intro = loadImage("intro.png");
  bubble = loadImage("bubble.png");
  turtle1 = loadImage("turtle1.png");
  turtle2 = loadImage("turtle2.png");
  turtle3 = loadImage("turtle3.png");
  egg = loadImage("egg.png");
  beach = loadImage("beach.png");
  bird1 = loadImage("bird1.png");
  bird2 = loadImage("bird2.png");
  crab1 = loadImage("crab1.png");
  crab2 = loadImage("crab2.png");
  crab3 = loadImage("crab3.png");
  sandy = loadImage("sandy.png");
  sea = loadImage("sea.png");
  sprite = loadImage("sprite.png");
}

void setup() {
  size(800, 600, OPENGL);
  orientation(LANDSCAPE);
  
  imageinit();
  ps = new ParticleSystem(50);
  
  fill(0);

  f = createFont("모리스9", 40, true);
  textFont(f);
  textAlign(CENTER);
  smooth();
}

void touchCursor()
{
  ps.update();
  ps.display();
  
  ps.setEmitter(mouseX,mouseY);
}

void drawTextBox(String text)
{
  rectMode(CORNER);
  fill(0, 0, 255, 70);
  rect(0, height*4.0/5, width, height);

  pushMatrix();
  translate(0, height*4.5/5);
  writeText(text);
  popMatrix();
}

void writeText(String text)
{
  float tlength = 0;
  fill(0);
  for (int i = 0; i < text.length(); i++)
  {
    pushMatrix();
    char currentChar = text.charAt(i);
    float w = textWidth(currentChar);

    tlength += w;
    translate(tlength, 0);
    text(currentChar, 0, 0);
    popMatrix();
  }
}

void keyPressed() {

  if (step == 3)
  {
    if (key == ENTER)
      input = true;

    if (!input)
    {
      if ((key >= 'a' && key <= 'z') || (key >='A' && key <='Z'))
        name += key;

      if (key == BACKSPACE)
      {
        if (name.length() > 1)
          name = name.substring(0, name.length()-1);
      }
    }
  }

  if (step == 4)
  {
    if (key == CODED)
    {
      if (keyCode == UP)
        dy -= height/10;

      else if (keyCode == DOWN)
        dy += height/10;

      else if (keyCode == LEFT)
        dx -= width/10;

      else if (keyCode == RIGHT)
        dx += width/10;
    }
    
    if (dx > width/3.5 && dy < -height/2.5) // Next key 5
      step = 5;
  }
}


void drawTitle()
{
  String title = "F i n d i n g  T U R T L E";

  pushMatrix();
  translate(width / 2, height / 2);
  imageMode(CENTER);
  image(intro, 0, 0, width, height);

  pushMatrix();
  translate(-textWidth(title)/2, 0);
  float tlength = 0;
  fill(0);
  for (int i = 0; i < title.length(); i++)
  {
    pushMatrix();
    char currentChar = title.charAt(i);
    float w = textWidth(currentChar);

    tlength += w;
    translate(tlength, 0);
    text(currentChar, 0, 0);
    popMatrix();
  }
  popMatrix();
  popMatrix();
}

void mousePressed()
{
  c = 255;
}

void mouseReleased()
{
  c = 0;
}

void mouseClicked()
{
  if (level == -1)
    level = 0;

  if (level == 0)
  {
    if (step == 0)
      if (mouseX > width/3.2 - width/17 && mouseX < width/4 + width/17)
        if (mouseY > height/1.25 - width/15 && mouseY < height/1.3 + width/15)
        {
          level = 1;
          step = 1;
        }
  }

  if (level == 1)
  {
    if (step == 1)
      if (mouseX > width/2.5 && mouseX < width/1.7)
        if (mouseY > height/3 && mouseY < height/1.5)
          count++;

    if (step == 2)
      step = 3;

    if (step == 3 && input)
      step = 4;

    if (step == 5)
    {
      level = 2;
      step = 6;
    }
  }
}

void draw() {
  background(255);
  if (level == -1) // title
  {
    drawTitle();
    for (int i = 0; i < 50; i++) {
    float x = random(width);
    float y = random(height);
    image(bubble, x, y, width/30, width/30);
  }
    delay(200);
  }

  if ((level == 0 || level == 1) && step < 4)
  {
    imageMode(CORNER);
    image(beach, 0, 0, width, height);

    imageMode(CENTER);
    image(egg, width/3.2, height/1.3, width/17, width/15);
    image(egg, width/4, height/1.3, width/17, width/15);
    image(egg, width/3.6, height/1.25, width/17, width/15);
  }

  if (level == 0) // tutorial
  {
    if (step == 0)
      drawTextBox("거북이 알을 터치하세요!");
  }

  if (level == 1)
  {
    if (step == 1)
    {
      drawTextBox("알을 터치하여 거북이를 태어나게 해주세요.");
      image(egg, width/2, height/2, width/4.5, height/3);

      if (count >= 3)
      {
        step = 2;
      }
    }

    if (step == 2 || step == 3)
      image(turtle1, width/2, height/2, width/5, height/4);
      
    if (step == 2)
      drawTextBox("거북이의 이름을 지어주세요.");

    if (step == 3)
    {
      if (name == " ")
        drawTextBox("거북이의 이름을 입력하신 후 확인을 눌러주세요");

      if (name != " " && !input)
        drawTextBox(name);

      if (name != " " && input)
        drawTextBox(name + "는(은) 예쁜 이름이네요 !");
    }

    if (step == 4)
    {
      for (int i=0; i<3; i++)
      {
        tx[i] += tdx[i];
        ty[i] += tdy[i];

        if (i<2)
        {
          if (tx[i] > width/15 || tx[i] < 1)
            tdx[i] =- tdx[i];

          if (ty[i] > width/15 || ty[i] < 1)
            tdy[i] =- tdy[i];
        } else
          if (tx[i] > width/10 || tx[i] < 1)
            tdx[i] =- tdx[i];
      }

      imageMode(CORNER);
      image(sandy, 0, 0, width, height);
      imageMode(CENTER);
      image(turtle1, width/2 + dx, height/1.5 + dy, width/5, height/4);
      image(bird1, width/1.25 + tx[0], height/1.65 + ty[0], width/4.5, height/4);
      image(bird2, width/4.5 + tx[1], height/13.5 + ty[1], width/4.5, height/4);
      image(crab1, width/6.5 + tx[2], height/2.5, width/6.5, height/6);
      image(crab2, width/1.6 - tx[2], height/2, width/6.5, height/6);

      drawTextBox(name + "을(를) 바다까지 안전하게 보내주세요 !");
    }

    if (step == 5)
    {
      imageMode(CORNER);
      image(sea, 0, 0, width, height);
      drawTextBox("미션 성공 !!");
    }
  }

  if (level == 2)
  {
  }

  if (level != -1)
  touchCursor();
}

void timer()
{
  time_sec = millis()/1000;
}
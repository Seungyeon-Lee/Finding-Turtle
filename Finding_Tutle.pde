import processing.opengl.*;

PFont f;
PImage arrow;
PImage tutle1, tutle2, egg;
PImage beach;

boolean click = false;
boolean input = false;
boolean next = false;
float tsize = 10; // touch size
float tdsize = 1; // touch diff size
String name = " ";
int level = -1;
int count = 0;
int namecnt = 0;

void setup() {
  size(800, 600, OPENGL);
  orientation(LANDSCAPE);
  fill(0);
  arrow = loadImage("arrow.png");
  tutle1 = loadImage("tutle1.gif");
  tutle2 = loadImage("tutle2.png");
  egg = loadImage("egg.png");
  beach = loadImage("beach.png");
  f = createFont("Georgia", 40, true);
  textFont(f);
  textAlign(CENTER);
  smooth();
}

void touchCursor()
{
  noStroke();
  fill(0);
  tsize += tdsize;
  if (tsize>30 || tsize<1) tdsize = -tdsize;

  frameRate(500);
  ellipseMode(CENTER);
  ellipse(mouseX, mouseY, tsize, tsize);
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
  textMode(CENTER);
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
  if (key == ENTER)
    input = true;

  if (!input)
  {
    name += key;

    if (key == BACKSPACE)
    {
      if (name.length() > 2)
        name = name.substring(0, name.length()-2);
    }
  }
}


void drawTitle()
{
  String title = "Finding Tutle";
  float r = width / 5; // The radius of a circle
  // Start in the center and draw the circle
  pushMatrix();
  translate(width / 2, height / 2);
  imageMode(CENTER);
  image(tutle1, 0, 0, width / 3, width / 3);

  // We must keep track of our position along the curve
  float arclength = 0;

  // For every box
  for (int i = 0; i < title.length(); i++)
  {
    // Instead of a constant width, we check the width of each character.
    char currentChar = title.charAt(i);
    float w = textWidth(currentChar);

    // Each box is centered so we move half the width
    arclength += w/2;
    // Angle in radians is the arclength divided by the radius
    // Starting on the left side of the circle by adding PI
    float theta = PI + arclength / r;    

    pushMatrix();
    // Polar to cartesian coordinate conversion
    translate(r*cos(theta), r*sin(theta));
    // Rotate the box
    rotate(theta+PI/2); // rotation is offset by 90 degrees
    // Display the character
    fill(0);
    text(currentChar, 0, 0);
    popMatrix();
    // Move halfway again
    arclength += w/2;
  }
  popMatrix();
}

void draw() {
  background(255);
  if (level == -1)
  {
    drawTitle();
    imageMode(CENTER);
    image(arrow, width * 4.0 / 5, height * 4.0 / 5, width / 6, width / 6);

    if (mouseX > width * 4.0 / 5 - width / 12 && mouseX < width * 4.0 / 5 + width / 12)
      if (mouseY > height * 4.0 / 5 - width / 12 && mouseY < height * 4.0 / 5 + width / 12)
        if (mousePressed)
          level = 0;
  }

  if (level == 0)
  {
    String text1 = "Touch Eggs!";
    String text2 = "Continue pressing the egg to break it.";
    String text3 = "Please make a name the turtle.";
    String text4 = "Type in the name and press Enter. ";
    String text5 = " is a nice name!";

    imageMode(CORNER);
    image(beach, 0, 0, width, height);

    imageMode(CENTER);
    image(egg, width/3.2, height/1.3, width/17, width/15);
    image(egg, width/4, height/1.3, width/17, width/15);
    image(egg, width/3.6, height/1.25, width/17, width/15);

    if (!click && count < 50)
      drawTextBox(text1);

    if (mouseX > width/3.2 - width/17 && mouseX < width/4 + width/17)
      if (mouseY > height/1.25 - width/15 && mouseY < height/1.3 + width/15)
        if (mousePressed)
          click = true;

    if (click)
    {
      drawTextBox(text2);
      image(egg, width/2, height/2, width/4.5, height/3);

      if (mouseX > width/2.5 && mouseX < width/1.7)
        if (mouseY > height/3 && mouseY < height/1.5)
          if (mousePressed)
            count++;
    }

    if (count > 50 && !next)
    {
      drawTextBox(text3);
      click = false;
      image(tutle2, width/2, height/2, width/4.5, height/4);

      imageMode(CENTER);
      image(arrow, width * 4.0 / 5, height * 4.0 / 5, width / 6, width / 6);

      if (mouseX > width * 4.0 / 5 - width / 12 && mouseX < width * 4.0 / 5 + width / 12)
        if (mouseY > height * 4.0 / 5 - width / 12 && mouseY < height * 4.0 / 5 + width / 12)
          if (mousePressed)
            next = true;
    }

    if (next)
    {
      image(tutle2, width/2, height/2, width/4.5, height/4);
      if (name == " ")
        drawTextBox(text4);

      if (name != " ")
        drawTextBox(name);

      if (name != " " && input)
        drawTextBox(name+text5);
    }
  }

  touchCursor();
}
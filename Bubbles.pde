/*
   Processing : 2.0.3
   Code : Smileblue(blue@makeprocessing.com)
   This code is free.
*/

class Bubbles
{
  float xpos, ypos;
  float speed;
  float w_size;
  color p_color;
  
  Bubbles(float temp_xpos, float temp_ypos, float temp_speed)
  {
    xpos = temp_xpos;
    ypos = temp_ypos;
    speed =  temp_speed;
    w_size = random(2, 15);
    p_color = color(random(255), random(255), random(255));
  }
   
  void display()
  {
    fill(p_color);
    image(bubble, xpos, ypos, w_size, w_size);
  }
   
  void drive()
  {
    ypos = ypos - speed;
    if(ypos < -10)
    {
      ypos = height + 10;
      xpos = random(width);
      p_color = color(random(255), random(255), random(255));
      w_size = random(2, 15);
      speed = random(0.5, 3);
    }
  }
}
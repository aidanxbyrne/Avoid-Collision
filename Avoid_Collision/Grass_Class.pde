class Grass
{
  PImage grassImg;
  float grassX;
  float grassY;
  float grassW;
  float grassH;
  float speed;
  
  Grass(PImage tempImg, float tempX, float tempY, float tempW, float tempH)
  {
    grassImg = tempImg;
    grassX = tempX;
    grassY = tempY;
    grassW = tempW;
    grassH = tempH;
    speed = 10;
  }
  
  void display()
  {
    //Load image of the grass
    image(grassImg, grassX, grassY, grassW, grassH);
  }
  
  void move()
  {
    //give the grass speed
    grassY = grassY + (speed * 1);
    
    //if grass moves off screen, reset back to top 
    if(grassY > 800)
    {
      grassY = -100;
    }
  }
}

class Roadline
{
  float roadX;
  float roadY;
  float roadW;
  float roadH;
  float roadSpeed;
  
  Roadline(float tempX, float tempY, float tempW, float tempH)
  {
    roadX = tempX;
    roadY = tempY;
    roadW = tempW;
    roadH = tempH;
    roadSpeed = 10;
  }
  
  void display()
  {
    //generate roadlines
    rectMode(CORNER);
    fill(255, 206, 0);
    rect(roadX, roadY, roadW, roadH);
  }
  
  void move()
  {
    //Give Speed to the roadlines
    roadY = roadY + (roadSpeed * 1);
    if(roadY > 800)
    {
      roadY = -100;
    }
    
  }
}

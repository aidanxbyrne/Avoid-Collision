class Obstacle
{
  PImage obstacle;
  
  float posX;
  float posY;
  float posW;
  float posH;
  float speed;
  
  Obstacle(PImage tempOb, float tempX, float tempY, float tempW, float tempH)
  {
    posX = tempX;
    posY = tempY;
    posW = tempW;
    posH = tempH;
    obstacle = tempOb;
    speed = 10;
  }
  
  void display()
  {
   //Create obstacles images based on defined variables
   image(obstacle, posX, posY, posW, posH);
  }
  
  void move()
  {
    //Give movement to the obstacle
    posY = posY + (speed * 1);
    
    //If the obstacle moves off screen reset back to top and change obstacle
    if( posY >= 800)
    {
      ranObstacle = random(-1, 6); //Calculates a new random position in the obstacle array
      randomObstacle = int(ranObstacle);
      posY = 0 - posH;
      posX = random(170, 580);
      posY = posY + (speed * 1);
      avoided++; //Increase score as car has successfully passed obstacle
      success.play();
      success.rewind();
    }
  }
  
  void speed()
  {
    //Increase the speed depending on the progress of user
    if (avoided >= 5)
      {
        speed = random(12, 17);
      }
    if (avoided >= 10)
      {
        speed = random (15, 20);
      }
    if (avoided >= 20)
      {
        speed = random(20, 25);
      }
    if (avoided >= 30)
      {
        speed = random(25, 30);
      }
    if (avoided >= 40)
      {
        speed = random(30, 35);
      }
     if (avoided >= 50)
      {
        speed = random(35, 40);
      }
    if (avoided >= 60)
      {
        speed = random(40, 45);
      }
    if (avoided >= 70)
      {
        speed = random(45, 50);
      }
    //No more increases as it is near impossible for the user to react fast enough at this point and if they do, they won't survive long
  }
}

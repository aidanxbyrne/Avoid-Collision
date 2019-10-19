class Perk 
{
  
  float posX;
  float posY;
  boolean run;
  PImage perk;
  
  Perk(float tempX, float tempY)
  {
    posX = tempX;
    posY = tempY;
    speed = 40;
    run = true;
    perk = loadImage("perk1.png");
  }
  
  void display()
  {
    imageMode(CENTER);
    fill(255, 0, 0);
    image(perk, posX, posY, 40, 40);
    imageMode(NORMAL);
  }
  
  void move()
  {
    if(run == true)
    {
      posY = posY + (speed * 1);
    }
  }
  
  void objects()
  {
    //Generates a perk depending on score
    if(avoided == 15)
    {
      myPerk[0].display();
      myPerk[0].move();
    }
    if(avoided == 30)
    {
      myPerk[1].display();
      myPerk[1].move();
    }
    if(avoided == 50)
    {
      myPerk[2].display();
      myPerk[2].move();
    }
    if(avoided == 70)
    {
      myPerk[3].display();
      myPerk[3].move();
    }
    if(avoided == 90)
    {
      myPerk[4].display();
      myPerk[4].move();
    }
  }
  
}

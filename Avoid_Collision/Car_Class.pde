class Car
{
  PImage car1;
  PImage car2;
  PImage car3;
  PImage cars;
  String[] carimg = {"car1.png", "car2.png"};
  float carW;
  float carH;
  float carX;
  float carY;
  int i;
  
  Car(PImage tempCar, float tempX, float tempY, float tempW, float tempH)
  {
    carX = tempX;
    carY = tempY;
    carW = tempW;
    carH = tempH;
    cars = tempCar;
  }
  
  void display()
  {
    //Load Car PImages
    car1 = loadImage("car1.png");
    car2 = loadImage("car2.png");
    car3 = loadImage("car3.png");
    
    imageMode(CORNER);
    if(usercar == 1)
    {
      image(car1, carX, carY, carW, carH);
    }
    if(usercar == 2)
    {
      image(car2, carX, carY, carW, carH);
    }
    if(usercar == 3)
    {
      image(car3, carX, carY, carW, carH);
    }
  }
  
  void carChoice()
  {
    imageMode(CENTER);
    image(cars, carX, carY, carW, carH);
  }
  
  void hover() //Car size will increase when hovered
  {
     if ((mouseX > carX - carW/2 && mouseX < carX + carW/2) && (mouseY > carY - carH/2 && mouseY < carY + carH/2))
     {
       if (carW <= 100)
       {
         carW++;
         carH = carH + 1.9333333;
       }
     }
     else
     {
       if (carW > 90)
       {
         carW--;
         carH = carH - 1.9333333;
       }
     }
  }
}

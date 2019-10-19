//Import Minim sound library
import ddf.minim.*;

//Create sound variables
//Learned about the basics and structure of Minim through a YouTube video
//Title: 'Using Sound in Processing with Minim' User: John Park Link: https://www.youtube.com/watch?v=LcX36OxgZgg
Minim minim;
AudioPlayer success;
AudioPlayer crash;
AudioPlayer bgSong;
AudioPlayer engine;
AudioPlayer powerup;
Boolean soundPlay;

int i;
int time; //time since beginning of sketch
int inTime; //Time when user collects perk
int perkLength; //Length the perk effects last

PImage car;
PImage grad;

//Car Image Dimensions
float imgX;
float imgY;

//Create car objects with the class Car
//Learned about how classes are structured in Daniel Shiffman's book 'Learning Processing'
//Shiffman, D. (2009). Learning Processing. Burlington: Elsevier Science, pp.121-136.
Car myCar;
Car myCar2;
Car myCar1;
Car myCar3;

//Create array of Roadline objects with the class Roadline
Roadline[] roadlines = new Roadline[6];

//create array of Grass
Grass[] grassblock = new Grass[10];
Grass[] grassblock2 = new Grass[10];

//Create Perk Class
Perk[] myPerk = new Perk [10];

//Create Array of obstacles with the class Obstacle
Obstacle[] myObstacle = new Obstacle[6];
float ranObstacle;
int randomObstacle;

int screen;
int usercar;
boolean optionbox;  //Boolean for Checkbox in options menu

PFont eightbitmad;
float txtsize;
float txtdirection;

//Create strings to be used on buttons
String startgame = "Start Game";
String startopt = "Options";
String back = "< Back";
String endgame = "End Game";

int directionY = 1;
float speed;

String score;
int avoided;

void setup()
{
  size(800, 800);
  frameRate (30);
  noStroke();
  
  eightbitmad = loadFont("8-Bit-Madness-48.vlw");
  eightbitmad = loadFont("8-Bit-Madness-72.vlw");
  txtsize = 72;
  txtdirection = 1;
  imgX = 90;
  imgY = 174;
  //Gradient background image
  grad = loadImage("grad.png");

  //Minim Sound Files
  minim = new Minim(this);
  success = minim.loadFile("ping.mp3"); /*Freesound.Org User: LittleRainySeasons License: Creative Commons 0 
                                          Link: https://freesound.org/people/LittleRainySeasons/sounds/335908/ */
  crash = minim.loadFile("crash.wav");  /*Freesound.Org User: Eponn License: Creative Commons 0 
                                          Link: https://freesound.org/people/Eponn/sounds/420356/ */
  bgSong = minim.loadFile("Home.mp3");  /*DL-Sounds.com TrackName:Spy Hunter Producer: Pascal Tatipata License: Creative Commons 0
                                          Link: https://www.dl-sounds.com/royalty-free/spy-hunter/ */
  engine = minim.loadFile("car.mp3");   /*Freesound.Org User: GiocoSound License: Creative Commons 0 
                                          Link: https://freesound.org/people/GiocoSound/sounds/401558/ */
  powerup = minim.loadFile("powerup.wav"); /*Freesound.Org User: GameAudio License: Creative Commons 0 
                                             Link: https://freesound.org/people/GameAudio/sounds/220173/ */
  soundPlay = true;
                                          
  //Finds number of seconds program has been running
  time = millis() / 1000;
  
  //Defines timer for Perk
  inTime = millis(); 
  perkLength = 15000; //perk length is 10 seconds
  
  //Define Score
  score = "score: " + avoided;
  avoided = 0; //Objects avoided
  speed = 10;

  //Loads car objects of the class Car
  myCar = new Car(car, mouseX - 45, 600, imgX, imgY);
  myCar2 = new Car(loadImage("car2.png"), width/2, height/2, imgX, imgY);
  myCar1 = new Car(loadImage("car1.png"), width/3.5, height/2, imgX, imgY);
  myCar3 = new Car(loadImage("car3.png"), width - width/3.5, height/2, imgX, imgY);

  //Loads roadline Objects of the class Roadline
  for (i = 0; i < roadlines.length; i++)
  {
    roadlines[i] = new Roadline(width/2 - 12.5, 150 * i, 25, 100);
  }
  
  //Loads grass objects on left side of road
  for (i = 0; i < grassblock.length; i++)
  {
    grassblock[i] = new Grass(loadImage("grass2.png"), 0, (100 * i) - 100, 100, 100);
  }
  
  //Loads grass objects on right side of road
  for (i = 0; i < grassblock2.length; i++)
  {
    grassblock2[i] = new Grass(loadImage("grass3.png"), 700, (100 * i) - 100, 100, 100);
  }

  //Loads obstacle objects of the class Obstacle
  myObstacle[0] = new Obstacle(loadImage("bus.png"), random(170, 580), -240, 90, 240);
  myObstacle[1] = new Obstacle(loadImage("truck.png"), random(170, 580), -240, 90, 240);
  myObstacle[2] = new Obstacle(loadImage("boulder.png"), random(170, 580), -50, 90, 90);
  myObstacle[3] = new Obstacle(loadImage("blueCar.png"), random(170, 580), -120, 90, 174);
  myObstacle[4] = new Obstacle(loadImage("redCar.png"), random(170, 580), -120, 90, 174);
  myObstacle[5] = new Obstacle(loadImage("greenCar.png"), random(170, 580), -120, 90, 174);
  ranObstacle = random(-1, 6); //Finds randome number between -1 and 6 as a float
  randomObstacle = int(ranObstacle); //converts ranObstacle to an integer
  
  //Load Perk object of the class Perk
  for(i = 0; i < myPerk.length; i++)
  {
    myPerk[i] = new Perk(random(115, 685), 0);
  }
}


void draw()
{
  //Play background music and repeat every time is ends
  //Originally attempted to use .loop() function of minim which would not work for some reason. This is the best solution I could find around it
  bgSong.play();
  time = millis() / 1000;
  if(time > 0 && time % (bgSong.length()/1000) == 0) //If the time in seconds since the program began divided the song length in seconds = 0 then song has ended and restart
  {
   bgSong.pause();
   bgSong.rewind(); 
  }
  
  //Switch to determine which screen the user will be shown
  switch(screen)
  {
  case 1:
    startScreen(); //Main Start Screen
    break;

  case 2:
    chooseCar(); //User chooses car before starting the game
    break;

  case 3:
    game(); //User plays the game
    break;

  case 4:
    gameOptions(); //Options Screen
    break;

  case 5:
    gameOver(); //Game over Screen
    break;

  default:
    screen = 1; //Sets initial screen to Start Screen
    break;
  }

  //Switch for the car the user has chosen
  switch(usercar)
  {
  case 1:
    myCar.display();
    break;

  case 2:
    myCar.display();
    break;

  case 3:
    myCar.display();
    break;
  }
  
  //Options Menu Toggles
  if(soundPlay == true)
  {
    bgSong.unmute();
  }
  else
  {
    bgSong.mute();
  }
  
  if(optionbox == true)
  {
    filter(GRAY);
  }
  else
  {
    filter(NORMAL);
  }
  
}


void startScreen() //Inital Screen when program is loaded
{
  background(grad);
  fill(255);
  textFont(eightbitmad);

  //Main Game Title
  textSize(txtsize);
  textAlign(CENTER);
  text("Avoid Collision", width/2, height/3);
  txtsize = txtsize + (0.3 * txtdirection);   //Increase text size by 0.3 in a certain direction
  if (txtsize >= 82 || txtsize <= 72)         //if the text size reaches 82, flip the direction
  {
    txtdirection = txtdirection * -1;
  }

  //Start Game Button
  textSize(48);
  textAlign(LEFT);
  text(startgame, 100, height/1.5);

  //Options Button
  textSize(48);
  textAlign(RIGHT);
  text(startopt, 700, height/1.5);

  //Change cursor if mouse is over buttons
  if ((mouseX > 100 && mouseX < 100 + textWidth(startgame) && mouseY > height/1.5 - 40 && mouseY < height/1.5) ||
    (mouseX > 700 - textWidth(startopt) && mouseX < 700 && mouseY > height/1.5 - 40 && mouseY < height/1.5))
  {
    cursor(HAND);
  } else
  {
    cursor(ARROW);
  }
}


void chooseCar()  //Screen showen when user clicks to start game. Must select their car here
{
  background(grad);
  fill(255);
  textFont(eightbitmad);

  //Choose Car Title
  textSize(72);
  textAlign(CENTER);
  text("Choose Your Car", width/2, height/4);

  //Back button to Start Screen
  textSize(48);
  textAlign(LEFT);
  text(back, 50, 750);

  //Load Car1 Data
  myCar1.carChoice();
  myCar1.hover();

  //Load Car2 Data
  myCar2.carChoice();
  myCar2.hover();

  //Load Car3 Data
  myCar3.carChoice();
  myCar3.hover();
  
  //Instruction Text
  textSize(35);
  textAlign(CENTER);
  text("Use your mouse to avoid oncoming vehicles", width/2, height/1.32);
  textSize(35);
  textAlign(CENTER);
  text("The more you pass, the faster they come", width/2, height/1.22);

  //If mouse is over buttons, change cursor to hand
  if ((mouseX > 50 && mouseX < 50 + textWidth(back)) && (mouseY > 750 - 48 && mouseY < 750) ||
    (mouseX > width/2 - myCar.carW/2 && mouseX < width/2 + myCar.carW/2) && (mouseY > height/2 - myCar.carY/2 && mouseY < height/2 + myCar.carY/2)
    || (mouseX > width/3.5 - myCar.carW/2 && mouseX < width/3.5 + myCar.carW/2) && (mouseY > height/2 - myCar.carY/2 && mouseY < height/2 + myCar.carY/2)
    || (mouseX > width - width/3.5 - myCar.carW/2 && mouseX < width - width/3.5 + myCar.carW/2) && (mouseY > height/2 - myCar.carY/2 && mouseY < height/2 + myCar.carY/2))
  {
    cursor(HAND);
  } else
  {
    cursor(ARROW);
  }
}


void game() //User plays game on this screen after selecting car
{
  //Calls on car class and display chosen on previous screen
  //Constrain prevents car from moving off the side of the road
  myCar = new Car(car, constrain(mouseX, 100 + imgX/2, 700 - imgX/2) - myCar.carW/2, 600, imgX, imgY);
  myCar.display();

  //Loads road
  background(102, 102, 102);
  noStroke();
  smooth();

  //Load Road Line Objects
  for (i=0; i < roadlines.length; i++)
  {
    roadlines[i].display();
    roadlines[i].move();
  }
  
  //Load grass objects
  for(i=0; i < grassblock.length; i++)
  {
    grassblock[i].display();
    grassblock[i].move();
    grassblock2[i].display();
    grassblock2[i].move();
  }

  //Generate a random Obstacle from the obstacle array
  myObstacle[randomObstacle].display();
  myObstacle[randomObstacle].move();
  myObstacle[randomObstacle].speed();
  
  //Generate perks
  myPerk[0].objects();

  //Top Bar
  fill(20, 20, 20);
  rect(0, 0, 800, 50);

  //Score Display
  score = "score: " + avoided;
  fill(255);
  textFont(eightbitmad);
  textSize(40);
  textAlign(CENTER);
  text(score, 100, 35);
  
  //Checks for Collision between car and objects
  for (i = 0; i < myObstacle.length; i++)
  {
    if ((myObstacle[i].posX + myObstacle[i].posW >= myCar.carX) && (myObstacle[i].posX <= myCar.carX + myCar.carW) && 
      (myObstacle[i].posY + myObstacle[i].posH >= myCar.carY) && (myObstacle[i].posY <= myCar.carY + myCar.carH))
    {
      crash.play();
      bgSong.pause();
      screen = 5;
    }
  }
  
  //If Perk is collected, car size halves making it easier to avoid objects
  for(i = 0; i < myPerk.length; i++)
  {
    if((myPerk[i].posX + 40 >= myCar.carX) && (myPerk[i].posX <= myCar.carX + myCar.carW) && (myPerk[i].posY + 40 >= myCar.carY) && (myPerk[i].posY <= myCar.carY + myCar.carW))
    {
      inTime = millis();
      imgX = 45;
      imgY = 87;
      powerup.play();
      powerup.rewind();
    }
  }
  
  //Perk length timer. When timer runs out, return car to normal size
  //If time since the beginning is greater than the time since perk is collected + perk length time
  if(millis() > inTime + perkLength)
  {
    imgX = 90;
    imgY = 174;
  }
}



void gameOver()  //Game over screen shown following collison with obstacle
{
  background(102, 102, 102);
  
  //Load grass objects
  for(i=0; i < grassblock.length; i++)
  {
    grassblock[i].display();
    grassblock2[i].display();
  }
  
  fill(255);

  //Game Over Title
  textSize(72);
  textAlign(CENTER);
  text("Game Over", width/2, height/4);
  
  //Displays number of objects avoided
  textSize(35);
  textAlign(CENTER);
  text("You avoided " + avoided + " collisions", width/2, height/2);
  
  //Top Bar
  fill(20, 20, 20);
  rect(0, 0, 800, 50);
  
  //Score Display
  score = "score: " + avoided;
  fill(255);
  textFont(eightbitmad);
  textSize(40);
  textAlign(CENTER);
  text(score, 100, 35);

  //Exit game button
  textSize(48);
  textAlign(CENTER);
  text(endgame, width/2, height/1.5);

  //If mouse is over button, change cursor to a hand
  if ((mouseX > width/2 - textWidth(endgame)/2 && mouseX < width/2 + textWidth(endgame)/2) && (mouseY > height/1.5 - 48 && mouseY < height/1.5))
  {
    cursor(HAND);
  } else
  {
    cursor(ARROW);
  }
}

void mouseClicked()
{
  if (screen == 1)
  {  
    //If user clicks Start Game button
    if (mouseX > 100 && mouseX < 100 + textWidth(startgame) && mouseY > height/1.5 - 40 && mouseY < height/1.5)
    {
      screen = 2;
      success.play();
      success.rewind();
    }
    //If user clicks Options button
    if (mouseX > 700 - textWidth(startopt) && mouseX < 700 && mouseY > height/1.5 - 40 && mouseY < height/1.5)
    {
      screen = 4;
      success.play();
      success.rewind();
    }
  }

  if (screen == 2)
  {
    //If user clicks Back button
    if ((mouseX > 50 && mouseX < 50 + textWidth(back)) && (mouseY > 750 - 48 && mouseY < 750))
    {
      screen = 1;
      success.play();
      success.rewind();
    }
    //If user selects car1
    if ((mouseX > width/3.5 - imgX/2 && mouseX < width/3.5 + imgX/2) && (mouseY > height/2 - imgY/2 && mouseY < height/2 + imgY/2))
    {
      screen = 3;
      usercar = 1;
      engine.play();
      bgSong.setGain(-10); //Lower the volume of song when game starts
    }
    //If user selects car2
    if ((mouseX > width/2 - imgX/2 && mouseX < width/2 + imgX/2) && (mouseY > height/2 - imgY/2 && mouseY < height/2 + imgY/2))
    {
      screen = 3;
      usercar = 2;
      engine.play();
      bgSong.setGain(-10);
    }
    //if user selects car3
    if ((mouseX > width - width/3.5 && mouseX < width - width/3.5 + imgX/2) && (mouseY > height/2 - imgY/2 && mouseY < height/2 + imgY/2))
    {
      screen = 3;
      usercar = 3;
      engine.play();
      bgSong.setGain(-10);
    }
  }

  if (screen == 4)
  {
    //If user clicks Back button
    if ((mouseX > 50 && mouseX < 50 + textWidth(back)) && (mouseY > 750 - 48 && mouseY < 750))
    {
      screen = 1;
      success.play();
      success.rewind();
    }
    //If user clicks options box
    if((mouseX > 515 - 15 && mouseX < 515 + 15) && (mouseY > 389 - 15 && mouseY < 389 + 15))
    {
      soundPlay = !soundPlay; //Flip boolean value when mouse is clicked
    }
    
    if((mouseX > 515 - 15 && mouseX < 515 + 15) && (mouseY > 459-15 && mouseY < 459 + 15))
    {
      optionbox = !optionbox; //Flip boolean value when mouse is clicked
    }
  }

  if (screen == 5)
  {
    //If user clicks End Game button
    if ((mouseX > width/2 - textWidth(endgame)/2 && mouseX < width/2 + textWidth(endgame)/2) && (mouseY > height/1.5 - 48 && mouseY < height/1.5))
    {
      exit(); //End program
    }
  }
}

void gameOptions()
{
  background(grad);
  fill(255);

  //Game Options Title
  textFont(eightbitmad);
  textSize(72);
  textAlign(CENTER);
  text("Game Options", width/2, height/4);
  
  //Menu Option 1
  textSize(48);
  textAlign(CENTER);
  text("Sound", 300, 400);
  
  fill (0, 0, 0, 0);
  stroke(255);
  strokeWeight(3);
  rectMode(CENTER);
  rect(515, 389, 30, 30);
  
  if((mouseX > 515 - 15 && mouseX < 515 + 15) && (mouseY > 389 - 15 && mouseY < 389 + 15))
  {
    noStroke();
    fill(255);
    rect(515.5, 389.5, 23, 23);
  }
  
  if(soundPlay == true)
  {
    noStroke();
    fill(255);
    rect(515.5, 389.5, 23, 23);
  }
  else
  {
    fill(0, 0, 0, 0);
  }
  
  //Menu Option 2
  fill(255);
  textSize(48);
  textAlign(CENTER);
  text("Greyscale", 300, 470);
  
  fill (0, 0, 0, 0);
  stroke(255);
  strokeWeight(3);
  rect(515, 459, 30, 30);
  
  if((mouseX > 515 - 15 && mouseX < 515 + 15) && (mouseY > 459 - 15 && mouseY < 459 + 15))
  {
    noStroke();
    fill(255);
    rect(515.5, 459.5, 23, 23);
  }
  
  if(optionbox == true)
  {
    noStroke();
    fill(255);
    rect(515.5, 459.5, 23, 23);
  }
  else
  {
    fill(0, 0, 0, 0);
  }

  //Back Button
  textSize(48);
  textAlign(LEFT);
  fill(255);
  text(back, 50, 750);

  //Change cursor if mouse over button
  if ((mouseX > 50 && mouseX < 50 + textWidth(back)) && (mouseY > 750 - 48 && mouseY < 750)
      || (mouseX > 515 - 15 && mouseX < 515 + 15) && (mouseY > 459 - 15 && mouseY < 459 + 15)
      || (mouseX > 515 - 15 && mouseX < 515 + 15) && (mouseY > 389 - 15 && mouseY < 389 + 15))
  {
    cursor (HAND);
  } else
  {
    cursor(ARROW);
  }

  //Mute Sound, Volume
}

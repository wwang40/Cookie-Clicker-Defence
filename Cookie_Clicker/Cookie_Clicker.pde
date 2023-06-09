int cookies = 0;
int health = 100;
boolean buttonPressed = false;
int timer = 0;
int min = 0;
int sec = 0;
boolean start = false;

int autoClick;
int healCost = 10;

PImage startScreen;
PImage gear;
PImage cross;

Turret turret;
Enemy monster = new Enemy(6000, 60, 200,#eb4034, 5);

  
void setup(){
    gear = loadImage("gear.png");
  cross = loadImage("health.png");
  size(1280, 720);
if(start){
background(#42a4f5);
fill(#a7d889);
stroke(#a7d889);
rect(width/2 - 200, 0, width/2 + 200,height); //grass
fill(#7d8c80);
stroke(#7d8c80);
rect(width/2 - 200, 0, 160,height); //wall
fill(#9c6c43);
stroke(#7a583a);
strokeWeight(5);
circle(220,200,300); // cookie
fill(#331b06);
stroke(#331b06);
rect(140,150,25,45);
rect(280,190,25,45);
rect(130,240,25,45);
rect(220,75,25,45);
fill(#404741);
stroke(#7d807d);
rect(120 , 370, 200, 50);

fill(#7d807d);
noStroke();
rect(120 , 450, 200, 50); //UPGRADE BUTTON SIZE
fill(#000000);
textSize(20);
text("UPGRADE SIZE = 10",125, 485);

fill(#7d807d);
noStroke();
rect(120, 450 + 60, 200, 50); //UPGRADE BUTTON DAMAGE
fill(#000000);
textSize(20);
text("UPGRADE DAMAGE = 10",125, 485 + 60);

fill(#7d807d);
noStroke();
rect(120, 450 + 120, 200, 50); //UPGRADE BUTTON SPEED
fill(#000000);
textSize(20);
text("UPGRADE SPEED = 15",125, 485 + 120);

fill(#7d807d);
noStroke();
rect(330, 450, 100, 200); //UPGRADE BUTTON AUTO
fill(#000000);
textSize(20);
text("AUTO = 20",335, 480);
gear.resize(150,150);
image(gear,305,480);

fill(#7d807d);
noStroke();
rect(7, 450, 100, 200); //HEAL BUTTON
fill(#000000);
textSize(20);
text("HEAL = " + healCost,13, 480);
cross.resize(90,90);
image(cross,13,500);

turret = new Turret("base", width/2 - 130, height/2);
monster.spawn();

monster.towerHealth = health;
fill(#404741);
stroke(#7d807d);
rect(15, height - 60, 405, 30);
fill(#5bb06a);
noStroke();
rect(18, height - 57, (400/100)*health, 26);
}else{
startScreen = loadImage("startScreen.jpg");
}
}

void draw(){
  if(start){
    if(health>0){
  if(frameCount%60 == 0){
    sec++;
  }
  if(frameCount%60 == 0){
    fill(#42a4f5);
    noStroke();
    rect(0,0,150,50);
    fill(#FFFFFF);
    textSize(40);
    text(min + ":" + sec,30, 40);
  }
  if(frameCount%60 == 0){
    cookies += autoClick; 
  }
  fill(#404741);
  stroke(#7d807d);
  rect(120 , 370, 200, 50);
  fill(#5bb06a);
  textSize(50);
  text(cookies,130, 410);
  if(sec%60==0 && sec != 0){
  min++;
  sec = 0;
  }
  int seconds = min * 60 + sec; 
  if(seconds%20==0 && sec != 0){
  //public void mutate(int hp, int spd, int sz, color shape, int dmg)
    color ranColor = color((int)random (0, 255), (int)random (0, 255), (int)random (0, 255));
  if(monster.size < 30){
  monster.mutate(100, 1, 0, ranColor, 0);
  }
  else{
  monster.mutate(100, 1, -1, ranColor, 0);
  }
  }
  //creates monsters
  if(frameCount%60 == 0){
   monster.spawn();
  }
   monster.attack();
   turret.turn(mouseX, mouseY);
   turret.shoot();
   
   health = monster.towerHealth;
   /*(turret.bullets.get(iter).x > monster.x.get(i) 
        && turret.bullets.get(iter).x < monster.x.get(i) + monster.size
        && turret.bullets.get(iter).y > monster.y.get(i) 
        && turret.bullets.get(iter).y < monster.y.get(i) + monster.size)
        || (turret.bullets.get(iter).x > monster.x.get(i) 
        && turret.bullets.get(iter).x + turret.bulletSize < monster.x.get(i)
        && turret.bullets.get(iter).y > monster.y.get(i) 
        && turret.bullets.get(iter).y + turret.bulletSize < monster.y.get(i))
        || (abs(turret.bullets.get(iter).x - monsterCenterX)< turret.bullets.get(iter).size && abs(turret.bullets.get(iter).y - monsterCenterY)<turret.bullets.get(iter).size )*/
   //checks for collision between bullets and monsters
   for(int iter = 0; iter < turret.bullets.size(); iter++){
      for(int i = 0; i < monster.x.size();i++){
        float monsterCenterX = monster.x.get(i) + monster.size/2;
        float monsterCenterY = monster.y.get(i) + monster.size/2;
        float bulletCenterX = turret.bullets.get(iter).x + turret.bullets.size()/2;
        float bulletCenterY = turret.bullets.get(iter).y + turret.bullets.size()/2;
        if(dist(monsterCenterX,monsterCenterY,bulletCenterX,bulletCenterY) <=  turret.bullets.size()/2 + monster.size/2){
          monster.healths.set(i, monster.healths.get(i) - turret.bullets.get(iter).damage);
          if(monster.healths.get(i) <= 0){
            monster.healths.remove(i);
          fill(#f1f505);
          textSize(100);
          text(turret.bullets.get(iter).damage,monster.x.get(i), monster.y.get(i));
          turret.bullets.remove(iter);
          monster.x.remove(i);
          monster.y.remove(i);
          i--;
          iter--;
          cookies++;
          fill(#404741);
          stroke(#7d807d);
          rect(120 , 370, 200, 50);
          fill(#5bb06a);
          textSize(50);
          text(cookies,130, 410);
          }else{
          fill(#f1f505);
          textSize(100);
          text(turret.bullets.get(iter).damage,monster.x.get(i), monster.y.get(i));
          turret.bullets.remove(iter);
          iter--;
          }
        }
      }
     }
     if(buttonPressed){
      fill(#7d807d);
      noStroke();
      rect(7, 450, 100, 200); //HEAL BUTTON
       fill(#000000);
        textSize(20);
      text("HEAL = " + healCost,13, 480);
      cross.resize(90,90);
       image(cross,13,500);
       
       fill(#7d807d);
       noStroke();
       rect(330, 450, 100, 200); //UPGRADE BUTTON AUTO
       fill(#000000);
       textSize(20);
       text("AUTO = 20",335, 480);
       gear.resize(150,150);
       image(gear,305,480);
       
       fill(#7d807d);
      noStroke();
      rect(120 , 450, 200, 50); //UPGRADE BUTTON
      fill(#000000);
      textSize(20);
      text("UPGRADE SIZE = 10",125, 485);
      
          fill(#7d807d);
    noStroke();
    rect(120 , 450 + 60, 200, 50); //UPGRADE BUTTON
    fill(#000000);
    textSize(20);
    text("UPGRADE DAMAGE = 10",125, 485 + 60);
    
        fill(#7d807d);
    noStroke();
    rect(120 , 450+120, 200, 50); //UPGRADE BUTTON
    fill(#000000);
    textSize(20);
    text("UPGRADE SPEED = 15",125, 485+120);
    
        buttonPressed = false;
     }
   }
  }
   else{
   image(startScreen, 0, 0);
   }
   if(health <= 0){
     background(#42a4f5);
     fill(#ff4640);
     textSize(100);
     text("Press R to restart",width/2 - 365, 100);
     text("YOU LOSE :(",width/2 - 230, height/2);
     int seconds = min * 60 + sec;
     text("You survived: " + seconds + " seconds",width/2 - 520, height/2 + 200);
     start = false;
     }
}
void mouseClicked(){

  if(start){

    if(mouseX > 7 && mouseX < 107 && mouseY > 450 && mouseY < 650 && cookies >= healCost && health <= 90){
      fill(#404741);
      noStroke();
      rect(7, 450, 100, 200); //HEAL BUTTON
      fill(#000000);
      textSize(20);
      text("HEAL = " + healCost,13, 480);
      cross.resize(90,90);
      image(cross,13,500);
      health += 10;
      cookies -= healCost;
      healCost += 10;
      buttonPressed = true;
      monster.towerHealth = health;
    fill(#404741);
        stroke(#7d807d);
        rect(15, height - 60, 405, 30);
        fill(#5bb06a);
        noStroke();
        rect(18, height - 57, (400/100)*health, 26);
    }
    
    if(mouseX > 330 && mouseX < 430 && mouseY > 450 && mouseY < 650 && cookies >= 20){
      fill(#404741);
      noStroke();
      rect(330, 450, 100, 200); //UPGRADE BUTTON AUTO
      fill(#000000);
      textSize(20);
      text("AUTO = 20",335, 480);
      gear.resize(150,150);
      image(gear,305,480);
      cookies -= 20;
      buttonPressed = true;
      autoClick++; 
    }
  if(mouseX > 70 && mouseX < 370 && mouseY > 50 && mouseY < 350){
   cookies++;
   fill(#404741);
  stroke(#7d807d);
  rect(120 , 370, 200, 50);
  fill(#5bb06a);
  textSize(50);
  text(cookies,130, 410);
  }
  if(mouseX > 400 && isAimed){
    turret.loadBullet();
  }
  //upgrade size
  if(mouseX > 120 && mouseY > 450 && mouseX<120 + 200 && mouseY < 450+50 && cookies >= 10){
    fill(#000000);
    noStroke();
    rect(120 , 450, 200, 50); //UPGRADE BUTTON
    fill(#7d807d);
    textSize(20);
    text("UPGRADE SIZE = 10",125, 485);
    buttonPressed = true;
    cookies -= 10;
    fill(#404741);
    stroke(#7d807d);
    rect(120 , 370, 200, 50);
    fill(#5bb06a);
    textSize(50);
    text(cookies,130, 410);
    turret.upgradeSize();
  }
  
  //upgrade dmg
  if(mouseX > 120 && mouseY > 450 + 60 && mouseX<120 + 200 && mouseY < 450+50 + 60 && cookies >= 10){
    fill(#000000);
    noStroke();
    rect(120 , 450 + 60, 200, 50); //UPGRADE BUTTON
    fill(#7d807d);
    textSize(20);
    text("UPGRADE DAMAGE = 10",125, 485 + 60);
    buttonPressed = true;
    cookies -= 10;
    fill(#404741);
    stroke(#7d807d);
    rect(120 , 370, 200, 50);
    fill(#5bb06a);
    textSize(50);
    text(cookies,130, 410);
    turret.upgradeDamage();
  }
  
  //upgrade speed
  if(mouseX > 120 && mouseY > 450 + 120 && mouseX<120 + 200 && mouseY < 450+50 + 120 && cookies >= 15){
    fill(#000000);
    noStroke();
    rect(120 , 450+120, 200, 50); //UPGRADE BUTTON
    fill(#7d807d);
    textSize(20);
    text("UPGRADE SPEED = 15",125, 485+120);
    buttonPressed = true;
    cookies -= 15;
    fill(#404741);
    stroke(#7d807d);
    rect(120 , 370, 200, 50);
    fill(#5bb06a);
    textSize(50);
    text(cookies,130, 410);
    turret.upgradeSpeed();
  }
  }else{
  if(mouseX - width/2 < 100 && mouseY > height/2){
    start = true;
    setup();
  }
  }
}

void keyPressed(){
  //heal
  if(key == 'q' && cookies >= healCost){
    fill(#000000);
      noStroke();
      rect(7, 450, 100, 200); //HEAL BUTTON
      fill(#000000);
      textSize(20);
      text("HEAL = " + healCost,13, 480);
      cross.resize(90,90);
      image(cross,13,500);
      health += 10;
      cookies -= healCost;
      healCost += 10;
      buttonPressed = true;
      monster.towerHealth = health;
      fill(#404741);
      stroke(#7d807d);
      rect(15, height - 60, 405, 30);
      fill(#5bb06a);
      noStroke();
      rect(18, height - 57, (400/100)*health, 26);
  }
  
  //auto
  if(key == 'e' && cookies >= 20){
    fill(#000000);
      noStroke();
      rect(330, 450, 100, 200); //UPGRADE BUTTON AUTO
      fill(#000000);
      textSize(20);
      text("AUTO = 20",335, 480);
      gear.resize(150,150);
      image(gear,305,480);
      cookies -= 20;
      buttonPressed = true;
      autoClick++; 
  }
  
  //reset
  if(key == 'r'){
  health = 100;
  cookies = 0;
  sec = 0;
  min = 0;
  healCost = 20;
  autoClick = 0;
  monster = new Enemy(6000, 60, 200,#eb4034, 5);
  }
  if(key == '1' && cookies >= 10){
    fill(#000000);
    noStroke();
    rect(120 , 450, 200, 50); //UPGRADE BUTTON
    fill(#7d807d);
    textSize(20);
    text("UPGRADE SIZE = 10",125, 485);
    buttonPressed = true;
    cookies -= 10;
    fill(#404741);
    stroke(#7d807d);
    rect(120 , 370, 200, 50);
    fill(#5bb06a);
    textSize(50);
    text(cookies,130, 410);
    turret.upgradeSize();
  }
  
  //upgrade dmg
  if(key == '2' && cookies >= 10){
    fill(#000000);
    noStroke();
    rect(120 , 450 + 60, 200, 50); //UPGRADE BUTTON
    fill(#7d807d);
    textSize(20);
    text("UPGRADE DAMAGE = 10",125, 485 + 60);
    buttonPressed = true;
    cookies -= 10;
    fill(#404741);
    stroke(#7d807d);
    rect(120 , 370, 200, 50);
    fill(#5bb06a);
    textSize(50);
    text(cookies,130, 410);
    turret.upgradeDamage();
  }
  
  //upgrade speed
  if(key == '3' && cookies >= 15){
    fill(#000000);
    noStroke();
    rect(120 , 450+120, 200, 50); //UPGRADE BUTTON
    fill(#7d807d);
    textSize(20);
    text("UPGRADE SPEED = 15",125, 485+120);
    buttonPressed = true;
    cookies -= 15;
    fill(#404741);
    stroke(#7d807d);
    rect(120 , 370, 200, 50);
    fill(#5bb06a);
    textSize(50);
    text(cookies,130, 410);
    turret.upgradeSpeed();
  }

}

void keyReleased(){
  if(key == ' '){
   cookies++;
   fill(#404741);
  stroke(#7d807d);
  rect(120 , 370, 200, 50);
  fill(#5bb06a);
  textSize(50);
  text(cookies,130, 410);
  }
}

int cookies = 0;
int health = 100;
Enemy monster = new Enemy(100, 1, 50,#eb4034, 5);
Turret turret;
boolean buttonPressed = false;
int timer = 0;
int min = 0;
int sec = 0;
void setup(){
size(1280, 720);
background(#42a4f5);
fill(#529c60);
stroke(#529c60);
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
text("UPGRADE DAMAGE = 20",125, 485 + 60);

fill(#7d807d);
noStroke();
rect(120, 450 + 120, 200, 50); //UPGRADE BUTTON SPEED
fill(#000000);
textSize(20);
text("UPGRADE SPEED = 15",125, 485 + 120);

turret = new Turret("base", width/2 - 130, height/2);


monster.towerHealth = health;
fill(#404741);
stroke(#7d807d);
rect(15, height - 60, 405, 30);
fill(#5bb06a);
noStroke();
rect(18, height - 57, (400/100)*health, 26);
}

void draw(){
  if(frameCount%60 == 0){
    sec++;
    fill(#42a4f5);
    noStroke();
    rect(0,0,150,50);
    fill(#FFFFFF);
    textSize(40);
    text(min + ":" + sec,30, 40);
  }
  if(sec%60==0 && sec != 0){
  min++;
  }
  
  if(sec%30==0 && sec != 0){
  min++;//public void mutate(int hp, int spd, int sz, color shape, int dmg)
  color ranColor = #529c60;
  monster.mutate(100, 0.1, 1, ranColor, 10);
  }
  
  if(frameCount%60 == 0){
   monster.spawn();
  }
   monster.attack();
   turret.turn(mouseX, mouseY);
   turret.shoot();
   
   health = monster.towerHealth;
   for(int iter = 0; iter < turret.bullets.size(); iter++){
      for(int i = 0; i < monster.x.size();i++){
        if((turret.bullets.get(iter).x > monster.x.get(i) 
        && turret.bullets.get(iter).x < monster.x.get(i) + monster.size
        && turret.bullets.get(iter).y > monster.y.get(i) 
        && turret.bullets.get(iter).y < monster.y.get(i) + monster.size)
        || turret.bullets.get(iter).x > monster.x.get(i) 
        && turret.bullets.get(iter).x + turret.bulletSize < monster.x.get(i)
        && turret.bullets.get(iter).y > monster.y.get(i) 
        && turret.bullets.get(iter).y + turret.bulletSize < monster.y.get(i)){
          monster.health -= turret.bullets.get(iter).damage;
          if(monster.health <= 0){
          fill(#f1f505);
          textSize(25);
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
          }
        }
      }
     }
       
     if(health < 0){
     noLoop();
     background(#42a4f5);
     fill(#ff4640);
     textSize(100);
     text("YOU LOSE :(",width/2, height/2);
     }
     
     if(buttonPressed){
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
    text("UPGRADE DAMAGE = 20",125, 485 + 60);
    
        fill(#7d807d);
    noStroke();
    rect(120 , 450+120, 200, 50); //UPGRADE BUTTON
    fill(#000000);
    textSize(20);
    text("UPGRADE SPEED = 15",125, 485+120);
    
        buttonPressed = false;
     }
   }

void mouseClicked(){
  if(mouseX > 70 && mouseX < 370 && mouseY > 50 && mouseY < 350){
   cookies++;
   fill(#404741);
  stroke(#7d807d);
  rect(120 , 370, 200, 50);
  fill(#5bb06a);
  textSize(50);
  text(cookies,130, 410);
  }
  if(mouseX > 400){
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
  if(mouseX > 120 && mouseY > 450 + 60 && mouseX<120 + 200 && mouseY < 450+50 + 60 && cookies >= 20){
    fill(#000000);
    noStroke();
    rect(120 , 450 + 60, 200, 50); //UPGRADE BUTTON
    fill(#7d807d);
    textSize(20);
    text("UPGRADE DAMAGE = 20",125, 485 + 60);
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
    cookies -= 10;
    fill(#404741);
    stroke(#7d807d);
    rect(120 , 370, 200, 50);
    fill(#5bb06a);
    textSize(50);
    text(cookies,130, 410);
    turret.upgradeSpeed();
  }
}

int cookies = 0;
int health = 100;
Enemy monster = new Enemy(100, 1, 50,#eb4034, 5);
Turret turret;

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
rect(120 , 450, 200, 50); //UPGRADE BUTTON
fill(#000000);
textSize(40);
text("UPGRADE",135, 490);
turret = new Turret("base", width/2 - 130, height/2);
monster.towerHealth = health;
}

void draw(){
  if(frameCount%100 == 0){
   monster.spawn();
  }
   monster.attack();
   turret.turn(mouseX, mouseY);
   turret.shoot();
   
   health = monster.towerHealth;
   for(int iter = 0; iter < turret.bullets.size(); iter++){
      for(int i = 0; i < monster.x.size();i++){
        if(turret.bullets.get(iter).x > monster.x.get(i) 
        && turret.bullets.get(iter).x < monster.x.get(i) + monster.size
        && turret.bullets.get(iter).y > monster.y.get(i) 
        && turret.bullets.get(iter).y < monster.y.get(i) + monster.size){
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
          }
        }
      }
     }
     
  fill(#404741);
  stroke(#7d807d);
  rect(15, height - 60, 405, 30);
  fill(#5bb06a);
  noStroke();
  rect(18, height - 57, (400/100)*health, 26);
     
     if(health < 0){
     noLoop();
     background(#42a4f5);
     fill(#ff4640);
     textSize(100);
     text("YOU LOSE :(",width/2, height/2);
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
  
  
}

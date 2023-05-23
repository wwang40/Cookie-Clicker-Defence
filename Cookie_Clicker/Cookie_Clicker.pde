int cookies = 0;
Enemy monster = new Enemy(100, 1, 50,#eb4034);
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
rect(120 , 450, 200, 50);
turret = new Turret("base", width/2 - 130, height/2);
}

void draw(){
  if(frameCount%100 == 0){
   monster.spawn();
  }
   monster.attack();
   turret.turn(mouseX, mouseY);
   turret.shoot();
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

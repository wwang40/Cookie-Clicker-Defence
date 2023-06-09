import java.util.ArrayList;
public class Enemy{
  ArrayList<Integer> x = new ArrayList<Integer>();
  ArrayList<Integer> y = new ArrayList<Integer>();
  int towerHealth;
  ArrayList<Integer> healths = new ArrayList<Integer>();
  int health;
  int speed;
  int size;
  color looks;
  int damage;
  int limit = 520;
  public Enemy(int hp, int spd, int sz, color shape, int dmg){
    health = hp;
    speed = spd;
    size = sz;
    looks = shape;
    damage = dmg;
  }
  public void spawn(){
    stroke(#529c60);
    fill(looks);
    x.add(width);
    y.add((int)random(0, height + 1));
    healths.add(health/60);
    square(x.get(x.size() - 1), y.get(y.size() - 1), size);
  }

  public void attack(){
    fill(#a7d889);
  stroke(#a7d889);
  rect(width/2 - 200, 0, width/2 + 200,height);
    for(int index = 0; index < x.size(); index++){
      if(x.get(index) - 1 < limit){
        stroke(#529c60);
        fill(#529c60);
        square(x.get(index), y.get(index), size);
        x.remove(index);
        y.remove(index);
        towerHealth -= damage;
        fill(#404741);
        stroke(#7d807d);
        rect(15, height - 60, 405, 30);
        fill(#5bb06a);
        noStroke();
        rect(18, height - 57, (400/100)*towerHealth, 26);
   
      }
      stroke(#529c60);
      fill(looks);
      if(index != 0){
      x.set(index, x.get(index) - speed/60);
      square(x.get(index), y.get(index), size);
      }
    }
  }

  public void mutate(int hp, int spd, int sz, color shape, int dmg){
    int frames = 0;
    frames++;
  increaseHealth(hp);
  decreaseSize(sz);
  increaseDamage(dmg);
  changeLooks(shape);
  increaseSpeed(spd);
  if(frames == 60){
     int healthSize = healths.size();
   for(int i = 0; i < healthSize; i++){
     healths.set(i,health);
   }
   frames = 0;
   }
  }
  
  private void increaseHealth(int val){
   health += val;
  }
  
  private void decreaseSize(int val){
   size += val;
  }
  
  private void increaseSpeed(int val){
    speed += val;
  }
  
  private void increaseDamage(int val){
    damage += val;
  }
  
  private void changeLooks(color look){
    looks = look;
  }
 
  
}

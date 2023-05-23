import java.util.ArrayList;
public class Enemy{
  ArrayList<Integer> x = new ArrayList<Integer>();
  ArrayList<Integer> y = new ArrayList<Integer>();
  int health;
  int speed;
  int size;
  color looks;
  int limit = 475;
  
  public Enemy(int hp, int spd, int sz, color shape){
    health = hp;
    speed = spd;
    size = sz;
    looks = shape;
  }
  public void spawn(){
    stroke(#529c60);
    fill(looks);
    x.add(width);
    y.add((int)random(0, height + 1));
    square(x.get(x.size() - 1), y.get(y.size() - 1), size);
  }
  
  public void attack(){
    fill(#529c60);
  stroke(#529c60);
  rect(width/2 - 200, 0, width/2 + 200,height);
    for(int index = 0; index < x.size(); index++){
      if(x.get(index) - 1 < limit){
        stroke(#529c60);
        fill(#529c60);
        square(x.get(index), y.get(index), size);
        x.remove(index);
        y.remove(index);
      }
      stroke(#529c60);
      fill(looks);
      x.set(index, x.get(index) - speed);
      square(x.get(index), y.get(index), size);
    }
  }
  
  
  
}

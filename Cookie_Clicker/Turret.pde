boolean isAimed = false;
public class Turret{
  int level;
  ArrayList<Projectile> bullets = new ArrayList<Projectile>();
  String type;
  int len = 80;
  final int size = 80;
  PShape muzzle;
  float angler;
  int x;
  int y;
  int bulletSize = 20;
  int bulletDamage = 100;
  float bulletSpeed = 1.0;
  
  public Turret(String type, int tx, int ty){
    x = tx;
    y = ty;
    this.type = type;
    fill(#529f84);
    strokeWeight(5);
    stroke(#9f526d);
    muzzle = createShape(RECT,0,-15,len,30);
    shape(muzzle, x, y);
    circle(x, y, size);
    bullets.add(new Projectile(1000, 1000, 20, 100, angler, "base"));
  }
  
  public void turn(int mX, int mY){
    mY = mY - y;
    mX = mX - x;
    float angle = atan((float)mY/mX);
    if(angle==angler){
      angler = angle;
    fill(#7d8c80);
    stroke(#7d8c80);
    rect(width/2 - 200, 0, 160,height);
    muzzle.rotate(angle);
    fill(#529f84);
    strokeWeight(5);
    stroke(#9f526d);
    shape(muzzle, x, y);
    circle(x, y, size);
    muzzle.rotate(-angle);
      fill(#1efb05);
      circle(x,y,40);
      isAimed = true;
    }else{
    angler = angle;
    fill(#7d8c80);
    stroke(#7d8c80);
    rect(width/2 - 200, 0, 160,height);
    muzzle.rotate(angle);
    fill(#529f84);
    strokeWeight(5);
    stroke(#9f526d);
    shape(muzzle, x, y);
    circle(x, y, size);
    muzzle.rotate(-angle);
    isAimed = false;
    }
  }
  
   
   public void shoot(){
    for(Projectile bullet: bullets){
        if(bullet.angle > 0){
            bullet.x += cos(bullet.angle)*10*bulletSpeed;
            bullet.y += sin(abs(bullet.angle))*10*bulletSpeed;
        }else{
            bullet.x += cos(bullet.angle)*10*bulletSpeed;
            bullet.y -= sin(abs(bullet.angle))*10*bulletSpeed;
        }
        fill(#529f84);
        strokeWeight(5);
        stroke(#9f526d);
        shape(bullet.bullet, bullet.x, bullet.y);
    }
}

   public void loadBullet(){
     bullets.add(new Projectile(x, y, bulletSize, bulletDamage, angler, "base"));
     bullets.get(bullets.size()-1).bullet.rotate(angler);
   }
   
   public void upgradeSize(){
     bulletSize += 3;
   }
   
   public void upgradeDamage(){
     bulletDamage += 100;
   }
   
   public void upgradeSpeed(){
     bulletSpeed += 0.1;
   }
  }

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
    bullets.add(new Projectile(x, y, 20, 100, angler, "base"));
  }
  
  public void turn(int mX, int mY){
    mY = mY - y;
    mX = mX - x;
    float angle = atan((float)mY/mX);
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
  }
  
  public void shoot(){
   for(Projectile bullet: bullets){
     if(bullet.angle > 0){
     bullet.x += cos(bullet.angle)*10;
     bullet.y += sin(abs(bullet.angle))*10;
     }else{
     bullet.x += cos(bullet.angle)*10;
     bullet.y -= sin(abs(bullet.angle))*10;
     }
    fill(#529f84);
    strokeWeight(5);
    stroke(#9f526d);
     shape(bullet.bullet, bullet.x, bullet.y);
   }
  }
   
   public void loadBullet(){
     System.out.println(angler);
     bullets.add(new Projectile(x, y, 20, 100, angler, "base"));
     bullets.get(bullets.size()-1).bullet.rotate(angler);
   }
  }

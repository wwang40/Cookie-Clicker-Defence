public class Projectile{
float x;
float y;
int speed;
float angle;
int size;
int damage;
String type;
PShape bullet;

  public Projectile(float x, float y, int size, int dmg, float angle, String type){
    this.x = x;
    this.y = y;
    this.size = size;
    damage = dmg;
    this.type = type;
    this.angle = angle;
    bullet = createShape(RECT,0,-15,size,size);
  }
}

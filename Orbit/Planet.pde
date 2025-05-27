//cos motion -> constant + cos(angle) * scalar. Sin motion is the same.
// Sin motion + cos motion = Circular motion

class Planet {
  int a; //semimajor axis
  float radius;
  float mass;
  color c;
  float eccentricity;
  PVector pos;
  float angle;
  float speed;
  
  public Planet(int x, int y, int a, float mass, float e, color c){
    this.a = a;
    this.radius = a;
    this.mass = mass;
    this.c = c;
    this.eccentricity = e;
    this.pos = new PVector(x, y);
    angle = 0.05;
    speed = 0.05;
  }
  
  public Planet(float x, float y){
    this.radius = 100;
    this.mass = 1; //earth mass
    this.c = color(random(255), random(255), random(255));
    this.eccentricity = 1;
    this.pos = new PVector(x, y);
    this.a = 100;
  }
  
  int scalar = 200; //modification of x
  int scalar2 = 100; //modification of y

  //float x = radius + sin(angle) * scalar2;
  //float y = radius + cos(angle) * scalar;
  //ellipse(x,y,50,50);
  //angle = angle + speed;

  PVector getPos(){
    return pos;
  }
  
  void setPos(float x, float y){
    pos.x = x;
    pos.y = y;
  }
  
  color getColor(){
    return c;
  }
    
  float getAngle(){
    return angle;
  }
  
  float getRadius(){
    return radius;
  }
  
  void updateAngle() {
    angle += speed;
  }


}

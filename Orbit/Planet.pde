//cos motion -> constant + cos(angle) * scalar. Sin motion is the same.
// Sin motion + cos motion = Circular motion

class Planet {
  float radius;
  float mass;
  color c;
  float b;
  float a;
  PVector pos;
  float angle;
  float speed;
  
  public Planet(int x, int y, float mass, float a, float b, color c){
    this.a = a;
    this.b = b;
    this.radius = a;
    this.mass = mass;
    this.c = c;
    this.pos = new PVector(x, y);
    angle = 0;
    speed = 1;
  }
  
  public Planet(float x, float y){
    this.mass = 1; //earth mass
    this.c = color(random(255), random(255), random(255));
    this.a = dist(width/2, height/2, x, y);
    this.radius = a;
    this.b = 200;
    this.pos = new PVector(x, y);
    speed = sqrt(mass/radius)/2;
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
  
  void setPos(PVector newV){
    pos = newV;
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
  
  void updateAngle(){
    this.angle += speed;
  }
  
  float getA(){
    return a;
  }
  
  float getB(){
    return b;
  }
  
  float getSpeed(){
    return speed;
  }

}

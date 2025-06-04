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
  final color[] colors = {#79a3e8, #a18d65, #5a8a7d, #8a665a, #d9bebd, 
                          #d9a179, #79b6d9, #284f66, #9e352f, #b8b8b8};

  public Planet(float x, float y){
    this.mass = random(3); //earth mass
    this.c = colors[(int)random(colors.length)];
    this.a = dist(width/2, height/2, x, y);
    this.b = random(100, 500);
    this.radius = a;
    this.pos = new PVector(x, y);
    speed = sqrt(mass/radius)/4;
  }
  
  public Planet(float m, color col, int a, int b){
    mass = m;
    c = col;
    this.a = a;
    this.b = b;
    this.radius = a;
    this.pos = new PVector(600 + (a * 13.1)/sqrt(2), 600 + (a * 13)/sqrt(2));
    speed = sqrt(mass/radius)/4;
  }

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
  
  float getMass(){
    return mass;
  }
  
  void setMass(float m){
    mass = m;
  }
  
  void setRadius(float r){
    this.a = r;
  }
  
  void setB(float r){
    this.b = r;
  }
  
  

}

class star{

  PVector pos;
  color c;
  float mass; //mass in solar masses
  
  star(float x, float y, float m){
    pos = new PVector(x, y);
    this.mass = m;
    if (m > 6.6){
      this.c = color(181, 186, 245);
    }
    else if (m > 1.8){
      this.c = color(181, 215, 245);
    }
    else if (m > 1.4){
      this.c = color(220, 237, 252);
    }
    else if (m > 1.1){
      this.c = color(237, 240, 242);
    }
    else if (m > 0.9){
      this.c = color(255, 248, 232);
    }
    else if (m > 0.7){
      this.c = color(245, 223, 166);
    }
    else {
      this.c = color(245, 182, 135);
    }
  }
  
  float getMass(){
    return mass;
  }
  
  PVector getPos(){
    return pos;
  }
  
  color getColor(){
    return c;
  }

}

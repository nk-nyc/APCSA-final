class star{

  PVector pos;
  color[] c = {color(245, 182, 135), color(245, 223, 166), color(255, 248, 232), color(237, 240, 242),
                color(220, 237, 252),  color(181, 215, 245)};
  float[] temps = {2000, 3000, 4000, 6000, 8000, 13000};
  float[] masses = {0.2, 0.5, 0.7, 1.0, 1.5, 3.1}; 
  int col = 0;
  int mass = 0;
  int temp = 0;
  boolean blackHole = false;
  //mass in solar masses
  
  star(float x, float y){
    pos = new PVector(x, y);
  }
  
  float getMass(){
    if (blackHole){
      return mass;
    }
    return masses[mass];
  }
  
  PVector getPos(){
    return pos;
  }
  
  color getColor(){
    return c[col];
  }
  
  float getTemp(){
    return temps[temp];
  }
  
  void toggleBlackHole(){
    blackHole = !blackHole;
    mass = 0;
    col = 0;
  }
  
  void solarMass(){
    mass = 3;
    col = 1;
  }
  
  void changeMass(){
    if (blackHole){
      mass = 100;
    }
    else {
      if (mass != masses.length - 1){
        mass++;
        temp++;
        col++;
      }
      else {
        mass = 0;
        temp = 0;
        col = 0;
      }
    }
  }

}

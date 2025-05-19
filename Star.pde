class star{

  PVector pos;
  color c;
  float m; //mass in solar masses
  
  star(float x, float y, float m){
    pos = new PVector(x, y);
    this.m = m;
    if (m > 6.6){
      this.c = color(#b5baf5);
    }
    else if (m > 1.8){
      this.c = color(#b5d7f5);
    }
    else if (m > 1.4){
      this.c = color(#dcedfc);
    }
    else if (m > 1.1){
      this.c = color(#edf0f2);
    }
    else if (m > 0.9){
      this.c = color(#fff8e8);
    }
    else if (m > 0.7){
      this.c = color(#f5dfa6);
    }
    else {
      this.c = color(#f5b687);
    }
  }
  
  float getMass(){
    return m;
  }
  
  PVector getPos(){
    return pos;
  }
  
  color getColor(){
    return c;
  }

}

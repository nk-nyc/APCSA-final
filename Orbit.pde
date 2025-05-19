  
  
star Sun = new star(width/2, height/2, 1.0);
ArrayList<Planet> planets = new ArrayList<Planet>();

void setup(){
  size(1000, 1000);
  background(0);
}

void draw(){
  background(0);
  for (Planet p : planets){
    drawPlanet(p);
  }
}

void drawPlanet(Planet p){}

void drawStar(){
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 20, 20);
}

star Sun = new star(500, 500, 1.0);
ArrayList<Planet> planets = new ArrayList<Planet>();
final float G = 0.00000000000667;
ArrayList<Float> angles = new ArrayList<Float>();
float angle = 0;

void setup(){
  size(1000, 1000);
  background(0);
  smooth();
  addPlanet();
}

void draw(){
  background(0);
  drawStar();
  for (Planet p : planets){
    drawPlanet(p);
  }
}

void addPlanet(){
  planets.add(new Planet(Sun.getPos().x + 100, Sun.getPos().y + 100));
}

void drawPlanet(Planet p){
  updatePlanet(p);
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y, 50, 50);
}

void updatePlanet(Planet p){
  angle += 0.05;
  float x = Sun.getPos().x + p.getA() * cos(angle);
  float y = Sun.getPos().y + p.getB() * sin(angle);
  p.setPos(new PVector(x, y));
}

void drawStar(){
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100, 100);
}


void mouseClicked() {
 if (mouseButton == LEFT) {
   int x = mouseX;
   int y = mouseY;
   planets.add(new Planet(x, y));
 }
}

star Sun = new star(500, 500, 1.0);
ArrayList<Planet> planets = new ArrayList<Planet>();
final float G = 0.00000000000667;
boolean press = false;

void setup(){
  size(1000, 1000);
  background(0);
  addPlanet();
}

void draw(){
  background(0);
  drawStar();
  for (Planet p : planets){
    updatePlanet(p);
    drawPlanet(p);
  }
}

void addPlanet(){
  planets.add(new Planet(Sun.getPos().x + 100, Sun.getPos().y + 100));
}

void drawPlanet(Planet p){
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y, 50, 50);
}

void updatePlanet(Planet p){
  p.updateAngle();
  float x = Sun.getPos().x + sin(p.getAngle()) * 20;
  float y = Sun.getPos().y + cos(p.getAngle()) * 200;
  p.setPos(x, y);
  System.out.println(p.getAngle());
}

void drawStar(){
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100, 100);
}

void keyPressed() {
  if (key == 's') press = true;
}

void mouseClicked() {
 if (mouseButton == LEFT) {
   float x = mouseX;
   float y = mouseY;
   planets.add(new Planet(x, y));
 }
}

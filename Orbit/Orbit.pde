star Sun = new star(500, 500, 1.0);
ArrayList<Planet> planets = new ArrayList<Planet>();
final float G = 0.00000000000667;
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
  float x = p.getA() * cos(angle) + Sun.getPos().x;
  float y = p.getB() * sin(angle)  + Sun.getPos().y ;
  p.setPos(new PVector(x, y));
}

void drawStar(){
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100, 100);
}

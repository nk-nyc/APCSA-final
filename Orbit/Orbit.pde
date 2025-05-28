star Sun = new star(500, 500, 1.0);
ArrayList<Planet> planets = new ArrayList<Planet>();
ArrayList<Float> angles = new ArrayList<Float>();

void setup(){
  size(1000, 1000);
  background(0);
  smooth();
  addPlanet(Sun.getPos().x, Sun.getPos().y);
}

void draw(){
  background(0);
  drawStar();
  for (int i = 0; i < planets.size(); i++){
    drawPlanet(planets.get(i), i);
      textSize(12);
      text("SPEED OF PLANET " + i + ": " + planets.get(i).getSpeed(), 15, 20 + 10 * i);
  }
  
  fill(255);
  stroke(255);
  rect(width - 100, 10,50,50);
  
}

void addPlanet(float x, float y){
  planets.add(new Planet(x, y));
  angles.add(0.0);
}

void drawPlanet(Planet p, int i){
  updatePlanet(p, i);
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y, 50, 50);
}

void updatePlanet(Planet p, int i){
  float x = p.getA() * cos(angles.get(i)) + Sun.getPos().x;
  float y = p.getB() * sin(angles.get(i))  + Sun.getPos().y ;
  p.setPos(new PVector(x, y));
  updateAngle(i);
}

void drawStar(){
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100, 100);
}

void updateAngle(int index){
  angles.set(index, angles.get(index) + planets.get(index).getSpeed());
}

void mouseClicked(){
  if (mouseButton == LEFT){
    addPlanet(mouseX, mouseY);
  }

}

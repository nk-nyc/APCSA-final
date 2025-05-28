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
  }
}

void addPlanet(float x, float y){
  planets.add(new Planet(x, y));
  angles.add(0.0);
}

void drawPlanet(Planet p, int i){
  updatePlanet(p, i);
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y, sqrt(p.getMass()) * 30, sqrt(p.getMass()) * 30);
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
    if ((mouseX < 550 && mouseX > 450) && (mouseY < 550 && mouseY > 450) ){
      
    }
    else {
        addPlanet(mouseX, mouseY);
    }
  }

}

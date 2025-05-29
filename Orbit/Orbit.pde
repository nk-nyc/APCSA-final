star Sun = new star(500, 500, 1.0);
ArrayList<Planet> planets = new ArrayList<Planet>();
ArrayList<Float> angles = new ArrayList<Float>();
boolean paused = false;
boolean menuOpen = false;
final int planetLimit = 10;

final int btnX = 900, btnY = 10, btnW = 80, btnH = 30;
final int speedUpX = 900, speedUpY = 50,
          speedUpX2 = 80, speedUpY2 = 30,
          speedUpX3 = 90, speedUpY3 = 40;
//final int menuBtnX = 900, menuBtnY = 50, menuBtnW = 80, menuBtnH = 30;

void setup(){
  size(1000, 1000);
  smooth();
  addPlanet(Sun.getPos().x, Sun.getPos().y);
}

void draw(){
  background(0);
  drawStar();
  text("MASS OF STAR: " + 
      Sun.getMass(),
      15, 20);

  for (int i = 1; i < planets.size(); i++){
    Planet p = planets.get(i);
    drawPlanet(p);
    if (!paused) {
      updatePlanet(p, i);
    }
   
    textSize(12);
    text("SPEED OF PLANET " + i + ": " + 
          p.getSpeed() * 2 * 3.14 + 
          " revolutions per year", 
          15, 30 + 10 * (i - 1));
  }
  
  if (paused) {
    fill(150);
  } else {
    fill(50);
  }
  stroke(0);
  rect(btnX, btnY, btnW, btnH);
  
  triangle(speedUpX, speedUpY, speedUpX2, speedUpY2, speedUpX3, speedUpY3);
  
  String label;
  if(paused) {
    label = "Resume";
  } else {
    label = "Pause";
  }
  fill(255);
  textAlign(CENTER, CENTER);
  text(label, btnX + btnW/2, btnY + btnH/2);
  textAlign(LEFT, BASELINE);
  
}


void drawPlanet(Planet p){
  stroke(p.getColor());
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y, 
          sqrt(p.getMass()) * 30, 
          sqrt(p.getMass()) * 30);
}


void mouseClicked(){
  if (mouseX >= btnX && mouseX <= btnX+btnW &&
      mouseY >= btnY && mouseY <= btnY+btnH) {
    paused = !paused;
    return;
  }
  
  else if (dist(mouseX, mouseY, Sun.getPos().x, Sun.getPos().y) < 100){
    Sun.changeMass();
    for (Planet p : planets){
      p.setRadius(p.getRadius() / sqrt(Sun.getMass()));
    }
  }
  
  else if (mouseButton == LEFT){
    addPlanet(mouseX, mouseY);
  }
}

void addPlanet(float x, float y){
  if (!(planets.size() > planetLimit)) {
    Planet p = new Planet(x, y);
    float theta = atan2((y - Sun.getPos().y)/ p.getB(),
                        (x - Sun.getPos().x) / p.getA());
    planets.add(p);
    angles.add(theta);
  }
}

void updatePlanet(Planet p, int i){
  float theta = angles.get(i);
  float x = p.getA() * cos(theta) + Sun.getPos().x;
  float y = p.getB() * sin(theta) + Sun.getPos().y ;
  p.setPos(new PVector(x, y));
  angles.set(i, theta + p.getSpeed() * Sun.getMass());
}

void drawStar(){
  stroke(Sun.getColor());
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100 * sqrt(Sun.getMass()), 100 * sqrt(Sun.getMass()));
}

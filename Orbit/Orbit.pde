star Sun = new star(500, 500);
ArrayList<Planet> planets = new ArrayList<Planet>();
ArrayList<Float> angles = new ArrayList<Float>();
boolean paused = false;
boolean faster = false;
boolean slower = false;
boolean reset = false;
boolean blackhole = false;
final int planetLimit = 10;
boolean blackHole = false;

final int btnX = 900, btnY = 10, btnW = 80, btnH = 30;
final int resetX = 900, resetY = 100, resetW = 80, resetH = 30;
final int blackBtnX = 900, blackBtnY = 140, blackBtnW = 80, blackBtnH = 30;
final int speedUpX = 945, speedUpX3 = 980;
final int slowX = 935, slowX3 = 900;
final int speedY = 50, speedY2 = 90, speedY3 = 70;

void setup(){
  size(1000, 1000);
  smooth();
  addPlanet(Sun.getPos().x, Sun.getPos().y);
}

void draw(){
        float mult = 1.0;
      if (paused) mult = 0;
      else if (faster) mult = 2.0;
      else if (slower) mult = 0.5;
  if (!blackHole){
    background(0);
    drawStar();
    text("MASS OF STAR: " + 
        Sun.getMass() + " SOLAR MASSES",
        15, 20);
  
    for (int i = 1; i < planets.size(); i++){
      Planet p = planets.get(i);
      drawPlanet(p);

      updatePlanet(p, i, mult);
  
      textSize(12);
      text("PERIOD OF PLANET " + i + ": " +  (double)
      (Math.round((2 * 3.14 * 100.0) / (p.getSpeed() * Sun.getMass() * 100)))/100
            + " YEARS", 
            15, 20 + 10 * i);
    }
    
    if (reset) planets.clear(); reset = false;
  }
  
  else {
    background(0);
    fill(#fff1d6);
    ellipse(Sun.getPos().x, Sun.getPos().y, 135, 135);
    fill(0);
    ellipse(Sun.getPos().x, Sun.getPos().y, 130, 130);
    for (int i = 0; i < planets.size(); i++){
      planets.get(i).setRadius(planets.get(i).getA() - 10);
      planets.get(i).setB(planets.get(i).getB() - 10);
      drawPlanet(planets.get(i));
      updatePlanet(planets.get(i), i, mult);
    }
  }
  
  //Buttons
  if (reset) {
    fill(150);
  } else {
    fill(50);
  }
  stroke(0);
  rect(resetX, resetY, resetW, resetH);
  String label = "Reset";
  fill(255);
  textAlign(CENTER, CENTER);
  text(label, resetX + resetW/2, resetY + resetH/2);
  textAlign(LEFT, BASELINE);
  
  
  if (paused) {
    fill(150);
  } else {
    fill(50);
  }
  stroke(0);
  rect(btnX, btnY, btnW, btnH);
  String label2;
  if(paused) {
    label2 = "Resume";
  } else {
    label2 = "Pause";
  }
  fill(255);
  textAlign(CENTER, CENTER);
  text(label2, btnX + btnW/2, btnY + btnH/2);
  textAlign(LEFT, BASELINE);
  
  
  if (blackhole) {
    fill(150);
  } else {
    fill(50);
  }
  stroke(0);
  rect(blackBtnX, blackBtnY, blackBtnW, blackBtnH);
  String label3 = "Black hole!!";
  fill(255);
  textAlign(CENTER, CENTER);
  text(label3, blackBtnX + blackBtnW/2, blackBtnY + blackBtnH/2);
  textAlign(LEFT, BASELINE);
  
  
  if (faster) {
    fill(150);
  } else {
    fill(50);
  }
  triangle(speedUpX, speedY, speedUpX, speedY2, speedUpX3, speedY3);
  
  if (slower) {
    fill(150);
  } else {
    fill(50);
  }
  triangle(slowX, speedY, slowX, speedY2, slowX3, speedY3);
 
  
}


void drawPlanet(Planet p){
  stroke(p.getColor());
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y, 
          sqrt(p.getMass()) * 30, 
          sqrt(p.getMass()) * 30);
}


void mouseClicked(){
  if (hitBox(resetX, resetX+resetW, resetY, resetY+resetH)) {
    reset = true;
    return;
  }
  if (hitBox(btnX, btnX+btnW, btnY, btnY+btnH)) {
    paused = !paused;
    return;
  }
  if (hitBox(speedUpX, speedUpX3, speedY, speedY2)) {
    faster = !faster;
    if (faster) slower = false;
    return;
  }
  if (hitBox(slowX3, slowX, speedY, speedY2)) {
    slower = !slower;
    if (slower) faster = false;
    return;
  }
  else if (dist(mouseX, mouseY, Sun.getPos().x, Sun.getPos().y) < 170){
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

void updatePlanet(Planet p, int i, float mult){
  float theta = angles.get(i);
  float x = p.getA() * cos(theta) + Sun.getPos().x;
  float y = p.getB() * sin(theta) + Sun.getPos().y ;
  p.setPos(new PVector(x, y));
  angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
}

void drawStar(){
  stroke(Sun.getColor());
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100 * sqrt(Sun.getMass()), 100 * sqrt(Sun.getMass()));
}

boolean hitBox(int w, int x, int y, int z) {
  return mouseX >= w && mouseX <= x && mouseY >= y && mouseY <= z;
}

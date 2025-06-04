import  java.util.*;

star Sun = new star(500, 500);
final int planetLimit = 20;
ArrayList<Planet> planets = new ArrayList<Planet>();
ArrayList<Float> angles = new ArrayList<Float>();
LinkedList<PVector> trail = new LinkedList<PVector>();
ArrayList<PVector> backgroundStars = new ArrayList<PVector>();
float zoom = 1;

void setup(){
  size(1000, 1000);
  smooth();
  addPlanet(Sun.getPos().x, Sun.getPos().y);
  for (int i = 0; i < 1000; i ++) {
    PVector point = new PVector(random(width), random(height));
    backgroundStars.add(point);
  }
}

void draw(){
  float mult = 1.0;
  if (paused) mult = 0;
  if (blackHole) mult = 3.0;
  if (blackHole && faster) mult = 4.0;
  else if (faster) mult = 2.0;
  if (blackHole && slower) mult = 2.0;
  else if (slower) mult = 0.5;
  if (reset) trail.clear();
 
  if (!blackHole){
    background(0);
    stroke(255);
    for (PVector point : backgroundStars) circle(point.x, point.y, 0.5);
    stroke(random(150, 255));
    for (int i = 0; i < backgroundStars.size() / 3 ; i++) {
      PVector point = backgroundStars.get(i);
      circle(point.x, point.y, random(0.6));
    }
    fill(0);
    drawStar();
    text("MASS OF STAR: " + Sun.getMass()
        + " SOLAR MASSES", 15, 20);
       
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
 
  //blackhole
  else {
    background(0);
    stroke(240);
    for (PVector point : backgroundStars) circle(point.x, point.y, 1);
    if (planets.size() > 0) {
      for (int i = 1; i < planets.size(); i++){
        if (dist(planets.get(i).getPos().x, planets.get(i).getPos().y, Sun.getPos().x, Sun.getPos().y) < 70){
          planets.remove(i);
          angles.remove(i);
        }
       
        else if (planets.get(i).getA() >= 70){
          planets.get(i).setRadius(planets.get(i).getA() - 1);
        }
         
        else if (planets.get(i).getB() >= 70){
          planets.get(i).setB(planets.get(i).getB() - 1);
        }
        if (i < planets.size()){
          drawPlanet(planets.get(i));
          updatePlanet(planets.get(i), i, mult);  
        }
      }
    }
   
    fill(255);
    text("MASS OF STAR: " +
    Sun.getMass() + " SOLAR MASSES",
    15, 20);
    stroke(255);
    fill(0);
    ellipse(Sun.getPos().x, Sun.getPos().y, 130, 130);
 
    for (int i = 1; i < planets.size(); i++){
      fill(255);
      textSize(12);
      text("PERIOD OF PLANET " + i + ": " +  (double)
      (Math.round((2 * 3.14 * 100.0) / (planets.get(i).getSpeed() * Sun.getMass() * 100)))/100
            + " YEARS",
            15, 20 + 10 * i);
    }
   
    if (reset) planets.clear(); reset = false;
  }

   drawTrail();
   drawMenu();
}


void drawPlanet(Planet p){
  stroke(p.getColor());
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y,
          sqrt(p.getMass()) * 30,
          sqrt(p.getMass()) * 30);
}


void drawTrail() {
  stroke(255);
  if (trail.size() >= 2) {
    PVector currentPoint, lastPoint = trail.get(0);
    for (int j = 0; j < trail.size(); j++) {
      currentPoint = trail.get(j);
      circle(lastPoint.x, lastPoint.y, 1.0);
      lastPoint = currentPoint;
     }
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
  if (!collisionMode) {
    float theta = angles.get(i);
    float x = p.getA() * cos(theta) + Sun.getPos().x;
    float y = p.getB() * sin(theta) + Sun.getPos().y ;
    p.setPos(new PVector(x, y));
    angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
    trail.addFirst(new PVector(x, y));
    while (trail.size() > planets.size() * 100) {
      trail.removeLast();
    }
    if (blackHole){
      angles.set(i, theta + p.getSpeed() * mult);
    }
    else {
      angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
    }
  }
  else {
    boolean collision = false;
    //collision
    for (int j = 0; j < planets.size(); j++){
      if (j != i) {
        if (dist(p.getPos().x, p.getPos().y, planets.get(j).getPos().x, planets.get(j).getPos().y) <
           ((sqrt(p.getMass()) * 30.0) + (sqrt(planets.get(j).getMass()) * 30.0)) - 20) {
           collision = true;
           if (p.getMass() > planets.get(j).getMass()){
             planets.remove(j);
             angles.remove(j);
             p.setMass(p.getMass() * (4.0/5.0));
           }
            else if (i < planets.size()) {
              planets.get(j).setMass(planets.get(j).getMass() * (4.0/5.0));
              planets.remove(i);
              angles.remove(i);
            }
         }
       }
    }
     
    if (i < planets.size()){
      float theta = angles.get(i);
      float x = p.getA() * cos(theta) + Sun.getPos().x;
      float y = p.getB() * sin(theta) + Sun.getPos().y ;
      p.setPos(new PVector(x, y));
      angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
     
      if (collision == false) {
      trail.addFirst(new PVector(x, y));
        while (trail.size() > planets.size() * 100) {
          trail.removeLast();
        }
        if (blackHole){
          angles.set(i, theta + p.getSpeed() * mult);
        }
        else {
          angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
        }
      }
    }
  }
 }

void drawStar(){
  stroke(Sun.getColor());
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100 * sqrt(Sun.getMass()), 100 * sqrt(Sun.getMass()));
}

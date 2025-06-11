import java.util.*;

star Sun = new star(500, 500);
final int planetLimit = 20;
ArrayList<Planet> planets = new ArrayList<Planet>();
ArrayList<Float> angles = new ArrayList<Float>();
LinkedList<PVector> trail = new LinkedList<PVector>();

Planet[] solarSystem = new Planet[9];
float[] solarAngles = new float[9];

float zoom = 1;
PImage kaboom;
float scale = 1;
float translateX = 0, translateY = 0;

PGraphics staticStars;
ArrayList<PVector> twinkleStars = new ArrayList<PVector>();
int totalStars   = 1000;
int twinkleCount = 200;

void setup() {
  size(1000, 1000);
  smooth();
  staticStars = createGraphics(width, height);
  staticStars.beginDraw();
  staticStars.background(0);
  staticStars.stroke(255);
  staticStars.strokeWeight(2);
  for (int i = 0; i < totalStars; i++) {
    float x = random(width);
    float y = random(height);
    staticStars.point(x, y);
    
    if (i < twinkleCount) {
      twinkleStars.add(new PVector(x, y));
    }
  }
  staticStars.endDraw();
  kaboom = loadImage("kaboom.png");
  setupSolar();
}

void setupSolar() {
  if (!solar) {
    addPlanet(Sun.getPos().x, Sun.getPos().y);
  }
  solarSystem[0] = new Planet(0.05,#b8b8b8,  100, 100, 0.24, 0.053);
  solarSystem[1] = new Planet(0.8, #e8cf9e,  120, 120, 0.61, 0.04);
  solarSystem[2] = new Planet(1, #4d9961,    150, 150, 1.00, 0.03);
  solarSystem[3] = new Planet(0.1, #c78158,  180, 180, 1.88, 0.02);
  solarSystem[4] = new Planet(5, #edd0a5,    300, 300, 11.86, 0.01);
  solarSystem[5] = new Planet(3, #dbcc9b,    350, 350, 29.40, 0.003);
  solarSystem[6] = new Planet(4.1, #d1ecff,  380, 380, 84.12, 0.0006);
  solarSystem[7] = new Planet(4, #2d54db,    410, 410, 165.21, 0.0001);
  solarSystem[8] = new Planet(0.02, #bfb7ab, 490, 490, 248.43, 0.00005);

  for (int j = 0; j < 9; j++) {
    solarAngles[j] = j * 0.03;
  } 
}

// MAIN DRAW ==================================================================

void draw() {
  resetZoomPan();
  background(0);
  drawStarfield(); 
  pushMatrix();
    translate(translateX, translateY);
    scale(scale);

    if (solar) {
      drawSolar();
    } else if (blackHole) {
      drawBlackHolePlanets();
      // draw black hole itself
      stroke(255);
      fill(0);
      ellipse(Sun.getPos().x, Sun.getPos().y, 130, 130);
    } else {
      drawStar();
      drawPlanets();
    }

    drawTrail();
  popMatrix();
  
  drawHUD();  
}

void resetZoomPan() {
  if (reset) {
    trail.clear();
    translateX = 0;
    translateY = 0;
    planets.clear();
    angles.clear();
    scale = 1;
    reset = false;
  }
}

void drawHUD() {
  fill(255);
  text("MASS OF STAR: " + Sun.getMass() + " SOLAR MASSES", 15, 20);

  for (int i = 1; i < planets.size(); i++) {
    Planet p = planets.get(i);
    fill(p.getColor());
    textSize(12);
    text("PERIOD OF PLANET " + i + ": " +
      (double)(Math.round((2 * 3.14 * 100.0) / (p.getSpeed() * Sun.getMass() * 100))) / 100 + " YEARS",
      15, 20 + 10 * i);
  }
  
  if (solar) {
    textAlign(LEFT, CENTER);
    textSize(12);
    for (int i = 0; i < solarSystem.length; i++) {
      Planet p = solarSystem[i];
      fill(p.getColor());
      text("PERIOD OF PLANET " + (i + 1) + ": " + p.getPeriod() + " YEARS", 15, 25 + 10 * i);
    }
  }


  drawMenu();
}

// GAME LOGIC ==================================================================

float getSpeedMult() {
  if (paused) return 0;
  if (blackHole && faster) return 4;
  if (blackHole) return 3;
  if (faster) return 2;
  if (slower) return 0.5;
  return 1;
}

void addTrailPoint(float x, float y) {
  trail.addFirst(new PVector(x, y));
  while (trail.size() > planets.size() * 100) {
    trail.removeLast();
  }
}

void blackHoleLogic(int i) {
  if (dist(planets.get(i).getPos().x, planets.get(i).getPos().y, Sun.getPos().x, Sun.getPos().y) < 70) {
    planets.remove(i);
    angles.remove(i);
    return;
  }

  if (planets.get(i).getA() >= 70) {
    planets.get(i).setRadius(planets.get(i).getA() - 1);
  } else if (planets.get(i).getB() >= 70) {
    planets.get(i).setB(planets.get(i).getB() - 1);
  }
}

void addPlanet(float x, float y) {
  if (dist(x, y, Sun.getPos().x, Sun.getPos().y) < 50 * sqrt(Sun.getMass())) {
    return;
  }
  if (!(planets.size() > planetLimit) && !solar) {
    Planet p = new Planet(x, y);
    float theta = atan2((y - Sun.getPos().y) / p.getB(), (x - Sun.getPos().x) / p.getA());
    planets.add(p);
    angles.add(theta);
  }
}


// DRAW PARTS ==================================================================

void drawSolar() {
  float mult = getSpeedMult();
  if (reset) trail.clear();
  Sun.solarMass();
  drawStar();

  for (int i = 0; i < 9; i++) {
    Planet p = solarSystem[i];
    noFill();
    stroke(200);
    ellipse(Sun.getPos().x, Sun.getPos().y, p.getA() * 2, p.getA() * 2);

    fill(p.getColor());
    drawPlanet(p);
    updatePlanet(p, i, mult);
  }
}

void drawPlanets() {
  for (int i = 1; i < planets.size(); i++) {
    Planet p = planets.get(i);
    drawPlanet(p);
    updatePlanet(p, i, getSpeedMult());
  }
}

void drawBlackHolePlanets() {
  for (int i = 1; i < planets.size(); i++) {
    blackHoleLogic(i);
    if (i < planets.size()) {
      Planet p = planets.get(i);
      drawPlanet(p);
      updatePlanet(p, i, getSpeedMult());
    }
  }
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

void drawPlanet(Planet p) {
  stroke(p.getColor());
  fill(p.getColor());
  ellipse(p.getPos().x, p.getPos().y, sqrt(p.getMass()) * 30, sqrt(p.getMass()) * 30);
}

void drawStar() {
  stroke(Sun.getColor());
  fill(Sun.getColor());
  ellipse(Sun.getPos().x, Sun.getPos().y, 100 * sqrt(Sun.getMass()), 100 * sqrt(Sun.getMass()));
}

void drawStarfield() {
  image(staticStars, 0, 0);
  noStroke();
  for (PVector pt : twinkleStars) {
    float t = noise(pt.x*0.1, pt.y*0.1, frameCount*0.04); 
    //perlin noise; gives star unique base value and also controls speed
    float size = map(t, 0, 1, 1, 7); 
    float alpha = map(t, 0, 1,  30, 255); // dim–to–bright
    fill(255, alpha);
    ellipse(pt.x, pt.y, size, size);
  }
}


// UPDATE PLANETS ==================================================================
void updatePlanet(Planet p, int i, float mult){
  if (solar) {
    updateSolarPlanet(p, i, mult);
    return;
  }
  if (!collisionMode) {
    updateNormalPlanet(p, i , mult);
  }
  else {
    updateCollisionPlanet(p, i, mult);
  }
}

void updateSolarPlanet(Planet p, int i, float mult) {
  float theta = solarAngles[i];
  float x = p.getA() * cos(theta) + Sun.getPos().x;
  float y = p.getB() * sin(theta) + Sun.getPos().y ;
  p.setPos(new PVector(x, y));
  solarAngles[i] = (theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
  addTrailPoint(x, y);
  solarAngles[i] = ( theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
}

void updateNormalPlanet(Planet p, int i, float mult) {
  float theta = angles.get(i);
  float x = p.getA() * cos(theta) + Sun.getPos().x;
  float y = p.getB() * sin(theta) + Sun.getPos().y;
  p.setPos(new PVector(x, y));
  angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
  addTrailPoint(x, y);
  if (blackHole) {
    angles.set(i, theta + p.getSpeed() * mult);
  }
  else {
    angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
  }
}

void updateCollisionPlanet(Planet p, int i, float mult) {
  boolean collision = false;
  for (int j = 0; j < planets.size(); j++) {
    if (j != i) {
      if (dist(p.getPos().x, p.getPos().y, planets.get(j).getPos().x, planets.get(j).getPos().y) < ((sqrt(p.getMass()) * 30.0) + (sqrt(planets.get(j).getMass()) * 30.0)) - 20) {
        collision = true;
        if (p.getMass() > planets.get(j).getMass()) {
          image(kaboom, p.getPos().x, p.getPos().y, 50, 50);
          planets.remove(j);
          angles.remove(j);
          p.setMass(p.getMass() * (4.0 / 5.0));
        }
        else if (i < planets.size()) {
          image(kaboom, planets.get(j).getPos().x, planets.get(j).getPos().y, 50, 50);
          planets.get(j).setMass(planets.get(j).getMass() * (4.0 / 5.0));
          planets.remove(i);
          angles.remove(i);
        }
      }
    }
  }

  if (i < planets.size()) {
    float theta = angles.get(i);
    float x = p.getA() * cos(theta) + Sun.getPos().x;
    float y = p.getB() * sin(theta) + Sun.getPos().y;
    p.setPos(new PVector(x, y));
    angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);

    if (collision == false) {
      addTrailPoint(x, y);
      if (blackHole) {
        angles.set(i, theta + p.getSpeed() * mult);
      }
      else {
        angles.set(i, theta + p.getSpeed() * sqrt(Sun.getMass()) * mult);
      }
    }  
  }
}


// MOVING ==================================================================

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  float oldScale = scale;

  if (e < 0) {
    zoom = 1.1;
  } else {
    zoom = 0.9;
  }

  float newScale = oldScale * zoom;
  if (newScale < 0.6) newScale = 0.6;
  if (newScale > 6) newScale = 6;

  float newX = (mouseX - translateX) / oldScale;
  float newY = (mouseY - translateY) / oldScale;
  scale = newScale;
  translateX = mouseX - newX * scale;
  translateY = mouseY - newY * scale;
}

void mouseDragged() {
  translateX += (mouseX - pmouseX);
  translateY += (mouseY - pmouseY);
}

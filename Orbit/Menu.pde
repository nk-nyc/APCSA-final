boolean paused = false;
boolean faster = false;
boolean slower = false;
boolean reset = false;
boolean blackHole = false;
boolean collisionMode = false;
boolean solar = false;

final int btnX = 900, btnY = 10, btnW = 80, btnH = 30;
final int resetY = 100;
final int blackBtnY = 140;
final int collisionBtnY = 180;

final int speedUpX = 945, speedUpX3 = 980;
final int slowX = 935, slowX3 = 900;
final int speedY = 50, speedY2 = 90, speedY3 = 70;
final int solarBtnY = 220;

void mouseClicked() {
  if (hitBox(btnX, btnX + btnW, resetY, resetY + btnH)) {
    reset = true;
    return;
  }
  if (hitBox(btnX, btnX + btnW, btnY, btnY + btnH)) {
    paused = !paused;
    slower = false;
    faster = false;
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
  
  if (hitBox(btnX, btnX + btnW, blackBtnY, blackBtnY + btnH)) {
    blackHole = !blackHole;
    Sun.toggleBlackHole();
    Sun.changeMass();
  }

  if (hitBox(btnX, btnX + btnW, collisionBtnY, collisionBtnY + btnH)) {
    collisionMode = !collisionMode;
  } else if (dist(mouseX, mouseY, Sun.getPos().x, Sun.getPos().y) < 150) {
    Sun.changeMass();
    for (Planet p: planets) {
      p.setRadius(p.getRadius() / sqrt(Sun.getMass()));
    }
  }
  
  if (hitBox(btnX, btnX + btnW, solarBtnY, solarBtnY + btnH)) {
    solar = !solar;
    if (solar) planets.clear();
    return;
  }

  else if (mouseButton == LEFT && !solar){
    addPlanet(mouseX, mouseY);
  }
}

void drawMenu() {
  drawRectBtn(btnX, resetY, "Reset", reset);
  drawRectBtn(btnX, blackBtnY, "Black hole!!", blackHole);
  drawRectBtn(btnX, collisionBtnY, "Collisions", collisionMode);
  drawRectBtn(btnX, solarBtnY, "Solar Sys",  solar);

  String pauseLabel;
  if (paused) {
    pauseLabel = "Resume";
  } else {
    pauseLabel = "Pause";
  }
  drawRectBtn(btnX, btnY, pauseLabel, paused);

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

boolean hitBox(int w, int x, int y, int z) {
  return mouseX >= w && mouseX <= x && mouseY >= y && mouseY <= z;
}


void drawRectBtn(int x, int y, String label, boolean on) {
  if (on) fill(150);
  else fill(50);
  stroke(0);
  rect(x, y, btnW, btnH);
  fill(255);
  textAlign(CENTER, CENTER);
  text(label, x + btnW/2, y + btnH/2);
  textAlign(LEFT, BASELINE);
}

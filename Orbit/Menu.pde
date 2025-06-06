boolean paused = false;
boolean faster = false;
boolean slower = false;
boolean reset = false;
boolean blackHole = false;
boolean collisionMode = false;
boolean solar = true;

final int btnX = 900, btnY = 10, btnW = 80, btnH = 30;
final int resetY = 100;
final int blackBtnY = 140;
final int collisionBtnY = 180;

final int speedUpX = 945, speedUpX3 = 980;
final int slowX = 935, slowX3 = 900;
final int speedY = 50, speedY2 = 90, speedY3 = 70;



void mouseClicked(){
  if (hitBox(btnX, btnX+btnW, resetY, resetY+btnH)) {
    reset = true;
    return;
  }
  if (hitBox(btnX, btnX+btnW, btnY, btnY+btnH)) {
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
  if (hitBox(btnX, btnX + btnW, blackBtnY, blackBtnY + btnH)){
    blackHole = !blackHole;
    Sun.toggleBlackHole();
    Sun.changeMass();
  }
 
  if (hitBox(btnX, btnX + btnW, collisionBtnY, collisionBtnY + btnH)){
    collisionMode = !collisionMode;
  }
 
  else if (dist(mouseX, mouseY, Sun.getPos().x, Sun.getPos().y) < 150){
    Sun.changeMass();
    for (Planet p : planets){
      p.setRadius(p.getRadius() / sqrt(Sun.getMass()));
    }
  }
  else if (mouseButton == LEFT){
    addPlanet(mouseX, mouseY);
  }
}

void drawMenu() {
  if (reset) {
    fill(150);
  } else {
    fill(50);
  }
  stroke(0);
  rect(btnX, resetY, btnW, btnH);
  String label = "Reset";
  fill(255);
  textAlign(CENTER, CENTER);
  text(label, btnX + btnW/2, resetY + btnH/2);
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
 
 
  if (blackHole) {
    fill(150);
  } else {
    fill(50);
  }
  stroke(0);
  rect(btnX, blackBtnY, btnW, btnH);
  String label3 = "Black hole!!";
  fill(255);
  textAlign(CENTER, CENTER);
  text(label3, btnX + btnW/2, blackBtnY + btnH/2);
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
 
 
  if (collisionMode) {
    fill(150);
  } else {
    fill(50);
  }
  stroke(0);
  rect(btnX, collisionBtnY, btnW, btnH);
  String label4 = "Collisions";
  fill(255);
  textAlign(CENTER, CENTER);
  text(label4, btnX + btnW/2, collisionBtnY + btnH/2);
  textAlign(LEFT, BASELINE);
}


boolean hitBox(int w, int x, int y, int z) {
  return mouseX >= w && mouseX <= x && mouseY >= y && mouseY <= z;
}

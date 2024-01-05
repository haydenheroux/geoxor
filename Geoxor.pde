Swarm left, right;

void setup() {
  size(1920, 1080);
  fullScreen();
  frameRate(60);
  
  initializePalette();
  left = new Swarm(14, false);
  right = new Swarm(14, true);
}

void draw() {
  background(kBackground);
  
  left.animate();
  left.repopulate();
  left.draw();
  
  right.animate();
  right.repopulate();
  right.draw();
}

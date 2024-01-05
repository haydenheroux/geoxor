Swarm swarm;

void setup() {
  size(1920, 1080);
  fullScreen();
  frameRate(60);
  
  initializePalette();
  swarm = new Swarm(10);
}

void draw() {
  background(kBackground);

  swarm.repopulate();
  swarm.animate();
  swarm.draw();
}

Swarm swarm;
Span vertical;

void setup() {
  size(1920, 1080);
  fullScreen();
  frameRate(60);
  
  initializePalette();
  swarm = new Swarm(14);
  
  vertical = new Span(0, height);
}

void draw() {
  background(kBackground);
  
  swarm.animate();

  swarm.repopulate();
  
  swarm.draw();
}

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
  
  stroke(255);
  
  for (Span span : swarm.spawnMask) {
    line(320, span.start, 320, span.end);
  }
}

Swarm swarm;

void setup() {
  size(1920, 1080);
  fullScreen();
  frameRate(60);
  
  initializePalette(PaletteOption.THREE);
  swarm = new Swarm(36, false);
}

void draw() {
  background(palette[0]);
  
  swarm.animate();
  swarm.repopulate();
  swarm.draw();
}

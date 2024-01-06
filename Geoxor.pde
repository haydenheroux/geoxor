int paletteSelector = int(random(0, 6));

Swarm swarm;

void setup() {
  size(1920, 1080);
  fullScreen();
  frameRate(60);
  
  setPalette(paletteSelector);
  swarm = new Swarm(36, false);
}

void draw() {
  background(palette[0]);
  
  swarm.animate();
  int culled = swarm.cull();
  swarm.spawn(culled);
  
  swarm.draw();
}

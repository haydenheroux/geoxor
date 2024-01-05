class Swarm {

  private final ArrayList<SwarmElement> elements = new ArrayList<SwarmElement>();
  
  public Swarm(int count) {
    for (int i = 0; i < count; i++) {
      elements.add(createSwarmElement());
    }
  }
  
  public void repopulate() {
    int count = 0;
    
    for (int i = elements.size() - 1; i >= 0; i--) {
      SwarmElement element = elements.get(i);
      if (element.dead()) {
        elements.remove(i);
        count++;
      }
    }
    
    for (int i = 0; i < count; i++) {
      elements.add(createSwarmElement());
    }
  }
  
  public void animate() {
    for (SwarmElement element : elements) {
      element.animate();
    }
  }
  
  public void draw() {
    for (SwarmElement element : elements) {
      element.draw();
    }
  }
  
}

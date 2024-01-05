import java.util.stream.Collectors;

class Swarm {

  private final ArrayList<SwarmElement> elements = new ArrayList<SwarmElement>();
  
  public ArrayList<Span> spawnMask = new ArrayList<Span>();
  
  public Swarm(int count) {
    for (int i = 0; i < count; i++) {
      elements.add(createSwarmElement(new Span(0, height)));
      
      updateSpawnMask();
    }
  }
  
  public ArrayList<Span> spans() {
    return new ArrayList<Span>(elements.stream().map(SwarmElement::span).collect(Collectors.toList()));
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
    
    if (spawnMask.isEmpty()) {
      return;
    }
    
    for (int i = 0; i < count; i++) {
      Span span = spawnMask.get(int(random(0, spawnMask.size())));
      
      elements.add(createSwarmElement(span));
      updateSpawnMask();
    }
  }
  
  public void updateSpawnMask() {
    spawnMask = new ArrayList<Span>(new Span(0, height).mask(this.spans()).stream().filter(span -> span.size() > 60).collect(Collectors.toList()));
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

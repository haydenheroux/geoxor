import java.util.stream.Collectors;
import java.util.List;

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
    List<Span> spans = elements.stream().map(SwarmElement::span).collect(Collectors.toList());
    
    return new ArrayList<Span>(spans);
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
    
    updateSpawnMask();
    
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
    ArrayList<Span> spaces = new Span(0, height).mask(this.spans());
    
    List<Span> largeSpaces = spaces.stream().filter(span -> span.size() > 60).collect(Collectors.toList());
    
    spawnMask = new ArrayList(largeSpaces);
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

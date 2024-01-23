import java.util.stream.Collectors;
import java.util.List;

class Swarm {

  private final boolean leftToRight;
  
  private final ArrayList<SwarmElement> elements = new ArrayList<SwarmElement>();
  
  public ArrayList<Span> spawnMask = new ArrayList<Span>();
  
  public Swarm(int count, boolean leftToRight) {
    this.leftToRight = leftToRight;
    
    this.spawn(count);
  }
  
  public ArrayList<Span> spans() {
    List<Span> spans = elements.stream().map(SwarmElement::span).collect(Collectors.toList());
    
    return new ArrayList<Span>(spans);
  }
  
  public int cull() {
    int removed = 0;
    
    for (int i = elements.size() - 1; i >= 0; i--) {
      SwarmElement element = elements.get(i);
      if (element.dead()) {
        elements.remove(i);
        removed++;
      }
    }
    
    updateSpawnMask();

    return removed;
  }
  
  public int spawn(int maximum) {
    updateSpawnMask();
    
    int spawned = 0;
    
    for (int i = 0; i < maximum; i++) {
      if (spawnMask.isEmpty()) break;
      
      Span randomSpan = spawnMask.get(int(random(0, spawnMask.size())));
      
      elements.add(createSwarmElement(randomSpan, this.leftToRight));
      
      spawned++;
      
      updateSpawnMask();
    }
    
    return spawned;
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
    
  public void drawMask() {
    for (Span span : this.spawnMask) {
      stroke(255);
      line(width / 2, span.start, width / 2, span.end);
    }
  }
  
}

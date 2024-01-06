import java.util.Stack;

class Span {
  
  public int start, end;
  
  public Span(int start, int end) {
    this.start = start;
    this.end = end;
  }
  
  public int size() {
    return this.end - this.start;
  }
  
  public boolean overlaps(Span other) {
    return this.start <= other.end && other.start <= this.end;
  }
  
  private int compareStart(Span a, Span b) {
    if (a.start == b.start) {
      return 0;
    } else if (a.start < b.start) {
      return -1;
    } else {
      return 1;
    }
  }
  
  private ArrayList<Span> merge(ArrayList<Span> spans) {
    if (spans.isEmpty()) return spans;
    
    Stack<Span> stack = new Stack<Span>();
  
    spans.sort(this::compareStart);
  
    stack.push(spans.get(0));
  
    for (int i = 1; i < spans.size(); i++) {
      Span top = stack.peek();
      Span span = spans.get(i);
      
      if (top.end < span.start) {
        stack.push(span);
      } else if (top.end < span.end) {
        top.end = span.end;
        stack.pop();
        stack.push(top);
      }
    }
  
    return new ArrayList(stack);
  } 
  
  public ArrayList<Span> mask(ArrayList<Span> masks) {
    ArrayList<Span> result = new ArrayList<Span>();
    
    ArrayList<Span> mergedMasks = this.merge(masks);
    
    int start = this.start;
    
    for (Span mask : mergedMasks) {
      result.add(new Span(start, mask.start));
      start = mask.end;
    }
    
    result.add(new Span(start, this.end));
    
    return result;
  }
  
}

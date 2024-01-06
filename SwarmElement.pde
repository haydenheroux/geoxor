class SwarmElement {

  private final int m_paletteIndex;

  private int m_steps = 0;
  private final int m_duration;

  private float m_startX, m_endX;

  private final int m_y, m_size;

  private final boolean m_leftToRight;
  
  private boolean m_dead = false;

  public SwarmElement(int paletteIndex, int x, int y, int size, boolean leftToRight, int duration) {
    m_paletteIndex = paletteIndex;
    m_startX = x;
    m_endX = x;

    m_y = y;
    m_size = size;
    m_leftToRight = leftToRight;
    
    m_duration = duration;
  }
  
  public Span span() {
    return new Span(m_y, m_y + m_size);
  }

  public void animate() {
    m_steps++;

    float t = float(m_steps) / float(m_duration);

    if (t > 1.0) {
      m_dead = true;
      return;
    }

    float velocityScalar = 24;

    if (!m_leftToRight) {
      velocityScalar *= -1;
    }

    float shape = sqrt(t);

    if (t < 0.8) {
      m_endX += shape * velocityScalar;
    }

    if (t > 0.4) {
      m_startX += shape * velocityScalar;
    }

    if (m_leftToRight) {
      if (m_endX < m_startX) {
        m_dead = true;
      }
    } else {
      if (m_endX > m_startX) {
        m_dead = true;
      }
    }
    
    if (m_leftToRight && m_startX > width) {
      m_dead = true;
    }
    
    if (!m_leftToRight && m_startX < 0) {
      m_dead = true;
    }
    
  }

  public void draw() {
    if (m_dead) {
      return;
    }

    drawRect(m_startX, m_endX);
  }

  private void drawRect(float left, float right) {
    fill(palette[m_paletteIndex]);
    noStroke();
    rect(left, m_y, right - left, m_size);
  }
  
  public boolean dead() {
    return m_dead;
  }
}

RandomNumberGenerator durationOffsetGenerator = new RandomNumberGenerator(0, 80, true);

public SwarmElement createSwarmElement(Span span, boolean leftToRight) {
  int paletteIndex = int(random(1, palette.length));
  float xOffset = random(-560, 560);
  
  float x = width / 2 + xOffset;
  
  float size = min(random(20, span.size()), 40);
  float y = random(span.start, span.end - size);
  float duration = 120 + durationOffsetGenerator.generate();
  
  boolean _leftToRight = random(0, 1) < 0.5;
    
  return new SwarmElement(paletteIndex, int(x), int(y), int(size), _leftToRight, int(duration));
}

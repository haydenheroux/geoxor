class SwarmElement {

  private final color m_color;

  private int m_steps = 0;
  private final int m_duration;

  private float m_startX, m_endX;

  private final int m_y, m_size;

  private final boolean m_leftToRight;
  
  private boolean m_dead = false;

  public SwarmElement(color c, int x, int y, int size, boolean leftToRight, int duration) {
    m_color = c;
    m_startX = x;
    m_endX = x;

    m_y = y;
    m_size = size;
    m_leftToRight = leftToRight;
    
    m_duration = duration;
  }

  public void animate() {
    m_steps++;

    float t = float(m_steps) / float(m_duration);

    if (t > 1.0) {
      m_dead = true;
      return;
    }

    float velocityScalar = 12;

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
    fill(m_color);
    noStroke();
    rect(left, m_y, right - left, m_size);
  }
  
  public boolean dead() {
    return m_dead;
  }
}

RandomNumberGenerator xOffsetGenerator = new RandomNumberGenerator(40, 360, true);
RandomNumberGenerator yCoordinateGenerator = new RandomNumberGenerator(20, 1060);
RandomNumberGenerator sizeGenerator = new RandomNumberGenerator(15, 60);
RandomNumberGenerator durationOffsetGenerator = new RandomNumberGenerator(0, 20, true);

public SwarmElement createSwarmElement() {
  color c = randomColor();
  float x = (width / 2) + xOffsetGenerator.generate();
  float y = yCoordinateGenerator.generate();
  float size = sizeGenerator.generate();
  float duration = 200 + durationOffsetGenerator.generate();
    
  return new SwarmElement(c, int(x), int(y), int(size), x > (width / 2), int(duration));
}

class Rectangle {

  private final color m_color;

  private int m_steps = 0;
  private final int m_duration;

  private float m_startX, m_endX;

  private final int m_y, m_size;

  private final boolean m_leftToRight;
  
  private boolean m_dead = false;

  public Rectangle(color c, int x, int y, int size, boolean leftToRight, int duration) {
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
  
  public boolean isDead() {
    return m_dead;
  }
}

Rectangle generate() {
  color c = colors[int(random(0, colors.length))];
  
  float xOffset = random(40, 120);
  float xDirection = random(-1, 1);
  xOffset = xOffset * xDirection / abs(xDirection);
  
  float y = random(20, 700);
  float size = random(15, 60);
  float duration = random(60, 180);
    
  return new Rectangle(c, (width / 2) + int(xOffset), int(y), int(size), xOffset > 0, int(duration));
}

float parametric(float t) {
  if (t < 0 || t > 1) return 0.0;

  return (t * t) / (2 * (t * t - t) + 1.0);
}

color kBackground = color(45, 19, 67);
color[] colors = new color[3];

final int count = 10;
Rectangle[] rectangles = new Rectangle[count];


void setup() {
  size(1280, 720);
  frameRate(60);
  
  colors[0] = color(28, 155, 220);
  colors[1] = color(255, 7, 189);
  colors[2] = color(33, 13, 54);
  
  for (int i = 0; i < count; i++) {
    rectangles[i] = generate();
  }

}

void draw() {
  background(kBackground);

  for (int i = 0; i < count; i++) {
    Rectangle rectangle = rectangles[i];
    
    if (rectangle.isDead()) {
      rectangles[i] = generate();
    }
    
    rectangles[i].animate();
    rectangles[i].draw();
  }
}

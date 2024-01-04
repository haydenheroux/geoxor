class Rectangle {

  private final color m_color;

  private int m_steps = 0;
  private final int m_duration = 100;

  private float m_startX, m_endX;

  private final int m_y, m_size;

  private final boolean m_reversed;

  public Rectangle(color c, int x, int initialWidth, int y, int size, boolean reversed) {
    m_color = c;
    m_startX = x;

    if (reversed) {
      m_endX = x - initialWidth;
    } else {
      m_endX = x + initialWidth;
    }

    m_y = y;
    m_size = size;
    m_reversed = reversed;
  }

  public void animate() {
    m_steps++;

    float t = float(m_steps) / float(m_duration);

    float velocityScalar = 16;

    if (m_reversed) {
      velocityScalar *= -1;
    }

    float shape = parametric(t);

    if (t < 0.8) {
      m_endX += shape * velocityScalar;
    }

    if (t > 0.4) {
      m_startX += shape * velocityScalar;
    }

    if (m_reversed) {
      if (m_endX > m_startX) {
        m_endX = m_startX;
      }
    } else {
      if (m_endX < m_startX) {
        m_endX = m_startX;
      }
    }
  }

  public void draw() {
    if (m_steps > m_duration) {
      return;
    }

    drawRect(m_startX, m_endX);
  }

  public void drawRect(float startX, float endX) {
    fill(m_color);
    noStroke();
    rect(startX, m_y, endX - startX, m_size);
  }
}

float parametric(float t) {
  if (t < 0 || t > 1) return 0.0;

  return (t * t) / (2 * (t * t - t) + 1.0);
}

color kBackground = color(45, 19, 67);
color[] colors = new color[3];

Rectangle[] rectangles = new Rectangle[10];


void setup() {
  size(1280, 720);
  frameRate(60);
  
  colors[0] = color(28, 155, 220);
  colors[1] = color(255, 7, 189);
  colors[2] = color(33, 13, 54);
  
  for (int i = 0; i < 10; i++) {
    color c = colors[int(random(0, colors.length))];
    float xOffset = random(-80, 80);
    float initialWidth = random(20, 40);
    float y = random(20, 720);
    float size = random(15, 60);
    
    rectangles[i] = new Rectangle(c, (width / 2) + int(xOffset), int(initialWidth), int(y), int(size), xOffset < 0);
  }

}

void draw() {
  background(kBackground);

  for (int i = 0; i < 10; i++) {
    rectangles[i].animate();
    rectangles[i].draw();
  }
}

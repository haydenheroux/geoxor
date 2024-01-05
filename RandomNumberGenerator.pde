class RandomNumberGenerator {

  private float m_min = 0;
  private float m_max;
  private boolean m_bidirectional = false;
  
  public RandomNumberGenerator(float max) {
    m_max = max;
  }
  
  public RandomNumberGenerator(float min, float max) {
    m_min = min;
    m_max = max;
  }
  
  public RandomNumberGenerator(float min, float max, boolean bidirectional) {
    m_min = min;
    m_max = max;
    m_bidirectional = bidirectional;
  }

  
  public float generate() {
    float value = random(m_min, m_max);
    
    if (!m_bidirectional) {
      return value;
    }
    
    float direction = random(-1, 1);
    float sign = direction / abs(direction);
    
    if (sign == 0) {
      return value;
    }
    
    return sign * value;
  }
  
}

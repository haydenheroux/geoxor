color kBackground = color(45, 19, 67);
color[] palette = new color[3];

public void initializePalette() {
  palette[0] = color(28, 155, 220);
  palette[1] = color(255, 7, 189);
  palette[2] = color(33, 13, 54);
}

public color randomColor() {
  return palette[int(random(0, palette.length))];
}

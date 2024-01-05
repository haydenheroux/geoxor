color[] palette = new color[4];

enum PaletteOption {
  ONE,
  TWO,
  THREE,
  FOUR,
  FIVE,
  SIX
}

public void initializePalette(PaletteOption option) {
  switch (option) {
    case ONE:
       palette[0] = color(45, 19, 67);
       palette[1] = color(28, 155, 220);
       palette[2] = color(255, 7, 189);
       palette[3] = color(33, 13, 54);
       break;
     case TWO:
       palette[0] = color(51, 9, 55);
       palette[1] = color(196, 206, 253);
       palette[2] = color(214, 36, 107);
       palette[3] = color(254, 226, 176);
       break;
     case THREE:
       palette[0] = color(57, 30, 63);
       palette[1] = color(237, 10, 168);
       palette[2] = color(255, 235, 192);
       palette[3] = color(167, 192, 212);
       break;
     case FOUR:
       palette[0] = color(250, 231, 248);
       palette[1] = color(247, 212, 185);
       palette[2] = color(169, 120, 214);
       palette[3] = color(251, 105, 219);
       break;
     case FIVE:
       palette[0] = color(223, 223, 235);
       palette[1] = color(176, 222, 233);
       palette[2] = color(255, 63, 172);
       palette[3] = color(254, 225, 212);
       break;
     case SIX:
       palette[0] = color(255, 204, 222);
       palette[1] = color(254, 73, 121);
       palette[2] = color(55, 39, 54);
       palette[3] = color(212, 67, 116);
       break;
  }
}

public color randomColor() {
  return palette[int(random(1, palette.length))];
}

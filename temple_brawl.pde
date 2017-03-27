
final int FLOOR_THICKNESS = 20;
boolean isFirstRun = true;

Sprite player;
ArrayList<Sprite> sprites = new ArrayList();

void setup() {
  size(1024, 768);
}

void tb_load() {
  player = new Sprite("data/sprites/figure.png", sprites);

  for (Sprite s : sprites) {
    s.load();
  }
}

void draw() {
  if (isFirstRun) {
    tb_setup();
  }

  tb_main_loop();
}

void tb_setup() {
  tb_load();
}

void tb_main_loop() {
  tb_update();
  tb_draw();
}

void tb_draw() {
  clear();
  background(0);

  // floor
  fill(255);
  strokeWeight(0);
  rect(0, height - FLOOR_THICKNESS, width, FLOOR_THICKNESS);

  for (Sprite s : sprites) {
    s.draw();
  }
}

void tb_update() {
  for (Sprite s : sprites) {
    s.update();
  }
}
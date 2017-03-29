
final int FLOOR_THICKNESS = 20;
boolean isFirstRun = true;

ArrayList<Sprite> sprites = new ArrayList();

Player player;

void setup() {
  size(1024, 768);
  tb_load();
}

void tb_load() {
  player = new Player("data/sprites/spritesheet.png", 50, 50);
  player.x = 200;
  player.y = height - FLOOR_THICKNESS - 50;
  player.y -= 100;
  sprites.add(player);

  for (Sprite s : sprites) {
    s.load();
  }
}

void draw() {
  tb_main_loop();
}

void keyPressed() {
  player.setKeyDown(keyCode, true);
}

void keyReleased() {
  player.setKeyDown(keyCode, false);
}

void tb_main_loop() {
  tb_update();
  tb_draw();
}

void tb_draw() {
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
  long time = System.currentTimeMillis();

  for (Sprite s : sprites) {
    s.update(time);
  }
}
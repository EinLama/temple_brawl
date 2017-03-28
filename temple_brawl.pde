
final int FLOOR_THICKNESS = 20;
boolean isFirstRun = true;

Sprite player;
ArrayList<Sprite> sprites = new ArrayList();

AnimatedSprite animatedPlayer;

void setup() {
  size(1024, 768);
}

void tb_load() {
  player = new Sprite("data/sprites/figure.png", sprites);
  player.x = 100;
  player.y = height - FLOOR_THICKNESS - 50;
  
  animatedPlayer = new AnimatedSprite("data/sprites/spritesheet.png", 50, 50);
  animatedPlayer.x = 200;
  animatedPlayer.y = height - FLOOR_THICKNESS - 50;
  sprites.add(animatedPlayer);

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

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
  sprites.add(player);

  ArrayList<AnimationStep> steps = new ArrayList();
  steps.add(new AnimationStep(0, 150));
  steps.add(new AnimationStep(1, 100));
  steps.add(new AnimationStep(2, 150));
  Animation anim = new Animation("walking", steps);
  player.currentAnimation = anim;

  for (Sprite s : sprites) {
    s.load();
  }

  anim.isLooping = true;
  anim.start(true);
}

void draw() {
  tb_main_loop();
}

void keyPressed() {
  if (keyCode == LEFT) {
    player.setKeyDown(LEFT, true);
  }
  if (keyCode == RIGHT) {
    player.setKeyDown(RIGHT, true);
  }
}

void keyReleased() {
  if (keyCode == LEFT) {
    player.setKeyDown(LEFT, false);
  }
  if (keyCode == RIGHT) {
    player.setKeyDown(RIGHT, false);
  }
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
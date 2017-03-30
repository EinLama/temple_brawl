
final int FLOOR_THICKNESS = 20;
boolean isFirstRun = true;

ArrayList<Sprite> sprites = new ArrayList();
ArrayList<Platform> platforms = new ArrayList();

Player player;
Platform ground;

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

  ground = new Platform(0, height - FLOOR_THICKNESS, width, FLOOR_THICKNESS);
  sprites.add(ground);
  platforms.add(ground);

  Platform p1 = new Platform(300, height - 3 * FLOOR_THICKNESS, 150, FLOOR_THICKNESS);
  sprites.add(p1);
  platforms.add(p1);

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

  for (Sprite s : sprites) {
    s.draw();
  }
}

void tb_update() {
  long time = System.currentTimeMillis();

  for (Sprite s : sprites) {
    if (s instanceof Platform) {
      Platform p = (Platform) s;
      if (player.collidesWith(p)) {
        player.handleCollision(p);
        p.g = 0;
      } else {
        p.g = 255;
      }
    }

    s.update(time);
  }
}
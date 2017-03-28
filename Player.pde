
class Player extends AnimatedSprite {
  final float ACCELERATION = 2;
  PlayerInput input = new PlayerInput();

  public Player(PImage image, int tileWidth, int tileHeight) {
    super(image, tileWidth, tileHeight);
  }

  public Player(String imagePath, int tileWidth, int tileHeight) {
    super(imagePath, tileWidth, tileHeight);
  }

  public void update(long time) {
    super.update(time);

    if (input.isDown(LEFT)) {
      x -= ACCELERATION;
    }
    if (input.isDown(RIGHT)) {
      x += ACCELERATION;
    }
  }

  public void setKeyDown(int key, boolean isDown) {
    input.setIsDown(key, isDown);
  }
}

class PlayerInput {
  HashMap<Integer, Boolean> keys = new HashMap();

  public boolean isDown(int key) {
    if (keys.containsKey(key)) {
      return keys.get(key);
    } else {
      return false;
    }
  }

  public void setIsDown(int key, boolean isDown) {
    keys.put(key, isDown);
  }
}
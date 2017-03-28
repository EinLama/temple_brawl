
class Player extends AnimatedSprite {
  final float ACCELERATION = 2;
  float velocityX, velocityY;
  PlayerInput input = new PlayerInput();
  HashMap<String, Animation> animations = new HashMap();

  public Player(PImage image, int tileWidth, int tileHeight) {
    super(image, tileWidth, tileHeight);
    setup();
  }

  public Player(String imagePath, int tileWidth, int tileHeight) {
    super(imagePath, tileWidth, tileHeight);
    setup();
  }

  private void setup() {
    animations.put("walkLeft", new AnimationFactory()
      .addStep(0, 150)
      .addStep(1, 100)
      .addStep(2, 150)
      .setName("walkLeft").looping(true).build());

    animations.put("stand", new AnimationFactory()
      .addStep(2, 0)
      .setName("stand").build());
  }

  public void setAnimation(Animation anim) {
    if (anim != null && anim.equals(currentAnimation)) { 
      return;
    }

    if (currentAnimation != null) {
      currentAnimation.stop();
    }

    currentAnimation = anim;
    if (anim != null) {
      anim.start(true);
    }
  }

  public void setAnimation(String animationName) {
    setAnimation(animations.get(animationName));
  }

  public void update(long time) {
    super.update(time);

    if (input.isDown(LEFT)) {
      velocityX = -ACCELERATION;
      setAnimation("walkLeft");
    } else if (input.isDown(RIGHT)) {
      velocityX = ACCELERATION;
      setAnimation("walkLeft");
    } else {
      velocityX = 0;
      setAnimation("stand");
    }

    x += velocityX;
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
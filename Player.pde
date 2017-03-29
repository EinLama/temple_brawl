
class Player extends AnimatedSprite {
  final float ACCELERATION = 2, GRAVITY = 2;
  float velocityX, velocityY;
  boolean isJumping;

  PlayerInput input = new PlayerInput();
  HashMap<String, Animation> animations = new HashMap();

  public Player(PImage image, int tileWidth, int tileHeight) {
    super(image, tileWidth, tileHeight);
  }

  public Player(String imagePath, int tileWidth, int tileHeight) {
    super(imagePath, tileWidth, tileHeight);
  }

  private void setup() {
    animations.put("walkLeft", new AnimationFactory()
      .addStep(0, 150)
      .addStep(1, 100)
      .addStep(2, 150)
      .setName("walkLeft").looping(true).build());

    animations.put("standLeft", new AnimationFactory()
      .addStep(2, 0)
      .setName("standLeft").build());

    ImageUtils imgUtils = new ImageUtils();
    addTile(imgUtils.flipHorizontally(tiles.get(0)));
    addTile(imgUtils.flipHorizontally(tiles.get(1)));
    addTile(imgUtils.flipHorizontally(tiles.get(2)));

    animations.put("walkRight", new AnimationFactory()
      .addStep(3, 150)
      .addStep(4, 100)
      .addStep(5, 150)
      .setName("walkRight").looping(true).build());

    animations.put("standRight", new AnimationFactory()
      .addStep(5, 0)
      .setName("standRight").build());

    animations.put("jumpLeft", new AnimationFactory()
      .addStep(0, 0)
      .setName("jumpLeft").build());

    animations.put("jumpRight", new AnimationFactory()
      .addStep(3, 0)
      .setName("jumpRight").build());
  }

  public void load() {
    super.load();
    this.setup();
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

  public void jump() {
    if (!isJumping) {
      velocityY = -24f;
      isJumping = true;
    }
  }

  public float getGroundPos() {
    return height - FLOOR_THICKNESS - image.height;
  }

  public boolean isOnGround() {
    return y >= getGroundPos();
  }

  public void update(long time) {
    super.update(time);

    if (isJumping) {
      if (velocityX > 0) {
        setAnimation("jumpRight");
      } else if (velocityX < 0) {
        setAnimation("jumpLeft");
      }
    }

    if (input.isDown(LEFT)) {
      velocityX = -ACCELERATION;

      if (!isJumping) {
        setAnimation("walkLeft");
      }
    } else if (input.isDown(RIGHT)) {
      velocityX = ACCELERATION;
      if (!isJumping) {
        setAnimation("walkRight");
      }
    } else if (!isJumping) {
      if (velocityX > 0) {
        setAnimation("standRight");
      } else if (velocityX < 0) {
        setAnimation("standLeft");
      }
      velocityX = 0;
    } else {
      velocityX = 0;
    }

    velocityY += GRAVITY;

    x += velocityX;
    y += velocityY;

    // Stick to ground, don't fall through it:
    if (isOnGround()) {
      isJumping = false; 
      float floorPos = getGroundPos(); 

      if (y >= floorPos) {
        y = floorPos;
        velocityY = 0;
      }
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
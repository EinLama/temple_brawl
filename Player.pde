
class Player extends AnimatedSprite implements IKeyListener {
  final float ACCELERATION = 3, GRAVITY = 1.5f, JUMP_ACCELERATION = 20;
  final int DIRECTION_LEFT = 0, DIRECTION_RIGHT = 1;

  float velocityX, velocityY;
  boolean isJumping;
  int direction = DIRECTION_RIGHT;

  PlayerInput input = new PlayerInput();

  public Player() {
    // default settings for this game
    setImagePath("data/sprites/spritesheet.png");
    tileWidth = 50;
    tileHeight = 50;
  }

  public Player(PImage image, int tileWidth, int tileHeight) {
    super(image, tileWidth, tileHeight);
  }

  public Player(String imagePath, int tileWidth, int tileHeight) {
    super(imagePath, tileWidth, tileHeight);
  }

  protected void setupAnimations() {
    input.addListener(this);

    ImageUtils imgUtils = new ImageUtils();
    addTile(imgUtils.flipHorizontally(tiles.get(0)));
    addTile(imgUtils.flipHorizontally(tiles.get(1)));
    addTile(imgUtils.flipHorizontally(tiles.get(2)));

    animations.put("walkLeft", new AnimationFactory()
      .addStep(0, 150)
      .addStep(1, 100)
      .addStep(2, 150)
      .looping(true)
      .build());

    animations.put("standLeft", new AnimationFactory()
      .addStep(2, 0)
      .build());

    animations.put("walkRight", new AnimationFactory()
      .addStep(3, 150)
      .addStep(4, 100)
      .addStep(5, 150)
      .looping(true)
      .build());

    animations.put("standRight", new AnimationFactory()
      .addStep(5, 0)
      .build());

    animations.put("jumpLeft", new AnimationFactory()
      .addStep(0, 0)
      .build());

    animations.put("jumpRight", new AnimationFactory()
      .addStep(3, 0)
      .build());
  }

  public void jumpKeyPressed() {
    if (!isJumping) {
      velocityY = -JUMP_ACCELERATION;
      isJumping = true;
    }
  }

  public void jumpKeyReleased() {
    if (isJumping && velocityY < -JUMP_ACCELERATION / 3) {
      velocityY = -JUMP_ACCELERATION / 3;
    }
  }

  public float getGroundPos() {
    return height - FLOOR_THICKNESS - this.getHeight();
  }

  public boolean isOnGround() {
    return y >= getGroundPos();
  }

  public void update(long time) {
    super.update(time);

    if (input.isDown(LEFT)) {
      velocityX = -ACCELERATION;
      direction = DIRECTION_LEFT;
    } else if (input.isDown(RIGHT)) {
      velocityX = ACCELERATION;
      direction = DIRECTION_RIGHT;
    } else if (!isJumping) {
      velocityX = 0;
    } else {
      velocityX = 0;
    }

    velocityY += GRAVITY;

    x += velocityX;
    y += velocityY;

    setAnimationForMovement();

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

  private void setAnimationForMovement() {
    boolean isMoving = velocityX != 0;

    switch (direction) {
    case DIRECTION_LEFT:
      if (isJumping) {
        setAnimation("jumpLeft");
      } else if (isMoving) {
        setAnimation("walkLeft");
      } else {
        setAnimation("standLeft");
      }
      break;
    case DIRECTION_RIGHT:
      if (isJumping) {
        setAnimation("jumpRight");
      } else if (isMoving) {
        setAnimation("walkRight");
      } else {
        setAnimation("standRight");
      }
    }
  }

  public void handleCollision(Sprite other) {
    if (other instanceof Coin) {
      // simulate coin pickup -> remove it from screen:
      other.destroy();
    }
  }

  public void setKeyDown(int key, boolean isDown) {
    input.setIsDown(key, isDown);
  }

  public void onKeyDown(int key) {
    if (key == UP) {
      jumpKeyPressed();
    }
  }

  public void onKeyUp(int key) {
    if (key == UP) {
      jumpKeyReleased();
    }
  }
}

interface IKeyListener {
  public void onKeyDown(int key);
  public void onKeyUp(int key);
}

class PlayerInput {
  ArrayList<IKeyListener> listeners = new ArrayList();
  HashMap<Integer, Boolean> keys = new HashMap();

  public boolean isDown(int key) {
    if (keys.containsKey(key)) {
      return keys.get(key);
    } else {
      return false;
    }
  }

  public void setIsDown(int key, boolean isDown) {
    if (isDown) {
      if (!this.isDown(key)) {
        for (IKeyListener lst : listeners) {
          lst.onKeyDown(key);
        }
      }
    } else {
      for (IKeyListener lst : listeners) {
        lst.onKeyUp(key);
      }
    }

    keys.put(key, isDown);
  }

  public void addListener(IKeyListener lst) {
    if (!listeners.contains(lst)) {
      listeners.add(lst);
    }
  }

  public void removeListener(IKeyListener lst) {
    listeners.remove(lst);
  }
}
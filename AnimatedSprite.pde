
class AnimatedSprite extends Sprite {
  int tileWidth, tileHeight;

  protected ArrayList<PImage> tiles = new ArrayList();
  HashMap<String, Animation> animations = new HashMap();
  protected int numberOfTiles, tileIndex;

  Animation currentAnimation;

  public AnimatedSprite(PImage image, int tileWidth, int tileHeight) {
    super(image);

    this.tileWidth = tileWidth;
    this.tileHeight = tileHeight;
  }

  public AnimatedSprite(String imagePath, int tileWidth, int tileHeight) {
    super(imagePath);

    this.tileWidth = tileWidth;
    this.tileHeight = tileHeight;
  }

  protected void extractSprites() {
    numberOfTiles = image.width / tileWidth;
    tiles = new ArrayList();

    for (int i=0; i != numberOfTiles; ++i) {
      tiles.add(image.get(tileWidth * i, 0, tileWidth, tileHeight));
    }

    tileIndex = 0;
  }

  public void addTile(PImage newTile) {
    tiles.add(newTile);
    numberOfTiles = tiles.size();
  }

  public int getIndex() {
    return tileIndex;
  }

  public void setIndex(int index) {
    if (index >= numberOfTiles && index < 0) {
      throw new Error("Index must be in range of tiles: " + numberOfTiles);
    }

    tileIndex = index;
  }

  protected void setupAnimations() {
    // should override this in extended classes
  }

  public void load() {
    super.load();
    extractSprites();
    setupAnimations();
  }

  public float getWidth() {
    return tileWidth;
  }
  public float getHeight() {
    return tileHeight;
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

  public void draw() {
    if (!this.isLoaded() || !isAlive) {
      return;
    }

    if (currentAnimation != null) {
      tileIndex = currentAnimation.getTileIndex();
    }

    image(tiles.get(tileIndex), x, y);
  }

  public void update(long time) {
    super.update(time);

    if (currentAnimation != null) {
      currentAnimation.update(time);
    }
  }
}
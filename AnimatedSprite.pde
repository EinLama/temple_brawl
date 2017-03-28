
class AnimatedSprite extends Sprite {
  int tileWidth, tileHeight;

  protected PImage[] tiles;
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
    tiles = new PImage[numberOfTiles];

    for (int i=0; i != numberOfTiles; ++i) {
      tiles[i] = image.get(tileWidth * i, 0, tileWidth, tileHeight);
    }

    tileIndex = 0;
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

  public void load() {
    super.load();
    extractSprites();
  }

  public void draw() {
    if (!this.isLoaded()) {
      return;
    }

    if (currentAnimation != null) {
      tileIndex = currentAnimation.getTileIndex();
    }

    image(tiles[tileIndex], x, y);
  }

  public void update(long time) {
    super.update(time);

    if (currentAnimation != null) {
      currentAnimation.update(time);
    }
  }
}
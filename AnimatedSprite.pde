
class AnimatedSprite extends Sprite {
  int tileWidth, tileHeight;

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

  public void draw() {
    if (!this.isLoaded()) {
      return;
    }
    
    image(this.image, x, y);
  }
}
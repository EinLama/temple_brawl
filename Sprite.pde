
class Sprite {
  String imagePath;
  PImage image;
  float x, y;

  public Sprite(PImage image, ArrayList<Sprite> spriteCollection) {
    this(image);
    spriteCollection.add(this);
  }

  public Sprite(String imagePath, ArrayList<Sprite> spriteCollection) {
    this(imagePath);
    spriteCollection.add(this);
  }

  public Sprite(PImage image) {
    this.image = image;
  }

  public Sprite(String imagePath) {
    this.imagePath = imagePath;
  }

  public void load() {
    if (!isLoaded()) {
      image = loadImage(imagePath);
    }
  }

  public boolean isLoaded() {
    return image != null;
  }

  public void draw() {
    if (this.isLoaded()) {
      image(this.image, x, y);
    }
  }

  public void update() {
  }
}
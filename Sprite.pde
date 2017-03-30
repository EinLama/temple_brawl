
class Sprite {
  String imagePath;
  PImage image;
  float x, y;

  boolean hasImage;
  boolean isAlive = true;

  public Sprite() {
  }

  public Sprite(ArrayList<Sprite> spriteCollection) {
    spriteCollection.add(this);
  }

  public Sprite(PImage image, ArrayList<Sprite> spriteCollection) {
    this(image);
    spriteCollection.add(this);
  }

  public Sprite(String imagePath, ArrayList<Sprite> spriteCollection) {
    this(imagePath);
    spriteCollection.add(this);
  }

  public Sprite(PImage image) {
    setImage(image);
  }

  public Sprite(String imagePath) {
    setImagePath(imagePath);
  }

  public void setImage(PImage img) {
    image = img;
    if (img != null) {
      hasImage = true;
    }
  }

  public void setImagePath(String path) {
    imagePath = path;
    if (path != null) {
      hasImage = true;
    }
  }

  public void load() {
    if (!isLoaded() && hasImage) {
      image = loadImage(imagePath);
    }
  }

  public float getWidth() {
    if (image != null) {
      return image.width;
    } else {
      return 0f;
    }
  }
  public float getHeight() {
    if (image != null) {
      return image.height;
    } else {
      return 0f;
    }
  }

  public boolean collidesWith(Sprite other) {
    if (other == null || other == this || !isAlive || !other.isAlive) { 
      return false;
    }

    if (this.x < other.x + other.getWidth() &&
      this.x + this.getWidth() > other.x &&
      this.y < other.y + other.getHeight() &&
      this.y + this.getHeight() > other.y) {
      return true;
    }

    return false;
  }

  public boolean isLoaded() {
    if (hasImage) {
      return image != null;
    } else {
      return true;
    }
  }

  public void draw() {
    if (isAlive && this.isLoaded()) {
      image(this.image, x, y);
    }
  }

  public void update(long time) {
  }

  public String toString() {
    return "<" + getClass().getSimpleName() + "\t" + x + "," + y + ":\t" + getWidth() + "x" + getHeight() + ">";
  }
}
class Platform extends Sprite {
  float width, height;
  int r, g, b;

  public Platform() {
    super();
  }

  public Platform(float x, float y, float w, float h) {
    this(x, y, w, h, 255, 255, 255);
  }

  public Platform(float x, float y, float w, float h, int r, int g, int b) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;

    this.r = r;
    this.g = g;
    this.b = b;
  }

  public void draw() {
    fill(r, g, b);
    strokeWeight(0);
    rect(x, y, this.width, this.height);
  }

  public float getWidth() {
    return this.width;
  }
  public float getHeight() {
    return this.height;
  }
}
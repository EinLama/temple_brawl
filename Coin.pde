class Coin extends AnimatedSprite {
  public Coin(PImage image, int tileWidth, int tileHeight) {
    super(image, tileWidth, tileHeight);
  }

  public Coin(String imagePath, int tileWidth, int tileHeight) {
    super(imagePath, tileWidth, tileHeight);
  }

  protected void setupAnimations() {
    animations.put("turn", new AnimationFactory()
      .addStep(0, 200)
      .addStep(1, 200)
      .addStep(2, 200)
      .looping(true)
      .build());

    setAnimation("turn");
  }
}
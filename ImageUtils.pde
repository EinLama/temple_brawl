
class ImageUtils {
  public PImage flipHorizontally(PImage img) {
    PImage flipped = createImage(img.width, img.height, ARGB);
    for (int i = 0; i < flipped.pixels.length; i++) {
      int srcX = i % flipped.width;
      int dstX = flipped.width-srcX-1;
      int y = i / flipped.width;
      flipped.pixels[y*flipped.width+dstX] = img.pixels[i];
    }

    return flipped;
  }
}

class Animation {
  String name;
  ArrayList<AnimationStep> steps;
  boolean isLooping;
  int currentStepIndex;

  long currentTime;

  public Animation() {
    this(new ArrayList<AnimationStep>());
  }

  public Animation(ArrayList<AnimationStep> steps) {
    this("", steps);
  } 

  public Animation(String name, ArrayList<AnimationStep> steps) {
    this.name = name;
    this.steps = steps;
  }

  public AnimationStep getCurrentStep() {
    return steps.get(currentStepIndex);
  }

  public int getTileIndex() {
    return getCurrentStep().index;
  }

  public AnimationStep nextStep() {
    if (currentStepIndex < steps.size() - 1) {
      ++currentStepIndex;
    } else if (isLooping) {
      currentStepIndex = 0;
    }

    return getCurrentStep();
  }

  public void start(boolean fromBeginning) {
    currentTime = System.currentTimeMillis();

    if (fromBeginning) {
      currentStepIndex = 0;
    }
  }

  public void stop() {
    currentTime = 0;
  }

  public boolean isRunning() {
    return currentTime > 0;
  }

  public void update(long time) {
    AnimationStep step = getCurrentStep();

    if (step != null && isRunning() && step.duration > 0) {
      if (time - currentTime >= step.duration) {
        nextStep();
        currentTime = System.currentTimeMillis();
      }
    }
  }
}

class AnimationStep {
  int index, duration;

  public AnimationStep() {
  }

  public AnimationStep(int index, int duration) {
    this.index = index;
    this.duration = duration;
  }
}


class AnimationFactory {
  Animation anim;

  public AnimationFactory() {
    anim = new Animation();
  }

  public AnimationFactory setName(String name) {
    anim.name = name;
    return this;
  }

  public AnimationFactory addStep(int index, int duration) {
    anim.steps.add(new AnimationStep(index, duration));
    return this;
  }

  public AnimationFactory looping(boolean isLooping) {
    anim.isLooping = isLooping;
    return this;
  }

  public Animation build() {
    return anim;
  }
}
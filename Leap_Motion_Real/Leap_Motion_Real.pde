import de.voidplus.leapmotion.*;
import processing.sound.*;


LeapMotion leap;

int COUNT = 30;
float [] xoxox= new float [COUNT];
float [] xoxoy= new float [COUNT];

float x = 0;
float y= height/2;

PImage gossipgirl;
PImage nate;
PImage dan;
PImage chuck;
PImage blair;
PImage serena;
PImage xoxo;

SoundFile file;

void setup() 
{
  size(800, 800, P2D);
  x=width/2;
  background(100);

  file = new SoundFile(this, "ggsong.mp3");
  file.play();


  leap = new LeapMotion(this);
  leap = new LeapMotion(this).allowGestures(); 
  leap = new LeapMotion(this).allowGestures("swipe");

  gossipgirl= loadImage ("gossipgirl.png");
  nate= loadImage ("nate.png");
  dan=loadImage ("dan.png");
  chuck=loadImage ("chuck.png");
  blair= loadImage("blair.png");
  serena= loadImage("serena.png");
  xoxo= loadImage ("xoxo.png");


  for (int i=0; i< COUNT; i++)
  {
    xoxox[i]=random(0, 800);
    xoxoy[i]=random (width);
  }
}


void leapOnSwipeGesture(SwipeGesture g, int state)
{
  background(0);
  x+= g.getSpeed()*0.00005*g.getDirection().x;
}




// ======================================================
// 1. Callbacks

void leapOnInit() 
{
  // println("Leap Motion Init");
}
void leapOnConnect() 
{
  // println("Leap Motion Connect");
}
void leapOnFrame()
{
  // println("Leap Motion Frame");
}
void leapOnDisconnect() 
{
  // println("Leap Motion Disconnect");
}



void draw() 
{

  background(255);

  fill(255, 0, 255);
  imageMode(CENTER);
  image(gossipgirl, x, height/2, 400, 300);


  for (int i=0; i< COUNT; i++)
  {
    image(xoxo, xoxox[i], xoxoy[i], 120, 40);
    xoxoy[i]+=2;

    if (xoxoy[i]>height)
    {
      xoxox[i]=random(0, 800);
      xoxoy[i]=random (width);
    }
  }

  for (int i=0; i< COUNT; i++)
  {

    image (xoxo, xoxox[i], xoxoy[i], 2, 2 );
    xoxoy[i]+=1;

    if (xoxoy[i]>height)
    {
      xoxox[i]=random(width);
      xoxoy[i]=random (0, 800);
    }
  }


  // ...

  int fps = leap.getFrameRate();
  for (Hand hand : leap.getHands ()) 
  {


    // ==================================================
    // 2. Hand

    int     handId             = hand.getId();
    PVector handPosition       = hand.getPosition();
    PVector handStabilized     = hand.getStabilizedPosition();
    PVector handDirection      = hand.getDirection();
    PVector handDynamics       = hand.getDynamics();
    float   handRoll           = hand.getRoll();
    float   handPitch          = hand.getPitch();
    float   handYaw            = hand.getYaw();
    boolean handIsLeft         = hand.isLeft();
    boolean handIsRight        = hand.isRight();
    float   handGrab           = hand.getGrabStrength();
    float   handPinch          = hand.getPinchStrength();
    float   handTime           = hand.getTimeVisible();
    PVector spherePosition     = hand.getSpherePosition();
    float   sphereRadius       = hand.getSphereRadius();

    // --------------------------------------------------
    // Drawing
    //hand.draw();


    // ==================================================
    // 3. Arm

    if (hand.hasArm()) 
    {
      Arm     arm              = hand.getArm();
      float   armWidth         = arm.getWidth();
      PVector armWristPos      = arm.getWristPosition();
      PVector armElbowPos      = arm.getElbowPosition();
    }


    // ==================================================
    // 4. Finger

    Finger  fingerThumb        = hand.getThumb();
    // or                        hand.getFinger("thumb");
    // or                        hand.getFinger(0);

    Finger  fingerIndex        = hand.getIndexFinger();
    // or                        hand.getFinger("index");
    // or                        hand.getFinger(1);

    Finger  fingerMiddle       = hand.getMiddleFinger();
    // or                        hand.getFinger("middle");
    // or                        hand.getFinger(2);

    Finger  fingerRing         = hand.getRingFinger();
    // or                        hand.getFinger("ring");
    // or                        hand.getFinger(3);

    Finger  fingerPink         = hand.getPinkyFinger();
    // or                        hand.getFinger("pinky");
    // or                        hand.getFinger(4);



    image(dan, fingerRing.getPosition().x, fingerRing.getPosition().y, 200, 300);
    for (Finger finger : hand.getFingers()) 

      image(nate, fingerMiddle.getPosition().x, fingerMiddle.getPosition().y, 100, 200);
    for (Finger finger : hand.getFingers()) 

      image(chuck, fingerIndex.getPosition().x, fingerIndex.getPosition().y, 200, 300);
    for (Finger finger : hand.getFingers()) 

      image(blair, fingerPink.getPosition().x, fingerPink.getPosition().y, 150, 250);
    for (Finger finger : hand.getFingers()) 

      image(serena, fingerThumb.getPosition().x, fingerThumb.getPosition().y, 190, 290);
    for (Finger finger : hand.getFingers()) 

    {
      // or              hand.getOutstretchedFingers();
      // or              hand.getOutstretchedFingersByAngle();

      int     fingerId         = finger.getId();
      PVector fingerPosition   = finger.getPosition();
      PVector fingerStabilized = finger.getStabilizedPosition();
      PVector fingerVelocity   = finger.getVelocity();
      PVector fingerDirection  = finger.getDirection();
      float   fingerTime       = finger.getTimeVisible();

      // ------------------------------------------------
      // Drawing

      // Drawing:
      // finger.draw();  // Executes drawBones() and drawJoints()
      // finger.drawBones();
      // finger.drawJoints();

      // ------------------------------------------------
      // Selection

      switch(finger.getType()) 
      {
      case 0:
        // System.out.println("thumb");
        break;
      case 1:
        // System.out.println("index");
        break;
      case 2:
        // System.out.println("middle");
        break;
      case 3:
        // System.out.println("ring");
        break;
      case 4:
        // System.out.println("pinky");
        break;
      }


      // ================================================
      // 5. Bones
      // --------
      // https://developer.leapmotion.com/documentation/java/devguide/Leap_Overview.html#Layer_1

      Bone    boneDistal       = finger.getDistalBone();
      // or                      finger.get("distal");
      // or                      finger.getBone(0);

      Bone    boneIntermediate = finger.getIntermediateBone();
      // or                      finger.get("intermediate");
      // or                      finger.getBone(1);

      Bone    boneProximal     = finger.getProximalBone();
      // or                      finger.get("proximal");
      // or                      finger.getBone(2);

      Bone    boneMetacarpal   = finger.getMetacarpalBone();
      // or                      finger.get("metacarpal");
      // or                      finger.getBone(3);

      // ------------------------------------------------
    }
  }
}
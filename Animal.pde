public class Animal{
  private float feed,SIZE,MAX_SPEED;
  private boolean alive;
  private PVector p,v,a;
  private int CLOCK;
  public Animal(float feed,float size,float maxspeed,boolean alive,PVector p){this.feed=feed;this.SIZE=size;this.MAX_SPEED=maxspeed;this.alive=alive;this.p=p;this.v=new PVector(0,0);this.a=new PVector(0,0);this.CLOCK=millis();}
  public Animal(float feed,float size,float maxspeed,boolean alive,PVector p,PVector v){this.feed=feed;this.SIZE=size;this.MAX_SPEED=maxspeed;this.alive=alive;this.p=p;this.v=v;this.a=new PVector(0,0);this.CLOCK=millis();}
  public Animal(float feed,float size,float maxspeed,boolean alive,PVector p,PVector v,PVector a){this.feed=feed;this.SIZE=size;this.MAX_SPEED=maxspeed;this.alive=alive;this.p=p;this.v=v;this.a=a;this.CLOCK=millis();}
  public float getFeed(){return this.feed;}
  public boolean getAlive(){return this.alive;}
  public float getSize(){return this.SIZE;}
  public float getMaxSpeed(){return this.MAX_SPEED;}
  public PVector getLoc(){return this.p;}
  public PVector getVelo(){return this.v;}
  public PVector getAccel(){return this.a;}
  public float getSpeed(){return this.v.mag();}
  public float getDir(){return this.v.heading();}
  public int getClock(){return this.CLOCK;}
  public void setFeed(float feed){this.feed=feed;}
  public void setAlive(boolean alive){this.alive=alive;}
  public void setLoc(PVector p){this.p=p;}
  public void setVelo(PVector v){this.v=v;}
  public void setAccel(PVector a){this.a=a;}
  public void setSpeed(float s){this.v.setMag(s);}
  public void setDir(float theta){this.v=PVector.fromAngle(theta).setMag(this.v.mag());}
  public void rotateDir(float theta){this.v.rotate(theta);this.a.rotate(theta);}
  public boolean detectCollision(){return this.getLoc().x<this.getSize()||this.getLoc().x>width-this.getSize()||this.getLoc().y<this.getSize()||this.getLoc().y>height-this.getSize();}
  public boolean detectCollision(Animal a){return PVector.dist(this.getLoc(),a.getLoc())<=this.getSize()+a.getSize();}
  public void update(boolean frameDependency){this.p.add(PVector.mult(this.v,frameDependency?1:millis()-this.CLOCK));this.v.add(PVector.mult(this.a,frameDependency?1:millis()-this.CLOCK));this.v.limit(MAX_SPEED);this.CLOCK=millis();}
  public void display(){ellipse(this.p.x,this.p.y,this.SIZE*2,this.SIZE*2);}
}
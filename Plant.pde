public class Plant extends Life{
  public static final float MAX_AGE=100,MIN_AGE=30;
  public Plant(float age,PVector p){super(age,2.5,false,p);this.checkAlive();}
  @Override public void setAge(float age){super.setAge(age);this.checkAlive();}
  protected void checkAlive(){this.alive=(age>=MIN_AGE&&age<MAX_AGE)?true:false;}
  @Override protected void grow(){super.grow();this.age%=Plant.MAX_AGE;}
  @Override protected void display(){fill(#0000FF);super.display();}
  @Override public void update(){this.checkAlive();super.update();}
}

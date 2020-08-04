final boolean FRAMEDEPENDENCY=false; //<>//
final float AGE_GRADIENT=1;
final int PREDATOR_NUM=1000,PREY_NUM=1000,PLANT_NUM=2000;
Predator[] predator;Prey[] prey;Plant[] plant;
public float dis(int i,int j){return PVector.dist(predator[i].p,prey[j].p);}
public float rand(float a,float b){return (random(-1,1)<0?-1:1)*random(a,b);}
public void setup(){
  size(1000,1000,P2D);surface.setTitle("Lotka-Volterra Equations");surface.setResizable(false);frameRate(600);
  background(#000000);noStroke();fill(#FFFFFF);
  predator=new Predator[PREDATOR_NUM];prey=new Prey[PREY_NUM];plant=new Plant[PLANT_NUM];
  for(int i=0;i<PREDATOR_NUM;i++)predator[i]=new Predator(random(0,Predator.MAX_AGE),random(10,100),random(3,5),true,new PVector(random(width),random(height)),new PVector(rand(.4,.8),rand(.4,.8)));
  for(int i=0;i<PREY_NUM;i++)prey[i]=new Prey(random(0,Prey.MAX_AGE),random(10,100),random(2,4),true,new PVector(random(width),random(height)),new PVector(rand(.4,.8),rand(.4,.8)));
  for(int i=0;i<PLANT_NUM;i++)plant[i]= new Plant(random(Plant.MIN_AGE,Plant.MAX_AGE),true,new PVector(random(width),random(height)));
}
public void draw(){
  background(#000000);
  for(int i=0;i<PREDATOR_NUM;i++){
    if(predator[i].detectCollisionX()){predator[i].p.x=min(max(predator[i].p.x,predator[i].getSize()),width-predator[i].getSize());predator[i].v.x=-predator[i].v.x;}
    if(predator[i].detectCollisionY()){predator[i].p.y=min(max(predator[i].p.y,predator[i].getSize()),height-predator[i].getSize());predator[i].v.y=-predator[i].v.y;}
  }
  for(int i=0;i<PREY_NUM;i++){
    if(prey[i].detectCollisionX()){prey[i].p.x=min(max(prey[i].p.x,prey[i].getSize()),width-prey[i].getSize());prey[i].v.x=-prey[i].v.x;}
    if(prey[i].detectCollisionY()){prey[i].p.y=min(max(prey[i].p.y,prey[i].getSize()),height-prey[i].getSize());prey[i].v.y=-prey[i].v.y;}
  }
  for(int i=0;i<PREDATOR_NUM;i++)predator[i].update();
  for(int i=0;i<PREY_NUM;i++)prey[i].update();
  for(int i=0;i<PLANT_NUM;i++)plant[i].update();
  println(frameRate);
}

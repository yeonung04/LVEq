final double PREY_TO_PREDATOR_E=10,PLANT_TO_PREY_E=1;
final int PREDATOR_NUM=0,PREY_NUM=1000 ,PLANT_NUM=2000,MAX_PREDATOR_NUM=1000,MAX_PREY_NUM=10000,MAX_PLANT_NUM=2000;
Predator[] predator;Prey[] prey;Plant[] plant;
public int reproducetime=0;
double random(double a,double b){return Math.random()*(b-a)+a;}
double min(double a,double b){return a<b?a:b;}
double max(double a,double b){return a>b?a:b;}
int predatorAlive(){int sum=0;for(int i=0;i<MAX_PREDATOR_NUM;i++)if(predator[i].isAlive())sum++;return sum;}
int preyAlive(){int sum=0;for(int i=0;i<MAX_PREY_NUM;i++)if(prey[i].isAlive())sum++;return sum;}
int plantAlive(){int sum=0;for(int i=0;i<MAX_PLANT_NUM;i++)if(plant[i].isAlive())sum++;return sum;}
int predatorHungry(){int sum=0;for(int i=0;i<MAX_PREDATOR_NUM;i++)if(predator[i].isAlive()&&predator[i].hungry())sum++;return sum;}
int preyHungry(){int sum=0;for(int i=0;i<MAX_PREY_NUM;i++)if(prey[i].isAlive()&&prey[i].hungry())sum++;return sum;}
int predatorStarving(){int sum=0;for(int i=0;i<MAX_PREDATOR_NUM;i++)if(predator[i].getHunger()<=0&&predator[i].isAlive())sum++;return sum;}
int preyStarving(){int sum=0;for(int i=0;i<MAX_PREY_NUM;i++)if(prey[i].getHunger()<=0&&prey[i].isAlive())sum++;return sum;}
float preyyvec(){float sum=0;for(int i=0;i<MAX_PREY_NUM;i++)sum+=Math.abs(prey[i].v.y);return sum;}
void setup(){
  size(1000,1000,P2D);surface.setTitle("Lotka-Volterra Equations");surface.setResizable(false);frameRate(600);
  background(#000000);noStroke();fill(#FFFFFF);
  predator=new Predator[MAX_PREDATOR_NUM];prey=new Prey[MAX_PREY_NUM];plant=new Plant[MAX_PLANT_NUM];
  for(int i=0;i<PREDATOR_NUM;i++)predator[i]=new Predator(random(0,Predator.MAX_AGE),random(10,100),random(10,100),random(3,5),true,random(.4,.8),random(8,12),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=0;i<PREY_NUM;i++)prey[i]=new Prey(random(0,Prey.MAX_AGE),random(10,100),random(10,100),random(2,4),true,random(.4,.8),random(8,12),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=0;i<PLANT_NUM;i++)plant[i]=new Plant(random(Plant.MIN_AGE,Plant.MAX_AGE),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=PREDATOR_NUM;i<MAX_PREDATOR_NUM;i++)predator[i]=new Predator(random(0,Predator.MAX_AGE),random(10,100),random(10,100),random(3,5),false,random(.04,.08),random(.8,1.2),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=PREY_NUM;i<MAX_PREY_NUM;i++)prey[i]=new Prey(random(0,Prey.MAX_AGE),random(10,100),random(10,100),random(2,4),false,random(.04,.08),random(.8,1.2),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=PLANT_NUM;i<MAX_PLANT_NUM;i++)plant[i]=new Plant(random(0,Plant.MIN_AGE),new Vector(random(0,(double)width),random(0,(double)height))); //TODO
  for(int i=0;i<MAX_PREDATOR_NUM;i++)predator[i].link(predator,prey,plant);
  for(int i=0;i<MAX_PREY_NUM;i++)prey[i].link(predator,prey,plant);
  for(int i=0;i<MAX_PLANT_NUM;i++)plant[i].link(predator,prey,plant);
}
void draw(){
  background(#000000);
  for(int i=0;i<MAX_PREDATOR_NUM;i++){
    if(predator[i].detectCollisionX()){predator[i].p.x=min(max(predator[i].p.x,predator[i].getSize()),width-predator[i].getSize());predator[i].v.x=-predator[i].v.x;}
    if(predator[i].detectCollisionY()){predator[i].p.y=min(max(predator[i].p.y,predator[i].getSize()),height-predator[i].getSize());predator[i].v.y=-predator[i].v.y;}
    if(predator[i].hungry())for(int j=0;j<MAX_PREY_NUM;j++)if(prey[j].isAlive()&&predator[i].detectCollision(prey[j])){predator[i].feed(min((float)prey[j].getOrg()*(float)PREY_TO_PREDATOR_E,(float)100));prey[j].setAlive(false);}
    predator[i].hunting();
  }
  for(int i=0;i<MAX_PREY_NUM;i++){
    if(prey[i].detectCollisionX()){prey[i].p.x=min(max(prey[i].p.x,prey[i].getSize()),width-prey[i].getSize());prey[i].v.x=-prey[i].v.x;}
    if(prey[i].detectCollisionY()){prey[i].p.y=min(max(prey[i].p.y,prey[i].getSize()),height-prey[i].getSize());prey[i].v.y=-prey[i].v.y;}
    if(prey[i].hungry())for(int j=0;j<MAX_PLANT_NUM;j++)if(plant[j].isAlive()&&prey[i].detectCollision(plant[j])){prey[i].feed(plant[j].getAge()*PLANT_TO_PREY_E);plant[j].setAge(0);}
    prey[i].feeding();
  }
  for(int i=0;i<MAX_PREDATOR_NUM;i++)predator[i].update();
  for(int i=0;i<MAX_PREY_NUM;i++)prey[i].update();
  for(int i=0;i<MAX_PLANT_NUM;i++)plant[i].update();
  
}
void keyPressed(){
  println(Life.FRAMEDEPENDENCY?millis()+"ms":"Frame "+frameCount+" ("+frameRate+"fps)");
  println("Predator : "+predatorAlive() + "\tHungry : " + predatorHungry() + "\tStarving : " +predatorStarving());
  println("Prey : "+preyAlive() + "\tHungry : " + preyHungry() + "\tStarving : " +preyStarving()+"  " + preyyvec() );
  println("Plant : "+plantAlive()+"  "+reproducetime);
  println();
}

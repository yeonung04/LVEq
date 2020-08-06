 //<>//
final double PREY_TO_PREDATOR_E=10,PLANT_TO_PREY_E=10; //<>// //<>// //<>//
final int PREDATOR_NUM=100,PREY_NUM=1000,PLANT_NUM=2000,MAX_PREDATOR_NUM=1000,MAX_PREY_NUM=10000,MAX_PLANT_NUM=20000;
Predator[] predator;Prey[] prey;Plant[] plant;
double random(double a,double b){return Math.random()*(b-a)+a;}
double min(double a,double b){return a<b?a:b;}
double max(double a,double b){return a>b?a:b;}
int predatorAlive(){int sum=0;for(int i=0;i<PREDATOR_NUM;i++)if(predator[i].isAlive())sum++;return sum;}
int preyAlive(){int sum=0;for(int i=0;i<PREY_NUM;i++)if(prey[i].isAlive())sum++;return sum;}
int plantAlive(){int sum=0;for(int i=0;i<PLANT_NUM;i++)if(plant[i].isAlive())sum++;return sum;}
int predatorHungry(){int sum=0;for(int i=0;i<PREDATOR_NUM;i++)if(predator[i].isAlive()&&predator[i].hungry())sum++;return sum;}
int preyHungry(){int sum=0;for(int i=0;i<PREY_NUM;i++)if(prey[i].isAlive()&&prey[i].hungry())sum++;return sum;}
int predatorStarving(){int sum=0;for(int i=0;i<PREDATOR_NUM;i++)if(predator[i].isAlive()&&predator[i].getHunger()<=0)sum++;return sum;}
int preyStarving(){int sum=0;for(int i=0;i<PREY_NUM;i++)if(prey[i].isAlive()&&prey[i].getHunger()<=0)sum++;return sum;}
void setup(){
  size(1000,1000,P2D);surface.setTitle("Lotka-Volterra Equations");surface.setResizable(false);frameRate(600);
  background(#000000);noStroke();fill(#FFFFFF);
  predator=new Predator[MAX_PREDATOR_NUM];prey=new Prey[MAX_PREY_NUM];plant=new Plant[MAX_PLANT_NUM];
  for(int i=0;i<PREDATOR_NUM;i++)predator[i]=new Predator(random(0,Predator.MAX_AGE),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=0;i<PREY_NUM;i++)prey[i]=new Prey(random(0,Prey.MAX_AGE),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=0;i<PLANT_NUM;i++)plant[i]=new Plant(random(Plant.MIN_AGE,Plant.MAX_AGE),new Vector(random(0,(double)width),random(0,(double)height)));
  for(int i=PREDATOR_NUM;i<MAX_PREDATOR_NUM;i++)predator[i]=new Predator();
  for(int i=PREY_NUM;i<MAX_PREY_NUM;i++)prey[i]=new Prey();
  for(int i=PLANT_NUM;i<MAX_PLANT_NUM;i++)plant[i]=new Plant();
  for(int i=0;i<MAX_PREDATOR_NUM;i++)predator[i].link(predator,prey,plant);
  for(int i=0;i<MAX_PREY_NUM;i++)prey[i].link(predator,prey,plant);
  for(int i=0;i<MAX_PLANT_NUM;i++)plant[i].link(predator,prey,plant);
} //<>//
void draw(){ //<>//
  background(#000000); //<>//
  for(int i=0;i<PREDATOR_NUM;i++)if(predator[i].isAlive()){
    if(predator[i].detectCollisionX()){predator[i].p.x=min(max(predator[i].p.x,predator[i].getSize()),width-predator[i].getSize());predator[i].v.x=-predator[i].v.x;}
    if(predator[i].detectCollisionY()){predator[i].p.y=min(max(predator[i].p.y,predator[i].getSize()),height-predator[i].getSize());predator[i].v.y=-predator[i].v.y;}
    if(predator[i].hungry())for(int j=0;j<PREY_NUM;j++)if(prey[j].isAlive()&&predator[i].detectCollision(prey[j])){predator[i].feed(min((float)prey[j].getOrg()*(float)PREY_TO_PREDATOR_E,(float)100));prey[j].kill();}
    predator[i].chase();
  }
  for(int i=0;i<PREY_NUM;i++)if(prey[i].isAlive()){
    if(prey[i].detectCollisionX()){prey[i].p.x=min(max(prey[i].p.x,prey[i].getSize()),width-prey[i].getSize());prey[i].v.x=-prey[i].v.x;}
    if(prey[i].detectCollisionY()){prey[i].p.y=min(max(prey[i].p.y,prey[i].getSize()),height-prey[i].getSize());prey[i].v.y=-prey[i].v.y;}
    if(prey[i].hungry())for(int j=0;j<PLANT_NUM;j++)if(plant[j].isAlive()&&prey[i].detectCollision(plant[j])){prey[i].feed(plant[j].getAge()*PLANT_TO_PREY_E);plant[j].kill();}
    prey[i].chase();
  }
  for(int i=0;i<PREDATOR_NUM;i++)predator[i].update();
  for(int i=0;i<PREY_NUM;i++)prey[i].update();
  for(int i=0;i<PLANT_NUM;i++)plant[i].update();
}
void keyPressed(){
  println(Life.FRAMEDEPENDENCY?millis()+"ms":"Frame "+frameCount+" ("+frameRate+"fps)");
  println("Predator : "+predatorAlive() + "\tHungry : " + predatorHungry() + "\tStarving : " +predatorStarving());
  println("Prey : "+preyAlive() + "\tHungry : " + preyHungry() + "\tStarving : " +preyStarving());
  println("Plant : "+plantAlive());
  println(prey[0].getAge());
  println();
}

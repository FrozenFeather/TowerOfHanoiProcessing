ArrayList<Integer> poles[] = (ArrayList<Integer>[])new ArrayList[3];
final int level = 7;
int target = 0,origin = 1,idle = 2;

void setup() {
  colorMode(HSB, level);
  background(0, 0, level);
  size(600, 400);
  poles[0] = new ArrayList<Integer>();
  poles[1] = new ArrayList<Integer>();
  poles[2] = new ArrayList<Integer>();
  for (int i=0; i<level; i++) {
    poles[origin].add(i+1);
  }
  show();
}
void draw() {
}
void keyPressed() {
  if(keyCode==ENTER){
    nextMove(level, origin, target, idle);
    show();
  }else if(keyCode==LEFT){
    origin = target;
    idle = target+1>=3 ? 0 : target+1;
    target = target-1<0 ? 2 : target-1;
    show();
  }else if(keyCode==RIGHT){
    origin = target;
    idle = target-1<0 ? 2 : target-1;
    target = target+1>=3 ? 0 : target+1;
    show();
  }
}
void nextMove(int dish, int from, int to, int temp) {
  if (dish<1 || dish==1 && poles[to].contains(1)) {
    println("Already finished");
    return;
  }
  if (poles[temp].contains(dish)) {  //The disk on "temp" just move it on "to"
    nextMove(dish, temp, to, from);  //shift the order
    return;
  }
  if (poles[from].contains(dish)) {  //The disk need to move hasn't moved yet
    if (poles[from].get(0)==dish) {  //The top disks are cleared
      if (poles[to].size()==0 || poles[to].get(0)>dish) {
        actMove(dish, from, to);
      } else {
        for (int i=poles[to].size()-1; i>=0; i--) {
          if (poles[to].get(i)>dish) continue;
          nextMove(poles[to].get(i), to, temp, from);  //clear away the "to" rod
          break;
        }
      }
      return;
    }
    //else clear the top
    if (poles[temp].contains(dish-1)) { //smaller dish are already on "temp"
      nextMove(dish-2, to, temp, from);        //move the smaller dish to "temp"
    }else {  //else move to "temp"
      nextMove(dish-1, to, temp, from);
    }
  } else {  //This disk already move, handle the disk above
    if (poles[to].contains(dish-1)) {//if smaller dish already on "to"
      nextMove(dish-2, from, to, temp);
    } else {  //move the smaller dish to "to"
      nextMove(dish-1, from, to, temp);
    }
  }
}
void actMove(int dish, int from, int to) {
  assert(poles[from].get(0)==dish);
  assert(poles[to].size()==0 || poles[to].get(0)>dish);
  poles[from].remove(0);
  poles[to].add(0, dish);
  println("Move Dish"+dish+" from pole"+from+" to pole"+to);
}
void show() {
  background(0, 0, level);
  fill(0, 0, level);
  for(int i=0; i<3; i++){
    if(target==i) fill(level*0.3, level, level);
    if(origin==i||idle==i) fill(0, 0, level*0.6);
    rect(i*200+95, 120, 10, 280);
    for (int j=0; j<poles[i].size(); j++) {
      int dish = poles[i].get(j);
      fill(dish, level, level);
      rect(i*200+100-dish*90.0/level, height-(poles[i].size()-j)*20, dish*180.0/level, 20);
    }
  }
}

ArrayList<Integer> poles[] = (ArrayList<Integer>[])new ArrayList[3];
//ArrayList<String> step = new ArrayList<String>();
final int level = 5;

void setup() {
  colorMode(HSB, level);
  background(0, 0, level);
  size(600, 400);
  poles[0] = new ArrayList<Integer>();
  poles[1] = new ArrayList<Integer>();
  poles[2] = new ArrayList<Integer>();
  for (int i=0; i<level; i++) {
    poles[1].add(i+1);
  }
  show();
}
void draw() {
}
void keyPressed() {
  nextMove(level, 1, 0, 2);
  show();
}
void nextMove(int dish, int from, int to, int temp) {
  if (dish==1 && poles[to].contains(1)) {
    println("Already finished");
    return;
  }
  if (poles[temp].contains(dish)) {  //The disk on "temp" just move it on "to"
    nextMove(dish, temp, to, from);  //shift the order
    return;
  }
  if (poles[from].contains(dish)) {  //The disk need to move
    if (poles[from].get(0)==dish) {
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
    if (poles[from].contains(dish-1)) {
      nextMove(dish-1, from, temp, to);
    } else if (poles[temp].contains(dish-1)) {
      nextMove(dish-2, to, temp, from);
    } else {  //on "to"
      nextMove(dish-1, to, temp, from);
    }
  } else {  //This disk already move, handle the disk above
    if (poles[from].contains(dish-1)) {
      nextMove(dish-1, from, to, temp);
    } else if (poles[temp].contains(dish-1)) {
      nextMove(dish-1, temp, to, from);
    } else {  //on "to"
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
  rect(95, 120, 10, 280);
  rect(295, 120, 10, 280);
  rect(495, 120, 10, 280);
  for (int i=0; i<3; i++) {
    for (int j=0; j<poles[i].size(); j++) {
      int dish = poles[i].get(j);
      fill(dish, level, level);
      rect(i*200+100-dish*90.0/level, height-(poles[i].size()-j)*20, dish*180.0/level, 20);
    }
  }
}
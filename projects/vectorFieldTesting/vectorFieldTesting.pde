// Config //
int line_interval = 10;
int total_balls = 2000;
float default_magnitude = 10;
float arrow_head_size = 4;
int Divider = 2;
int totalWidth = 1100;

// Variables //
vectorLine[][] vectorField;
vectorBall[] vectorBall;

// Procedures //
void arrow(float x1, float y1, float x2, float y2) {
  line(x1, y1, x2, y2);
  pushMatrix();
  translate(x2, y2);
  float a = atan2(x1-x2, y2-y1);
  rotate(a);
  line(0, 0, -arrow_head_size, -arrow_head_size);
  line(0, 0, arrow_head_size, -arrow_head_size);
  popMatrix();
}

// Functions //
PVector GetLineDir(float x, float y) {
  
  PVector dir = new PVector(0, 0);
  
  /*
    x = width/2.25 - x;
    y = height/2.25 - y;
    float expX = (x/y) / (y/x);
    float expY = (y/x) / (x/y);
    dir = new PVector(expY, expX);
  */
  
  //*
  dir = new PVector(-(y - height/2.5), x - width/2.5);
  //*/
  
  /*  
    dir = new PVector(y - height/2.5, x - width/2.5);
  */
  
  /*
  dir = new PVector(height-y/2, x-width/2);
  */
  return dir.normalize();
}

// Classes //
class vectorLine {

  PVector pos;
  PVector dir;
  float line_mag = default_magnitude;

  vectorLine(PVector new_pos, PVector new_dir) {
    pos = new_pos;
    dir = new_dir;
  }

  vectorLine(PVector new_pos, PVector new_dir, float new_mag) {
    pos = new_pos;
    dir = new_dir;
    line_mag = new_mag;
  }

  void show() {
    arrow(pos.x, pos.y, pos.x + (dir.x * line_mag), pos.y + (dir.y * line_mag));
    //line(pos.x, pos.y, pos.x + (dir.x * line_mag), pos.y + (dir.y * line_mag));
  }
}

class vectorBall {

  PVector position = new PVector(0,0);
  boolean active = true;
  float speed = 5;
  
  vectorBall(PVector pos) {
    position = pos;
  }
  
  void show() {
    circle(position.x, position.y, 5);
  }
  
  void update() {
    if (active) {
      position.add(GetLineDir(position.x, position.y).mult(speed));
      //if (position.x > width || position.y > height || position.x < 0 || position.y < 0) {
      //  active = false;
      //}
    }
  }
  
}

// Setup //
void setup() {
  
  background(0,0,0);
  
  int horizontal_count = floor(totalWidth/Divider);
  int vertical_count = floor(totalWidth/Divider);
  size(1000, 1000);
  
  // Create Vector Field Lines //
  vectorField = new vectorLine[horizontal_count][vertical_count];
  for (int x = 0; x < horizontal_count; x++) {
    for (int y = 0; y < vertical_count; y++) {
      PVector pos = new PVector(x * Divider, y * Divider);
      PVector dir = GetLineDir(x * Divider, y * Divider);
      vectorLine new_line = new vectorLine(pos, dir);
      vectorField[x][y] = new_line;
    }
  }
  
  // Create Vector Field Balls //
  vectorBall = new vectorBall[total_balls];
  for (int i = 0; i < vectorBall.length - 1; i++) {
    vectorBall[i] = new vectorBall(new PVector(random(20, totalWidth - 20), random(20, totalWidth - 20)));
  }
}

void draw() {
  
  stroke(100, 20);
  noFill();
  for (int x = 0; x < vectorField.length - 1; x++) {
    for (int y = 0; y < vectorField[x].length - 1; y++) {
      if (x%line_interval == 0 && y%line_interval == 0) {
        vectorField[x][y].show();
      }
    }
  }
  stroke(255);
  fill(255);
  
  for (int i = 0; i < vectorBall.length - 1; i++) {
    vectorBall[i].update();
    vectorBall[i].show();
  }
  
  stroke(0,0,0,10);
  fill(0,10);
  rect(0,0,width,height);
  
}

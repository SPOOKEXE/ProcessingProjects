
Grid newGrid;
Pathfinder newPather;
ArrayList<Vector2> path;

void setup() {
  size(800, 800);
  background(0);
  noFill();
  frameRate(60);
  
  newGrid = new Grid();
  newPather = new Pathfinder(newGrid);
  path = newPather.calculatePath();
  
  println( path != null ? "Path Found" : "Failed to find path!" );
}

void draw() {
  background(0);
  noFill();
  frameRate(1);
  newGrid.show();
  if (path != null) {
    stroke(255, 255, 0);
    for (Vector2 point : path) {
      newGrid.showSquare(point.x, point.y);
    }
  }
}

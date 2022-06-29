

class Grid {
  
  // Publics
  public int posX = 100;
  public int posY = 100;
  public int sizeX = 500;
  public int sizeY = 500;
  public int pixelDivider = 25;
  
  public Vector2 start;
  public Vector2 goal;
  
  // Privates
  private float[][] grid;
  private boolean[][] blocked;
  private int cols;
  private int rows;
  
  // Constructors
  public Grid() { this.construct(); }
  public Grid(int sizeX, int sizeY) { this.sizeX = sizeX; this.sizeY = sizeY; this.construct(); }
  public Grid(int pixelDivider) { this.pixelDivider = pixelDivider; this.construct(); }
  
  // Functions
  public Vector2 getRandomPosition() {
    return new Vector2( (int) random(cols), (int) random(rows) );
  }
   
  public float heuristic( Vector2 point ) {
    float f_dx = abs(point.x - this.goal.x);
    float f_dy = abs(point.y - this.goal.y);
    float s_dx = abs(this.start.x - point.x);
    float s_dy = abs(this.start.y - point.y);
    return floor(f_dx + f_dy + s_dx + s_dy);
  }
  
  public float getCost(Vector2 point, float currCost) {
    return currCost + point.copy().sub(this.start).mag() + point.copy().sub(this.goal).mag();
  }
  
  public ArrayList<Vector2> getNeighbors(Vector2 point) {
    ArrayList<Vector2> neighbors = new ArrayList<Vector2>();
    boolean reverse = (point.x + point.y) % 2 == 0;
    if (point.x - 1 >= 0 && !this.blocked[point.x - 1][point.y]) {
      neighbors.add( reverse ? 0 : neighbors.size(), new Vector2(point.x - 1, point.y) );
    }
    if (point.y - 1 >= 0 && !this.blocked[point.x][point.y - 1]) {
      neighbors.add( reverse ? 0 : neighbors.size(), new Vector2(point.x, point.y - 1) );
    }
    if (point.x + 1 < cols && !this.blocked[point.x + 1][point.y]) {
      neighbors.add( reverse ? 0 : neighbors.size(), new Vector2(point.x + 1, point.y) );
    }
    if (point.y + 1 < rows && !this.blocked[point.x][point.y + 1]) {
      neighbors.add( reverse ? 0 : neighbors.size(), new Vector2(point.x, point.y + 1) );
    }
    return neighbors;
  }
  
  // Methods
  public void getRandomStartFinish() {
    this.start = new Vector2( (int) random(this.cols), (int) random(this.rows) );
    while ( (this.cols > 0) && (this.rows > 0) && this.blocked[start.x][start.y] == true ) {
      this.start = new Vector2( (int) random(this.cols), (int) random(this.rows) );
    }
    this.goal = new Vector2( (int) random(this.cols), (int) random(this.rows) );
    while ( (this.cols > 0) && (this.rows > 0) && (this.goal.copy().sub(this.start).mag() == 0) ) {
      this.goal = new Vector2( (int) random(this.cols), (int) random(this.rows) );
    }
    println("[", this.start.toString(), "] [", this.goal.toString(), "]");
  }
  
  private void construct() {
    this.cols = floor(this.sizeX / this.pixelDivider);
    this.rows = floor(this.sizeY / this.pixelDivider);
    this.blocked = new boolean[ this.cols ][ this.rows ];
    for(int x = 0; x < cols; x++) {
      for(int y = 0; y < rows; y++) {
        this.blocked[x][y] = round(random(1, 5)) == 3;
      }
    }
    this.grid = new float[ this.cols ][ this.rows ];
    this.getRandomStartFinish();
    for(int x = 0; x < cols; x++) {
      for(int y = 0; y < rows; y++) {
        this.grid[x][y] = this.heuristic( new Vector2(x, y) );
      }
    }
  }
  
  public void showSquare(int x, int y) {
    rect(this.posX + (x * this.pixelDivider), this.posY + (y * this.pixelDivider) - this.pixelDivider, this.pixelDivider, this.pixelDivider);
  }
  
  public void show() {
    
    // Show text, white cells, start and finish
    textSize(15);
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        float score = this.grid[x][y];
        
        // Text
        text(floor(score * 10) / 10, this.posX + (x * this.pixelDivider), this.posY + (y * this.pixelDivider) );
        
        // Square
        strokeWeight(2);
        stroke(255, 255, 255);
        this.showSquare(x, y);
      }
    }
    
    // Red squares on top
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        if (this.blocked[x][y] == true) {
          strokeWeight(3);
          stroke(255,0,0);
          this.showSquare(x, y);
        }
      }
    }
    
    // Goal / Start squares on top
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        if (x == this.start.x && y == this.start.y) {
          strokeWeight(2);
          stroke(0,255,0);
        } else if (x == this.goal.x && y == this.goal.y) {
          strokeWeight(2);
          stroke(0,0,255);
        } else {
          continue;
        }
        this.showSquare(x, y);
      }
    }
    
    
  }
  
}

class Vector2 {
  public int x = 0;
  public int y = 0;
  
  public Vector2() { };
  public Vector2(int x, int y) { this.x = x; this.y = y; }
  
  public Vector2 sub(Vector2 other) {
    this.x -= other.x;
    this.y -= other.y;
    return this;
  }
  
  public Vector2 add(Vector2 other) {
    this.x += other.x;
    this.y += other.y;
    return this;
  }
  
  public Vector2 mult(int mult) {
    this.x *= mult;
    this.y *= mult;
    return this;
  }
  
  public Vector2 copy() {
    return new Vector2(this.x, this.y);
  }
  
  public float mag() {
    if (this.x == 0 && this.y == 0) {
      return 0;
    }
    return sqrt(pow(this.x, 2) + pow(this.y, 2));
  }
  
  public boolean equals( Vector2 other ) {
    return (this.x == other.x) && (this.y == other.y); 
  }
  
  public String toString() {
    return "(" + this.x + ", " + this.y + ")";
  }
  
}

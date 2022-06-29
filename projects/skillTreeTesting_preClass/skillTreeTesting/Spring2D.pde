
class Spring2D {
  Spring xAxis, yAxis;
  
  public Spring2D() {
    this.xAxis = new Spring();
    this.yAxis = new Spring();
  }
  
  public Spring2D(int x, int y) {
    this.xAxis = new Spring();
    this.yAxis = new Spring();
    this.xAxis.set(x);
    this.yAxis.set(y);
  }
  
  void update(float deltaTime) {
    this.xAxis.update(deltaTime);
    this.yAxis.update(deltaTime);
  };
  
  void push(float vel) {
    this.xAxis.push(vel);
    this.yAxis.push(vel);
  };
  
  void target(float targ) {
    this.xAxis.target(targ);
    this.yAxis.target(targ);
  };
  
  void set(int x, int y) {
    this.xAxis.set(x);
    this.yAxis.set(y);
  }
  
}

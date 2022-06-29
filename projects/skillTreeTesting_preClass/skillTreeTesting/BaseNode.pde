
class BaseNode {

  int x, y = 0;
  int layerZ = 99; // this is what column they are in
  int radius = 35;
  
  public BaseNode() {
    
  }
  
  public void setPosition(int nX, int nY) {
    this.x = nX;
    this.y = nY;
  }
  
  public void setLayer(int nLayer) {
    this.layerZ = nLayer;
  }
   
  public void show() {
    circle(this.x, this.y, this.radius);
  }
   
}

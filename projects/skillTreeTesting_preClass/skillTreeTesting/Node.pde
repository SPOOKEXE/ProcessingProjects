
class Node extends BaseNode {
  
  Spring2D spring;
  String ID;
  String[] depends;
  int orderNumber = 0; // set automatically to make room for lines
  
  public Node() {
    this.ID = str( random(1000000) );
    depends = new String[0];
    // spring = new Spring2D();
  }
  
  public Node(String nID) {
    this.ID = nID;
    depends = new String[0];
    // spring = new Spring2D();
  }
  
  public void setPosition(int nX, int nY) {
    super.setPosition(nX, nY);
    // this.spring.set(nX, nY);
  }
  
  public void setLayer(int nLayer) {
    super.setLayer(nLayer);
  }
  
  public void loadDepends( JSONArray dependsArray ) {
    depends = dependsArray.getStringArray();
  }

  public void show() {
    super.show();
  }
}

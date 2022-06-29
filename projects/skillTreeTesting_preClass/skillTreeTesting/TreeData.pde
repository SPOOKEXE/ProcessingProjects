

class TreeData {
  
  Node[] nodes;
  HashMap<String, Node> IDToNode;
  HashMap<Integer, ArrayList<BaseNode>> LayerZToNodeHashMap;
  
  public TreeData() {
    nodes = new Node[0];
    IDToNode = new HashMap<String, Node>();
    LayerZToNodeHashMap = new HashMap<Integer, ArrayList<BaseNode>>();
  }
  
  public void loadJSONFile( JSONArray jsonData ) {
    
  }
  
  
}

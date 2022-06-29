

class TreeData {
  
  boolean activelyShowing = false;
  Node[] nodes;
  HashMap<String, Node> IDToNode;
  HashMap<Integer, ArrayList<BaseNode>> LayerZToNodeHashMap;
  
  int widthSeparation = 100;
  
  public TreeData() {
    nodes = new Node[0];
    IDToNode = new HashMap<String, Node>();
    LayerZToNodeHashMap = new HashMap<Integer, ArrayList<BaseNode>>();
  }
  
  public void loadJSONFile( JSONArray nodeJSONArray ) {
    // Create nodes
    IDToNode = new HashMap<String, Node>();
    LayerZToNodeHashMap = new HashMap<Integer, ArrayList<BaseNode>>();
    nodes = new Node[nodeJSONArray.size()];
    for (int i = 0; i < nodeJSONArray.size(); i++) {
      JSONObject nodeData = nodeJSONArray.getJSONObject(i);
      if (nodeData == null) {
         println("[WARN] Node Data is null at index " + i);
         continue;
      }
      
      String nodeID = nodeData.getString("ID");
      if (nodeID == null) {
        println("[WARN] Node Data has no ID at index " + i);
        continue; 
      }
      
      Integer layerNumber = nodeData.getInt("Layer");
      ArrayList<BaseNode> nodeArrayList = LayerZToNodeHashMap.get(layerNumber);
      if (nodeArrayList == null) {
        nodeArrayList = new ArrayList<BaseNode>();
        LayerZToNodeHashMap.put(layerNumber, nodeArrayList);
      }
      
      if (IDToNode.get(nodeID) != null) {
        println("[WARN] Node of ID exists already at index " + i);
        continue; 
      }
      
      Node newNode = new Node(nodeID);
      newNode.setLayer(layerNumber);
      newNode.loadDepends( nodeData.getJSONArray("Depends") );
      nodes[i] = newNode;
      IDToNode.put(nodeID, newNode);
      nodeArrayList.add(newNode);
    }
  
    // Check duplicate depends (recursively)
    for (Map.Entry me : LayerZToNodeHashMap.entrySet()) {
      Integer layerNumber = (int) me.getKey();
      ArrayList<BaseNode> layerNodes = (ArrayList<BaseNode>) me.getValue();
      
      int layerCount = layerNodes.size();
      float deltaCount = (1.0f / layerCount);
      float deltaStep = (height * 0.5) * deltaCount;
      
      float topHeight = ((height * 0.5) - ( (layerCount / 2) * deltaStep ));
      for (int nodeIndex = 0; nodeIndex < layerNodes.size(); nodeIndex++) {
        BaseNode node = layerNodes.get(nodeIndex);
        int nodeY = (int) (topHeight + (deltaStep * nodeIndex));
        node.setPosition( layerNumber * widthSeparation, nodeY );
      }
  
    }
  }
  
  public void draw() {
    // Show connection lines
    stroke(255);
    fill(255);
    for (int i = 0; i < nodes.length; i++) {
      
      Node baseNode = nodes[i];
      for (String dependID : baseNode.depends) {
        
        Node dependedNode = IDToNode.get(dependID);
        
        // If node is null, then the depended node is not within this tree.
        if (dependedNode == null) {
          printOnce("[WARN] Depended ID has no node in the tree! " + baseNode.ID + " depending on " + dependID);
          continue;
        }
        
        // Create line to link the dependant ones
        noFill();
        bezierLine( baseNode.x, baseNode.y, dependedNode.x, dependedNode.y, widthSeparation);
        fill(255);
      }
      
    }
    
    // Show nodes
    for (int i = 0; i < nodes.length; i++) {
      nodes[i].show();
    }
  }
  
  
}

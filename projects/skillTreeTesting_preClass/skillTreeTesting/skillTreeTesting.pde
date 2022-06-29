import java.util.Map;

Node[] nodes;
final int widthSeparation = 100;
HashMap<String, Node> IDToNode;
HashMap<Integer, ArrayList<BaseNode>> LayerZToNodeHashMap;

void bezierLine( int sX, int sY, int fX, int fY, float widthSep ) {
  if (sY == fY) {
    line(sX, sY, fX, fY);
  } else {
    int intWidthSep = (int) (widthSep * 0.75);
    bezier(sX, sY, sX - intWidthSep, sY, fX + intWidthSep, fY, fX, fY);
  }
}

void setup() {
  // Setup Frame
  size(800, 800);
  
  // Load nodes json
  JSONArray nodeJSONArray = loadJSONArray("nodes.json");
  println(nodeJSONArray);
  
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

void draw() {
  // Clear Background
  background(0);
  
  // Show connection lines
  stroke(255);
  fill(255);
  for (int i = 0; i < nodes.length; i++) {
    
    Node baseNode = nodes[i];
    for (String dependID : baseNode.depends) {
      
      Node dependedNode = IDToNode.get(dependID);
      
      // If node is null, then the depended node is not within this tree.
      if (dependedNode == null) {
        println("[WARN] Depended ID has no node in the tree! " + dependID);
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

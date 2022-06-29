import java.util.Map;

// Variables
int activeIndex = 0;
TreeData[] activeTrees;
String[] jsonNames = new String[] { "nodes.json", "nodes2.json" };

// Print a message once
HashMap<String, Boolean> warnedMessages = new HashMap<String, Boolean>();
void printOnce( String message ) {
  if (warnedMessages.get(message) == null) {
    warnedMessages.put(message, true);
    print(message);
  }
}

// Nice lines for inbetween nodes
void bezierLine( int sX, int sY, int fX, int fY, float widthSep ) {
  if (sY == fY) {
    line(sX, sY, fX, fY);
  } else {
    int intWidthSep = (int) (widthSep * 0.75);
    bezier(sX, sY, sX - intWidthSep, sY, fX + intWidthSep, fY, fX, fY);
  }
}

// Update active
void updateActive() {
  // Update trees
  for (int index = 0; index < activeTrees.length; index++) {
    activeTrees[index].activelyShowing = (index == activeIndex);
  }
}

// Setup
void setup() {
  // Setup Frame
  size(800, 800);
  activeTrees = new TreeData[jsonNames.length];
  for (int index = 0; index < jsonNames.length; index++) {
    JSONArray nodeJSONArray = loadJSONArray(jsonNames[index]);
    //println(nodeJSONArray);
    TreeData newTree = new TreeData();
    newTree.loadJSONFile(nodeJSONArray);
    activeTrees[index] = newTree;
  }
  updateActive();
}

// Draw
void draw() {
  // Clear Background
  background(0);
  for (TreeData activeTreeData : activeTrees) {
    if (activeTreeData.activelyShowing == true) {
      activeTreeData.draw();
    }
  }
}

void keyPressed() {
  // key pressed
  if (key == 'q') {
    activeIndex += 1;
    if (activeIndex > activeTrees.length - 1) {
      activeIndex = 0;
    }
  } else if (key == 'e') {
    activeIndex -= 1;
    if (activeIndex < 0) {
      activeIndex = activeTrees.length - 1;
    }
  }
  
  updateActive();
}



class Pathfinder {
  
  Grid parentGrid;
  ArrayList<Vector2> frontier;
  HashMap<String,Vector2> cameFrom;
  HashMap<String,Float> costTable;
  
  // Private Methods //
  private void resetLists() {
    frontier = new ArrayList<Vector2>();
    cameFrom = new HashMap<String,Vector2>();
    costTable = new HashMap<String,Float>();
  }
  
  private void setParentGrid( Grid parentGrid ) {
    this.parentGrid = parentGrid;
    this.resetLists();
    this.frontier.add( parentGrid.start );
  }
  
  // Constructors //
  public Pathfinder( Grid parentGrid ) {
    this.setParentGrid( parentGrid );
  }
  
  public Pathfinder( Grid parentGrid, ArrayList<Vector2> frontier, HashMap<String,Vector2> cameFrom, HashMap<String,Float> costTable ) {
    this.setParentGrid( parentGrid );
    this.frontier = frontier;
    this.cameFrom = cameFrom;
    this.costTable = costTable;
  }
  
  // Public Methods //
  public void sortFrontier() {
    
    // Selection sort
    
    // For each value
    for (int index = 0; index < this.frontier.size(); index++) {
      // If any values past this point
      for (int j = index; j < this.frontier.size(); j++) {
        Vector2 thisPos = this.frontier.get(index);
        Vector2 otherPos = this.frontier.get(j);
        float thisCost = this.parentGrid.grid[thisPos.x][thisPos.y];
        float otherCost = this.parentGrid.grid[otherPos.x][otherPos.y];
        // Is smaller then the current value
        if (otherCost < thisCost) {
          // Swap it
          this.frontier.set(index, otherPos);
          this.frontier.set(j, thisPos);
        }
      }
    } 
    
  }
  
  public ArrayList<Vector2> calculatePath() {
    
    Vector2 activePoint = null;
    
    while (frontier.size() > 0) {
      activePoint = frontier.get(0);
      frontier.remove(0);
      
      if (activePoint.equals(this.parentGrid.goal)) { 
        break;
      }
      
      for (Vector2 point : this.parentGrid.getNeighbors(activePoint)) {
        float activeCost = 1.0f;
        if (this.costTable.get(point.toString()) != null) {
          activeCost = this.costTable.get(point.toString()); 
        }
        float cost = this.parentGrid.getCost(point, activeCost);
        if (this.cameFrom.get(point.toString()) != null) {
          if (cost < activeCost) {
            this.costTable.put(point.toString(), cost);
            this.cameFrom.put(point.toString(), activePoint);
            this.frontier.add(0, point);
          }
        } else {
          this.costTable.put(point.toString(), cost);
          this.cameFrom.put(point.toString(), activePoint);
          this.frontier.add(this.frontier.size(), point);
        }
      }
      
      this.sortFrontier();
    }
    
    if (activePoint != null && activePoint.equals(this.parentGrid.goal)) {
      ArrayList<Vector2> path = new ArrayList<Vector2>();
      while (activePoint != null && !activePoint.equals(this.parentGrid.start)) {
        path.add(activePoint);
        activePoint = this.cameFrom.get(activePoint.toString());
      }
      return path;
    }
    
    return null;
    
  }
  
  public void show() {
    
  }
  
}

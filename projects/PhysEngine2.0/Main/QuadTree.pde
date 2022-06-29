
class QuadTree {
  
  QuadTree northeast, northwest, southeast, southwest;
  Rectangle boundary;
  
  ArrayList <Particle> particles = new ArrayList<Particle>();
  
  int capacity = 4;
  boolean divide = false;
  

  QuadTree(Rectangle rect) {
    boundary = rect;

  }
  
  QuadTree(Rectangle rect, int cap) {
    boundary = rect;
    capacity = cap;
  }
  
  void SubDivide (){
      float x = boundary.x;
      float y = boundary.y;
      float w = boundary.w;
      float h = boundary.h;
      northeast = new QuadTree(new Rectangle (x+w/2 , y-h/2 , w/2 , h/2), capacity);
      northwest = new QuadTree(new Rectangle (x-w/2 , y-h/2 , w/2 , h/2),capacity);
      southeast = new QuadTree(new Rectangle (x+w/2 , y+h/2 , w/2 , h/2),capacity);
      southwest = new QuadTree(new Rectangle (x-w/2 , y+h/2 , w/2 , h/2),capacity);
      divide = true;
  }
  
  boolean insert(Particle p) {
    if (!boundary.contains(p)) {
        return false;
    }
    if (particles.size() < capacity ){
      particles.add(p); 
      return true;
    } else {
      if (!divide) {
        SubDivide();
      }
      if (northeast.insert(p)){
       return true; 
      } else if (northwest.insert(p)){
        return true;
      } else if (southeast.insert(p)){
        return true;
      } else if (southwest.insert(p)){
        return true;
      } else {
      return false;
      }
    }
  }
  
  void query(Rectangle range, ArrayList <Particle> points) {
    if (range.intersects(boundary)) {
      for (int i = 0 ; i < particles.size(); i++) {
        if (range.contains(particles.get(i))) {
          points.add(particles.get(i));
        }
      }
      if (divide) {
         northeast.query(range, points); 
         northwest.query(range, points); 
         southeast.query(range, points); 
         southwest.query(range, points); 
      }
    }
  }
  
  void show() {
   boundary.show();
   if (divide) {
     northeast.show(); 
     northwest.show(); 
     southeast.show(); 
     southwest.show(); 
   }
  }
  
}

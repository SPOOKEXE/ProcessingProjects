
class Rectangle {
  
  float x = 0;
  float y = 0;
  float w = 50; // Width *radius*
  float h = 50; // Height *radius*
  
  Rectangle() {}
  
  Rectangle(float n_x, float n_y, float n_w, float n_h) {
    x = n_x;
    y = n_y;
    w = n_w;
    h = n_h;
  }
  
  boolean intersects(Rectangle range) {
    return !(
      range.x - range.w > x + w ||
      range.x + range.w < x - w ||
      range.y - range.h > y + h ||
      range.y + range.h < y - h
    );
  }
  
  boolean contains (Particle p) {
     return (
         p.pos.x <= x + w &&
         p.pos.x >= x - w &&
         p.pos.y <= y + h &&
         p.pos.y >= y - h
     );
  }
  
  void show() {
    rect(x-w, y-h, w+w, h+h);
  }
  
}

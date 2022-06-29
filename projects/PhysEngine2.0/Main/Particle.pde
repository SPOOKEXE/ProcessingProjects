import java.util.ArrayList;
import java.util.UUID;

class Particle {
  
  String id = UUID.randomUUID().toString();
  
  // Physics
  PVector pos = new PVector();
  PVector vel = new PVector();
  float charge = 0;
  float radius = PARTICLE_defaultRadius;
  float speed = 0;
  
  // Visual Properties //
  String type = "Neutron";
  float col_r = 0;
  float col_g = 0;
  float col_b = 0;
  
  Particle collidingWith;
  
  Particle() {}
  
  Particle(PVector startPos, PVector startDir, float startSpeed) {
    this.pos = startPos;
    this.vel = startDir.normalize();
    this.speed = startSpeed;
  }
  
  void show() {
    fill(this.col_r, this.col_g, this.col_b);
    circle(this.pos.x, this.pos.y, this.radius);
  }
  
  void random_charge() {
     if (random(-1, 1) < 0) {
        this.charge = -1;
        this.col_b = 255;
        this.radius = PARTICLE_defaultRadius * 0.75;
        this.type = "Electron";
     } else {
        this.charge = 1;
        this.col_r = 255;
        this.type = "Proton";
     } 
  }
  
  boolean collides(Particle particle) {
    return pos.copy().sub(particle.pos).mag() <= (radius * 2);
  }
  
  PVector GetAttractionForce(Particle attractant) {
    float closest_distance = this.pos.copy().sub(attractant.pos).mag();
    float attract_strength = (PARTICLE_attraction_constant) / pow(closest_distance, 2);
    PVector attract_direction = this.pos.copy().sub(attractant.pos).normalize();
    float c = -1;
    if (this.charge == attractant.charge) {
      c = 1;
    }
    PVector attract_force = attract_direction.copy().mult(attract_strength * (radius * attractant.radius) * 0.01 * c * PARTICLE_attraction_direction); 
    return attract_force; // Return attraction force (PVector)
  }
  
}

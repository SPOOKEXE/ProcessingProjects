import java.util.ArrayList;

ArrayList<Particle> particles;
QuadTree particle_grid;

boolean checkCircularCollision(Particle particleA, Particle particleB) {
  float combinedRadi = (particleA.radius / 2 + particleB.radius / 2);
  PVector delta_pos = particleA.pos.copy().sub(particleB.pos);
  float dist_apart = delta_pos.mag();
  boolean IsColliding = (dist_apart <= combinedRadi);
  if (!IsColliding) {
    particleA.collidingWith = null;
    particleB.collidingWith = null;
    return false;
  }
  
  PVector directionAToB = particleB.pos.copy().sub(particleA.pos).normalize(); 
  float displace_distance = (combinedRadi - dist_apart) / 2;
  directionAToB.mult(displace_distance);
  particleA.pos.sub(directionAToB);
  particleB.pos.add(directionAToB);
  
  // Velocity Transfer
  //particleA.vel.mult(-1);
  //particleB.vel.mult(-1);
  
  particleB.vel.add(particleA.vel.copy().mult(0.8));
  particleA.vel.mult(0.2);
  
  particleA.collidingWith = particleB;
  particleB.collidingWith = particleA;
  return true;
}

void setup() {
  background(0);
  size(1200, 1200);
  frameRate(300);
  particles = new ArrayList<Particle>();
  for (int i = 0; i < PARTICLE_count; i++) {
    Particle newParticle = new Particle();
    newParticle.random_charge();
    newParticle.pos = getRandomPosition();
    if (randomVelocities) {
      newParticle.vel = new PVector(random(-5, 5)/100, random(-5, 5)/100);
    }
    particles.add(newParticle);
  }
}

void draw() {
  
  background(0);
  noFill();
  
  particle_grid = new QuadTree( new Rectangle(width/2, height/2, width/2 - 6, height/2 - 6) );
  for (int i = 0; i < particles.size(); i++) {
    particle_grid.insert(particles.get(i));
  }
  
  // Quad Grid
  stroke(255, 255, 255);
  particle_grid.show();
  
  // Calculations
  for (int i = 0; i < particles.size(); i++) {
    
    Particle myParticle = particles.get(i);
    
    ArrayList<Particle> collided = new ArrayList<Particle>();
    ArrayList<Particle> neighbours = new ArrayList<Particle>();
    
    Rectangle searchRegion = new Rectangle(myParticle.pos.x, myParticle.pos.y, QUAD_RegionWidth, QUAD_RegionWidth);
    particle_grid.query(searchRegion, neighbours);
    
    if (i < 3) {
      stroke(myParticle.col_r, myParticle.col_g, myParticle.col_b);
      searchRegion.show();
      stroke(255, 255, 0);
      for (Particle particle : neighbours) {
        rect(particle.pos.x - 5, particle.pos.y - 5, 10, 10);
      }
    }
    
    PVector netForce = new PVector(0, 0);

    for (int j = 0; j < neighbours.size(); j++) {
      Particle neighbourParticle = neighbours.get(j);
      if (neighbourParticle.id != myParticle.id) {
        if (checkCircularCollision(myParticle, neighbourParticle)) {
          collided.add(neighbourParticle);
        }
        PVector attraction_force = myParticle.GetAttractionForce(neighbourParticle);
        netForce.add(attraction_force);
      }
    }
    
    myParticle.vel.add(netForce);
    
    for (int j = 0; j < neighbours.size(); j++) {
      Particle neighbourParticle = neighbours.get(j);
      if (!collided.contains(neighbourParticle) && neighbourParticle.id != myParticle.id) {
        checkCircularCollision(myParticle, neighbourParticle);
      }
    }
    
  }
  
  // Visual
  noStroke();
  for (int i = 0; i < particles.size(); i++) {
    Particle myParticle = particles.get(i);
    myParticle.vel.mult(0.98);
    myParticle.pos.add(myParticle.vel);
    myParticle.show();
  }
}

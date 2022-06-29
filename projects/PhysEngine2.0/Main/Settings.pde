
// Particle // 
boolean randomVelocities = false;
int PARTICLE_count = 100;
float PARTICLE_defaultRadius = 25;
float PARTICLE_attraction_constant = 10; //1 * pow(10, -25);
float PARTICLE_attraction_direction = 1; // 1 = normal, -1 = inverted
float QUAD_RegionWidth = 100;

float pythagoras(float x1, float y1, float x2, float y2) {
  return sqrt(pow(x2-x1, 2) + pow(y2-y1, 2));
}

boolean numberSameSign(float nA, float nB) {
  return ((nA > 0 && nB > 0) || (nA < 0 && nB < 0)); 
}

float getRandomVal(float min, float max, float divider) {
  return random(min, max)/divider;
}

PVector getRandomPosition() {
  return new PVector(getRandomVal(width*0.1, width*0.9, 1), getRandomVal(height*0.1, height*0.9, 1));
}

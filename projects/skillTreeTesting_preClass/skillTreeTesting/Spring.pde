
class Spring {
  float p;
  float v;
  float target;
  float angularFrequency = 10;
  float dampingRatio = 1;
  
  public Spring() {
    this.p = 0;
    this.v = 0;
    this.target = 0;
  }
  
  public Spring(float nP, float nV, float nT) {
    this.p = nP;
    this.v = nV;
    this.target = nT;
  }
  
  public void set(int p) {
    this.p = p;
    this.v = 0;
    this.target = p;
  }
  
  public void push(float vel) {
    this.v += vel; 
  }
  
  public void target(float targ) {
    this.target = targ;
  }
  
  public void update(float deltaTime) {
    float EPSILON = 0.0001;
    float aF = this.angularFrequency;
    float dR =  this.dampingRatio;
    
    if (aF < EPSILON) {
      return;
    };
    if (dR < 0) {
      dR = 0;
    }
    
    float epos = this.target;
    float dpos = this.p - epos;
    float dvel = this.v;
    if (dR > 1 + EPSILON) {
      float za = -aF * dR;
      float zb = aF * sqrt(dR*dR - 1);
      float z1 = za - zb;
      float z2 = za + zb;
      float expTerm1 = exp(z1 * deltaTime);
      float expTerm2 = exp(z2 * deltaTime);
      
      float c1 = (dvel - dpos*z2)/(-2*zb);
      float c2 = dpos - c1;
      this.p = epos + c1*expTerm1 + c2*expTerm2;
      this.v = c1*z1*expTerm1 + c2*z2*expTerm2;
    } else if (dR > 1 - EPSILON) {
      float expTerm = exp(-aF * deltaTime);
      
      float c1 = dvel + aF*dpos;
      float c2 = dpos;
      float c3 = (c1*deltaTime + c2)*expTerm;
      
      this.p = epos + c3;
      this.v = (c1*expTerm) - (c3*aF);
    } else {
      float omegaZeta = aF*dR;
      float alpha = aF*sqrt(1 - dR*dR);
      float expTerm = exp(-omegaZeta*deltaTime);
      float cosTerm = cos(alpha*deltaTime);
      float sinTerm = sin(alpha*deltaTime);
      
      float c1 = dpos;
      float c2 = (dvel + omegaZeta*dpos) / alpha;
      this.p = epos + expTerm*(c1*cosTerm + c2*sinTerm);
      this.v = -expTerm*((c1*omegaZeta - c2*alpha)*cosTerm + (c1*alpha + c2*omegaZeta)*sinTerm);
    }
  }
}


// https://ncalculators.com/geometry/ellipse-calculator.htm

double ellipseArea( double r1, double r2 ) {
  return PI * r1 * r2;
}

double ellipseVolume( double r1, double r2, double r3 ) {
  return (4 * PI * r1 * r2 * r3) / 3;
}

double ellipsePermiter( double r1, double r2 ) {
  return 2 * PI * sqrt( (pow((float) r1, 2) + pow((float) r2, 2)) / 2 ); 
}

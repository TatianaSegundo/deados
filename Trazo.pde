class Trazo {
  float x1;
  Trazo() {
  }



  void dibujar(float x1_) {
    noStroke();
    x1=x1_;
    bezier(x1_, x1_*2, x1_, x1_*3, x1_*2.5, x1_*2.5, x1_/2, x1_/2);
  }
}

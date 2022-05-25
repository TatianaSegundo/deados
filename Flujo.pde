class Flujo {
  float[][] azar;
  int cant=int(random(6));
  Trazo trazo;
  Paleta p;
  PVector grilla[][];
  int columna, fila;
  int r;

  Flujo(int a) {
    r=a;
    columna= width/r;
    fila= height/r;
    grilla=new PVector[columna][fila];
    azar = new float[columna][fila];

    p=new Paleta();
    trazo=new Trazo();
  }

  void iniciar(float a) {
    float xoff=0;
    for (int i=0; i<columna; i++) {
      float yoff=0;
      for (int j=0; j<fila; j++) {
        float theta= map(noise(xoff, yoff, a), 0, 1, 0, PI*2);
        grilla[i][j]=PVector.fromAngle(theta+a);
        azar[i][j] = random(1);
        yoff +=random(0.07, 0.1);
      }
      xoff+=random(0.07, 0.1);
    }
  }
  void dibujar(int l, int w) {

    for (int i=0; i<columna; i++) {
      for (int j=0; j<fila; j++) {
        fill(p.darUnColor(azar[i][j], w));

        dibujarVector(grilla[i][j], i*l, j*l);
      }
    }
  }
  void dibujarVector(PVector v, float y, float x) {
    push();

    translate(x, y);
    rotate(v.heading());
    stroke(1);
    trazo.dibujar(12);
    pop();
  }
  void quepaleta() {
    println(cant);
  }
}

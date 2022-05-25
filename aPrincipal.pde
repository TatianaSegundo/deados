
import oscP5.*;
//variables de calibración

float minimoAmp = 30;
float maximoAmp = 100;

float minimoPitch = 50;
float maximoPitch = 80;

float f = 0.1;
boolean haySonido=false;
boolean sonidoCorto=false;
long marcaDeTiempo;
float marcaDeTiempoA;
//int tiempo=10000;
OscP5 osc; // declaracion del objeto osc
boolean monitor= true;
float amp = 0.0;
float pitch = 0.0;
GestorSenial gestorAmp;
GestorSenial gestorPitch;

Flujo flujo;
int contador;
Paleta paleta;
float q;
float inc=0.5;
int w=int(random(4));
void setup() {
  background(0);
  flujo=new Flujo(3);
  // size(600,600);
  fullScreen();
  flujo.iniciar(q);
  osc = new OscP5(this, 12345); // parametros: puntero a processing y puerto

  //inicialización
  //por defecto el rango es 0-100
  gestorAmp = new GestorSenial( minimoAmp, maximoAmp, f );
  gestorPitch = new GestorSenial( minimoPitch, maximoPitch, f );
}
void draw() {
  background(0);
  gestorAmp.actualizar( amp );
  gestorPitch.actualizar( pitch );
  float contenido = sin(q/2);
  float contenidoMap = map(contenido, -1, 1, -1.5, 2);
  flujo.dibujar(10, w);

  if (monitor) {
    gestorAmp.imprimir( 100, 100, 400, 200);
    gestorPitch.imprimir( 100, 350, 400, 200);
  }
  if (gestorAmp.filtradoNorm()>0.5){
   haySonido = true; 
  }else haySonido = false;
  if (haySonido==true) {

    marcaDeTiempo=millis();
  }
  if (haySonido==false) {

    marcaDeTiempoA=millis();
  }

  if (gestorPitch.filtradoNorm()>0.3 && w<=3 && contador>0 && contador<2) {
    w++;
  } //ruido agudo corto
  else if (gestorPitch.filtradoNorm()<0.2 && w>0 && contador>0 && contador<2) {
    w--;
  } //ruido grave y corto

  if (haySonido==true)
  {
    q+=inc;
    flujo.iniciar(contenidoMap);
    contador++;
  }else contador=0;

  println(contador);
}

void oscEvent( OscMessage m) {

  if (m.addrPattern().equals("/amp")) {
    amp = m.get(0).floatValue();
    //println("amp: " + amp);
  }

  if (m.addrPattern().equals("/pitch")) {
    pitch = m.get(0).floatValue();
    //println("pitch: " + pitch);
  }
}

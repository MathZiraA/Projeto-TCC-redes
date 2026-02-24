#include <Wire.h>
#include <Adafruit_MCP23017.h>
#include <VL53L0X.h>

Adafruit_MCP23017 mcp;
VL53L0X sensorFrontal;

// ---------------- MOTORES ----------------
#define MOT1_A 14
#define MOT1_B 13
#define MOT2_A 10
#define MOT2_B 46
#define MOT3_A 3
#define MOT3_B 18
#define MOT4_A 12
#define MOT4_B 11

// ------------- SENSOR TOF ----------------
#define XSHUT_FRONTAL 4

// ----------- SENSORES IR (PORTA A) -------
int sensores[8] = {0,1,2,3,4,5,6,7};

// ----------- LEDs (PORTA B) --------------
#define LED_FRENTE_ESQ   8
#define LED_FRENTE_DIR   9
#define LED_TRAS_ESQ     10
#define LED_TRAS_DIR     11
#define LED_LAT_ESQ1     12
#define LED_LAT_ESQ2     13
#define LED_LAT_DIR1     14
#define LED_LAT_DIR2     15

// --------------------------------------------------

void setup() {
  Serial.begin(115200);

  // Motores
  pinMode(MOT1_A, OUTPUT); pinMode(MOT1_B, OUTPUT);
  pinMode(MOT2_A, OUTPUT); pinMode(MOT2_B, OUTPUT);
  pinMode(MOT3_A, OUTPUT); pinMode(MOT3_B, OUTPUT);
  pinMode(MOT4_A, OUTPUT); pinMode(MOT4_B, OUTPUT);

  Wire.begin();
  mcp.begin();

  // Sensores IR como entrada (PORTA A)
  for(int i=0;i<8;i++){
    mcp.pinMode(sensores[i], INPUT);
  }

  // LEDs como saída (PORTA B)
  for(int i=8;i<16;i++){
    mcp.pinMode(i, OUTPUT);
    mcp.digitalWrite(i, LOW);
  }

  // Inicializa VL53L0X
  pinMode(XSHUT_FRONTAL, OUTPUT);
  digitalWrite(XSHUT_FRONTAL, LOW);
  delay(10);
  digitalWrite(XSHUT_FRONTAL, HIGH);
  delay(10);

  sensorFrontal.init(true);
  sensorFrontal.setAddress(0x30);
  sensorFrontal.startContinuous();
}

// ---------------- LEDS ----------------

void desligarLEDs(){
  for(int i=8;i<16;i++)
    mcp.digitalWrite(i, LOW);
}

void ledsFrente(){
  desligarLEDs();
  mcp.digitalWrite(LED_FRENTE_ESQ, HIGH);
  mcp.digitalWrite(LED_FRENTE_DIR, HIGH);
}

void ledsTras(){
  desligarLEDs();
  mcp.digitalWrite(LED_TRAS_ESQ, HIGH);
  mcp.digitalWrite(LED_TRAS_DIR, HIGH);
}

void setaEsquerda(){
  desligarLEDs();
  mcp.digitalWrite(LED_LAT_ESQ1, HIGH);
  mcp.digitalWrite(LED_LAT_ESQ2, HIGH);
}

void setaDireita(){
  desligarLEDs();
  mcp.digitalWrite(LED_LAT_DIR1, HIGH);
  mcp.digitalWrite(LED_LAT_DIR2, HIGH);
}

// ---------------- MOVIMENTO ----------------

void mover(int m1a,int m1b,int m2a,int m2b,int m3a,int m3b,int m4a,int m4b){
  digitalWrite(MOT1_A,m1a); digitalWrite(MOT1_B,m1b);
  digitalWrite(MOT2_A,m2a); digitalWrite(MOT2_B,m2b);
  digitalWrite(MOT3_A,m3a); digitalWrite(MOT3_B,m3b);
  digitalWrite(MOT4_A,m4a); digitalWrite(MOT4_B,m4b);
}

void andarReto(){
  ledsFrente();
  mover(HIGH,LOW,HIGH,LOW,HIGH,LOW,HIGH,LOW);
}

void virarEsquerda(){
  setaEsquerda();
  mover(LOW,HIGH,HIGH,LOW,LOW,HIGH,HIGH,LOW);
}

void virarDireita(){
  setaDireita();
  mover(HIGH,LOW,LOW,HIGH,HIGH,LOW,LOW,HIGH);
}

void parar(){
  ledsTras();
  mover(LOW,LOW,LOW,LOW,LOW,LOW,LOW,LOW);
}

// ---------------- LOOP PRINCIPAL ----------------

void loop(){

  int distancia = sensorFrontal.readRangeContinuousMillimeters();

  // 🚨 DESVIO DE OBSTÁCULO
  if(distancia < 150){
    Serial.println("Obstáculo detectado!");
    parar();
    delay(300);
    virarDireita();
    delay(500);
    andarReto();
    delay(600);
    return;
  }

  // 📍 LEITURA LINHA
  int leitura[8];
  for(int i=0;i<8;i++){
    leitura[i] = mcp.digitalRead(sensores[i]);
  }

  if(leitura[3]==0 && leitura[4]==0){
    andarReto();
  }
  else if(leitura[2]==0 || leitura[1]==0){
    virarEsquerda();
  }
  else if(leitura[5]==0 || leitura[6]==0){
    virarDireita();
  }
  else if(leitura[0]==0){
    virarEsquerda();
  }
  else if(leitura[7]==0){
    virarDireita();
  }
  else{
    parar();
  }

  delay(30);
}
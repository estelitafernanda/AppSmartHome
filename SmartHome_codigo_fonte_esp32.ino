/*
#include "DHT.h"
#include <WiFi.h>                        
#include <IOXhop_FirebaseESP32.h>          // ESP32 comunicação com Firebase
#include <ArduinoJson.h>                   // JSON para trabalhar com dados do Firebase

//#define WIFI_SSID "FLEXNET_070823" // nome da sua rede WiFi
//#define WIFI_PASSWORD "@20231535#"   // senha da sua rede WiFi
//#define WIFI_SSID "teste" // nome da sua rede WiFi
//#define WIFI_PASSWORD "hello9090"   // senha da sua rede WiFi
#define WIFI_SSID "brisa-1328765"
//#define WIFI_SSID ""
#define WIFI_PASSWORD "ni7o4uz6"

#define FIREBASE_HOST "https://appsmarthome-fce63-default-rtdb.firebaseio.com/" // link do banco de dados
#define FIREBASE_AUTH "Azgd7ariGA6UVaVbE1ibcnyfWSJZYUzfMznlEehx"     // chave de autenticação do Firebase

#define SENSOR_PRESENCA_PIN 13
#define DHTPIN 12  // ANTES O PINO ERA O 13 TIVE QUE TROCAR PRA 12 POR CAUSA DO SENSOR DE PRESENCA
#define LDR_PIN_PARTE_EXTERNA 34  // LDR parte externa
#define LDR_PIN_COZINHA 35 // LDR cozinha
#define DHTTYPE DHT11 // DHT 11

DHT dht(DHTPIN, DHTTYPE);

const byte pinR = 27;
const byte pinG = 26;
const byte pinB = 25;
const byte lampadaSala = 14;
const byte lampadaParteExterna = 15;
const byte lampadaGaragem = 32;
const byte lampadaBanheiro = 18;
const byte lampadaCozinha = 19;

int r = 255, g = 255, b = 255; 
bool lampadaQuartoLigado = false;
bool lampadaSalaLigado = false;
bool lampadaParteExternaLigado = false;
bool lampadaGaragemLigado = false;
bool lampadaBanheiroLigado = false;
bool lampadaCozinhaLigado = false;
bool estadoSensorPIR = false;

void setup() {
  Serial.begin(115200);
  Serial.println("Inicializando...");

  pinMode(LDR_PIN_PARTE_EXTERNA, INPUT);
  pinMode(LDR_PIN_COZINHA, INPUT);
  pinMode(SENSOR_PRESENCA_PIN, INPUT);

  pinMode(pinR, OUTPUT);
  pinMode(pinG, OUTPUT);
  pinMode(pinB, OUTPUT);
  pinMode(lampadaSala, OUTPUT);
  pinMode(lampadaParteExterna, OUTPUT);
  pinMode(lampadaGaragem, OUTPUT);
  pinMode(lampadaBanheiro, OUTPUT);
  pinMode(lampadaCozinha, OUTPUT);

  dht.begin();

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Conectando ao WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println("\nWiFi conectado!");

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {


  lampadaSalaLigado = Firebase.getBool("casa/sala/lampada"); 
  digitalWrite(lampadaSala, lampadaSalaLigado);
  Serial.printf("LED Simples sala: %s\n", lampadaSalaLigado ? "Ligado" : "Desligado");

  lampadaParteExternaLigado = Firebase.getBool("casa/parteExterna/lampada"); 
  digitalWrite(lampadaParteExterna, lampadaParteExternaLigado);
  Serial.printf("LED Simples Parte Externa: %s\n", lampadaParteExternaLigado ? "Ligado" : "Desligado");

  lampadaGaragemLigado = Firebase.getBool("casa/garagem/lampada"); 
  digitalWrite(lampadaGaragem, lampadaGaragemLigado);
  Serial.printf("LED Simples Garagem: %s\n", lampadaGaragemLigado ? "Ligado" : "Desligado");

  lampadaBanheiroLigado = Firebase.getBool("casa/banheiro/lampada"); 
  digitalWrite(lampadaBanheiro, lampadaBanheiroLigado);
  Serial.printf("LED Simples Banheiro: %s\n", lampadaBanheiroLigado ? "Ligado" : "Desligado");

  lampadaCozinhaLigado = Firebase.getBool("casa/cozinha/lampada"); 
  digitalWrite(lampadaCozinha, lampadaCozinhaLigado);
  Serial.printf("LED Simples Cozinha: %s\n", lampadaCozinhaLigado ? "Ligado" : "Desligado");


  estadoSensorPIR = digitalRead(SENSOR_PRESENCA_PIN);  

  Firebase.setBool("casa/sala/presenca", estadoSensorPIR);
  Serial.print("Movimento na sala: ");
  Serial.println(estadoSensorPIR ? "Detectado" : "Não detectado");


  int ldrValorParteExterna = analogRead(LDR_PIN_PARTE_EXTERNA);
  float porcentagemParteExterna = (ldrValorParteExterna / 4095.0) * 100.0; 


  Firebase.setFloat("casa/parteExterna/luminosidade", porcentagemParteExterna);
  Serial.print("LDR Valor Parte Externa: ");
  Serial.print(ldrValorParteExterna);
  Serial.print(" | Porcentagem Parte Externa: ");
  Serial.print(porcentagemParteExterna, 2);
  Serial.println(" %");

  int ldrValorCozinha = analogRead(LDR_PIN_COZINHA);
  float porcentagemCozinha = (ldrValorCozinha / 4095.0) * 100.0; 

  Firebase.setFloat("casa/cozinha/luminosidade", porcentagemCozinha);
  Serial.print("LDR Valor Cozinha: ");
  Serial.print(ldrValorCozinha);
  Serial.print(" | Porcentagem Cozinha: ");
  Serial.print(porcentagemCozinha, 2);
  Serial.println(" %");



  // leitura da temperatura e umidade
  float h = dht.readHumidity();
  float t = dht.readTemperature();

  // verifica se a leitura é válida
  if (isnan(t) || isnan(h)) {
    Serial.println("Falha ao ler do sensor DHT");
  } else {
    Serial.print("Umidade: ");
    Serial.print(h);
    Serial.print(" %t");
    Serial.print("Temperatura: ");
    Serial.print(t);
    Serial.println(" *C");

    
    Firebase.setFloat("casa/quarto/temperatura", t);
    Firebase.setFloat("casa/quarto/umidade", h);
  }

  // Controle do LED RGB
  String jsonString = Firebase.getString("casa/quarto/lampadaRGB"); 
  Serial.println("JSON Recebido: " + jsonString);

  if (jsonString != "") { // verifica se o retorno não está vazio
    // adiciona chaves ao JSON se necessário
    if (!jsonString.startsWith("{")) {
      jsonString = "{" + jsonString + "}";
    }

    // usando o ArduinoJson v5
    DynamicJsonBuffer jsonBuffer;
    JsonObject& doc = jsonBuffer.parseObject(jsonString);

    if (doc.success()) {
      r = doc["R"];
      g = doc["G"];
      b = doc["B"];
      Serial.printf("RGB Atualizado: R=%d, G=%d, B=%d\n", r, g, b);

      // ajuste nos pinos do LED RGB
      analogWrite(pinR, 255 - r); // inversão por causa do LED comum
      analogWrite(pinG, 255 - g);
      analogWrite(pinB, 255 - b);
    } else {
      Serial.println("Erro ao analisar JSON!");
    }
  } else {
    Serial.println("Erro ao obter valores RGB do Firebase!");
  }

  delay(1000); // Pequeno atraso para evitar sobrecarga
}
*/


// CODIGO COM AR CONDICIONADO e SENSOR DE GAS

#include "DHT.h"
#include <WiFi.h>                        
#include <IOXhop_FirebaseESP32.h>          // ESP32 comunicação com Firebase
#include <ArduinoJson.h>                   // JSON para trabalhar com dados do Firebase
#include <LiquidCrystal_I2C.h>

//#define WIFI_SSID "FLEXNET_070823" // nome WiFi
//#define WIFI_PASSWORD "@20231535#"   // senha WiFi
//#define WIFI_SSID "teste" // nome WiFi
//#define WIFI_PASSWORD "hello9090"   // senha WiFi
#define WIFI_SSID "Galaxy A23E2CB"
//#define WIFI_SSID ""
#define WIFI_PASSWORD "17110521"

#define FIREBASE_HOST "https://appsmarthome-fce63-default-rtdb.firebaseio.com/" // link do banco de dados
#define FIREBASE_AUTH "Azgd7ariGA6UVaVbE1ibcnyfWSJZYUzfMznlEehx"     // chave de autenticação do Firebase

LiquidCrystal_I2C lcd(0x27, 16, 2);

#define SENSOR_PRESENCA_PIN 4
#define DHTPIN 13
//#define LDR_PIN_PARTE_EXTERNA 34
#define LDR_PIN_COZINHA 35
#define DHTTYPE DHT11
#define MOTOR_PIN 5   // Pino para controlar o motor
#define CONTROL_PIN 34 // Pino para controle adicional (botão ou lógica extra)


DHT dht(DHTPIN, DHTTYPE);

const byte pinR = 27;
const byte pinG = 26;
const byte pinB = 25;
const byte lampadaSala = 14;
const byte lampadaParteExterna = 15;
const byte lampadaGaragem = 32;
const byte lampadaBanheiro = 18;
const byte lampadaCozinha = 19;

int r = 255, g = 255, b = 255;
bool lampadaQuartoLigado = false;
bool lampadaSalaLigado = false;
bool lampadaParteExternaLigado = false;
bool lampadaGaragemLigado = false;
bool lampadaBanheiroLigado = false;
bool lampadaCozinhaLigado = false;
bool estadoSensorPIR = false;

const int MQ6_PIN = 33;  
const int THRESHOLD = 1000; 

void setup() {
  Serial.begin(115200);
  Serial.println("Inicializando...");

  pinMode(MOTOR_PIN, OUTPUT);    // Configura o pino 5 como saída
  pinMode(CONTROL_PIN, INPUT_PULLUP); // Configura o pino 4 como entrada com pull-up interno

  pinMode(LDR_PIN_PARTE_EXTERNA, INPUT);
  pinMode(LDR_PIN_COZINHA, INPUT);
  pinMode(SENSOR_PRESENCA_PIN, INPUT);

  pinMode(pinR, OUTPUT);
  pinMode(pinG, OUTPUT);
  pinMode(pinB, OUTPUT);
  pinMode(lampadaSala, OUTPUT);
  pinMode(lampadaParteExterna, OUTPUT);
  pinMode(lampadaGaragem, OUTPUT);
  pinMode(lampadaBanheiro, OUTPUT);
  pinMode(lampadaCozinha, OUTPUT);

  pinMode(MQ6_PIN, INPUT); 

  dht.begin();

  // Inicializa o LCD
  lcd.init();
  lcd.backlight();
  lcd.clear();

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Conectando ao WiFi");
  while (WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(300);
  }
  Serial.println("\nWiFi conectado!");

  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
}

void loop() {

  /*
  int sensorValue = analogRead(MQ6_PIN);

  // Verifica se o limite foi ultrapassado
  bool gasDetectado = sensorValue > THRESHOLD;

  
  //Firebase.setInt("casa/mq6/valor", sensorValue);
  Firebase.setBool("casa/mq6/gasDetectado", gasDetectado);

  Serial.print("Valor do sensor MQ-6: ");
  Serial.println(sensorValue);
  Serial.println(gasDetectado ? "** ATENÇÃO: Gás detectado! **" : "Ambiente seguro.");
  */

  int sensorValue = analogRead(MQ6_PIN);
  bool gasDetectado;

  if (sensorValue > THRESHOLD) {
    gasDetectado = true;
    Serial.println("** ATENÇÃO: Gás detectado! **");
  } else {
    gasDetectado = false;
    Serial.println("Ambiente seguro.");
  }
 
  Firebase.setBool("casa/mq6/gasDetectado", gasDetectado);

  Serial.print("Valor do sensor MQ-6: ");
  Serial.println(sensorValue);


  lampadaSalaLigado = Firebase.getBool("casa/sala/lampada"); 
  digitalWrite(lampadaSala, lampadaSalaLigado);
  Serial.printf("LED Simples sala: %s\n", lampadaSalaLigado ? "Ligado" : "Desligado");

  lampadaParteExternaLigado = Firebase.getBool("casa/parteExterna/lampada"); 
  digitalWrite(lampadaParteExterna, lampadaParteExternaLigado);
  Serial.printf("LED Simples Parte Externa: %s\n", lampadaParteExternaLigado ? "Ligado" : "Desligado");

  lampadaGaragemLigado = Firebase.getBool("casa/garagem/lampada"); 
  digitalWrite(lampadaGaragem, lampadaGaragemLigado);
  Serial.printf("LED Simples Garagem: %s\n", lampadaGaragemLigado ? "Ligado" : "Desligado");

  lampadaBanheiroLigado = Firebase.getBool("casa/banheiro/lampada"); 
  digitalWrite(lampadaBanheiro, lampadaBanheiroLigado);
  Serial.printf("LED Simples Banheiro: %s\n", lampadaBanheiroLigado ? "Ligado" : "Desligado");

  lampadaCozinhaLigado = Firebase.getBool("casa/cozinha/lampada"); 
  digitalWrite(lampadaCozinha, lampadaCozinhaLigado);
  Serial.printf("LED Simples Cozinha: %s\n", lampadaCozinhaLigado ? "Ligado" : "Desligado");

  estadoSensorPIR = digitalRead(SENSOR_PRESENCA_PIN);  

  Firebase.setBool("casa/sala/presenca", estadoSensorPIR);
  Serial.print("Movimento na sala: ");
  Serial.println(estadoSensorPIR ? "Detectado" : "Não detectado");


  int ldrValorParteExterna = analogRead(LDR_PIN_PARTE_EXTERNA);
  float porcentagemParteExterna = (ldrValorParteExterna / 4095.0) * 100.0; 


  Firebase.setFloat("casa/parteExterna/luminosidade", porcentagemParteExterna);
  Serial.print("LDR Valor Parte Externa: ");
  Serial.print(ldrValorParteExterna);
  Serial.print(" | Porcentagem Parte Externa: ");
  Serial.print(porcentagemParteExterna, 2);
  Serial.println(" %");

  /*int ldrValorCozinha = analogRead(LDR_PIN_COZINHA);
  float porcentagemCozinha = (ldrValorCozinha / 4095.0) * 100.0; 

  Firebase.setFloat("casa/cozinha/luminosidade", porcentagemCozinha);
  Serial.print("LDR Valor Cozinha: ");
  Serial.print(ldrValorCozinha);
  Serial.print(" | Porcentagem Cozinha: ");
  Serial.print(porcentagemCozinha, 2);
  Serial.println(" %");*/

  float h = dht.readHumidity();
  float t = dht.readTemperature();

  // verifica se a leitura é válida
  if (isnan(t) || isnan(h)) {
    Serial.println("Falha ao ler do sensor DHT");
  } else {
    Serial.print("Umidade: ");
    Serial.print(h);
    Serial.print(" %t");
    Serial.print("Temperatura: ");
    Serial.print(t);
    Serial.println(" *C");
    
    Firebase.setFloat("casa/quarto/temperatura", t);
    Firebase.setFloat("casa/quarto/umidade", h);
  }

   // Controle do LED RGB
  String jsonString = Firebase.getString("casa/quarto/lampadaRGB"); 
  Serial.println("JSON Recebido: " + jsonString);

  if (jsonString != "") { // verifica se o retorno não está vazio
    // adiciona chaves ao JSON se necessário
    if (!jsonString.startsWith("{")) {
      jsonString = "{" + jsonString + "}";
    }

    // usando o ArduinoJson v5
    DynamicJsonBuffer jsonBuffer;
    JsonObject& doc = jsonBuffer.parseObject(jsonString);

    if (doc.success()) {
      r = doc["R"];
      g = doc["G"];
      b = doc["B"];
      Serial.printf("RGB Atualizado: R=%d, G=%d, B=%d\n", r, g, b);

      // ajuste nos pinos do LED RGB
      analogWrite(pinR, 255 - r); // inversão por causa do LED comum
      analogWrite(pinG, 255 - g);
      analogWrite(pinB, 255 - b);
    } else {
      Serial.println("Erro ao analisar JSON!");
    }
  } else {
    Serial.println("Erro ao obter valores RGB do Firebase!");
  }

  bool arCondicionadoLigado = Firebase.getBool("casa/quarto/arCondicionado/ligado");
  if (arCondicionadoLigado) {
    int temperatura = Firebase.getInt("casa/quarto/arCondicionado/temperatura");
    lcd.backlight();
    lcd.clear();
    lcd.setCursor(0, 0);
    lcd.print("AC Ligado");
    lcd.setCursor(0, 1);
    //lcd.print("Temp: ");
    lcd.print(temperatura);
    lcd.print(" C");
  } else {
    lcd.noBacklight();
  }

  int controlState = digitalRead(CONTROL_PIN); // Lê o estado do pino de controle

  if (controlState == LOW) {  // Se o botão estiver pressionado
    digitalWrite(MOTOR_PIN, HIGH);  // Liga o motor
  } else {
    digitalWrite(MOTOR_PIN, LOW);   // Desliga o motor
  }

  delay(10); // Delay para evitar leituras instáveis

  delay(1000);
}




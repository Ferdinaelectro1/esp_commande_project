#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

#define led 5

const char *ssid = "Infinix SMART 7 HD";
const char *password = "tchaasousso";

ESP8266WebServer server(80);

void onled()
{
  digitalWrite(led,1);
  server.send(200,"text","Esp vous dit led allume");
}

void offled()
{
  digitalWrite(led,0);
  server.send(200,"text","Esp vous dit led eteint");
}

void setup() {
  Serial.begin(115200);
  WiFi.begin(ssid,password);
  pinMode(led,OUTPUT);
  while(!WiFi.isConnected()) delay(100);
  digitalWrite(LED_BUILTIN,0);
  
  Serial.println(WiFi.localIP());
  server.on("/onled",onled);
  server.on("/offled",offled);
  server.begin();
}

void loop() {
  server.handleClient();
}

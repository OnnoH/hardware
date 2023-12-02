#include <Arduino.h>

#define LED_BUILT_IN_ESP 2
#define LED_BUILT_IN_NODE 16

void setup()
{
  pinMode(LED_BUILT_IN_ESP, OUTPUT);
  pinMode(LED_BUILT_IN_NODE, OUTPUT);
}

void loop()
{
  digitalWrite(LED_BUILT_IN_ESP, HIGH);
  digitalWrite(LED_BUILT_IN_NODE, LOW);
  delay(1000);
  digitalWrite(LED_BUILT_IN_ESP, LOW);
  digitalWrite(LED_BUILT_IN_NODE, HIGH);
  delay(1000);
}
// Minimal sketch for this board: prints a heartbeat over the serial port.
// Nothing board specific yet, it is here so the project compiles.

#include "Arduino.h"

void setup()
{
  Serial.begin(115200);
  Serial.println();
  Serial.println("Olimex EVB ready");
}

void loop()
{
  Serial.print("up for ");
  Serial.print(millis() / 1000);
  Serial.println(" s");
  delay(1000);
}

/*
   This code is provided to show how to control TX and RX LEDs within a sketch.
*/
#include "Arduino.h"

int RXLED = 17; // The RX LED has a defined Arduino pin
// The TX LED needs to use pre-defined macros (TXLED1, TXLED0) to control that.
// Those are available for the RX LED too (RXLED1, RXLED0)

void setup()
{
  pinMode(RXLED, OUTPUT); // Set RX LED as an output
  // TX LED is set as an output behind the scenes
}

void loop()
{
  digitalWrite(RXLED, LOW); // set the RX LED ON
  TXLED0;                   // TX LED is not tied to a normally controlled pin so a macro is needed, turn LED OFF
  delay(1000);              // wait for a second

  digitalWrite(RXLED, HIGH); // set the RX LED OFF
  TXLED1;                    // TX LED macro to turn LED ON
  delay(1000);               // wait for a second
}

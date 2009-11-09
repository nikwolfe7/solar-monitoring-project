#include <ModbusRTU.h>

int LED = 13;
ModbusRTU mrtu;

/* This program interacts with the 
   output of SerialPortCommunication.java
*/

void setup()
{
  mrtu = ModbusRTU();
  pinMode( LED, OUTPUT );
  Serial.begin(9600);
}

void loop()
{
  digitalWrite( LED, LOW );
  while (Serial.available() > 0) {
    unsigned char c = char(Serial.read());
    unsigned char arr[] = { c };
    unsigned short s = mrtu.generateCRC_16( arr, 1 ); 
    Serial.println( s, HEX );
    digitalWrite( LED, HIGH );
  }
}

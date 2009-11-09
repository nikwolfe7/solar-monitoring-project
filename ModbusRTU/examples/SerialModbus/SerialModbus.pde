#include <ModbusRTU.h>

int LED = 13;
ModbusRTU mrtu;

void setup()
{
  mrtu = ModbusRTU();
  pinMode( LED, OUTPUT );
  Serial.begin(9600);
}

void loop()
{
  digitalWrite( LED, LOW );
  if (Serial.available() > 0) {
    unsigned char c = char(Serial.read());
    unsigned char arr[] = { c };
    unsigned short s = mrtu.generateCRC_16( arr, 1 ); 
    Serial.println( s );
    digitalWrite( LED, HIGH );
    //delay( 30 );   
  }
}

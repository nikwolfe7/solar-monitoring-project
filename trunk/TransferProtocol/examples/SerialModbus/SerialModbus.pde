#include <TransferProtocol.h>

int LED = 13;
TransferProtocol modbus;

void setup()
{
  modbus = TransferProtocol();
  pinMode( LED, OUTPUT );
  Serial.begin(9600);
}

void loop()
{
  digitalWrite( LED, LOW );
  delay(2000);
  modbus.getBatteryVoltage();
  while (Serial.available() > 0) {
    unsigned char c = char(Serial.read());
    unsigned char arr[] = { c };
    modbus.transferData( arr, 1 ); 
    digitalWrite( LED, HIGH );
  }
}
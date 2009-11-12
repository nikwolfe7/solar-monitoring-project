#include <ControllerTransferProtocol.h>

int LED = 13;
ControllerTransferProtocol modbus;
boolean transmit = true;

void setup()
{
  modbus = ControllerTransferProtocol();
  pinMode( LED, OUTPUT );
  Serial.begin(9600);
  indicateInitialize( 4, 500 );
  Serial.println("A");
}

void loop()
{
  digitalWrite( LED, LOW );
  delay( 1000 );
  
  if( transmit )
  {
    digitalWrite( LED, HIGH );
    Serial.print( "Voltage: " );
    Serial.print( modbus.getBatteryVoltage() );
    transmit = false;
  }
  
     
  /*
  while (Serial.available() > 0) {
    unsigned char c = char(Serial.read());
    unsigned char arr[] = { c };
    digitalWrite( LED, HIGH );
  }
  */
}

/*=====================================================================
  indicateInitialize() -- debug output blinks indicating a process is starting
*/
void indicateInitialize( int beats, int delay_period )
{
  for(int i = 0; i < beats; ++i ){
    digitalWrite( LED, HIGH );    // set the LED on
    delay( delay_period );            // wait
    digitalWrite( LED, LOW );     // set the LED off
    delay( delay_period );
  }
}


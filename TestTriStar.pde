#include <ControllerTransferProtocol.h>

int LED_PIN = 12;
char arr[] = { 0x01, 0x03, 0x00, 0x10, 0x00, 0x01, 0x85, 0xCF };
ControllerTransferProtocol controller;
double val = 0;

void setup()
{
  Serial.begin(9600);
  controller = ControllerTransferProtocol(); 
  pinMode( LED_PIN, OUTPUT );
  /*
  for( int i = 0; i < 8; ++i )
  {
    Serial.print(arr[i]);
  } 
  */
  indicateInitialize(1,2000);
}

void loop()
{
  /*
  if( Serial.available() > 0 )
  {
    int x = Serial.available();
    indicateInitialize(x, 300); 
    Serial.flush();
  }
  */
  val = 0;
  delay( 2000 );
  val = controller.getBatteryVoltage();
  //indicateInitialize(1,300);
  if( val > 12 ) {
   indicateInitialize(10, 50);  
  }
}

/*=====================================================================
  indicateInitialize() -- debug output blinks indicating a process is starting
*/
void indicateInitialize( int beats, int delay_period )
{
  for(int i = 0; i < beats; ++i ){
    digitalWrite( LED_PIN, HIGH );    // set the LED on
    delay( delay_period );            // wait
    digitalWrite( LED_PIN, LOW );     // set the LED off
    delay( delay_period );
  }
}

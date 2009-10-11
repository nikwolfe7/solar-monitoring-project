/*
  Nikolas Wolfe
  9/18/09
  
  Push Key Program
  
  This program toggles buttons on a cell phone keypad
  which are controlled through an electronic switch.
  
  The switch enables are ACTIVE-LOW, so the signals are
  asserted HIGH by default, and asserted LOW to initiate a 
  key press action.
  
*/

int PWR = 2; // output signal to control power button
int ACCEPT = 3; // output signal to control the accept/call button
int ONE = 4; // output signal to control the 1 key
int TWO = 5; // output signal to control 2 key

int STARTUP_TIME = 20000; // 20 second delay

int ledPin = 13;
boolean isRun = false;

// setup runs once, intializes all outputs to HIGH
void setup() 
{ 
 // assert pins as OUTPUTs
 pinMode( PWR, OUTPUT );
 pinMode( ACCEPT, OUTPUT );
 pinMode( ONE, OUTPUT );
 pinMode( TWO, OUTPUT ); 
 pinMode(ledPin, OUTPUT); 
 
 // assert signals HIGH -- disables buffers
 digitalWrite( PWR, HIGH );
 digitalWrite( ACCEPT, HIGH );
 digitalWrite( ONE, HIGH );
 digitalWrite( TWO, HIGH );
 
 // indicate to the user that we're starting up
 indicateInitialize();
 
 // turn phone ON
 toggle_on_off();
 
 // wait for startup to complete
 delay( STARTUP_TIME );
}

// the loop() method runs over and over again,
// as long as the Arduino has power

// loop runs forever
void loop()                     
{
  if( !isRun ){
    toggle_on_off();
    isRun = true;
  }
}

void toggle_on_off()
{
  digitalWrite( PWR, LOW ); // assert pin low
  delay( 4000 ); // 4 seconds will turn the phone on or off
  digitalWrite( PWR, HIGH ); // reassert pin high
}

void indicateInitialize()
{
  for(int i = 0; i < 5; ++i ){
    digitalWrite(ledPin, HIGH);   // set the LED on
    delay(500);                  // wait for a second
    digitalWrite(ledPin, LOW);    // set the LED off
    delay(500);                   // wait for a second
  }
}


/*
  Nikolas Wolfe
  9/18/09
  
  Push Key Program
*/

// These can change
const int INCOMING_CALL  = 2;
const int NODE_1         = 3;
const int NODE_2         = 4;
const int NODE_3         = 5;
const int NODE_A         = 6;
const int NODE_B         = 7;
const int NODE_C         = 8;
const int NODE_D         = 9;
const int ACCEPT         = 10;
const int PWR            = 11;

// These should not
const int ZERO[]        = { NODE_2, NODE_D };
const int ONE[]         = { NODE_1, NODE_A };
const int TWO[]         = { NODE_2, NODE_A };
const int THREE[]       = { NODE_3, NODE_A };
const int FOUR[]        = { NODE_1, NODE_B };
const int FIVE[]        = { NODE_2, NODE_B };
const int SIX[]         = { NODE_3, NODE_B };
const int SEVEN[]       = { NODE_1, NODE_C };
const int EIGHT[]       = { NODE_2, NODE_C };
const int NINE[]        = { NODE_3, NODE_C };

const int* decimalArray[] = { ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE };

const int STAR[]        = { NODE_1, NODE_D };
const int POUND[]       = { NODE_3, NODE_D };
const int ACCEPT_CALL[] = { NODE_1, ACCEPT };
const int POWER[]       = { PWR, PWR };

const int LED_PIN = 13;

boolean isRun = true;

/*=====================================================================
  ARDUINO CONTROL METHODS
  
  setup() -- runs once, initializes outputs
  loop() -- main control loop
  =====================================================================
*/

void setup() 
{ 
  // serial communiction
  initializeSerialPort();
  setOutputPins();
  initializeOutputPinStates();
  
  // debug
  pinMode( LED_PIN, OUTPUT ); 
  digitalWrite( LED_PIN, LOW );
  
  Serial.println("initializing interrupt...");
  pinMode( INCOMING_CALL, INPUT );
  attachInterrupt( 0, hello, CHANGE );
 
  // indicate to the user that we're starting up
  indicateInitialize( 3, 500 );
}

void loop()
{
  if( !isRun )
  {
     pushKey( ACCEPT_CALL );
     pushKey( POUND );
     pushKey( decimalArray[0] );
     pushKey( decimalArray[1] );
     pushKey( decimalArray[2] );
     pushKey( decimalArray[3] );
     pushKey( decimalArray[4] );
     pushKey( decimalArray[5] );
     pushKey( decimalArray[6] );
     pushKey( decimalArray[7] );
     pushKey( decimalArray[8] );
     pushKey( decimalArray[9] );
     pushKey( POUND );
     pushKey( STAR );
     
     delay( 2000 );
     
     pushKey( POWER );
 
     isRun = true;  
  }  
}

/*=====================================================================
  indicateInitialize() -- debug output blinks indicating a process is starting
*/
void indicateInitialize( int beats, int delay_period )
{
  for(int i = 0; i < beats; ++i ){
    digitalWrite( LED_PIN, HIGH );   // set the LED on
    delay( delay_period );          // wait
    digitalWrite( LED_PIN, LOW );    // set the LED off
    delay( delay_period );
  }
}


void initializeOutputPinStates()
{
  digitalWrite( NODE_1, LOW );
  digitalWrite( NODE_2, LOW );
  digitalWrite( NODE_3, LOW );
  digitalWrite( NODE_A, LOW );
  digitalWrite( NODE_B, LOW );
  digitalWrite( NODE_C, LOW );
  digitalWrite( NODE_D, LOW );
  digitalWrite( ACCEPT, LOW ); 
  digitalWrite( PWR, LOW ); 
}

/*=====================================================================
  incomingCallISR() -- interrupt service routine for incoming calls
*/
void initializeSerialPort()
{
  // initialize serial baud rate
  Serial.begin(9600);  
}

/*=====================================================================
  setOutputPins() -- sets pins as outputs
*/
void setOutputPins()
{
  // assert pins as outpus
  pinMode( NODE_1, OUTPUT );
  pinMode( NODE_2, OUTPUT );
  pinMode( NODE_3, OUTPUT );
  pinMode( NODE_A, OUTPUT );
  pinMode( NODE_B, OUTPUT );
  pinMode( NODE_C, OUTPUT );
  pinMode( NODE_D, OUTPUT );
  pinMode( ACCEPT, OUTPUT );
  pinMode( PWR, OUTPUT ); 
}

/*=====================================================================
  togglePin() -- pushes a single key
*/
void pushKey( const int* key )
{
  digitalWrite( key[0], HIGH );   // assert pin 1 HIGH
  digitalWrite( key[1], HIGH );   // assert pin 2 HIGH
  delay( 125 );                   // time required for gate delay / pin debouncing
  digitalWrite( key[0], LOW );    // reassert pin 1 LOW
  digitalWrite( key[1], LOW );    // reassert pin 2 LOW
  delay( 125 );                   // time required for gate delay / pin debouncing 
}

void hello() 
{
  Serial.println("interrupt!");
  isRun = false;
}

void togglePower()
{
  
  
}

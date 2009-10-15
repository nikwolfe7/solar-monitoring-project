/*
  Nikolas Wolfe
  9/18/09
  
  Push Key Program
  
  This program utilizes the output pins of an Arduino
  Duemilanove to electronically press keys on the keypad 
  of a cellular phone. 
*/

/*===================================================================== 
  PIN ASSIGNMENTS 
  
  The variable name (e.g. ZERO) corresponds to the key that the output
  pin (e.g. pin 9) electronically enables. 
  
  Logically the keypad is arranged thus:
  
  | 1 | 2 | 3 |
  -------------
  | 4 | 5 | 6 |
  -------------
  | 7 | 8 | 9 |
  -------------
  | * | 0 | # |
  
  The circuits to press the keys are arranged based on the colums. Since
  pins 0 and 1 are used for serial data transmission on the Arduino, the
  pin assignments start at 2, where 3, 6, 9, and # are in the first column,
  2, 5, 8, 0 the second, and 1, 4, 7 the third. The * key is not mapped, as
  that pin space is needed in order to push the "accept" key. 
  
  Ergo, the pin mapping is as follows:
  
  PIN 3 --> KEY 3
  PIN 4 --> KEY 6  
  PIN 5 --> KEY 9
  PIN 6 --> KEY #
  PIN 7 --> KEY 2
  PIN 8 --> KEY 5
  PIN 9 --> KEY 8
  PIN 10 --> KEY 0
  PIN 11 --> KEY 1
  PIN 12 --> KEY 4
  PIN 13 --> KEY 7   
  =====================================================================
*/

const int THREE = 3;
const int SIX = 4;
const int NINE = 5;
const int POUND = 6;
const int TWO = 7; 
const int FIVE = 8; 
const int EIGHT = 9;
const int ZERO = 10;
const int ONE = 11;
const int FOUR = 12;
const int SEVEN = 13;
//const int STAR = ;

/*===================================================================== 
  INT ARRAY FOR NUMBER PAD
  
  This array can be used anywhere to obtain the pin number of a given 
  key using an integer. This is useful when translating data inputs into
  output values. The values for # and * are not included here. 
  =====================================================================
*/
const int decimalArray[] = {  ZERO, ONE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE };

/*=====================================================================
  OTHER VARIABLES
  =====================================================================
*/
const int interruptZero = 0;
const int interruptPin = 2;
const int ledPin = 13;
boolean isRun = false;

/* TEST VALUES!! */
double panelVoltage = 25.883;
double panelAmperage = 36.095;
double batteryVoltage = 25.996;
double batteryAmperage = 05.639;
double temperature = 89.352; 
double valArr[] = { panelVoltage, panelAmperage, batteryVoltage, batteryAmperage, temperature };

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
  
  // set output pins
  setOutputPins();
  initializeOutputPinStates();
  
  // set input pins
  setInputPins();
  initializeInputPinStates();
  
  // set up interrupts
  initializeInterrupts();
  
  // debug
  pinMode( ledPin, OUTPUT ); 
  digitalWrite( ledPin, LOW );
 
  // indicate to the user that we're starting up
  indicateInitialize( 3, 500 );
  
  /*
  PCICR |= (1 << PCIE1);
  PCMSK1 |= (1 << PCINT12);
  PCMSK1 |= (1 << PCINT13); 
  */
}

void loop()
{
  while( !isRun ) 
  {
    // huh ? 
    isRun = true;
  }
}

/*=====================================================================
  APPLICATION FUNCTIONS
  
  incomingCallISR() -- interrupt service routine for incoming calls
  indicateInitialize() -- debug output blinks indicating a process is starting
  initializeInputPinStates() -- initializes the state of the input pins
  initializeInterrupts() -- initializes external interrupts
  initializeOutputPinStates() -- initializes the state of the output pins
  initializeSerialPort() -- initializes all serial communication. 
  outputField() -- receives an int, outputs as keypresses 
  outputDataFrame() -- receives an array of values, outputs to cell phone
  setInputPins() -- sets pins as inputs
  setOutputPins() -- sets pins as outputs
  togglePin() -- pushes a single key
  
  =====================================================================
*/

/*=====================================================================
  incomingCallISR() -- interrupt service routine for incoming calls
*/
void incomingCallISR()
{
  noInterrupts();
  Serial.println("HEY BITCHES I'M HERE!");
  interrupts();
  outputDataFrame( valArr, 5 );
}

/*=====================================================================
  indicateInitialize() -- debug output blinks indicating a process is starting
*/
void indicateInitialize( int beats, int delay_period )
{
  for(int i = 0; i < beats; ++i ){
    digitalWrite( ledPin, HIGH );   // set the LED on
    delay( delay_period );          // wait
    digitalWrite( ledPin, LOW );    // set the LED off
    delay( delay_period );
  }
}

/*=====================================================================
  initializeInputPinStates() -- initializes the state of the input pins
*/
void initializeInputPinStates()
{
  digitalWrite( interruptPin, LOW );
}

/*=====================================================================
  initializeInterrupts() -- initializes external interrupts
*/
void initializeInterrupts()
{
  // external interrupt 0 on pin 2  
  attachInterrupt( interruptZero, incomingCallISR, CHANGE );
}

/*=====================================================================
  initializeOutputPinStates() -- initializes the state of the output pins
*/
void initializeOutputPinStates()
{
  // assert active-low signals HIGH -- disables buffers
  digitalWrite( THREE, HIGH );
  digitalWrite( SIX, HIGH );
  digitalWrite( NINE, HIGH );
  digitalWrite( POUND, HIGH );
  digitalWrite( TWO, HIGH );
  digitalWrite( FIVE, HIGH );
  digitalWrite( ZERO, HIGH );
  digitalWrite( EIGHT, HIGH );
  //digitalWrite( ONE, HIGH );
  //digitalWrite( FOUR, HIGH );
  //digitalWrite( SEVEN, HIGH );    
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
  outputDataFrame() -- receives an array of values, outputs to cell phone
*/
void outputDataFrame( double* valuesArray, int numVals )
{
  for(int i = 0; i < numVals; ++i )
  {
    togglePin( POUND ); // indicate initialize
    outputField( valuesArray[i] ); // test values!!
    indicateInitialize( 1, 100 );
  }
  togglePin( POUND ); // indicate finished
}

/*=====================================================================
  outputField() -- receives an int, outputs as keypresses
*/
void outputField( double num )
{ 
  // takes a positive number, outputs it to the keypad
  if( num > 0 ) // ensure positive range
  {
    // first, we convert from double to long, preserving
    // TWO decimal places by multiplying 10^2.
    unsigned long val = long( num * 100 );
    
    // figure out the size of num
    unsigned long temp = val;
    int digitCount = 0; 
    while ( temp > 0 )
    {
      digitCount += 1;
      temp = temp / 10; // chop off one digit at a time
    }
    
    // break the number into an array of digits
    if( digitCount > 0 ) 
    {
      int digit;
      int i = digitCount - 1 ; // start at the end of the array
      int buffer[ digitCount ];
      while( val > 0 ) 
      {
        digit = val % 10; // grab the one's place
        buffer[ i-- ] = digit; // store the digit in the array
        val = val / 10; // chop off the one's place.
      } 
      
      // output the value to the keypad
      for( i = 0; i < digitCount; ++i )
      { 
        int decimalVal = buffer[ i ];
        togglePin( decimalArray[ decimalVal ] );
        Serial.print( decimalVal );
      }
    }
  }  
}

/*=====================================================================
  setInputPins() -- sets pins as inputs
*/
void setInputPins()
{
  // assert pins as inputs
  pinMode( interruptPin, INPUT ); 
}

/*=====================================================================
  setOutputPins() -- sets pins as outputs
*/
void setOutputPins()
{
  // assert pins as outpus
  pinMode( THREE, OUTPUT );
  pinMode( SIX, OUTPUT );
  pinMode( NINE, OUTPUT );
  pinMode( POUND, OUTPUT );
  pinMode( TWO, OUTPUT );
  pinMode( FIVE, OUTPUT );
  pinMode( EIGHT, OUTPUT );
  pinMode( ZERO, OUTPUT );
  //pinMode( ONE, OUTPUT );
  //pinMode( FOUR, OUTPUT );
  //pinMode( SEVEN, OUTPUT );
  //pinMode( STAR, OUTPUT ); 
}

/*=====================================================================
  togglePin() -- pushes a single key
*/
void togglePin( int pin )
{
  digitalWrite( pin, LOW );   // assert pin low
  delay( 150 );               // time required for gate delay / pin debouncing
  digitalWrite( pin, HIGH );  // reassert pin high
  delay( 150 );               // time required for gate delay / pin debouncing 
}

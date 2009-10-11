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

/*
  These are the pin assignments for the buffer enables.
  Note, these correspond to the hardware arrangement of the chips,
  so ONE != 1, necessarily. It's the number of the pin that controls
  the enable attached to the buffer that presses the actual button. 
*/
#include "WProgram.h"
void setup();
void loop();
void toggle_pin( int pin );
void indicateInitialize( int beats, int delay_period );
void enterField();
int ZERO = 9; 
//int ONE = ;
int TWO = 6; 
int THREE = 2;
//int FOUR = ;
int FIVE = 7; 
int SIX = 3;
//int SEVEN = ;
int EIGHT = 8; 
int NINE = 4;
int POUND = 5;
//int STAR = ;

int ledPin = 13;
boolean isRun = false;

// setup runs once, intializes all outputs to HIGH
void setup() 
{ 
 // assert pins as OUTPUTs
 pinMode( ZERO, OUTPUT );
 //pinMode( ONE, OUTPUT );
 pinMode( TWO, OUTPUT );
 pinMode( THREE, OUTPUT );
 //pinMode( FOUR, OUTPUT );
 pinMode( FIVE, OUTPUT );
 pinMode( SIX, OUTPUT );
 //pinMode( SEVEN, OUTPUT );
 pinMode( EIGHT, OUTPUT );
 pinMode( NINE, OUTPUT );
 pinMode( POUND, OUTPUT );
 //pinMode( STAR, OUTPUT );
 pinMode( ledPin, OUTPUT ); 
 
 // assert active-low signals HIGH -- disables buffers
 digitalWrite( ZERO, HIGH );
 //digitalWrite( ONE, HIGH );
 digitalWrite( TWO, HIGH );
 digitalWrite( THREE, HIGH );
 //digitalWrite( FOUR, HIGH );
 digitalWrite( FIVE, HIGH );
 digitalWrite( SIX, HIGH );
 //digitalWrite( SEVEN, HIGH );
 digitalWrite( EIGHT, HIGH );
 digitalWrite( NINE, HIGH );
 digitalWrite( POUND, HIGH );
 
 digitalWrite( ledPin, LOW );
 
 // indicate to the user that we're starting up
 indicateInitialize( 3, 500 );

}

// loop runs forever
void loop()
{
  while( !isRun ) 
  {
    for(int i = 0; i < 2; ++i )
    {
      toggle_pin( POUND );
      enterField();
      toggle_pin( POUND );
      indicateInitialize( 1, 100 );
    }
    isRun = true;
  }
}

void toggle_pin( int pin )
{
  digitalWrite( pin, LOW ); // assert pin low
  delay( 150 );
  digitalWrite( pin, HIGH ); // reassert pin high
}

void indicateInitialize( int beats, int delay_period )
{
  for(int i = 0; i < beats; ++i ){
    digitalWrite( ledPin, HIGH );   // set the LED on
    delay( delay_period );          // wait
    digitalWrite( ledPin, LOW );    // set the LED off
    delay( delay_period );
  }
}

void enterField()
{
   toggle_pin( THREE ); 
   toggle_pin( THREE ); 
   toggle_pin( THREE ); 
  
   toggle_pin( TWO );
   toggle_pin( FIVE );
   toggle_pin( EIGHT );
   toggle_pin( THREE );
   toggle_pin( SIX );
   toggle_pin( NINE );
   toggle_pin( ZERO ); 
   toggle_pin( TWO );
   toggle_pin( FIVE );
   toggle_pin( EIGHT );
   toggle_pin( THREE );
   toggle_pin( SIX );
   toggle_pin( NINE );
   
}




int main(void)
{
	init();

	setup();
    
	for (;;)
		loop();
        
	return 0;
}


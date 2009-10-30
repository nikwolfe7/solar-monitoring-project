
int ledPin =  13;    // LED connected to digital pin 13
boolean blinkNow = false;

// The setup() method runs once, when the sketch starts

void setup()   {                
  // initialize the digital pin as an output:
  pinMode(ledPin, OUTPUT);   
  digitalWrite( ledPin, LOW );  
  pinMode( 2, INPUT );
  attachInterrupt( 0, hello, CHANGE );
}

// the loop() method runs over and over again,
// as long as the Arduino has power

void loop()                     
{
  if( blinkNow )
  {
    doBlinkNow();
    blinkNow = false;
  }
}

void doBlinkNow()
{
  for( int i = 0; i < 5; ++i )
    {
      digitalWrite( ledPin, HIGH );
      delay( 500 );
      digitalWrite( ledPin, LOW );
      delay( 500 );  
    }
}

void hello() 
{    
   blinkNow = true;
}

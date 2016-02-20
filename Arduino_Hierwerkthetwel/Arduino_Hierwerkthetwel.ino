 int buttonleftPin = 3; 
int buttonrightPin = 4;


void setup () 
{
    Serial.begin(9600);
   
    pinMode(buttonleftPin, INPUT); 
    pinMode(buttonrightPin, INPUT); 
   
    digitalWrite(buttonleftPin,LOW); 
    digitalWrite(buttonrightPin,LOW);
}

void loop ()
{
    // LEFT Button 
    if (digitalRead (buttonleftPin)== HIGH)
    {
        Serial.write(1);
        Serial.println("left");
        delay(10);  
    }  
    
    
    // Right button 
    else if (digitalRead (buttonrightPin) == HIGH)
    {
        Serial.write(2);
        Serial.println("right");
        delay(10);  
    }
}

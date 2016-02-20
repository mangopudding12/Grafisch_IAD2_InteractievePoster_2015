 
const int vacht1 = 5;
const int vacht2 = 6;
const int vacht3 = 7;
const int vacht4 = 8;

const int motionsensor = 9; 
int signaalfase = 0; 
int signaalvacht = 0; 

void setup() 
{
  Serial.begin(9600);
  pinMode(vacht1, INPUT); 
  pinMode(vacht2, INPUT);  
  pinMode(vacht3, INPUT); 
  pinMode(vacht4, INPUT);  
}


void loop() 
{ 
        if (digitalRead (motionsensor) == HIGH)
        { 
            // 1 keer hoog signaal naar processing
            if (signaalfase == 0)
            {
              Serial.write(1);
              delay(10);
              Serial.write(0);
              signaalfase = 1;
               
            }
        }  else { 
            signaalfase = 0; 
        }
        
    
    
    
      if (digitalRead (vacht1)== HIGH)
      {
          if (signaalvacht == 0 || signaalvacht == 2 || signaalvacht == 3 || signaalvacht == 4)
          {
            Serial.write(2);
            Serial.println("geluid afspelen 1");
            delay(10);
            Serial.write(10);
            signaalvacht = 1; 
            delay(1000);
          }
      }  
      else if (digitalRead (vacht2) == HIGH)
      {
          if (signaalvacht == 0  || signaalvacht == 1 || signaalvacht == 3 || signaalvacht == 4)
          {
            Serial.write(3);
            delay(10);  
            Serial.write(10);
            Serial.println("geluid afspelen 2");
            signaalvacht = 2; 
            delay(1000);
          }
      } 
      else if (digitalRead (vacht3) == HIGH)
      {
          if (signaalvacht == 0  || signaalvacht == 1 || signaalvacht == 2 || signaalvacht == 4)
          {
            Serial.write(4);
            delay(10);  
            Serial.write(10);
            Serial.println("geluid afspelen 3");
            signaalvacht = 3; 
            delay(1000);
          }
      }
      else if (digitalRead (vacht4) == HIGH)
      {
          if (signaalvacht == 0  || signaalvacht == 1 || signaalvacht == 2 || signaalvacht == 3)
          {
            Serial.write(5);
            delay(10);  
            Serial.write(10);
            Serial.println("geluid afspelen 4");
            signaalvacht = 4; 
            delay(1000);
          }
      }
      else { 
          signaalvacht = 0;
          //Serial.println("geluid reset");
      }
    

}

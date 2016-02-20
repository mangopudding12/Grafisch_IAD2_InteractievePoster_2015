const int vacht2 = 6; 
const int vacht1 = 5;
const int motionsensor = 9; 
int signaalfase = 0; 
int signaalvacht = 0; 

void setup() 
{
  Serial.begin(9600);
  pinMode(vacht1, INPUT); 
  pinMode(vacht2, INPUT);   
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
          if (signaalvacht == 0 || signaalvacht == 2)
          {
            Serial.write(2);
            delay(10);
            Serial.write(10);
            //Serial.println("geluid afspelen 1");
            signaalvacht = 1; 
          }
      }  
      else if (digitalRead (vacht2) == HIGH)
      {
          if (signaalvacht == 0  || signaalvacht == 1)
          {
            Serial.write(3);
            delay(10);  
            Serial.write(10);
            //Serial.println("geluid afspelen 2");
            signaalvacht = 2; 
          }
      }
      else { 
          signaalvacht = 0;
          //Serial.println("geluid reset");
      }
    

}

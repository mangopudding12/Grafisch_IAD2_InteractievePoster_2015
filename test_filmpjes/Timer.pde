 class Timer 
 {
   int eindtijd; 
   long savetime; 
   long passedtime; 
   boolean klaar = false; 
   
   // Constructor 
   Timer (int eindtijd_) 
   {
       eindtijd = eindtijd_; 
   }
   
   void starttijd() 
   { 
       savetime = millis(); 
   }
   
   void tikking() 
   { 
       passedtime = millis() - savetime;
       
   }
 }

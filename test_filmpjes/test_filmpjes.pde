
// Marijn hier te do lijstje. 
// * 4 vacht aanraak plekken maken 
// * code schrijven voor knor 3 & knor 4 
// * Zorgen dat processing ook reageer als je aai plek 3 & 4 aait 


import processing.video.*;
import ddf.minim.*;
import processing.serial.*; 

// Serial communication
Serial USBpoort; 
int DataUSB; 

// Geluid 
Minim minum; 
AudioPlayer miauw; 
AudioPlayer knor1;
AudioPlayer knor2; 
AudioPlayer knor3;
AudioPlayer knor4; 

// Declaring the movies. 
Movie wachten_tot_interactie;
Movie iemandloopt_langs;
Movie vacht_1geaaid; 
Movie vacht_2geaaid; 
Movie vacht_3geaaid; 
Movie vacht_4geaaid; 
Movie boodschap; 

// Timer aanmaken 
Timer tijd; 
boolean timer;
boolean Timerstart; // aanzetten / resetten van timer  
int Timerfase; 

// Organisatie code 
int muziekfase = 0; 
int hoevaakvachtgeaaid = 0; 

// Filmpjes booleans
boolean wachtentotinteractie = false;
boolean erisiemand = false; 
boolean vacht1geaaid = false; 
boolean vacht2geaaid = false; 
boolean vacht3geaaid = false; 
boolean vacht4geaaid = false; 
boolean boodschapp = false;

  void setup () 
  {
     // displayWidth= 1600 & displayHeight = 900
       size (displayWidth, displayHeight); 
     
     // Load the movies that stands in data folder. 
       wachten_tot_interactie = new Movie(this, "wachten_tot_interactie.mp4"); 
       iemandloopt_langs = new Movie(this,"iemandloopt_langs.mp4");
       vacht_1geaaid = new Movie(this,"aai_vacht1.mp4");
       vacht_2geaaid = new Movie(this,"aai_vacht2.mp4"); // hier moet vacht 2 nog in te komen te staan.
       vacht_3geaaid = new Movie(this,"aai_vacht1.mp4"); // zelfde animatie als vacht 1
       vacht_4geaaid = new Movie(this,"aai_vacht2.mp4"); // zelfde animatie als vacht 2
       boodschap = new Movie(this,"boodschap.mp4"); // hier moet boodschap verrandering filmpje te staan.
    
     
     // Arduino stuff     
       String PortName = Serial.list()[1]; 
       USBpoort = new Serial(this,PortName,9600);
       
     // Geluid stuff 
       minum =  new Minim(this); 
       miauw = minum.loadFile("miauw.mp3");
       knor1 = minum.loadFile("knor1.mp3");
       knor2 = minum.loadFile("knor2.mp3");
       knor3 = minum.loadFile("knor3.mp3");
       knor4 = minum.loadFile("knor4.mp3");
       
       
     // Timer hoeveelheid
       tijd = new Timer(8000); // 8 seconden 
  }
  
  
  void draw() 
  {
       // Arduino signalen ontvangen 
       if (USBpoort.available() > 0)
       {
             DataUSB = USBpoort.read();
       } 
//DataUSB = 0;    
    
       // wachten tot interactie
       if (DataUSB == 0)
       {     
               // Als het knor geluid niet speelt && miauw geluid && filmpje erisiemand is klaar dan ... 
               if(!knor1.isPlaying() && !knor1.isPlaying() && !knor3.isPlaying() && !knor4.isPlaying() && !miauw.isPlaying() && erisiemand == false && vacht1geaaid == false)
               {
                    wachtentotinteractie = true; // speel filmpje wachten tot interactie af.
                    muziekfase = 0; // nu kan geluid gereset worden
               }
       } 
       else if (DataUSB == 1)
       { // iemand loopt langs --> voor paar seconden hoog
       
          if (timer == false)
           {
                 // reset geluid 
                 if (muziekfase == 0)
                 {
                     hoevaakvachtgeaaid = 0; // reset boodschapp krijgen -> wat wanneer de kat gaat miauwen betekent dat bezoeker weg is gegaan.
                     wachtentotinteractie = false; 
                     erisiemand = true; // erisiemand animatie aan 
                     miauw.rewind();
                     muziekfase = 1;
                 }
                 miauw.play();
           }
           
       }
       
       else if (DataUSB == 2)
       { // vacht 1 wordt geaaid
             timer = true; 
             miauw.pause(); 
                  
           if (muziekfase == 0 && !knor1.isPlaying() && !knor2.isPlaying()&& !knor3.isPlaying() && !knor4.isPlaying())
           {
              knor1.rewind();
              wachtentotinteractie = false;
              erisiemand = false;
              
              if (vacht1geaaid == false && vacht2geaaid == false && vacht3geaaid == false  && vacht4geaaid == false && boodschapp == false) // wanneer er geen animatie af spelen
              { // wordt er 1 opgeteld anders zou je in 1 animatie er 2 bij krijgen --> mis je herhaling booschap.
                hoevaakvachtgeaaid += 1; 
              }
             
                if (hoevaakvachtgeaaid < 3)
                {
                    vacht1geaaid = true;
                } else if (hoevaakvachtgeaaid >= 3 && hoevaakvachtgeaaid <=4){
                    vacht1geaaid = false;
                    boodschapp = true;
                } else { 
                    hoevaakvachtgeaaid = 0; // reset ---> reset testen !!! Ga kijken of het wel werkt !!! !!! Hier moet je wezen
                    vacht1geaaid = true;
                }
              muziekfase = 1;  
              knor1.play();  
           }

           
       }
       
       else if (DataUSB == 3)
       { // vacht 2 wordt geaaid
           timer = true; 
           miauw.pause(); 
             
       
           if (muziekfase == 0 && !knor2.isPlaying() && !knor1.isPlaying() && !knor3.isPlaying() && !knor4.isPlaying() )
           {
              knor2.rewind();
              wachtentotinteractie = false;
              erisiemand = false;
              
              if (vacht1geaaid == false && vacht2geaaid == false && vacht3geaaid == false  && vacht4geaaid == false && boodschapp == false) // wanneer er geen animatie af spelen
              { // wordt er 1 opgeteld anders zou je in 1 animatie er 2 bij krijgen --> mis je herhaling booschap.
                hoevaakvachtgeaaid += 1; 
              }
              
                if (hoevaakvachtgeaaid < 3)
                {
                    vacht2geaaid = true;
                } else if (hoevaakvachtgeaaid >= 3 && hoevaakvachtgeaaid <=4){
                    vacht2geaaid = false;
                    boodschapp = true;
                } else { 
                    hoevaakvachtgeaaid = 0; // reset ---> reset testen !!! Ga kijken of het wel werkt !!! !!! Hier moet je wezen
                    vacht2geaaid = true;
                }
              muziekfase = 2;  
              knor2.play(); 
           }
       }
       else if (DataUSB == 4)
       { // vacht 3 wordt geaaid
             timer = true; 
             miauw.pause(); 
             
             
           if (muziekfase == 0 && !knor2.isPlaying() && !knor1.isPlaying() && !knor3.isPlaying() && !knor4.isPlaying())
           {
              knor3.rewind();
              wachtentotinteractie = false;
              erisiemand = false;
              
              if (vacht1geaaid == false && vacht2geaaid == false && vacht3geaaid == false  && vacht4geaaid == false && boodschapp == false) // wanneer er geen animatie af spelen
              { // wordt er 1 opgeteld anders zou je in 1 animatie er 2 bij krijgen --> mis je herhaling booschap.
                hoevaakvachtgeaaid += 1; 
              }
              
                if (hoevaakvachtgeaaid < 3)
                {
                    vacht3geaaid = true;
                } else if (hoevaakvachtgeaaid >= 3 && hoevaakvachtgeaaid <=4){
                    vacht3geaaid = false;
                    boodschapp = true;
                } else { 
                    hoevaakvachtgeaaid = 0; // reset ---> reset testen !!! Ga kijken of het wel werkt !!! !!! Hier moet je wezen
                    vacht3geaaid = true;
                }
              muziekfase = 2;  
              knor3.play(); 
           }
       }
        else if (DataUSB == 5)
       { // vacht 4 wordt geaaid
             timer = true; 
             miauw.pause(); 
             
           
           if (muziekfase == 0 && !knor2.isPlaying() && !knor1.isPlaying() && !knor3.isPlaying() && !knor4.isPlaying())
           {
              knor4.rewind();
              wachtentotinteractie = false;
              erisiemand = false;
              
              if (vacht1geaaid == false && vacht2geaaid == false && vacht3geaaid == false  && vacht4geaaid == false && boodschapp == false) // wanneer er geen animatie af spelen
              { // wordt er 1 opgeteld anders zou je in 1 animatie er 2 bij krijgen --> mis je herhaling booschap.
                hoevaakvachtgeaaid += 1; 
              }
              
                if (hoevaakvachtgeaaid < 3)
                {
                    vacht4geaaid = true;
                } else if (hoevaakvachtgeaaid >= 3 && hoevaakvachtgeaaid <=4){
                    vacht4geaaid = false;
                    boodschapp = true;
                } else { 
                    hoevaakvachtgeaaid = 0; // reset ---> reset testen !!! Ga kijken of het wel werkt !!! !!! Hier moet je wezen
                    vacht4geaaid = true;
                }
              muziekfase = 2;  
              knor4.play(); 
           }
       }
       else if (DataUSB == 10)
       {
         
           muziekfase = 0;
           miauw.pause();
       }
       
      
   
   
   
   
   
   
   
   
   
   
   
   
   
   // ......... Filmpje erisiemand ............
       if (erisiemand == true) 
       {
           iemandloopt_langs.play();
           iemandloopt_langs.loop();
         
             if (iemandloopt_langs.available() ) 
             {
                 iemandloopt_langs.read();         
             }  
          
             image(iemandloopt_langs,0,0,displayWidth+300, displayHeight);
             
           // Als het filmpje is afgelopen en het miauwen is klaar 
           if (iemandloopt_langs.time() >= iemandloopt_langs.duration()-0.08 && !miauw.isPlaying())
           {
               erisiemand = false; // Maak hem false
           }
         
       } else { 
                iemandloopt_langs.stop();
                iemandloopt_langs.jump(0.0);
       }
   
   
   // ............... Filmpje wachten tot interactie ......................
     if(wachtentotinteractie == true)
     {
         wachten_tot_interactie.play(); 
         wachten_tot_interactie.loop();
        
           if ( wachten_tot_interactie.available()) 
           {
                wachten_tot_interactie.read();         
           }
          
         image( wachten_tot_interactie,0,0,displayWidth+300, displayHeight);
         
     } else { 
         wachten_tot_interactie.stop(); 
         wachten_tot_interactie.jump(0.0);
     }
   
   
   // ................. Filmpje vacht 1 geaaid ........................
       if (vacht1geaaid== true) 
       {
           vacht_1geaaid.play(); 
           vacht_1geaaid.loop();
        
            if ( vacht_1geaaid.available()) 
            {
                vacht_1geaaid.read();         
            }
          
          image(vacht_1geaaid,0,0,displayWidth+300, displayHeight);
          
          // Als het filmpje is afgelopen en het miauwen is klaar 
           if (vacht_1geaaid.time() >= vacht_1geaaid.duration()-0.15 && !knor1.isPlaying())
           { 
              wachten_tot_interactie.jump(0.0);
              DataUSB = 0; // Zet terug in de standaard fase --> wachten tot interactie
              Timerstart = true; 
              vacht1geaaid = false; // Maak hem false
           } else { 
              Timerstart = false; 
           }
         
       } else { 
           vacht_1geaaid.stop(); 
           vacht_1geaaid.jump(0.0);
       }
   
   
   
   // ................. Filmpje vacht 2 geaaid ........................
       if (vacht2geaaid== true) 
       {
           vacht_2geaaid.play(); // alles moet nog vacht 2 worden !!! --> animatie bestaat nog niet.
           vacht_2geaaid.loop();
        
            if ( vacht_2geaaid.available()) 
            {
                vacht_2geaaid.read();         
            }
          
          image(vacht_2geaaid,0,0,displayWidth+300, displayHeight);
          
          // Als het filmpje is afgelopen en het miauwen is klaar 
           if (vacht_2geaaid.time() >= vacht_2geaaid.duration()-0.15 && !knor2.isPlaying())
           {
              wachten_tot_interactie.jump(0.0);
              DataUSB = 0; // Zet terug in de standaard fase --> wachten tot interactie
              Timerstart = true; 
              vacht2geaaid = false; // Maak hem false
           } else { 
              Timerstart = false; 
           }
         
       } else { 
           vacht_2geaaid.stop(); 
           vacht_2geaaid.jump(0.0);
       }
   
   
   // ................. Filmpje vacht 3 geaaid ........................
       if (vacht3geaaid== true) 
       {
           vacht_3geaaid.play(); 
           vacht_3geaaid.loop();
        
            if (vacht_3geaaid.available()) 
            {
                vacht_3geaaid.read();         
            }
          
          image(vacht_3geaaid,0,0,displayWidth+300, displayHeight);
          
           // Als het filmpje is afgelopen en het miauwen is klaar 
           if (vacht_3geaaid.time() >= vacht_3geaaid.duration()-0.15 && !knor3.isPlaying())
           {
              wachten_tot_interactie.jump(0.0);
              DataUSB = 0; // Zet terug in de standaard fase --> wachten tot interactie
              Timerstart = true; 
              vacht3geaaid = false; // Maak hem false
           } else { 
              Timerstart = false; 
           }
           
       } else { 
           vacht_3geaaid.stop(); 
           vacht_3geaaid.jump(0.0);
       }
       
   // ................. Filmpje vacht 4 geaaid ........................
       if (vacht4geaaid== true) 
       {
           vacht_4geaaid.play(); 
           vacht_4geaaid.loop();
        
            if (vacht_4geaaid.available()) 
            {
                vacht_4geaaid.read();         
            }
          
          image(vacht_4geaaid,0,0,displayWidth+300, displayHeight);
          
           // Als het filmpje is afgelopen en het miauwen is klaar 
           if (vacht_4geaaid.time() >= vacht_4geaaid.duration()-0.15 && !knor4.isPlaying())
           {
              wachten_tot_interactie.jump(0.0);
              DataUSB = 0; // Zet terug in de standaard fase --> wachten tot interactie
              Timerstart = true; 
              vacht4geaaid = false; // Maak hem false
           } else { 
              Timerstart = false; 
           }
          
       } else { 
           vacht_4geaaid.stop(); 
           vacht_4geaaid.jump(0.0);
       }
   
   
    // ................. Filmpje boodschap ........................
       if (boodschapp == true) 
       {
           boodschap.play(); 
           boodschap.loop();
        
            if ( boodschap.available()) 
            {
                boodschap.read();         
            }
          
          image(boodschap,0,0,displayWidth+300, displayHeight);
          
          // Als het filmpje is afgelopen en het miauwen is klaar 
           if (boodschap.time() >= boodschap.duration()-0.15 && !knor1.isPlaying()&& !knor2.isPlaying()&& !knor3.isPlaying()&& !knor4.isPlaying())
           {
              wachten_tot_interactie.jump(0.0);
              DataUSB = 0; // Zet terug in de standaard fase --> wachten tot interactie  
              Timerstart = true;  
              boodschapp = false; // Maak hem false
           } else {
                Timerstart = false; 
           }
           
       } else { 
           boodschap.stop(); 
           boodschap.jump(0.0);
       }
   
   
   // Deze staat buiten de state if statement omdat die moet door gaan ook al is het niet meer de juiste state
   if (Timerstart == true)
   {
       if (Timerfase == 0)
       {
             tijd.starttijd(); // save start tijd timer 
             timer = true;     // timer loopt is true
             miauw.pause();    // stop miauwen
             Timerfase = 1; 
       }     
     
        tijd.tikking();
        println(tijd.passedtime);
        
           if (tijd.passedtime >= tijd.eindtijd)
           {
               timer = false; // kat gaat miauwen als je langs loopt
               Timerstart = false; 
               
           } else { 
               timer = true; // Kat gaat niet miauwen als je langs loopt
           }
   } else {
          Timerfase = 0; // reset timer
   }
  
   
 } // end draw 

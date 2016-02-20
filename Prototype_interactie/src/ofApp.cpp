#include "ofApp.h"


//--------------------------------------------------------------
void ofApp::setup()
{
	// Arduino stuff
	ofAddListener(Arduino.EInitialized, this, &ofApp::setupArduino); 
    arduino_opstarten = false; 
 	Arduino.connect("COM3", 57600); 
	Arduino.sendFirmwareVersionRequest(); 

	// Sensors & button 
	ikzie_mens = false; 
	startplaying_miauw = false; 
	startplaying_kzacht = false; 
	startplaying_khard = false; 

	// Geluid
	miauw.loadSound("schattig_miauw_korter1.mp3");
	knor1.loadSound("lief_knor1.mp3");
	hardknor2.loadSound("hard_knor1.mp3"); 
	
	// Timer 
	fase = 0; 
	tijd.passedTime = 11;
	tijd.eindtijd = 10; 
}


//-------------------------------------------------------------
void ofApp::setupArduino(const int& version) 
{
	// Arduino opstarten 
	ofRemoveListener(Arduino.EInitialized, this, &ofApp::setupArduino);
	arduino_opstarten = true; 


		// motion detection 
		Arduino.sendAnalogPinReporting(0, ARD_ANALOG);

		// digitale knoppen
		Arduino.sendDigitalPinMode(3,ARD_INPUT); 
		Arduino.sendDigitalPinMode(4,ARD_INPUT); 

		


	 // Lisenaars voor de arduino poorten 
	ofAddListener(Arduino.EAnalogPinChanged, this, &ofApp::analogPinChanged);
	ofAddListener(Arduino.EDigitalPinChanged, this, &ofApp::digitalPinChanged);
}


//--------------------------------------------------------------
void ofApp::update()
{
	Arduino.update();
	

	// ........ Geluids afdeleing .......

		// Wanneer de bool true is en wanneer de file niet aan het spelen is -------> speel de file af
		if (startplaying_miauw == true && !miauw.getIsPlaying() && !knor1.getIsPlaying() && !hardknor2.getIsPlaying())
		{
			miauw.play(); 
			cout << "play muziek !!!!!!!!!!!!!!!!!!" << endl;
			startplaying_miauw = false; 
		}




		if (startplaying_kzacht == true && !knor1.getIsPlaying() )
		{
			miauw.setPaused(true); 

			knor1.play(); 
			startplaying_kzacht = false; 
			cout << "knor1" << endl;
		} else if (startplaying_khard == true && !hardknor2.getIsPlaying()){
			miauw.setPaused(true);
			
			hardknor2.play(); 
			startplaying_khard = false; 
			cout << "knor22222222222222222222222222" << endl;
		} else {
			
			if (fase == 1  && !hardknor2.getIsPlaying() && !knor1.getIsPlaying())
			{
				tijd.start(5000); // start timer 
				fase = 2; // zogt ervoor dat maar 1 keer wordt uitgevoerd
			} else if (fase == 2) {
				cout << "Tijd voorbij" << tijd.passedTime << endl; 
				tijd.tikking(); 
			}
		}

}


//-------------------------------------------------------------
void ofApp:: analogPinChanged(const int & pinNum)
{

	// Geluids part 
		// Speel het geluid al als er beweging wordt gezien in de ruimte
		// Wacht tot geluid afgelopen is
		// Kijk daarna weer of er beweging is in de ruimte
	if (tijd.passedTime > tijd.eindtijd && !knor1.getIsPlaying() && !hardknor2.getIsPlaying())
	{
			miauw.setPaused(false); 
			

			if (startplaying_miauw == false && !miauw.getIsPlaying())
			{
				motionsensor = Arduino.getAnalog(0);
				cout << "Detecting"  << motionsensor << endl; 

				if (motionsensor > 500)
				{
					startplaying_miauw = true; 
				}
			} 
	}
}


//-------------------------------------------------------------
void ofApp:: digitalPinChanged(const int & pinNum)
{


		if (Arduino.getDigital(3) == 1 && !knor1.getIsPlaying() )
		{

			if (startplaying_khard == false && !hardknor2.getIsPlaying() )
			{
				startplaying_kzacht = true; 
				cout << " activeer knor 1 "<< endl;
				fase = 1; 
			}
		} 
		
		else if (Arduino.getDigital(4) == 1 && !hardknor2.getIsPlaying() )
		{
		
			if (startplaying_kzacht == false && !knor1.getIsPlaying() )
			{	
				startplaying_khard = true; 
				cout << " activeer knor 222222222222222 "<< endl;
				fase = 1; 
			}
		}


}


//-------------------------------------------------------------
void ofApp:: draw() 
{
	
}







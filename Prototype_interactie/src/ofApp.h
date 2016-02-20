#pragma once

#include "ofMain.h"
#include "Timer.h"


class ofApp : public ofBaseApp{

	public:
		void setup();
		void update();
		void draw(); 

			// Arduino stuff
			bool arduino_opstarten; 
			ofArduino Arduino; 

			float motionsensor; 
			bool ikzie_mens; 

			// Geluid stuff
			ofSoundPlayer miauw; 
			bool startplaying_miauw; 

			ofSoundPlayer knor1; 
			bool startplaying_kzacht; 
			int zachtknorren; 

			ofSoundPlayer hardknor2; 
			bool startplaying_khard;
			int hardknorren; 

			// Timer 
			Timer tijd;
			int fase; 

	private: 
		void setupArduino(const int & version); 
 		void analogPinChanged(const int & pinNum); 
		void digitalPinChanged(const int & pinNum); 		
};

#pragma once 
#include "ofMain.h"

class Timer 
{
public: 
	Timer(); 

	void start(int eindtijd_);
	void tikking(); 

	// variable 
	float savetime; 
	float passedTime;
	int eindtijd; 

	// boolean 
	bool klaar; 
private: 


}; 
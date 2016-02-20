#include "Timer.h"

Timer :: Timer () 
{

}

void Timer :: start (int eindtijd_) 
{ 
	savetime = ofGetElapsedTimeMillis(); 
	eindtijd = eindtijd_;
} 


void Timer :: tikking () 
{ 
	passedTime = ofGetElapsedTimeMillis() - savetime;				
} 


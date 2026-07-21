/**
* Main program of Model Viewer.
* Model Viewer for Spatial Strucutures. 
*
* Bachelor's Thesis
* Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
* Student: Samuel Gajdoš
* Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
* VUT FIT 2021
*/

/**
* Program imports
*/
import controlP5.*;      // GUI library
import g4p_controls.*;   // GUI library
import peasy.*;          // Camera library


/**
* GLOBAL VARIABLES
*/
Model model;  // Main object for displaying the model


/**
* Initialize main objects and the display for the program.
*/
void setup() {
  size(1200, 900, P2D);
  surface.setTitle("Model Viewer"); 
  createGUI();
  model = new Model(this); 
}

/**
* Draw componets of the program and display the model. Average speed is 60 FPS.
*/
void draw() {  
  background(224);
  model.draw();
}

  

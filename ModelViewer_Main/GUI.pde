/**
* Setting up the UI componets (buttons, sliders etc.)
* Model Viewer for Spatial Strucutures. 
*
* Bachelor's Thesis
* Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
* Student: Samuel Gajdoš
* Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
* VUT FIT 2021
*/

/**
* GLOBAL VARIABLES For GUI
*/
ControlP5 controlP5;    // Control object for GUI components
float X_SHIFT = 0;
float Y_SHIFT = 0;
float Z_SHIFT = 0;

/**
* Create the UI components. A Button, Sliders, Togglers.
*
* Source: https://www.kasperkamperman.com/blog/processing-code/controlp5-library-example2/
* Author: Kasper Kamperman
* Contact: https://www.kasperkamperman.com/contact-me/
*/
void createGUI() {
  
  // change the default font to Verdana
  PFont p = createFont("Verdana",21); 
  ControlFont font = new ControlFont(p);
  

  controlP5 = new ControlP5(this);
  controlP5.setFont(font);
  
  controlP5.addSlider("X SHIFT")
  .setRange(-300,300)
  .setValue(0)
  .setPosition(910,20)
  .setSize(200,50)
  .setColorLabel(0x0);
  
  controlP5.addSlider("Y SHIFT")
  .setRange(-300,300)
  .setValue(0)
  .setPosition(910,80)
  .setSize(200,50)
  .setColorLabel(0x0);
  
  controlP5.addSlider("Z SHIFT")
  .setRange(-300,300)
  .setValue(0)
  .setPosition(910,140)
  .setSize(200,50)
  .setColorLabel(0x0);
  
  controlP5.addToggle("TOGGLE AXIS")
  .setValue(true)
  .setPosition(910,210)
  .setSize(30,30)
  .setColorLabel(0x0);
 
  controlP5.addToggle("TOGGLE NAMES")
  .setValue(true)
  .setPosition(910,280)
  .setSize(30,30)
  .setColorLabel(0x0);
  
  //controlP5.addToggle("TOGGLE RECTANGLE")
  //.setValue(true)
  //.setPosition(910,350)
  //.setSize(30,30); 
  
  controlP5.addButton("OPEN A MODEL")
  .setPosition(950,580)
  .setSize(200,70);   
}

/**
* Control changes and catch the Event of GUI components.
*
* Source: https://www.kasperkamperman.com/blog/processing-code/controlp5-library-example2/
* Author: Kasper Kamperman
* Contact: https://www.kasperkamperman.com/contact-me/
*/
void controlEvent(ControlEvent theEvent) {

  if(theEvent.getController().getName()=="OPEN A MODEL") {
    String fname;
    fname = G4P.selectInput("Select a Model File .mf", "mf", "Model files");
    
    model.openModel(fname);
  }
   
  if(theEvent.getController().getName()=="X SHIFT") {
    X_SHIFT = theEvent.getController().getValue();
  }
  
  if(theEvent.getController().getName()=="Y SHIFT") {
    Y_SHIFT = theEvent.getController().getValue();
  }
  
  if(theEvent.getController().getName()=="Z SHIFT") {
    Z_SHIFT = theEvent.getController().getValue();
  }
}

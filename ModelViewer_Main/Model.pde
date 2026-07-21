/**
* Model class for displaying Cardiovascular System of the Human Hand Finger model.
* Model Viewer for Spatial Strucutures. 
*
* Bachelor's Thesis
* Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
* Student: Samuel Gajdoš
* Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
* VUT FIT 2021
*/

class Model {

  GViewPeasyCam view;
  PeasyCam cam;
  PApplet theApplet;
  ArrayList<ModelNode> model_nodes;
  boolean model_ready = false;
  PFont f1;
  
  /**
  * Constructor.
  *
  * @param theApplet main window of the application
  */
  Model(PApplet theApplet) {
    
    f1 = createFont("Verdana", 154);
    this.view = new GViewPeasyCam(theApplet, 0, 0, 900, 900, 1000);
    this.cam = this.view.getPeasyCam();
    cam.setMinimumDistance(100);
    cam.setMaximumDistance(3000);
    this.theApplet = theApplet;
  
  }
  
  /**
  * Showing the x,y,z axis.
  *
  * @param camDist how far is camera from the [0,0,0] point
  * @param pg object for displaying 3D graphics
  */
  void showAxis(float camDist, PGraphics pg) {
  
    pg.strokeWeight(5);
    pg.stroke(240, 0, 0);
    pg.line(-camDist, 0, 0, camDist, 0, 0);
    pg.stroke(0, 240, 0);
    pg.line(0, -camDist, 0, 0, camDist, 0);
    pg.stroke(0, 0, 240);
    pg.line(0, 0, -camDist, 0, 0, camDist);
  }
  
  /**
  * Showing the names. On X axis, it is radial and ulnar. On Z axis, dorsal and palmar.
  *
  * @param camDist how far is camera from the [0,0,0] point
  * @param pg object for displaying 3D graphics
  */
  void showNames(float camDist, PGraphics pg) {
    
    pg.fill(0,0,0);
    pg.textFont(f1); 
    pg.textSize(camDist/25);
    
    pg.pushMatrix();
    pg.text("ulnar", camDist/3.5, -camDist/50, 0);    
    pg.text("radial", -camDist/3.5 - camDist/12, -camDist/50);
    pg.popMatrix();
    
    pg.pushMatrix();
    pg.rotateY(PI/2);
    pg.text("palmar", camDist/4, -camDist/50, 0);    
    pg.text("dorsal", -camDist/3.5 - camDist/12, -camDist/50);
    pg.popMatrix();
  }
  
  
  void showRectangle(PGraphics pg) {
  
   //pg.translate(width/2, height/2, 200);
   pg.pushMatrix();
   pg.strokeWeight(2);
   pg.stroke(255);
   pg.fill(51);
   pg.rectMode(CENTER);
   pg.rect(0, 0, 500, 1200); 
   pg.popMatrix();

  }
  
  
  /**
  * Loads a model from a file.
  *
  * @param fname full string of a location of the model file.
  */
  void openModel(String fname) {
      
    if (fname == null)
    {
      return;
    }
    
    if (fname.length() > 3) {
      if (!fname.substring(fname.length() - 3).equals(".mf")) {
        System.err.println("Selected file has bad suffix, it has to be '.mf'!");
        G4P.showMessage(theApplet, "Model file has to have a '.mf' suffix." , "Bad file name", G4P.ERROR_MESSAGE);
        return;
      }  
    } else {
      System.err.println("Selected file name is too short!");
      G4P.showMessage(theApplet, "File name is too short!" , "Bad file name", G4P.ERROR_MESSAGE);
      return;
    }
    
    
    String[] lines = loadStrings(fname);
    
    if (lines.length == 0) {
      println("Selected file is empty!");
      G4P.showMessage(theApplet, "Selected file is empty!" , "Empty file", G4P.WARN_MESSAGE);
      return;
    }
    
    // Array of ModelNodes
    model_nodes = new ArrayList<ModelNode>();
    
    // Parsing file
    String[] split_line;
    for (int i = 0 ; i < lines.length; i++) {
      
      split_line = lines[i].split(",");
    
      if (split_line.length != 7) {
        System.err.println("Incorrect number of params at line: " + String.format("%d", i+1) + ".");
        G4P.showMessage(theApplet, "Incorrect number of params at line: " + String.format("%d", i+1) + "." , "Bad file content", G4P.ERROR_MESSAGE);
        return;
      }
      
      PVector pos;
      PVector parent_pos;
      float size;
      
      try {
        
        pos = new PVector(Float.parseFloat(split_line[0]), Float.parseFloat(split_line[1]) - 200, Float.parseFloat(split_line[2]));
        parent_pos = new PVector(Float.parseFloat(split_line[3]), Float.parseFloat(split_line[4]) - 200, Float.parseFloat(split_line[5]));
        size = Float.parseFloat(split_line[6]);
      }
      catch(Exception e) {
        System.err.println("Incorrect param syntax at line: " + String.format("%d", i+1) + ".");
        G4P.showMessage(theApplet, "Incorrect param syntax at line: " + String.format("%d", i+1) + "." , "Bad file content", G4P.ERROR_MESSAGE);
        return;
      }
     
      ModelNode mn = new ModelNode(pos, parent_pos, size);
      model_nodes.add(mn);
    }
    
    surface.setTitle(fname);
    model_ready = true;
  }
  
  /**
  * Draw parts of the display. Average speed is 60 FPS.
  * Showing axis, names, cardiovascular parts of the model.
  */
  void draw() {
  
    PGraphics pg = view.getGraphics();
    cam = view.getPeasyCam();
    pg.beginDraw();
    pg.resetMatrix();
    
    cam.feed();
    pg.background(234);
    
    float camDist = (float) cam.getDistance(); 
    
    if (controlP5.getController("TOGGLE AXIS").getValue() == 1.0)
      this.showAxis(camDist, pg);
      
    if (controlP5.getController("TOGGLE NAMES").getValue() == 1.0)
      this.showNames(camDist, pg);
     
    //if (controlP5.getController("TOGGLE RECTANGLE").getValue() == 1.0)
    //  this.showRectangle(pg);
      
    if (model_ready) {
      
      for (ModelNode mn: model_nodes) {
        mn.show(pg);
      }
      
    }
     
    
    cam.beginHUD();
    cam.endHUD();
    
    
    pg.endDraw();
    
      if (keyPressed) {
    if (key == 's' || key == 'S') {
      saveFrame();
    }
    }
    
    
  }
}

/**
* Object for a single node (a line) of the Cardiovascular System of the Human Hand Finger model.
* Model Viewer for Spatial Strucutures. 
*
* Bachelor's Thesis
* Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
* Student: Samuel Gajdoš
* Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
* VUT FIT 2021
*/

class ModelNode {

  PVector pos;
  PVector parent_pos;
  float size;
  
  /**
  * Constructor.
  *
  * @param pos first position of the line of the node
  * @param parent_pos second position of the line of the node
  * @param size width of the line of the node
  */
  ModelNode(PVector pos, PVector parent_pos, float size) {
  
    this.pos = pos;
    this.parent_pos = parent_pos;
    this.size = size;  
  }
  
  /**
  * Show specific node(line) at its position and with specific size.
  * It is called from the model draw function.
  *
  * @param pg object for displaying 3D graphics
  */
  void show(PGraphics pg) {
    
    pg.strokeWeight(size);
    pg.stroke(0);
    pg.line(pos.x + X_SHIFT, pos.y - Y_SHIFT, pos.z - Z_SHIFT, parent_pos.x + X_SHIFT, parent_pos.y - Y_SHIFT, parent_pos.z - Z_SHIFT);
  }  
}

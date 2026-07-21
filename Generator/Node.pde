/**
 * Class for the vein Node (line).
 * Generator of the Spatial Structure.
 *
 * Bachelor's Thesis
 * Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
 * Student: Samuel Gajdoš
 * Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
 * VUT FIT 2021
 */

class Node {
  Node parent;
  ArrayList<Node> children = new ArrayList<Node>();
  PVector pos;
  PVector dir;
  int count = 0;
  PVector saveDir;
  float len = 3;
  float size = node_size;
  boolean tip = true;
  PVector nextDirCheck;
  
  /**
  * Constructor for a brand new Node.
  *
  * @param  v vector of positions of the node
  * @param  d vector of the direction of the node (line)
  *
  * Source: Coding Rainbow
  * Author: Daniel Shiffman
  * Link: http://patreon.com/codingtrain
  * For Video: https://youtu.be/JcopTKXt8L8
  */
  Node(PVector v, PVector d) {
    parent = null;
    pos = v.copy();
    dir = d.copy();
    saveDir = dir.copy();
  }

  /**
  * Constructor for an inherited Node.
  *
  * @param  p parent Node of the new Node.
  * 
  * Source: Coding Rainbow
  * Author: Daniel Shiffman
  * Link: http://patreon.com/codingtrain
  * For Video: https://youtu.be/JcopTKXt8L8
  */
  Node(Node p) {
    parent = p;
    pos = parent.next();
    dir = parent.dir.copy();
    saveDir = dir.copy();
  }

  /**
  * Reset of the Node. 
  * No Attractors attract the Node. Node earns previous direction.
  * 
  * Source: Coding Rainbow
  * Author: Daniel Shiffman
  * Link: http://patreon.com/codingtrain
  * For Video: https://youtu.be/JcopTKXt8L8
  */
  void reset() {
    count = 0;
    dir = saveDir.copy();
  }

  /**
  * Get a new position for the new Node.
  *
  * @return next position for the new node
  * 
  */
  PVector next() {
    this.tip = false;
    
    /**
    * get a new position for the node
    *
    * Source: Coding Rainbow
    * Author: Daniel Shiffman
    * Link: http://patreon.com/codingtrain
    * For Video: https://youtu.be/JcopTKXt8L8
    * Lines: 91-92
    */
    PVector nextDir = PVector.mult(this.dir, this.len);
    PVector nextPos = PVector.add(this.pos, nextDir);
    
    // If attractors are in an orthogonal angles, it might cause a neverending loop in the node generation.
    // Simple solution is to move the node a little bit, to make it more attracted to one specific attractor.
    if (this.nextDirCheck != null)
    {  
      if (nextDir.x == this.nextDirCheck.x)
      {
        print("same X\n");
        this.pos.x -= 10;
      }
      if (nextDir.y == this.nextDirCheck.y)
      {
        print("same Y\n");
        this.pos.y -= 10;
      }
      if (nextDir.z == this.nextDirCheck.z)
      {
        print("same Z\n");
        this.pos.z -= 10;
      }
    }
    this.nextDirCheck = nextDir;
    
    return nextPos;
  }
}

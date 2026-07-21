/**
 * The Tree class for creating a tree structure.
 * Generator of the Spatial Structure.
 *
 * Bachelor's Thesis
 * Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
 * Student: Samuel Gajdoš
 * Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
 * VUT FIT 2021
 */
 
class Tree {
  ArrayList<Attractor> attractors; 
  ArrayList<Node> nodes;

  /**
   * Constructor.
   *
   * @param  arg_rootNodes   number of initial nodes for the tree
   * @param  arg_attractors   number of attractors for the tree 
   */
  Tree(ArrayList<Node> arg_rootNodes, ArrayList<Attractor> arg_attractors) {
    
    attractors = new ArrayList<Attractor>(arg_attractors);
    nodes = new ArrayList<Node>(arg_rootNodes);
       
  }

  /**
  * Check if at least one attractor is in the kill zone.
  *
  * @param n node for check
  * @return true if an attractor is in the kill zone
  * 
  * Source: Coding Rainbow
  * Author: Daniel Shiffman
  * Link: http://patreon.com/codingtrain
  * For Video: https://youtu.be/JcopTKXt8L8
  */
  boolean closeEnough(Node n) {

    for (Attractor a : attractors) {
      float d = PVector.dist(n.pos, a.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }

  /**
  * Grow a new generations of nodes.
  * Check if attractors are in kill zone and dismiss them.
  * 
  * Source: Coding Rainbow
  * Author: Daniel Shiffman
  * Link: http://patreon.com/codingtrain
  * For Video: https://youtu.be/JcopTKXt8L8
  */
  void grow() {
    for (Attractor a : attractors) {
       
      /* For Open venation.
      *
      * Source: Coding Rainbow
      * Author: Daniel Shiffman
      * Link: http://patreon.com/codingtrain
      * For Video: https://youtu.be/JcopTKXt8L8
      * Lines: 71-95
      */
      if (a.type == 'o') {
        Node closest = null;
        PVector closestDir = null;
        float record_f = -1;

        for (Node n : nodes) {
          
          PVector dir = PVector.sub(a.pos, n.pos);
          float d = dir.mag();
          if (d < min_dist) {
            a.reached();
            closest = null;
            break;
          } else if (d > max_dist) {
          } else if (closest == null || d < record_f) {
            closest = n;
            closestDir = dir;
            record_f = d;
          }
        }
        if (closest != null && closestDir != null ) {
          closestDir.normalize();
          closest.dir.add(closestDir);
          closest.count++;
        }
      }
       
      /* For Closed venation. */
      else if (a.type == 'c') {
          
        ArrayList<Node> neighborhoodNodes = this.getRelativeNeighborHood(a);
        
        if (neighborhoodNodes == null) {
          continue;
        }
        
        int reachedNodesNumber = 0;
        
        for(Node n : neighborhoodNodes){
          float dist = PVector.dist(a.pos, n.pos);
          if (dist <= min_dist)
          {
            reachedNodesNumber++;
            n.count++;
            n.size += 0.1;
            continue;
          }
          
          PVector newDir = PVector.sub(a.pos, n.pos);          
          newDir.normalize();
          n.dir.add(newDir);
          n.count++;
        }

        if (reachedNodesNumber == neighborhoodNodes.size() && neighborhoodNodes.size() > 0)
        {
          a.reached = true;
        }
      }
      
     
    }
    
     /* All reached attractors (in kill zone) are removed.
      *
      * Source: Coding Rainbow
      * Author: Daniel Shiffman
      * Link: http://patreon.com/codingtrain
      * For Video: https://youtu.be/JcopTKXt8L8
      * Lines: 141-144
      */
    for (int i = attractors.size()-1; i >= 0; i--) {
      if (attractors.get(i).reached) {
        attractors.remove(i);
      }
      
      /* End of the generation of a single model. */
      if (attractors.size() == 0) {
          
        print(millis()/1000 - timer, '\n');
        timer = millis()/1000;
        is_generating = false;
        return;
      }
    }
    
    
     /* Generation of new nodes
      *
      * Source: Coding Rainbow
      * Author: Daniel Shiffman
      * Link: http://patreon.com/codingtrain
      * For Video: https://youtu.be/JcopTKXt8L8
      * Lines: 165-178
      */
    for (int i = nodes.size()-1; i >= 0; i--) {
      Node n = nodes.get(i);
      if (n.count > 0) {
        
        n.dir.div(n.count);
        PVector rand = PVector.random3D();
        rand.setMag(0.3);
        n.dir.add(rand);
        n.dir.normalize();
        Node newN = new Node(n);
        n.children.add(newN);
        
        nodes.add(newN);
        n.reset();
        
        /* Growing size of the nodes. */
        Node currentNode = n;
        while (currentNode.parent != null)
        { 
          if (currentNode.parent.children.size() > 0 && currentNode.parent.size < 5.0) {
            currentNode.parent.size += 0.002;
          }
          currentNode = currentNode.parent;
        }
      }
    }
  }

  /**
  * Grow a new generations of nodes.
  * Check if attractors are in kill zone and dismiss them.
  * 
  * Source: Coding Rainbow
  * Author: Daniel Shiffman
  * Link: http://patreon.com/codingtrain
  * For Video: https://youtu.be/JcopTKXt8L8
  */
  ArrayList<Node> getRelativeNeighborHood(Attractor a) {
    
    ArrayList<Node> nearbyNodes = this.getNodesInAttractionZone(a);

    if (nearbyNodes.size() == 0) {
      return null;
    }
    
    ArrayList<Node> relativeNeighbors = new ArrayList<Node>();
    float aToP0, aToP1, p0ToP1;
    boolean fail = false;

    for (Node p0 : nodes) {
      fail = false;
      aToP0 = p0.pos.dist(a.pos);
        for(Node p1 : nearbyNodes) {
          if(p0 == p1) {
            continue;
          }
  
          aToP1 = p1.pos.dist(a.pos);
  
          if(aToP1 > aToP0) {
            continue;
          }
  
          p0ToP1 = p0.pos.dist(p1.pos);
  
          if(aToP0 > p0ToP1) {
             fail = true;
             break;
          }
        }

      if(!fail) {
        relativeNeighbors.add(p0);
        
        if (relativeNeighbors.size()>3) {
          return relativeNeighbors;
        }
      }
    }
    return relativeNeighbors;
  }
  
  /**
  * Check closest nodes for closed venation.
  *
  * @param a
  * @return list of closest nodes
  * 
  */
  ArrayList<Node> getNodesInAttractionZone(Attractor a) {
    
    ArrayList<Node> nodesInAttractionZone = new ArrayList<Node>();

    for (Node n : nodes) {
      float d = a.pos.dist(n.pos);
      
      if (d < max_dist)
      {
        nodesInAttractionZone.add(n);
      }
    }
    
    return nodesInAttractionZone;
  }
  
  void show() {
    for (Attractor l : attractors) {
      l.show();
    }    
    //for (Node b : nodes) {
    
 
    for (int i = 0; i < nodes.size(); i++) {
      Node b = nodes.get(i);
      if (b.parent != null) {
        //float sw = map(i, 0, nodes.size(), 6, 0);
        strokeWeight(b.size);
        stroke(0);
        line(b.pos.x, b.pos.y, b.pos.z, b.parent.pos.x, b.parent.pos.y, b.parent.pos.z);
      }
    } 
  }
}

/**
 * Main program for Generator.
 * Generator of the Spatial Structure.
 *
 * Bachelor's Thesis
 * Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
 * Student: Samuel Gajdoš
 * Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
 * VUT FIT 2021
 */

import peasy.*;

PeasyCam cam;

/**
* GLOBAL VARIABLES
*/

Tree tree1; // tree vein structure 1
Tree tree2; // tree vein structure 1

float min_dist = 3;    // minimum distance, determine the kill zones
float max_dist = 150;  // maximum distance, determine the zones of attraction
float timer = 0;       // timer for total time during generation
float node_size = 0.2; // node size
boolean is_generating = true; // true if new model is generating

int MODELS_COUNT = 5; // Number of models to generate
int current_counter = 1;// initial number of generated model

/**
* Initialize the main window, variables for generation of a new spatial structure.
*/
void setup() {
  size(300, 900, P3D);
  cam = new PeasyCam(this, 1000);
  
  
  ArrayList<Node> rootNodes = new ArrayList<Node>();
  ArrayList<Attractor> attractors = veinInitialSpace(10,150, 'd');
  
  rootNodes.add(new Node(new PVector(-80, 550, 40), new PVector(0, -1)));
  rootNodes.add(new Node(new PVector(80, 550, 40), new PVector(0, -1)));
  tree1 = new Tree(rootNodes, attractors);
  
  rootNodes.clear();
  attractors.clear();
  rootNodes.add(new Node(new PVector(-80, 550, 40), new PVector(0, -1)));
  rootNodes.add(new Node(new PVector(80, 550, 40), new PVector(0, -1)));
  attractors = veinInitialSpace(290,190, 'p');
  tree2 = new Tree(rootNodes, attractors);
  
}

/**
* Running program in average speed 60 FPS.
* Generating models of a spatial structure and writting data to a new file.
*/
void draw() {
  
  background(51);
  while(is_generating) {
    node_size = 0.8;
    tree1.grow();
    node_size = 0.3;
    tree2.grow();
  }
  
  tree1.nodes.addAll(tree2.nodes);
  
  PrintWriter output;
  output = createWriter("./closed/" + String.format("%03d", current_counter) + "_finger_model_closed.mf"); 
  
  for (Node n: tree1.nodes) {
    
    if (n.parent != null) {
        output.print(n.pos.x);
        output.print(",");
        output.print(n.pos.y);
        output.print(",");
        output.print(n.pos.z);
        output.print(",");
        
        output.print(n.parent.pos.x);
        output.print(",");
        output.print(n.parent.pos.y);
        output.print(",");
        output.print(n.parent.pos.z);
        output.print(",");
        
        output.println(n.size);
    }
    
  }
    
    output.flush();
    output.close(); 
    
    current_counter++;
    
    // Exit program if number of models is reached.
    if (current_counter > MODELS_COUNT) {
      exit(); 
    }
    
    is_generating = true;
    setup();    
}

void keyReleased() {
  setup();
}




  

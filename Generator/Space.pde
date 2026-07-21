/**
 * Space generator of the attractors. Specify the attractor's position.
 * Generator of the Spatial Structure.
 *
 * Bachelor's Thesis
 * Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
 * Student: Samuel Gajdoš
 * Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
 * VUT FIT 2021
 */

/**
GLOBAL VARIABLES
*/
int COORDINATE_COUNTER = 0; // Counts how many Attractors were created

/**
* Create an ArrayList of the Attractors.
*
* @param  open_num   number of attractors for open venation
* @param  closed_num   number of attractors for closed venation
* @param  z_section  dorsal or palmar section of the finger
* @return         ArrayList of Attractors
*/
ArrayList<Attractor> veinInitialSpace( int open_num, int closed_num, char z_section) {
  
    ArrayList<Attractor> attractors = new ArrayList<Attractor>();
    
    if (open_num > 0) {
      int tip_open_num = (int) open_num/2;
      int bottom_open_num = open_num - tip_open_num;
      
      for (int i = 0; i < tip_open_num; i++) {
        PVector cor = createCor('t', z_section);
        attractors.add(new Attractor('o', cor));
      }  
      
      for (int i = 0; i < bottom_open_num; i++) {
        PVector cor = createCor('b', z_section);
        attractors.add(new Attractor('o', cor));
      }
    }
    
    if (closed_num > 0) {
      int tip_closed_num = (int) closed_num/10;
      int bottom_closed_num = closed_num - tip_closed_num;
      
      for (int i = 0; i < tip_closed_num; i++) {
        PVector cor = createCor('t', z_section);
        attractors.add(new Attractor('c', cor));
      }  
      
      for (int i = 0; i < bottom_closed_num; i++) {
        PVector cor = createCor('b', z_section);
        attractors.add(new Attractor('c', cor));
      }
    }
    
    
    for (Attractor a: attractors) {
      a.pos.y -= 350;
    }
    return attractors;  
}


/**
* Create the coordinates for the Attractor
*
* @param  y_section   tip or bottom section of the finger
* @param  z_section   dorsal or palmar section of the finger
* @return         vector of created coordinates
*/
PVector createCor(char y_section, char z_section ) {
      
      COORDINATE_COUNTER++;
      
      PVector cor = PVector.random3D();
      
      // Dorsal part of the finger
      if (z_section == 'd') {
        if (cor.z > 0.4) {
          cor.z -= 0.4;
        }
      }
      
      if (z_section == 'p') {
        if (cor.z < -0.4) {
          if (COORDINATE_COUNTER % 30 == 0) {
            cor.z += 0.4;
          }
        }
      }
      
      // Tip of the finger
      if (y_section == 't') {
      
        if (cor.y < 0) {
          cor.y *= -1;
        }
        
        if (cor.z < -0.8) {
          cor.z += 0.1;
        }
        
        if (COORDINATE_COUNTER % 100 == 0) {
          cor.x *= random(100);
          cor.y *= random(190);
          cor.z *= random(80);
          
        }
        else {
          cor.x *= 100;
          cor.y *= 190;
          cor.z *= 80;
        }
        
         
      }
      
      // Bottom section of the finger
      if (y_section == 'b') {
        
        
        if (cor.y > 0) {
          cor.y *= -1;
        }
        
        if (COORDINATE_COUNTER % 100 == 0) {
          cor.x *= random(120);
          cor.z *= random(85);
        }
        else {
          cor.x *= 120;
          cor.z *= 85;    
        }
        
        cor.y = random(-900);
      }
      
      translateCorToCartesian(cor);
      return cor;

}

/**
* Translate y,z coordinates to a cartesian system.
*
* @param  cor   
* @return         translated coordinates
*/
PVector translateCorToCartesian(PVector cor) {

  cor.y *= -1;
  cor.z *= -1;
  
  return cor;
}

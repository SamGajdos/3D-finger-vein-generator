/**
 * Class for the attractor.
 * Generator of the Spatial Structure.
 *
 * Bachelor's Thesis
 * Generator of the Spatial Structure of the Cardiovascular System of the Human Hand Finger
 * Student: Samuel Gajdoš
 * Supervisor: Drahanský Martin, prof. Ing., Dipl.-Ing., Ph.D.
 * VUT FIT 2021
 */

class Attractor {
  PVector pos;
  boolean reached = false;
  char type = 'o';

  /**
   * Constructor.
   *
   * @param  arg_type   type of the attractor: 'o' open venation, 'c' closed venation
   * @param  arg_pos    position for the attractor
   */
  Attractor(char arg_type, PVector arg_pos) {
    type = arg_type;
    pos = arg_pos;
  }

  /**
  * set an attractor to reached. Attractor is in the kill zone.
  *
  * Source: Coding Rainbow
  * Author: Daniel Shiffman
  * Link: http://patreon.com/codingtrain
  * For Video: https://youtu.be/JcopTKXt8L8
  */
  void reached() {
    reached = true;
  }
  
  void show() {
    pushMatrix();
    stroke(51,204,204);
    strokeWeight(10);
    point(pos.x, pos.y, pos.z);
    popMatrix();
  }
}

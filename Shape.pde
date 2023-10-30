class Shape
{
  PVector shapePosition = new PVector();
  PShape object = null;
 
  void LoadShape(String file) { object = loadShape("models/" + file + ".obj"); }
  
  void SetPosition(float x,float y,float z) { shapePosition = new PVector(x,y,z); }
  
  void SetColor(int r, int g, int b) { object.setFill(color(r,g,b)); }
  
}

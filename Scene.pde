class Scene
{
  
  ArrayList<Light> lights = new ArrayList<Light>();
  ArrayList<Shape> shapes = new ArrayList<Shape>();
  color background = color(0,0,0);
  int shapeCount = 0;
  int lightCount = 0;
  
  void DrawScene()
  {
    
    background(background);
    
    //Draw Lights
    for (int i = 0; i < lightCount; i++)
    {
      
      PVector lightPosition = lights.get(i).lightPosition;
      PVector lightColor = lights.get(i).lightColor;
      pointLight(lightColor.x,lightColor.y, lightColor.z,
                 lightPosition.x,lightPosition.y,lightPosition.z);
    }
    
    //Draw Shapes
    for (int i = 0; i < shapeCount; i++) 
    {
      
      PVector shapePosition = shapes.get(i).shapePosition;
      pushMatrix();
        translate(shapePosition.x,shapePosition.y,shapePosition.z);
        shape(shapes.get(i).object);
      popMatrix();
      
    }
    
  }
  
  int GetShapeCount() { return shapeCount; }
  
  int GetLightCount() { return lightCount; }
 
  void SetBackground(int r, int g, int b) { background = color(r,g,b); }

  void AddShape(Shape newShape) 
  { 
    
    shapes.add(newShape);
    shapeCount++; 
    
  }
  
  void AddLight(Light newLight) 
  { 
    
    lights.add(newLight);
    lightCount++; 
    
  }
  
}

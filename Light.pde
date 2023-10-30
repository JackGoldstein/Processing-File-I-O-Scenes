class Light 
{
  PVector lightPosition = new PVector();
  PVector lightColor = new PVector();
  
  void SetColor(int r, int g, int b) { lightColor = new PVector(r,g,b); }
  
  void SetPosition(int x,int y,int z) { lightPosition = new PVector(x,y,z); }
  
}

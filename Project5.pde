import java.io.*;    // Needed for BufferedReader
import queasycam.*;
import controlP5.*;

QueasyCam cam;
ControlP5 cp5;
float xPos = 150;
float zPos = 300;
float speed = 1.0f;

ArrayList<Scene> scenes = new ArrayList<Scene>();
int currentScene = 0;

void setup()
{
  size(1200, 1000, P3D);
  perspective(radians(60.0f), width/(float)height, 0.1, 1000);
  
  cp5 = new ControlP5(this);
  cp5.addButton("ChangeScene").setPosition(10, 10);
  
  cam = new QueasyCam(this);
  cam.speed = 0;
  cam.sensitivity = 0;
  cam.position = new PVector(0, -50, 100);

  //Loading in testfile
  BufferedReader reader0 = createReader("scenes/testfile.txt");
  Scene testScene = new Scene();
  
  try
  {
     String line = reader0.readLine();
     String data[] = line.split(",");
     Shape newShape = new Shape();
     newShape.LoadShape(data[0]);
     int x = Integer.parseInt(data[1]);
     int y = Integer.parseInt(data[2]);
     int z = Integer.parseInt(data[3]);
     newShape.SetPosition(x,y,z);
     int r = Integer.parseInt(data[4]);
     int g = Integer.parseInt(data[5]);
     int b = Integer.parseInt(data[6]);
     newShape.SetColor(r,g,b);
     testScene.AddShape(newShape);
     
     line = reader0.readLine();
     data = line.split(",");
     Light newLight = new Light();
     x = Integer.parseInt(data[0]);
     y = Integer.parseInt(data[1]);
     z = Integer.parseInt(data[2]);
     newLight.SetPosition(x,y,z);
     r = Integer.parseInt(data[3]);
     g = Integer.parseInt(data[4]);
     b = Integer.parseInt(data[5]);
     newLight.SetColor(r,g,b);
     testScene.AddLight(newLight);
     
     scenes.add(testScene);
     
  }
  catch (IOException e)
  {
    e.printStackTrace();
  }
  
  //Loading in scene 1
  BufferedReader reader1 = createReader("scenes/scene1.txt");
  LoadFiles(reader1);
  
  //Loading in scene 2
  BufferedReader reader2 = createReader("scenes/scene2.txt");
  LoadFiles(reader2);
  
  
  lights(); // Lights turned on once here
}

void draw()
{
  // Use lights, and set values for the range of lights. Scene gets REALLY bright with this commented out...
  lightFalloff(1.0, 0.001, 0.0001);
  perspective(radians(60.0f), width/(float)height, 0.1, 1000);
  pushMatrix();
  rotateZ(radians(180)); // Flip everything upside down because Processing uses -y as up
  
  scenes.get(currentScene).DrawScene(); //Draws scene

  popMatrix();

  camera();
  perspective();
  noLights(); // Turn lights off for ControlP5 to render correctly
  DrawText();
}

void mousePressed()
{
  if (mouseButton == RIGHT)
  {
    // Enable the camera
    cam.sensitivity = 1.0f; 
    cam.speed = 2;
  }

}

void mouseReleased()
{  
  if (mouseButton == RIGHT)
  {
    // "Disable" the camera by setting move and turn speed to 0
    cam.sensitivity = 0; 
    cam.speed = 0;
  }
}

//updates the current scene
void ChangeScene()
{
  currentScene++;
  if (currentScene >= scenes.size()) 
    currentScene = 0;
}

//shows total lights and shapes
void DrawText()
{
  textSize(30);
  text("PShapes: " + scenes.get(currentScene).GetShapeCount(), 0, 60);
  text("Lights: " + scenes.get(currentScene).GetLightCount(), 0, 90);
}

//file I/O for scene files
void LoadFiles(BufferedReader reader)
{
  
  Scene newScene = new Scene();
  
  try
  {
    String line = reader.readLine();
    String data[] = line.split(",");
    int r = Integer.parseInt(data[0]);
    int g = Integer.parseInt(data[1]);
    int b = Integer.parseInt(data[2]);
    newScene.SetBackground(r,g,b);
    
    //Load in shapes
    line = reader.readLine();
    data = line.split(",");
    int count = Integer.parseInt(data[0]);
    for (int i = 0; i < count; i++)
    {
      
      Shape newShape = new Shape();
      line = reader.readLine();
      data = line.split(",");
      
      newShape.LoadShape(data[0]);
      float x = Float.parseFloat(data[1]);
      float y = Float.parseFloat(data[2]);
      float z = Float.parseFloat(data[3]);
      newShape.SetPosition(x,y,z);
      r = Integer.parseInt(data[4]);
      g = Integer.parseInt(data[5]);
      b = Integer.parseInt(data[6]);
      newShape.SetColor(r,g,b);
      newScene.AddShape(newShape);
      
    }
    
    //Load in Lights
    line = reader.readLine();
    data = line.split(",");
    count = Integer.parseInt(data[0]);
    for(int i = 0; i < count; i++)
    {
      
     line = reader.readLine();
     data = line.split(",");
     Light newLight = new Light();
     int x = Integer.parseInt(data[0]);
     int y = Integer.parseInt(data[1]);
     int z = Integer.parseInt(data[2]);
     newLight.SetPosition(x,y,z);
     r = Integer.parseInt(data[3]);
     g = Integer.parseInt(data[4]);
     b = Integer.parseInt(data[5]);
     newLight.SetColor(r,g,b);
     newScene.AddLight(newLight);
      
    }
    
    scenes.add(newScene);
    
  } 
  catch (IOException e)
  {
     e.printStackTrace();
  }
  
}

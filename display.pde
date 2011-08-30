Grid board; 
int[][] data;
void setup() 
{  
  size(640, 480);  
  background(0)
  board = new Grid(10, 10, width-10, height-3, 10);  
  data = new int[board.gw][board.gh];
  frameRate(30);
}  

void draw()
{
  frameRate(30);
  background(0);
  board.render();  
  for (int x = 0; x < board.gw; x++) {
    for (int y = 0; y < board.gh; y++) {
      if (data[x][y] == 1) {
        PVector l = board.toScreen(x, y); 
        rect((int)l.x, (int)l.y, board.res, board.res);
      }
    }
  }
}

// taken form https://github.com/stevenklise/ConwaysGameOfLife/
void mouseClicked() 
{                                                                               
  if (mouseX > board.tx && 
      mouseX < board.bx && 
      mouseY < board.by && 
      mouseY > board.ty) {                                                                             
    PVector l = board.toGrid(mouseX, mouseY); 
    if (mouseButton == LEFT) {
      data[(int)l.x][(int)l.y] = abs(data[(int)l.x][(int)l.y] - 1);
    }                                                                           
  }                                                                             
}

boolean erase;

void mousePressed()
{
  if (mouseX > board.tx && 
      mouseX < board.bx && 
      mouseY < board.by && 
      mouseY > board.ty) {                                                                             
    PVector l = board.toGrid(mouseX, mouseY); 
    if (mouseButton == LEFT) {
      if (data[(int)l.x][(int)l.y] == 0) {
        erase = false;
      } else {
        erase = true;
      }
    }                                                                           
  } 

}

void mouseDragged()
{
  if (mouseX > board.tx && 
      mouseX < board.bx && 
      mouseY < board.by && 
      mouseY > board.ty) {                                                                             
    PVector l = board.toGrid(mouseX, mouseY); 
    if (mouseButton == LEFT) {
      if (erase) {
        data[(int)l.x][(int)l.y] = 0;
      } else {
        data[(int)l.x][(int)l.y] = 1;
      }
    }                                                                           
  } 
}

void output()
{
  String out = "";
  for (int x = 0; x < board.gw; x++) {
    for (int y = 0; y < board.gh; y++) {
      if (data[x][y] == 1) {
        out += "[" + x + ", " + y + "],";
      }
    }
  }
  document.getElementById("text-out").value = "[" + out + "]";
}

class Grid                                                                      
{                                                                               
  int tx;                                                                       
  int ty;                                                                       
  int bx;                                                                       
  int by;                                                                       
  int gw;                                                                       
  int gh;                                                                       
  int res;                                                                      
                                                                                
  Grid(int _tx, int _ty, int _bx, int _by, int _res)                            
  {                                                                             
    tx = _tx;                                                                   
    ty = _ty;                                                                   
    bx = _bx;                                                                   
    by = _by;                                                                   
    res = _res;                                                                 
    gw = int((bx-tx)/res);                                                      
    gh = int((by-ty)/res);                                                      
  }                                                                             
                                                                                
  void render()                                                                 
  {                                                                             
    stroke(60,60,60,255);                                                       
    for (int x=tx; x<=bx; x += res)                                             
    {                                                                           
      line(x,ty,x,gh*res+ty);                                                   
    }                                                                           
    for (int y=ty; y<=by; y += res)                                             
    {                                                                           
      line(tx,y,gw*res+tx,y);                                                   
    }                                                                           
  }                                                                             
                                                                                
  PVector toGrid(int x, int y) // Convert a pixel number to a grid number       
  {                                                                             
    int gridx = (x - tx)/res;                                                   
    int gridy = (y - ty)/res;                                                   
    PVector v = new PVector(gridx,gridy);                                       
    return v;                                                                   
  }                                                                             
                                                                                
  PVector toScreen(int x, int y) // Convert a grid number to a pixel number     
  {                                                                             
    int sx = x*res+tx;                                                          
    int sy = y*res+ty;                                                          
    PVector v = new PVector(sx,sy);                                             
    return v;                                                                   
  }                                                                             
} 

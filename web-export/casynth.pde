
int COLUMNS = 16;
int ROWS = 16;
int refresh = 2;
int frequency = 60*refresh;

float step_x, step_y, radius;

World world;

void setup()
{
  frameRate(60);
  size(600, 600);
  step_x = width / COLUMNS;
  step_y = height / ROWS;
  radius = min(step_x, step_y)*0.8;
  world = new World(COLUMNS, ROWS);
}

void draw()
{
  world.draw();
  if (frameCount % frequency == 0)
  {
    world.step();
  }
}


class Cell
{
  public final static int ON = 1;
  public final static int OFF = 0;
  public final static int DYING = 2;
  
  int col;
  int row;
  int state;
   
  public Cell(int col, int row, int state)
  {
    this.col = col;
    this.row = row;
    this.state = state;
  }
  
  public void draw()
  {
    switch(this.state)
    {
      case Cell.OFF:
        draw_off();
        break;
      case Cell.ON:
        draw_on();
        break;
      case Cell.DYING:
        draw_dying();
        break;
    }
  }
  
  private void draw_dying()
  {
    fill(117,23,24);
    ellipse(step_x/2+col*step_x, step_y/2+row*step_y, radius, radius);
    fill(0);
    ellipse(step_x/2+col*step_x, step_y/2+row*step_y, radius*0.7, radius*0.7);
    fill(117,23,24);
    ellipse(step_x/2+col*step_x, step_y/2+row*step_y, radius*0.4, radius*0.4);
  }
  
  private void draw_on()
  {
    fill(0,177,177);
    ellipse(step_x/2+col*step_x, step_y/2+row*step_y, radius, radius);
    fill(0);
    ellipse(step_x/2+col*step_x, step_y/2+row*step_y, radius*0.7, radius*0.7);
    fill(22,244,245);
    ellipse(step_x/2+col*step_x, step_y/2+row*step_y, radius*0.4, radius*0.4);
  }
  
  private void draw_off()
  {
    fill(0);
    ellipse(step_x/2+col*step_x, step_y/2+row*step_y, radius, radius);
  }
  
}

class World
{
  public int num_columns;
  public int num_rows;
  public Cell[][] cells;
  
  public World(int columns, int rows)
  {
    this.num_columns = columns;
    this.num_rows = rows;
    this.cells = this.randomWorld();
  }
  
  private Cell[][] randomWorld()
  {
    
    Cell[][] cells = new Cell[this.num_columns][this.num_rows];
    for (int i=0;i<this.num_columns;++i)
    {
      for(int j=0;j<this.num_rows;++j)
      {
        cells[i][j] = new Cell(i,j,int(random(3)));
      }
    } 
    
    return cells;
  }
  
  public void draw()
  {
    background(0);
    for (int i=0;i<this.num_columns;++i)
    {
      for(int j=0;j<this.num_rows;++j)
      {
        cells[i][j].draw();
      }
    }
  }
  
  public void step()
  {
    this.cells = updateStatus();
  }
  
  private Cell[][] updateStatus()
  {
    Cell[][] cells = new Cell[this.num_columns][this.num_rows];
    for (int i=0;i<this.num_columns;++i)
    {
      for(int j=0;j<this.num_rows;++j)
      {
        ArrayList<Cell> neighbours = this.getNeighbours(i,j);
        int num_on = 0;
        int num_dying = 0;
        for (Cell cell : neighbours)
        {
          if (cell.state == Cell.ON) ++num_on;
          if (cell.state == Cell.DYING) ++num_dying;
        }
        int num_off = 8 - num_on - num_dying;
        int new_state;
        
        if (cell.state == Cell.OFF && num_on == 2) new_state = Cell.ON;
        else if (cell.state == Cell.ON) new_state = Cell.DYING;
        else if (cell.state == Cell.DYING) new_state = Cell.OFF;
        
        cells[i][j] = new Cell(i,j,new_state);
      }
    }
    return cells; 
  }
  
  private ArrayList<Cell> getNeighbours(int col, int row)
  {
    ArrayList<Cell> neighbours = new ArrayList<Cell>();
    for (m = -1; m <= +1; m++) 
    {
      for (n = -1; n <= +1; n++) 
      {
        neighbours.add(cells[(num_rows+col+m) % num_rows][(num_columns+row+n)%num_columns]);
      }
    }
    return neighbours;
  }
}


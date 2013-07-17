
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

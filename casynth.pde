
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


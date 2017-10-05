/* //<>//
Programmer: Sheldon Klassen
Minesweeper Game:
The goal is to flag every mine that you can find, by deducing the amount
that are found in the surrounding tiles. This requires a little logic, 
but is quite enjoyable to play.
*/

int xSize = 25;
int ySize = 25;

int difficulty = 100;
float xCellSize;
float yCellSize;

int[][] mineGrid = new int[xSize][ySize];
int[][] grid = new int[xSize][ySize]; 

boolean gameRunning = true;
boolean gameWin = false;

void setup()
{
  size(1000, 1000);
  if(xSize * ySize <= difficulty -1)
  {
    print("You MUST at least 1 tile that is not a mine.");
    exit();
  }
  gameRunning = true;
  gameWin = false;
  xCellSize = width / xSize;
  yCellSize = height / ySize;
  for (int i = 0; i < xSize; i++)
  {
    for (int a = 0; a < ySize; a++)
    {
      mineGrid[i][a] = 0;
      grid[i][a] = 0;
    }
  }
  for (int i  = 0; i < difficulty; i++)
  {
    int xRandom = (int)random(xSize);
    int yRandom = (int)random(ySize);
    while (mineGrid[xRandom][yRandom] != 0)
    {
      xRandom = (int)random(xSize);
      yRandom = (int)random(ySize);
    }
    mineGrid[xRandom][yRandom] = 2;
  }
}
void draw()
{

  if (gameRunning == true)
  {
    for (int i = 0; i < xSize; i++)
    {
      for (int a = 0; a < ySize; a++)
      {
        int nearby = gridNearCount(i, a);

        if (grid[i][a] == 0)
        {
          fill(255);
        } else if (grid[i][a] == 1)
        {

          fill(125);
        } else if (grid[i][a] == 2)
        {
          fill(0);
        } else if (grid[i][a] == 3)
        {
          fill(255);
        }

        rect(i*xCellSize, a *yCellSize, xCellSize, yCellSize);
        if (grid[i][a] ==3)
        {
          pushMatrix();
          fill(255, 0, 255);
          translate(i * xCellSize, a * yCellSize);
          triangle(10, 10, 10, 30, 30, 20);
          translate(0, 0);
          popMatrix();
        } else if (grid[i][a] == 1 && nearby > 0)
        {
          fill(cos(nearby)*255, tan(nearby)*255, sin(nearby)*255);
          textSize(20);
          text(nearby + "", i*xCellSize +(xCellSize/2), a *yCellSize +(yCellSize/1.5));
        }
      }
    }
    int correctFlag = 0;
    for (int i = 0; i < xSize; i++)
    {
      for (int a = 0; a < ySize; a++)
      {
        if (grid[i][a] == 3 && mineGrid[i][a] == 2)
        {
          correctFlag++;
        }
        if (correctFlag == difficulty)
        {
          gameWin =true;
          gameRunning = false;
        }
      }
    }


    for (int m = 0; m < xSize; m++)
    {
      for (int n = 0; n < ySize; n++)
      {
        if ( mineGrid[m][n] != 2)
        {
          if (m>0 && m < xSize-1 && n>0 && n < ySize-1)
          {
            for (int c = -1; c <= 1; c++)
            {
              for (int d = -1; d <= 1; d++)
              {

                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {
                  grid[m][n]= 1;
                }
              }
            }
          } else if (m != 0&&m != xSize-1&& n==0)
          {
            for (int c = -1; c <= 1; c++)
            {
              for (int d = 0; d <= 1; d++)
              {

                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {
                  grid[m][n]= 1;
                }
              }
            }
          } else if (m ==xSize-1&&n!=0&&n!=ySize-1)
          {
            for (int c = -1; c <=0; c++)
            {
              for (int d = -1; d <= 1; d++)
              {
                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {

                  grid[m][n]= 1;
                }
              }
            }
          } else if (m!=0 && m!=xSize-1 && n==ySize-1)
          {
            for (int c = -1; c <= 1; c++)
            {
              for (int d = -1; d <= 0; d++)
              {

                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {
                  grid[m][n]= 1;
                }
              }
            }
          } else if (m==0 && n!=0 && n!=ySize-1)
          {
            for (int c = 0; c <= 1; c++)
            {
              for (int d = -1; d <= 1; d++)
              {

                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {
                  grid[m][n]= 1;
                }
              }
            }
          } else if (m==0 && n==0)
          {
            for (int c = 0; c <= 1; c++)
            {
              for (int d = 0; d <= 1; d++)
              {

                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {
                  grid[m][n]= 1;
                }
              }
            }
          } else if (m==xSize-1 && n == ySize-1)
          {
            for (int c = -1; c <= 0; c++)
            {
              for (int d = -1; d <= 0; d++)
              {

                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {
                  grid[m][n]= 1;
                }
              }
            }
          } else if (m==0&& n==ySize-1)
          {
            for (int c = 0; c <= 1; c++)
            {
              for (int d = -1; d <= 0; d++)
              {

                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {

                  grid[m][n]= 1;
                }
              }
            }
          } else if (m==xSize-1&& n== 0)
          {
            for (int c = -1; c <= 0; c++)
            {
              for (int d = 0; d <= 1; d++)
              {
                int secondNearby = gridNearCount(m+c, n+d);
                if (mineGrid[m+ c][n + d] != 2 &&grid[m+c][n+d] == 1  &&grid[m][n] == 0 && secondNearby < 1)
                {
                  grid[m][n]= 1;
                }
              }
            }
          }
        }
      }
    }
  } else
  {

    fill(0,0,0);
    color(0,0,0);
    rect(width/2-350,height/2-100,625 ,425);
    fill(255, 125, 100);
    color(255, 125, 100);
    if (keyPressed ==true && key == ENTER)
    {
      gameRunning = true;   
      setup();
    } else if (keyPressed == true && key != ENTER)
    {
      textSize(100);
      text("WRONG KEY", width/2 -325, height/2 + 300);
    } else
    {
      if(gameWin == false)
      {
      textSize(100);
      text("You LOSE.", width/2 -275, height/2);
      text("Game Over", width/2 -300,height /2 + 100);
      textSize(50);
      text("Press ENTER to restart", width/2 -300, height/2 + 200);
      }
      else
      {
            fill(0, 255, 150);
    color(0, 255, 150);
        textSize(100);
      text("You WIN!", width/2 -275, height/2);
      text("Game Over", width/2 -300,height /2 + 100);
      textSize(50);
      text("Press ENTER to restart", width/2 -300, height/2 + 200);
      }
    }
  }
}

// Calculate the number of mines that are in the 3x3 grid around block
int gridNearCount(int x, int y)
{
  int answer = 0;
  if (x>0 && x < xSize-1 && y>0 && y < ySize-1)
  {
    for (int i = -1; i <= 1; i++)
    {
      for (int a = -1; a <= 1; a++)
      {

        if (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x != 0&&x != xSize-1&& y==0)
  {
    for (int i = -1; i <= 1; i++)
    {
      for (int a = 0; a <= 1; a++)
      {

        if (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x ==xSize-1&&y!=0&&y!=ySize-1)
  {
    for (int i = -1; i <=0; i++)
    {
      for (int a = -1; a <= 1; a++)
      {

        if (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x!=0 && x!=xSize-1 && y==ySize-1)
  {
    for (int i = -1; i <= 1; i++)
    {
      for (int a = -1; a <= 0; a++)
      {

        if (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x==0 && y!=0 && y!=ySize-1)
  {
    for (int i = 0; i <= 1; i++)
    {
      for (int a = -1; a <= 1; a++)
      {

        if (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x==0 && y==0)
  {
    for (int i = 0; i <= 1; i++)
    {
      for (int a = 0; a <= 1; a++)
      {

        if (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x==xSize-1 && y == ySize-1)
  {
    for (int i = -1; i <= 0; i++)
    {
      for (int a = -1; a <= 0; a++)
      {

        if  (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x==0&& y==ySize-1)
  {
    for (int i = 0; i <= 1; i++)
    {
      for (int a = -1; a <= 0; a++)
      {

        if  (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } else if (x==xSize-1&& y== 0)
  {
    for (int i = -1; i <= 0; i++)
    {
      for (int a = 0; a <= 1; a++)
      {
        if  (mineGrid[x+i][y+a] ==2)
        {
          answer++;
        }
      }
    }
  } 
  return answer;
}

void mousePressed() 
{
  if (mouseButton == LEFT)
  {
    for (int i = 0; i < xSize; i++)
    {
      for (int a = 0; a < ySize; a++)
      {
        if (mouseX > i*xCellSize && mouseY > a*yCellSize && mouseX < i*xCellSize +xCellSize && mouseY< a* yCellSize + yCellSize)
        {
          if (mineGrid[i][a] == 0&&grid[i][a] == 0&&grid[i][a]!=3)
          {
            grid[i][a] =1;
          } else if (mineGrid[i][a]==2&&grid[i][a]!=3)
          {
            grid[i][a] =2;
            gameRunning = false;
          }
        }
      }
    }
  } else if (mouseButton == RIGHT)
  {
    for (int i = 0; i < xSize; i++)
    {
      for (int a = 0; a < ySize; a++)
      {
        if (mouseX > i*xCellSize && mouseY > a*yCellSize && mouseX < i*xCellSize +xCellSize && mouseY< a* yCellSize + yCellSize)
        {
          if (grid[i][a] == 0)
          {
            grid[i][a] =3;
          } else if (grid[i][a] == 3)
          {
            grid[i][a] =0;
          }
        }
      }
    }
  }
}
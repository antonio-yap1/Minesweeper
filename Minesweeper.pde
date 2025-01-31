import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 10;
private final static int MINES = 5;
private final static int NUM_COLS = 10;
public static int counter=0;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines= new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r<NUM_ROWS;r++){
      for(int c = 0;c<NUM_COLS;c++){
        buttons[r][c] =new MSButton(r,c);
        
        
        
        
      }
    }
      
      
      
    
    
    
    setMines();
}
public void setMines()
{
    //your code
    for(int i =0;i<MINES;i++){
    int row = (int)(Math.random()*NUM_ROWS);
    int col = (int) (Math.random()*NUM_COLS);
    if(!mines.contains(buttons[row][col]))
    mines.add(buttons[row][col]);
    }
    
    
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    if((NUM_ROWS*NUM_COLS)-counter==MINES)
    return true;
    return false;
}
public void displayLosingMessage()
{
    text("you lose",200,100);
}
public void displayWinningMessage()
{
    text("you win",200,200);
}
public boolean isValid(int r, int c)
{
  if(r>=NUM_ROWS||r<0)
  return false;
  if(c >=NUM_COLS||c<0)
  return false;
  else
  return true;
}
public int countMines(int row, int col)
{
    int count = 0;
  if(isValid(row,col)==false)
  return 0;
  
if((isValid(row-1,col-1)==true)&& mines.contains(buttons[row-1][col-1]))
count++;

if((isValid(row-1,col)==true)&&  mines.contains(buttons[row-1][col]))
count++;

if((isValid(row-1,col+1)==true)&&  mines.contains(buttons[row-1][col+1]))
count++;

if((isValid(row,col-1)==true)&& mines.contains(buttons[row][col-1]))
count++;

if((isValid(row,col+1)==true)&&  mines.contains(buttons[row][col+1]))
count++;

if((isValid(row+1,col-1)==true)&&  mines.contains(buttons[row+1][col-1]))
count++;

if((isValid(row+1,col)==true)&&  mines.contains(buttons[row+1][col]))
count++;

if((isValid(row+1,col+1)==true)&&  mines.contains(buttons[row+1][col+1]))
count++;
  
  return count;
  
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }

    // called by manager
    public void mousePressed () 
    {
    
        clicked = true;
        //your code here
        if(mouseButton==RIGHT){
          flagged= !flagged;
          if(flagged==false)
          clicked=false;
        }
        else if(countMines(myRow,myCol)>0)
        setLabel(""+countMines(myRow,myCol));  
        
        if(mouseButton==LEFT){
          counter++;
          if(mines.contains(this))
          displayLosingMessage();
          
      if(isValid(myRow,myCol-1)&& !mines.contains(buttons[myRow][myCol-1])&&buttons[myRow][myCol-1].clicked==false)
      buttons[myRow][myCol-1].mousePressed();
      
       else if(isValid(myRow,myCol+1)&& !mines.contains(buttons[myRow][myCol+1])&&buttons[myRow][myCol+1].clicked==false)
      buttons[myRow][myCol+1].mousePressed();
      
       else if(isValid(myRow-1,myCol)&& !mines.contains(buttons[myRow-1][myCol])&&buttons[myRow-1][myCol].clicked==false)
      buttons[myRow-1][myCol].mousePressed();
      
      else if(isValid(myRow+1,myCol)&& !mines.contains(buttons[myRow+1][myCol])&&buttons[myRow+1][myCol].clicked==false)
      buttons[myRow+1][myCol].mousePressed();
      
       else if(isValid(myRow+1,myCol-1)&& !mines.contains(buttons[myRow+1][myCol-1])&&buttons[myRow+1][myCol-1].clicked==false)
      buttons[myRow+1][myCol-1].mousePressed();
      
       else if(isValid(myRow-1,myCol+1)&& !mines.contains(buttons[myRow-1][myCol+1])&&buttons[myRow-1][myCol+1].clicked==false)
      buttons[myRow-1][myCol+1].mousePressed();
      
       else if(isValid(myRow+1,myCol+1)&& !mines.contains(buttons[myRow+1][myCol+1])&&buttons[myRow+1][myCol+1].clicked==false)
      buttons[myRow+1][myCol+1].mousePressed();
      
       else if(isValid(myRow-1,myCol-1)&& !mines.contains(buttons[myRow-1][myCol-1])&&buttons[myRow-1][myCol-1].clicked==false)
      buttons[myRow-1][myCol-1].mousePressed();
      
        }
     
        
        
    }
    public void draw () 
    {    
      
        if (flagged)
            fill(0);
         else if(clicked && mines.contains(this) ) {
             fill(255,0,0);
             text("you lose",200,100);
              displayLosingMessage();
             
         }
        else if(clicked)
            fill( 200 );
        else 
        fill( 100 );
        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);

    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}

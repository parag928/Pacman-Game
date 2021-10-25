//variables
float X = 200;
float Y = 250;
float XDelta = 90;
float YDelta = 90;
final float PACMAN_SIZE = 70;
float ghostX=45;
float ghostY=45;
float [] dotsX;
float [] dotsY;
int NumberofBalls= 50;
int NumberofBallsRemaining= NumberofBalls;
int score= 0;

//setup - sets the canavas size, 50 ellipses' color and assign their random postions, and makes the pacman move through pressing keys on the keyboard
  void setup() {
    size(1200, 550);
    fill (255);
    assignDotPositions();
    keyPressed();
}

/// Draw - Sketches Pacman and ghost and moves them, draws and erases the dots, and stops the game if pacman and ghost collide.       
void draw() {
  background(0);
  drawDots();
  drawGhost();
  drawPacman();
  noStroke();
  eraseDots();
  ghostandpacmanCollision();
  drawText();
}

//DrawPacman - draws a packman a the given x, y
  void drawPacman() {
    fill (0,0,255);
    arc (X, Y, 100, 100, QUARTER_PI, PI+HALF_PI+QUARTER_PI); 
      if (X>width){
          X= 0;
        }
      if (X<0){
        X=1200;
      }
      if (Y<0){
        Y=550;
      }
      if (Y>height){
        Y=0;
      }
}

//makePacmanMoveWithKeys- The pacman moves to the right, left, top and bottom with the correspondent 'd' 'a' 'w' 's' keys when they are pressed 
  void keyPressed() {
      if (key == 'w') 
      {
        Y-=YDelta;
      }
      if (key == 'd') 
      {
        X+=XDelta;
      }
      if (key == 'a') 
      {
        X-=XDelta;
      }
      if (key == 's') 
      {
        Y+=YDelta;
      }
}

// DrawGhost - Draws and moves ghost at given x,y with cursor.
  void drawGhost() {
    fill(230, 0, 0);
    rect(ghostX, ghostY, 90, 90, 45, 45, 0, 0);
    fill(0);
    strokeWeight(7);
    stroke(255);
    ellipse(ghostX+30, ghostY+25, 20, 20);
    ellipse(ghostX+60, ghostY+25, 20, 20);
//if x value of ghost is greater than the cursor on the x direction, move it to the left along with cursor goes to the left 
    if (ghostX>X-95) {
      ghostX-=0.75;
    }
//if x value of ghost is less than the cursor on the x direction, move it to the right along with cursor goes to the right
    if (ghostX<X+5) {
      ghostX+=0.75;
    }
//if y value of the ghost greater than the cursor moving on the y direction, move it to up as cursor moves up
    if (ghostY>Y+5) {
      ghostY-=0.75;
    }
//if y value of the ghost less than the cursor moving on the x direction, move it to the right along with the cursor by 1 pixel 
    if (ghostY<Y-95) {
      ghostY+=0.75;
    }
}

//assignDotPositions - Assigns random x and y postions to each 50 dots
  void assignDotPositions() {
    dotsX= new float [NumberofBalls];
    dotsY= new float [NumberofBalls];
    fill(255);
    for (int i=0; i<NumberofBalls; i++) {
      dotsX[i]= random (10, 1190);
      dotsY[i]= random (10, 540);
    }
}

//drawDots- Draws the sketch of dots on the canvas
  void drawDots() {
    fill(255);
    for (int i=0; i<NumberofBalls; i++) {
      ellipse(dotsX[i], dotsY[i], 20, 20);
    }
}

//ghostandpacmanCollision- if the ghost and the pacman collide, the game will be over and the user will be unable to play further on.
  void ghostandpacmanCollision(){
       float dist= sqrt((ghostX-X) * (ghostX-X)+(ghostY-Y) * (ghostY-Y));
        if (dist<=50) {
          background(255,0,0);
          fill(0,0,255);
          textSize(80);
          text("Game Over!", 350, 275);
       noLoop();
    }
}
//eraseDots- Erases the dots as they get within the pacman's radius  
    void eraseDots(){
      for (int i=NumberofBalls-1; i>=0; i--) {
        float dist= sqrt((dotsX[i]-X) * (dotsX[i]-X)+(dotsY[i]-Y) * (dotsY[i]-Y));
        if (dist<=50) {
          dotsX[i]=-100;
          dotsY[i]=-100;
          score= score + 1;
          NumberofBallsRemaining--;
          break;
          }
      }
}

//drawText- draws the text "Score" on the upper right of the canvas and finishes the game when all the dots are eaten.
  void drawText(){
    fill(255,0,0);
    textSize(40);
    text("Score: " + score, 1000,35);
    if (NumberofBallsRemaining==0){
      background(0,255,0);
      fill(0,0,210);
      textSize(50);
      text("Congratulations! You've Completed", 175, 325); 
    }
}

import controlP5.*;
import processing.serial.*;

Serial port;
String[] words;
String var = " ";
int card_number;
int desk_count = 4;
int mode = 0;
ControlP5 cp5;
PFont fontdesk;
PFont fonttitle;

// control arduino using gui

void setup(){
  
  size(1800,400); 
  printArray(Serial.list());
  
  port = new Serial(this, "COM6", 9600);  // arduino to com3 connect
  cp5 = new ControlP5(this);
  
  
  fontdesk = createFont("calibri light bold", 40);
  fonttitle = createFont("calibri light bold", 60);
  
   init();
   
   background(192, 192, 192);
   fill(255, 255, 255);
   
   textFont(fonttitle);
   text("SMART CAFE", 650, 50);
   
}

void draw(){
  
  if ( port.available() > 0) 
  {  // If data is available,
    var = port.readStringUntil('\n');         // read it and store it in val
  }
  
  print(var);
  delay(1000);
  
  count();
  
  if (var.indexOf("82 49 86 89") != -1 && card_number == 0) {
    mode = 1;
    card_number = 1;
    desk_count = desk_count - 1;
  }
  if(var.indexOf("30 5B 59 A8") != -1 && card_number == 0) {
    mode = 1;
    card_number = 2;
    desk_count = desk_count - 1;
  }
  
  if (mode == 0) {
    button_exit();
  }
  if (mode == 1) {
    button_sit();
  }
}

void button_sit() {//sit mode
  cp5.getController("Desk2")
    .setColorBackground(color(255,0,0))
    ;
}

void button_exit() { //exit mode
  cp5.getController("Desk2")
    .setColorBackground(color(0,255,0))
    ;
}

void reset() { //gui reset
  cp5.getController("Desk1")
    .setColorBackground(color(0,255,0))
    ;
  cp5.getController("Desk2")
    .setColorBackground(color(0,255,0))
    ;
  cp5.getController("Desk3")
    .setColorBackground(color(0,255,0))
    ;
  cp5.getController("Desk4")
    .setColorBackground(color(0,255,0))
    ;
}

void init() { //gui init
 cp5.addButton("Desk1")
    .setPosition(100, 80)
    .setSize(300, 200)
    .setFont(fontdesk)
    .setColorBackground(color(0, 255, 0))
    .setColorActive(color(0, 0, 0))
   ;
  cp5.addButton("Desk2")
    .setPosition(500, 80)
    .setSize(300, 200)
    .setFont(fontdesk)
    .setColorBackground(color(0, 255, 0))
    .setColorActive(color(0, 0, 0))
   ;
  cp5.addButton("Desk3")
    .setPosition(900, 80)
    .setSize(300, 200)
    .setFont(fontdesk)
    .setColorBackground(color(0, 255, 0))
    .setColorActive(color(0, 0, 0))
   ;
  cp5.addButton("Desk4")
    .setPosition(1300, 80)
    .setSize(300, 200)
    .setFont(fontdesk)
    .setColorBackground(color(0, 255, 0))
    .setColorActive(color(0, 0, 0))
   ;
  cp5.addButton("exit")
    .setPosition(1650, 150)
    .setSize(100,100)
    .setFont(fontdesk)
    .setColorBackground(color(0, 0, 0))
    ;
    
  cp5.addTextfield("count")
    .setPosition(1300,300)
    .setText("count : " + Integer.toString(desk_count))
    .setSize(300,100)
    .setColorBackground(color(0, 0, 0))
    .setFont(fontdesk)
    ;
}

void exit() {//reset button
  mode = 0;
  card_number = 0;
  var = " ";
  desk_count = 4;
  reset();
}

void count() {
  cp5.get(Textfield.class, "count")
    .setText("count : " + Integer.toString(desk_count))
    ;
}

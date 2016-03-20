 include <PRZutility.scad>
 include <X_utils.scad>
// (c) Pierre ROUZEAU jan 2016 - CC  BY-SA
// This plastic garden train "G" track bender is closely derived from the "oakbender" build in oak. This is one rare design which was usable at first print, however slightly improved since (to simplify supply).
// Designed just for fun, to see how easier it could be built compared to oak building. 
// bearings 608 (8x) and F688 (2x)
// Wood screw, countersunk head, diam 5 x 30 (6x)
// Medium washer M5 (6 x)
// Screw M4x50, countersunk head (1x)
// Butterfly nut M4 (1x)
// Simple nut M4 (1x)
// Bolt M8x80 (2x)
// Small washer M8 (4 x)

// Printing PETG or ABS. Prototype tested in PETG.
// Layer thickness : 0.3
// Fill-in : Honeycomb 70%
// 3 walls
// 5 layers on top and 5 layers on bottom
// In PETG, run hot for good interlayer adhesion, bridging is very limited.
// Printing time 2.5h to 4h depending your printer speed
// plastic weight: 58g (with above parameters and PETG - lighter in ABS)
// weight equipped with bearings : 254 g

part=9;  // set part=0 to see ensemble
xpart=0; // neutralise demo

BBspace = 80;
BBspace2 = 60;
trackWidth = 45;
BHt = 22;
FaceHt = 10-3.5; // bearings shall clear a reduced track heught (code 250)
TensHt = 9.5;
TensOff = -9.5;
 
showAcc = true;
holeplay = 0.15;
diamNut4 = 8.1;
 

if (part==1) support();
else if (part==2) push();  
else if (part==3) push2();  
else if (part==9) {
  support();
  tsl (-22,-22,1.2) rotz (90) push();
  tsl (-39,-22,BHt+3.6)  rotz (90) mirrorz () push2();
}

else ensemble();

module support() {
  difference() {
    union() { 
      dmirrory() {
        duplx(trackWidth)        
          cone3z (12,10, 3,3,BHt-6, 0,BBspace/2);  
        hull() 
          duplx(trackWidth)        
            cylz (4,BHt, 0,BBspace/2+3);  
        hull() {
          cylx(12.5,trackWidth+16, -11.5,BBspace2/2,FaceHt);       
          cubex(trackWidth+16,8.5,2,  -11.5,BBspace2/2+0.5,1);              
        } 
        cubex(trackWidth,15,1.5,   0,BBspace2/2+5,0.75);              
      } 
      duplx(trackWidth) {
        hull() 
          dmirrory()          
            cylz (4,BHt, 0,BBspace/2);  
      }
      hull() {
        cubez (10,28,9, 6,0,5.5);
        cubez (6,22,1, 6);
        dmirrory() 
          cylz (3,18, 0,BBspace/2);  
      }  
    } //::: then whats removed :::
    dmirrory() {
      duplx(trackWidth)        
        cylz (-4,111, 0,BBspace/2);
      cylx(-8,222, -11,BBspace2/2,FaceHt); 
      cylx(23.5,-8, -10.8+trackWidth,BBspace2/2,FaceHt);  
    }  
    tsl (-35,TensOff,TensHt) {
      rot (25) cylx (diamNut4,5, 43,0,0, 6);     
      cylx (4,66);     
    }  
    scale (1.02) push();
  }
  dmirrory() // add M8 guide to be in contact with bearing
    difference() {
      cylx(12.5,trackWidth+16, -11.5,BBspace2/2,FaceHt);    
      cylx(-8,222, -11.5,BBspace2/2,FaceHt);    
      cylx(23,-7.2, -11.5+trackWidth,BBspace2/2,FaceHt);  
    }
}

module push() {
  posb = -1.2;
  difference() {
    union() { 
      hull() {
        cylz (15,5, -23,0,posb);
        cubez (2,15,5, 48,0,posb);
      }  
      duplx(trackWidth)   
        cone3z (15,9.5, 5,6,BHt-17.5, -23,0,posb);
      hull() 
        dmirrory() {
          cylx (4,72, -23,5.5,4.5+posb);  
          cylx (1,72, -23,3.5,10+posb);  
        }
      difference() {  
        hull() {  
          cylx (9,12, -29, TensOff, TensHt+2+posb);  
          cubex (12,8,8, -29, -6.5, 4+posb);  
        }  
        cylz (14.3,-14, -23,0,BHt+3+posb);
      }  
    } //:::::::::::::::
    duplx(trackWidth)   
      cylz (-4,111, -23,0,posb);
    cylx (-4,111,  -29, TensOff, TensHt+2+posb);  
  }   
}

module push2() {
  posb=-1.2;
  tsl (0,0,-0.2)
  difference() {
    union() { 
      duplx(trackWidth)   
        cylz (14,-15.6, -23,0,BHt+5+posb);
      hull() 
        duplx(trackWidth+23)   
          cylz (14,-3.5, -23,0,BHt+5+posb);
    } //:::::::::::::::
    duplx(trackWidth) {  
      cylz (-4,111, -23);
      cylz (9.8,-30, -23,0,BHt-6.2+posb);
    }  
  }
}


module acc() {
   gray() {
     dmirrory() {
       duplx(trackWidth) {       
         cylz (22,-7, 0,BBspace/2, -1);  
         cylz (5,30, 0,BBspace/2, -9);  
         cylx(22,-7, -11.5,BBspace2/2,FaceHt);     
       }
       cylx(8,80, -24,BBspace2/2,FaceHt);     
     } 
     duplx(trackWidth)
       tsl (-23,0,-5.9) {
         BB("F688"); // ball bearing         
         cylz (5, 30, 0,0,-1.5);
       }  
     cylx (4,50, -35, TensOff,TensHt);     
     tsl (-35,TensOff,TensHt)
       rot (25)cylx (diamNut4,3.1, 43.5,0,0, 6); 
  } 
}
      
module ensemble() {
  //diff() { 
    u() {
  support();
  *acc() ;
  push();
  push2();
  }
  //  cubez (100,100,100,-73, 0, -50); // check 
  //}  
}  

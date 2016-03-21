 include <PRZutility.scad>
 include <X_utils.scad>
// (c) Pierre ROUZEAU march 2016 - CC  BY-SA
// This plastic garden train "G" track bender is closely derived from the "oakbender" build in oak. 
// Designed just for fun, to see how easier it could be built compared to oak building. 
// bearings 608 (8x) and F688 (2x)
// Wood screw, countersunk head, diam 5x40 (6x)
// Medium washer M5 (8x) - below bearing
// Simple nut M4 (2x)
// Bolt M8x80 (2x) - bearing assembly
// Bolt M4x40 (3x), hex head - pusher and push bar assembly
// small washers M4 (4x)
// medium washer M4 (2x)
// Small washer M8 (4 x)

// Set one washer below 608 bearings and two washers below 688 bearings

// Printing PETG or ABS. Prototype tested in PETG.
// Layer thickness : 0.3
// Fill-in : 100%
// 3 walls
// 5 layers on top and 5 layers on bottom
// In PETG, run hot for good interlayer adhesion, bridging is very limited.
// Printing time 3.5h to 6h depending your printer speed
// plastic weight: 95g (with above parameters and PETG - lighter in ABS)
// let the parts cool down on the bed before removing it.
// weight equipped with bearings : 300 g (in PETG)

part=0;  // set part=0 to see ensemble
xpart=0; // neutralise demo

BBspace = 80;
BBspace2 = 60;
trackWidth = 45+2.8;
BHt = 30;
FaceHt = 10-3.5; // bearings shall clear a reduced track height (code 250)
TensHt = 5;
TensOff = 0;
 
showAcc = true;
holeplay = 0.15;
diamNut4 = 8.1;
 

if (part==1) support();
else if (part==2) push();  
else if (part==3) rot (180) push2(); 
else if (part==4) thumbwheel();   
else if (part==9) {
  support();
  tsl (-22,-14,1.2) rotz (90) push();
  tsl (-40,10,BHt+4.1)  rotz (-90) mirrorz () push2();
  tsl (22) thumbwheel();
}

else ensemble(0);

module support() {
  difference() {
    union() { 
      dmirrory() {
        duplx(trackWidth)        
          cone3z (12,9.5, 4,3,BHt-7, 0,BBspace/2);  
          hull() {
          cylx(12.5,trackWidth+17, -11.5,BBspace2/2,FaceHt);       
          cubex(trackWidth+17,8.5,2,  -11.5,BBspace2/2+0.5,1);
        } 
        cubex(trackWidth,15,1.5,   0,BBspace2/2+5,0.75);              
        //-- sides -------------
        hull() 
          duplx(trackWidth) cylz (4,4, 0,BBspace/2+3);         
        hull() 
          duplx(trackWidth) cylz (2.5,BHt, 0,BBspace/2+3);         
        hull() 
          duplx(trackWidth) {       
            cylz (2.5,1, 0,BBspace/2+3, BHt/2);  
            cylz (4,-5, 0,BBspace/2+2.75, BHt);  
          }
        
      }    
      //-- faces ------------- 
      duplx(trackWidth) {
        hull() dmirrory() {
          cylz (3,(BHt-10)/2+10, 0,BBspace/2);  
          cylz (6,4, 0,BBspace/2, 10); 
        }  
        hull() dmirrory() {
          cylz (3.5,-BHt/2,  0,BBspace/2, BHt);  
          cylz (6,-4,           0,BBspace/2, BHt); 
        }
      }  
      htx=10;
      hull() {
        dmirrory()
          cylz (6,htx, trackWidth+26,8);
        cubez (7,15,htx, trackWidth+24.5);
      }  
      dmirrory()
        hull()  {
          cylz (6,htx, trackWidth+26,8);
          cylz (6,htx, trackWidth-8,28);
        } 
    } //::: then whats removed :::
    dmirrory() {
      duplx(trackWidth)        
        cylz (-3.9,111, 0,BBspace/2);
      cylx(-8,222, -11,BBspace2/2,FaceHt); 
      cylx(23.5,-8, -11+trackWidth,BBspace2/2,FaceHt);  
    }  
    cylx (4.2,30,trackWidth+10, 0,TensHt); 
    tsl (5) scale (1.02) push(trackWidth-0.8,false);
  }
  dmirrory() // add M8 guide to be in contact with bearing
    difference() {
      cylx(12.5,trackWidth+16, -11.5,BBspace2/2,FaceHt);    
      cylx(-8,222, -11.5,BBspace2/2,FaceHt);    
      cylx(23,-7.2, -11.5+trackWidth,BBspace2/2,FaceHt);  
    }
}

module push(tw = trackWidth-0.8, hole=true) {
  // trackwidth is reduced as internal radius is liower than external radius
  posb = -1.2;
  difference() {
    union() { 
      hull() {
        cylz (15,5, -23,0,posb);
        cubez (2,15,5, 50,0,posb);
      }  
      duplx(tw)   
        cone3z (15,9.5, 5.5,5.5,5.5, -23,0,posb, 24,0);
      hull() 
        dmirrory() {
          cylx (4,74, -23,5.5,5+posb);  
          cylx (1,74, -23,3.5,10.5+posb);  
        }
      hull() {
        dmirrory() 
          cylz (9,BHt-posb-4.5, trackWidth+8,4.5, posb);
        cubez (5,15,BHt-posb-4.5, trackWidth+8-2.5, 0, posb);
      }  
    } //:::::::::::::::
    dmirrory() 
      cylz (-4,111, trackWidth+8,4.5, -10);
    duplx(tw)   
      cylz (3.9,111, -23,0,-10);
    if (hole) 
      cylx (4.1,111,  29, TensOff, TensHt+2+posb);  
    hull() {
      cylx (diamNut4,3.5, 48, 0, TensHt, 6);
      cylx (diamNut4+0.6,3.5, 48, 0, TensHt-8, 6);
    }  
  }   
}

module push2(tw = trackWidth-0.8) {
  posb=-2.25;
  echo (tw=tw);
  tsl (0,0,-0.2)
    difference() {
      union() { 
        duplx(tw)   
          cylz (14,-BHt+5.9, -23,0,BHt+6.5+posb);
        hull() 
          duplx(trackWidth+23)   
            cylz (14,-4, -23,0,BHt+6.5+posb);
        hull() {
          cylz (14,-4, trackWidth,0,BHt+6.5+posb);
          dmirrory() 
            cylz (9,-4, trackWidth+8,4.5,BHt+6.5+posb);
        } 
        hull() 
          dmirrory() 
            cylz (9,-8,  trackWidth+8,4.5, BHt+6.5+posb);
      } //:::::::::::::::
      dmirrory() 
        cylz (-4,111, trackWidth+8,4.5, -10);
      duplx(tw) {  
        cylz (-3.9,111, -23);
        cylz (9.7,-30, -23,0,18.5+posb);
      }  
    }
}

module thumbwheel () {
  difference() {
    union() {
    for (i=[0:4])
      rotz (i*72)  
        hull() {
          cylz (9, 10);
          cylz (3,4, 17);
        }
      cylz (13.5, 8);  
    }    
    cylz (diamNut4,4, 0,0,-0.1,6.5);    
    cylz (-4.2, 55);
  }    
}


module acc (move=0) {
   gray() {
     dmirrory() {
       duplx(trackWidth) {       
         cylz (22,-7, 0,BBspace/2, -1);  
         cylz (5,30, 0,BBspace/2, -9);  
         cylx(22,-7, -11.5,BBspace2/2,FaceHt);     
       }
       cylx(8,80, -24,BBspace2/2,FaceHt);     
     }
    tsl (move) 
     duplx(trackWidth)
       tsl (-23,0,-5.9) {
         BB("F688"); // ball bearing         
         cylz (5, 30, 0,0,-1.5);
       }  
     cylx (4,50, 40, TensOff,TensHt);     
     tsl (78,TensOff,TensHt)
       cylx (diamNut4,3.1, 0,0,0, 6); 
  } 
}
      
module ensemble(move=0) {
  diff() { 
  u() {
    support();
    acc(move) ;
    tsl (move) {    
      push();
      push2();
    } 
    tsl (91,0, TensHt) rot (0,-90) thumbwheel(); 
  }
    // cubez (100,100,100,-73, 0, -50); // check holes
  }  
}  

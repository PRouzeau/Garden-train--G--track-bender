 include <Z_library.scad>
 include <X_utils.scad>
// (c) Pierre ROUZEAU march 2016-2019 - CC  BY-SA 4.0
// This 3D printed garden train "G" track bender is closely derived from the "oakbender" build in oak. 
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
//The version here is reinforced compared to the prototype to increase stiffness.
// weight equipped with bearings : 300 g (in PETG)
//rev. Jan 2018: Adapt to customizer, Camera view, create STL for parts
//rev oct 2019: autozoom
/*
CUSTOMIZER -------------------------------
 It may help to use OpenSCAD customizer
  - Menu [View] Untick [Hide customizer]-
 
 You shall use a recent OpenSCAD version for proper operation of Customizer.  Minimal version: 2019.05
 More recent snapshots version are generally quite reliable:
http://www.openscad.org/downloads.html#snapshots
*/  

/* [Hidden] */
xpart=0; // neutralise demo
diamNut4 = 8.1;
FaceHt = 10-3.5; // bearings shall clear a reduced track height (code 250)

/*[Camera view] -------------------- */
//Activate to impose default camera view
Force_view_position = false;
//force camera position at first preview
Cimp = Force_view_position ||$vpr==[55,0,25]; 

$vpd=Cimp?480:$vpd;  // camera distance: work only if set outside a module
$vpr=Cimp?[65,0,30]:$vpr; // camera rotation
$vpt=Cimp?[28,0,20]:$vpt; //camera translation  

/* [General] */
part=0;  // [0:View ensemble, 1:Frame, 2:Push bar top, 3:Push bar bottom, 4:ThumbWheel, 9:Full part set]
BBspace = 80;
BBspace2 = 60;
//Track width : inside rails
track_width = 45;
//Width of the top of one rail
rail_width = 2.8;
//Frame height - increasing it improve stiffness
BHt = 30;
//Tensioner screw height - no change to do
TensHt = 5;
//Tensioner side offset: always 0
TensOff = 0;
//Margin for holes diameter 
holeplay = 0.15;

wheel_track = track_width +rail_width;

if (part==1) frame();
else if (part==2) push();  
else if (part==3) rot (180) push2(); 
else if (part==4) thumbwheel(); 
else if (part==9) {
  frame();
  tsl(-22,-14,1.2) rotz (90) push();
  tsl(-40,10,BHt+4.1)  rotz (-90) mirrorz () push2();
  tsl(22) thumbwheel();
}
else ensemble(0);
  


module frame () {
  difference() {
    union() { 
      dmirrory() {
        duplx(wheel_track)        
          cone3z (12,9.5, 4,3,BHt-7, 0,BBspace/2);  
          hull() {
          cylx(12.5,wheel_track+17, -11.5,BBspace2/2,FaceHt);       
          cubex(wheel_track+17,8.5,2,  -11.5,BBspace2/2+0.5,1);
        } 
        cubex(wheel_track,15,1.5,   0,BBspace2/2+5,0.75);              
        //-- sides -------------
        hull() 
          duplx(wheel_track) cylz (4,4, 0,BBspace/2+3);         
        hull() 
          duplx(wheel_track) cylz (2.5,BHt, 0,BBspace/2+3);         
        hull() 
          duplx(wheel_track) {       
            cylz (2.5,1, 0,BBspace/2+3, BHt/2);  
            cylz (4,-5, 0,BBspace/2+2.75, BHt);  
          }
        
      }    
      //-- faces ------------- 
      duplx(wheel_track) {
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
          cylz (6,htx, wheel_track+26,8);
        cubez (7,15,htx, wheel_track+24.5);
      }  
      dmirrory()
        hull()  {
          cylz (6,htx, wheel_track+26,8);
          cylz (6,htx, wheel_track-8,28);
        } 
    } //::: then whats removed :::
    dmirrory() {
      duplx(wheel_track)        
        cylz (-3.9,111, 0,BBspace/2);
      cylx(-8,222, -11,BBspace2/2,FaceHt); 
      cylx(22.3,-8, -11+wheel_track,BBspace2/2,FaceHt, 32);  
    }  
    cylx (4.2,30,wheel_track+10, 0,TensHt); 
    tsl (5) scale (1.02) push(wheel_track-0.8,false);
  }
  dmirrory() // add M8 guide to be in contact with bearing
    difference() {
      cylx(12.5,wheel_track+16, -11.5,BBspace2/2,FaceHt);    
      cylx(-8,222, -11.5,BBspace2/2,FaceHt);    
      cylx(23,-7.2, -11.5+wheel_track,BBspace2/2,FaceHt);  
    }
}

module push (tw = wheel_track-0.8, hole=true) {
  // wheel_track is reduced as internal radius is liower than external radius
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
          cylz (9,BHt-posb-4.5, wheel_track+8,4.5, posb);
        cubez (5,15,BHt-posb-4.5, wheel_track+8-2.5, 0, posb);
      }  
    } //:::::::::::::::
    dmirrory() 
      cylz (-4,111, wheel_track+8,4.5, -10);
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

module push2 (tw = wheel_track-0.8) {
  posb=-2.25;
  echo (tw=tw);
  tsl (0,0,-0.2)
    difference() {
      union() { 
        duplx(tw)   
          cylz (14,-BHt+5.9, -23,0,BHt+6.5+posb);
        hull() 
          duplx(wheel_track+23)   
            cylz (14,-4, -23,0,BHt+6.5+posb);
        hull() {
          cylz (14,-4, wheel_track,0,BHt+6.5+posb);
          dmirrory() 
            cylz (9,-4, wheel_track+8,4.5,BHt+6.5+posb);
        } 
        hull() 
          dmirrory() 
            cylz (9,-8,  wheel_track+8,4.5, BHt+6.5+posb);
      } //:::::::::::::::
      dmirrory() 
        cylz (-4,111, wheel_track+8,4.5, -10);
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
       duplx(wheel_track) {       
         cylz (22,-7, 0,BBspace/2, -1);  
         cylz (5,30, 0,BBspace/2, -9);  
         cylx(22,-7, -11.5,BBspace2/2,FaceHt);     
       }
       cylx(8,80, -24,BBspace2/2,FaceHt);     
     }
    tsl (move) 
     duplx(wheel_track)
       tsl (-23,0,-5.9) {
         BB("F688"); // ball bearing         
         cylz (5, 30, 0,0,-1.5);
       }  
     cylx (4,50, 40, TensOff,TensHt);     
     tsl (78,TensOff,TensHt)
       cylx (diamNut4,3.1, 0,0,0, 6); 
  } 
}
      
module ensemble (move=0) {
  diff() { 
  u() {
    frame();
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

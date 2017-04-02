//$t=0.7267;
include <../../Meta/Animation.scad>;

use <../../Meta/Debug.scad>;
use <../../Meta/Manifold.scad>;
use <../../Meta/Resolution.scad>;

use <../../Vitamins/Pipe.scad>;
use <../../Vitamins/Double Shaft Collar.scad>;

use <../../Lower/Receiver Lugs.scad>;
use <../../Lower/Lower.scad>;

use <../../Upper/Cross/Cross Upper.scad>;
use <../../Upper/Cross/Forend/Forend.scad>;
use <../../Upper/Cross/Forend/Forend Slotted.scad>;
use <../../Upper/Cross/Forend/Single/Twist/Barrel Lugs.scad>;
use <../../Upper/Cross/Forend/Single/Twist/Lugged Forend.scad>;

use <../../Reference.scad>;

use <Base.scad>;

module Liberator12k_TwistAction(barrelLength=BarrelLength(), alpha=1) {

  // Barrel, lugs and shaft collar (animated)
  translate([LowerMaxX()+ForendMidsectionLength()+ForendSlottedLength(),0]) {
    
    translate([ForendSlottedLength()*Animate(ANIMATION_STEP_UNLOAD),0,0])
    translate([-ForendSlottedLength()*Animate(ANIMATION_STEP_LOAD),0,0]) {

      rotate([BarrelLugAngle(),0,0])
      rotate([-BarrelLugAngle()*Animate(ANIMATION_STEP_UNLOCK),0,0])
      rotate([BarrelLugAngle()*Animate(ANIMATION_STEP_LOCK),0,0]) {
        BarrelLugs();

        color("Black")
        rotate([45+15,0,0])
        rotate([0,90,0])
        DoubleShaftCollar();
      }

      translate([-(LowerMaxX()+0.25)-ForendSlottedLength(),0,0])
      Barrel(hollow=true, barrelLength=barrelLength);
    }
    
    LuggedForend(alpha=alpha);
  }

  ForendBaseplate();
  translate([BarrelLugLength(),0,0])
  ForendFront();
  ForendMidsection();
  ForendSlotted12k(alpha=alpha);
}

module ForendSlotted12k(alpha=1) {

  translate([LowerMaxX()+ManifoldGap(2),0,0])
  rotate([0,90,0])
  color("Gold", alpha)
  render()
  linear_extrude(height=ForendSlottedLength()-ManifoldGap(3))
  ForendSlotted2d(slotAngles=[0,180]);
}

Liberator12k_PlainFrame(length=12);
Liberator12k_TwistAction();
Liberator12k_Base();
Liberator12k_Stock();
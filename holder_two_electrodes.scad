flag_throw_together = true;

// design variables (in mm)
//## Cap
electrode_d = 1;
platform_l = 30;

holder_grip_l = 50;
grip_thick = 4;

holder_d = 10;
holder_gap = 5;

//## Stopper
l_stopper = 10;
h_stopper = 4;
d_screw = 5;

// __program_variables
h_cap = holder_d + 2*grip_thick;
w_cap = 2*holder_d + 2*grip_thick + holder_gap;
offset_grip_side = (holder_d+holder_gap)/2;
offset_platform = (holder_grip_l+platform_l)/2;
offset_screw = offset_platform;

module get_cap(x=0,y=0,z=0){ translate([x,y,z]){
    // cap base 
    difference()
    {
        cube([holder_grip_l, w_cap, h_cap], center=true);
        translate([0,offset_grip_side,0]) rotate([0,90,0]) 
        cylinder(h=holder_grip_l+1, d=holder_d, center=true);
        translate([0,-offset_grip_side,0]) rotate([0,90,0]) 
        cylinder(h=holder_grip_l+1, d=holder_d, center=true);    
    }

    //electrode platform
    difference()
    {
        translate([offset_platform, 0, -h_cap/4]) 
        cube([platform_l,w_cap, h_cap/2], center=true);
        translate([offset_platform,offset_grip_side,0]) rotate([0,90,0]) 
        cylinder(h=platform_l+1, d=electrode_d, center=true);
        translate([offset_platform,-offset_grip_side,0]) rotate([0,90,0]) 
        cylinder(h=platform_l+1, d=electrode_d, center=true);
        translate([offset_screw,0,0]) 
        cylinder(h=h_cap+1, d=d_screw, center=true);  
    }
}}

module get_stopper(x=0,y=0,z=0){ translate([x,y,z]){
    translate([0, 0, h_stopper/2])
    difference(){ 
        cube([l_stopper,w_cap, h_stopper], center=true);
        cylinder(h=h_stopper+1, d=d_screw, center=true);
    }
}}


module main(){
    if (flag_throw_together)
    {
        get_cap();
        get_stopper(offset_screw,0, 10);
    }
    else
    {
        get_cap();
        //get_stopper();
    }   
}

main();
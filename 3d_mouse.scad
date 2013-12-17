$fn = 200;

$ellipse_length = 1.9;//x_coefficient [2.1:3.3]
$ellipse_width = 1.5;//y_coefficient [1:2]
$ellipse_height = 1.5;//z_coefficient [1:2.5]
$ellipse_radius = 10;//zoom

$thickness = 0.5; //thickness of the walls
$thumbsize = 3;
$handler_radius = 1.9*$ellipse_radius;
$handler_thickness = 5;

//cut the bottom of the ellipse by cube
$cube_x = 2*$ellipse_length*$ellipse_radius;
$cube_y = 2*$ellipse_width*$ellipse_radius;
$cube_z = 2*$ellipse_height*$ellipse_radius;


//========================================//
module back_part()
{
difference()
{
//main ellipse part
scale([$ellipse_length,$ellipse_width,$ellipse_height]) sphere($ellipse_radius);

//front cutting cube
translate([-$cube_x,-$cube_y/2,-$cube_z/2])
cube([$cube_x,$cube_y,$cube_z]);

//bottom cutting cube
translate([-$cube_x/2,-$cube_y/2,-$cube_z*5/4])
cube([$cube_x,$cube_y,$cube_z]);
//main ellipse part
scale([$ellipse_length-$thickness,
		$ellipse_width-$thickness,
		$ellipse_height-$thickness]) 
sphere($ellipse_radius);

//thumb
translate([0,-$ellipse_width*$ellipse_radius,0])
scale([2,$thickness-0.1,1]) 
sphere($thumbsize);
}
}

//========================================//
module front_part()
{
difference()
{

//intersection of two equal ellipses with 90 degrees difference
intersection()
{
translate([0,0,-$ellipse_height*$ellipse_radius/20])
rotate([90,90,0]) 
scale([$ellipse_length,$ellipse_width,$ellipse_height]) 
sphere($ellipse_radius);

scale([$ellipse_length,$ellipse_width,$ellipse_height]) 
sphere($ellipse_radius);
}

//front cutting cube
translate([0,-$cube_y/2,-$cube_z/2])
cube([$cube_x,$cube_y,$cube_z]);

//bottom cutting cube
translate([-$cube_x/2,-$cube_y/2,-$cube_z*5/4])
cube([$cube_x,$cube_y,$cube_z]);

//cut inside the same part as above, but smaller on $thickness
intersection()
{
translate([0,0,-$ellipse_height*$ellipse_radius/20])
rotate([90,90,0]) 
scale([$ellipse_length-$thickness,
		$ellipse_width-$thickness,
		$ellipse_height-$thickness]) 
sphere($ellipse_radius);

scale([$ellipse_length-$thickness,
		$ellipse_width-$thickness,
		$ellipse_height-$thickness]) 
sphere($ellipse_radius);
}
//THUMB
translate([0,-$ellipse_width*$ellipse_radius,0])
scale([2,$thickness-0.1,1]) 
sphere($thumbsize);

//========================================//
//BUTTONS
//VERTICAL LINES
rotate([0,15,0])
translate([-2*$ellipse_radius+5,3,0])
cube([2.5,1,5]);
rotate([0,15,0])
translate([-2*$ellipse_radius+5,-3,0])
cube([2.5,1,5]);
rotate([0,15,0])
translate([-2*$ellipse_radius+5,9,0])
cube([5.5,1,5]);
rotate([0,15,0])
translate([-2*$ellipse_radius+5,-9,0])
cube([5.5,1,5]);
//HORIZONTAL LINE
rotate([90,0,0])
translate([-2*$ellipse_radius+5,3.5,-11])
cube([4,1,20]);
}
}


//========================================//
module handler()
{
rotate([90,90,60])
translate([$ellipse_length-5,$ellipse_width+9,8])
difference ()
{
linear_extrude($handler_thickness)
difference()
{
	circle($handler_radius);
	circle($handler_radius-1);
}
	//bottom cutting cube
	translate([0,-$handler_radius,-$handler_radius])
	cube(2*($handler_thickness+$handler_radius));
	
}
}
//========================================//

handler();
front_part();
back_part();

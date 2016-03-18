$fs=0.1;


/*[Tuberack]*/

Number_of_Row = 4;	//[3:8]
Number_of_Column = 2;	//[2:6]
Tube_diameter = 12;
Tube_row_distance = 8;
Tube_column_distance = 12;
Tube_holder_plate_distance = 30;

Rack_support_plate_distance = 15;
Rack_side_top_height_extra = 5;
Rack_side_bottom_height_extra = 10;

//Bottom_plate_tall = 

/*[Material]*/

Base_Material = 4;	//[3:8]
Screw_Diameter = 4; //
Screw_Length = 9; //
Nut_Height = 3; //
Nut_Width = 7.2; //

Output_type = "3d"; //dxf, 3d

/*[Hidden]*/


Material_thickness = Base_Material;

Tube_row = Number_of_Row -1 ;
Tube_column = Number_of_Column -1;
//Tube_diameter = 17;
Tube_plate_distance = Tube_holder_plate_distance;
Tube_support_height = Tube_plate_distance - (Material_thickness);

//Rack_support_plate_distance = 20;

Tubes_calculated_width =  (Tube_row_distance * Tube_row) + (( Tube_diameter ) * Tube_row) + Tube_diameter * 2;
Tubes_calculated_height =  (Tube_column_distance * Tube_column) + (( Tube_diameter ) * Tube_column) + Tube_diameter * 2;
Tubes_calculated_tall = (1*Material_thickness) + 0 + 0 +Rack_support_plate_distance + Tube_plate_distance;

Tube_hinge_quantity = Tube_column;
Tube_hinge_width = (Tubes_calculated_height/Tube_hinge_quantity)*0.35;
Tube_hinge_height = Material_thickness;


Tube_support_width = Tubes_calculated_width;
//Tube_support_height = 6;
Tube_support_center_x = Tube_support_width/2;
Tube_support_center_y = Tube_support_height/2;
Tube_support_hinge_width = Tube_support_width*0.14;
Tube_support_hinge_height = Material_thickness;
Tube_support_hinge_center_from_bottom = Tube_support_center_y-Tube_support_hinge_width/2;

Tube_screw_width = Screw_Length;
Tube_screw_height = Screw_Diameter;

Tube_screw_from_bottom_x = 0;
Tube_screw_from_bottom_y = Tube_support_center_y - Tube_screw_height/2;

Tube_screw_nuts_width = Nut_Width;
Tube_screw_nuts_height = Nut_Height; //diamater mur harusnya 2 = 4 mm


Tube_screw_nuts_distance_from_screw = 4;


Tube_screw_nuts_from_bottom_x = Tube_screw_from_bottom_x+Tube_screw_nuts_distance_from_screw;
Tube_screw_nuts_from_bottom_y = Tube_support_center_y - Tube_screw_nuts_width/2;


if ( Output_type == "dxf")
{
Tube_Print_SVG();
}else{
Tube_Holder_Complete_3D();
}    
    



module Tube_Print_SVG()
{
projection()
{
  Tube_Holder_Plate();
  translate([0,Tubes_calculated_height+1,0])
    {
      Tube_Holder_Plate();
    }    
    
  translate([Tubes_calculated_width+Material_thickness*2+1,0,0])
    {
                                Tube_Holder_Support();

    }

  translate([(Tubes_calculated_width+Material_thickness*2)*2+Tube_support_height/2,-Tubes_calculated_width,0])
    {
        _distance = Tube_support_height/2 +1;

    for (a = [0:Tube_column-1])
    {
        translate([(a*_distance*2),0,0])
        {
                    rotate([90,0,90])
            {

                        Tube_Support_Complete();
            }
        }
    }
    }
    
  translate([0,(Tubes_calculated_width+Material_thickness*2+1)*2,0])
    {    
        translate([Tubes_calculated_width/2+((Material_thickness*2))-Rack_side_top_height_extra/2-Rack_side_bottom_height_extra/2,0,0])
{
Tube_Holder_Complete_2D();
}
    }
    
    

  translate([0,(Tubes_calculated_width+Material_thickness*2+1)*3,0])
    {    
        translate([Tubes_calculated_width/2+((Material_thickness*2))-Rack_side_top_height_extra/2-Rack_side_bottom_height_extra/2,0,0])
{
Tube_Holder_Complete_2D();
}
    }
    

} 
}


module Tube_Holder_Complete_3D()
{   translate([Tubes_calculated_width/2,-Tubes_calculated_height/2, -Tubes_calculated_height/2])
{
    rotate([0,90,0])
    {
   // translate([90,90,0])
    { 
        //projection()
        {
            rotate([0,90,0])
            {
              //  difference()
                {      
                   
                    Side_Plate_Right();
                    Side_Plate_Left();
                    Tube_Holder_Plate(); 
                    
                    translate([0,Material_thickness/1,-(Tube_plate_distance )/2])
                    {
                        Tube_Support_Column();
                        Tube_Support_Column_Cutting();
                    }

                    translate([0,0,-Tube_plate_distance])
                    {
                       Tube_Holder_Plate(); 
                    }
                    
                    translate([0,0,-(Tube_plate_distance+Rack_support_plate_distance)])
                    {
                       Tube_Holder_Support();
                    }
                }
            }
        }
    }
}}
}
                
module Tube_Holder_Complete_2D()
{   
   // translate([90,90,0])
    { 
        //projection()
        {
            rotate([0,90,0])
            {
                difference()
                {      
                   
                    Side_Plate_Right();
                    Side_Plate_Left();
                    Tube_Holder_Plate(); 
                    
                    translate([0,Material_thickness/1,-(Tube_plate_distance )/2])
                    {
                        Tube_Support_Column();
                        Tube_Support_Column_Cutting();
                    }

                    translate([0,0,-Tube_plate_distance])
                    {
                       Tube_Holder_Plate(); 
                    }
                    
                    translate([0,0,-(Tube_plate_distance+Rack_support_plate_distance)])
                    {
                       Tube_Holder_Support();
                    }
                }
            }
        }
    }
    
}



module Side_Plate_Right()
{
    translate([-Material_thickness*0.5,Tubes_calculated_height*0.5,-Tubes_calculated_tall*0.5 + Material_thickness*0.5 + Rack_side_top_height_extra*0.5 - Rack_side_bottom_height_extra*0.5])
    {
    difference()
        {
            
            
    cube([Material_thickness,Tubes_calculated_height,Tubes_calculated_tall+Rack_side_top_height_extra+ Rack_side_bottom_height_extra],true);
        
                    translate([0,0,-(Tubes_calculated_tall+Rack_side_top_height_extra+ Rack_side_bottom_height_extra)/2-10])
            {
                rotate([0,90,0])
                {
                roundedRect([10,Tubes_calculated_height*0.75,Material_thickness*2],10);
                }
                    }
            
            
            }
            
            }
}

module Side_Plate_Left()
{
    
    translate([Tubes_calculated_width+Material_thickness*0.5,Tubes_calculated_height*0.5,-Tubes_calculated_tall*0.5 + Material_thickness*0.5 + Rack_side_top_height_extra*0.5 - Rack_side_bottom_height_extra*0.5])
    {
        
            difference()
        {
    cube([Material_thickness,Tubes_calculated_height,Tubes_calculated_tall+Rack_side_top_height_extra+ Rack_side_bottom_height_extra],true);
        
                    translate([0,0,-(Tubes_calculated_tall+Rack_side_top_height_extra+ Rack_side_bottom_height_extra)/2-10])
            {
                rotate([0,90,0])
                {
                roundedRect([10,Tubes_calculated_height*0.75,Material_thickness*2],10);
                }
                    }
        }
            
            
    }
}

module Tube_Hinge_Right()
{    _spacing =  0+(Tube_diameter)+Tube_column_distance;    

        translate([(-Tube_hinge_height/2)-0.0,(Tube_diameter),0])
    {      
        for (a = [0:Tube_hinge_quantity])
        {
            translate([0,a*_spacing,0])
            {
               Tube_Holder_Hinge();   
            }
        }
    }
}


module Tube_Hinge_Left()
{    
    _spacing =  0+(Tube_diameter)+Tube_column_distance;    

    translate([(Tubes_calculated_width+Tube_hinge_height/2)+0.0,(Tube_diameter),0])
    {      
        for (a = [0:Tube_hinge_quantity])
        {
            translate([0,a*_spacing,0])
            {
               Tube_Holder_Hinge();   
            }
        }
    }    
        
}

module Tube_Holder_Plate()
{
    //_spacing =  0+(Tube_diameter)+Tube_column_distance;    
    
    
    translate([0,0,-Material_thickness/2])
    {
    union()
    {
    
    Tube_Hinge_Left();
    Tube_Hinge_Right();


    translate([(Tube_diameter),(Tube_diameter),0])
    {
        difference()
        {
            translate([-(Tube_diameter),-(Tube_diameter),0])
            {
                cube([Tubes_calculated_width, Tubes_calculated_height, Material_thickness], false);
            }
            Tube_Column();
        }
        
    }
    }
}
}


module Tube_Holder_Support()
{
    _spacing =  0+(Tube_diameter)+Tube_column_distance;    
        translate([0,0,-Material_thickness/2])
    {
    union()
    {
    
    Tube_Hinge_Left();
    Tube_Hinge_Right();


    translate([(Tube_diameter),(Tube_diameter),0])
    {
        //difference()
        {
            translate([-(Tube_diameter),-(Tube_diameter),0])
            {
                cube([Tubes_calculated_width, Tubes_calculated_height, Material_thickness], false);
            }
            //Tube_Column();
        }
        
    }
    }
}
}


module Tube_Holder_Hinge()
{
    translate([0,0,(Material_thickness)/2])
    {
        cube([Tube_hinge_height, Tube_hinge_width, Material_thickness], true);
    }
}


module Tube_Support_Column_Cutting()
{
    /*
    _distance = (Tube_diameter)+Tube_column_distance;
    for (a = [1:Tube_column])
    {
        translate([0,(a*_distance)-Material_thickness*1.5,0])
        {
                         //    #cube([Material_thickness,Material_thickness,Material_thickness],true);
            rotate([0,90,0])
            {
                                            cylinder(h = Material_thickness*4, r = Tube_screw_nuts_height, center = true);
            }
        }
    }
    */
    
            _distance = ((Tube_diameter)+Tube_column_distance)/2;

        translate([(0),(Tube_diameter)-_distance-Material_thickness,0])
    {
    for (a = [1:Tube_column])
    {
        translate([0,(a*_distance*2),0])
        {
                        rotate([0,90,0])
            {

                                            cylinder(h = Material_thickness*4, r = Tube_screw_height/2, center = true);
        }

        }
    }
}
}

module Tube_Support_Column()
{
   // (Tube_column_distance * Tube_column) + (( Tube_diameter ) * Tube_column) + Tube_diameter * 2;
    //_distance = (Tube_diameter)+Tube_column_distance;
  /*  _distance = Tube_hinge_width+Tube_column_distance/2;
    translate([0,-Material_thickness,0])
    {
    for (a = [0:Tube_column])
    {
        translate([0,(a*_distance),0])
        {

            #cube([Material_thickness,Material_thickness,100], true);

            Tube_Support_Complete();
          }
    }
}*/
    
        _distance = ((Tube_diameter)+Tube_column_distance)/2;

        translate([(0),(Tube_diameter)-_distance,0])
    {
    for (a = [1:Tube_column])
    {
        translate([0,(a*_distance*2),0])
        {
            Tube_Support_Complete();

        }
    }
}
}

module Tube_Column()
{
    _distance = (Tube_diameter)+Tube_column_distance;
    for (a = [0:Tube_column])
    {
        translate([0,a*_distance,0])
        {
           //cube([2,2,2],true)
           Tube_Row();
        }
    }
}

module Tube_Row()
{
    _distance = (Tube_diameter)+Tube_row_distance;
    for (index =[0:Tube_row])
    {
        translate([index*_distance,0,0])
        {
 
                cylinder(h = Material_thickness*4, r = Tube_diameter/2, center = true);
        }
    }
}




module roundedRect(size, radius)
{
	x = size[0];
	y = size[1];
	z = size[2];

	translate([0,0,-z/2])
	linear_extrude(height=z)
	hull()
	{
		// place 4 circles in the corners, with the given radius
		translate([(-x/2)+(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (-y/2)+(radius), 0])
		circle(r=radius);
	
		translate([(-x/2)+(radius), (y/2)-(radius), 0])
		circle(r=radius);
	
		translate([(x/2)-(radius), (y/2)-(radius), 0])
		circle(r=radius);
	}
}




    module Tube_Support_Complete()
{
    //Tube_Cutting_Hole();
    translate([0,-Material_thickness/2,0])
{
                    rotate([90,0,0])
                    {
  translate([0,-Tube_support_center_y,0])
    {
        
                  //           #cube([4,Material_thickness,Material_thickness],true);

  difference()
  {

        //plate
      union()
      {
        difference()
         {

             
             translate([-Material_thickness,0,0])
             {
               cube([Tube_support_width + Material_thickness * 2,Tube_support_height,Material_thickness], false);   
             }
             
             
             translate([-Material_thickness,Tube_support_hinge_center_from_bottom,0])
             {
               cube([Tube_support_hinge_height,Tube_support_hinge_width,Material_thickness], false);  
             }

             translate([Tube_support_width,Tube_support_hinge_center_from_bottom,0])
             {
               cube([Tube_support_hinge_height,Tube_support_hinge_width,Material_thickness], false);  
             }   
             
             
         }
         

         
       }
        
      translate([0,Tube_support_center_y,0])
      {
      rotate([0,0,0])
      {
        Hinge_Screw_Joint();
      }
      
      translate([Tube_support_width,0,0])
      {
      rotate([0,0,180])
      {
      Hinge_Screw_Joint();
      }      }
      
      }
  }
            
  }
  }
  }}
  
  module Hinge_Screw_Joint()
  {
   translate([0,-Tube_support_center_y,0])
      {
    union()
        {
            //hinge

            
            //screw
            translate([Tube_screw_from_bottom_x,Tube_screw_from_bottom_y,0])
            {
            cube([Tube_screw_width,Tube_screw_height,Material_thickness], false);
            }
            
            //nuts
            translate([Tube_screw_nuts_from_bottom_x,Tube_screw_nuts_from_bottom_y,0])
            {
            cube([Tube_screw_nuts_height,Tube_screw_nuts_width,Material_thickness], false);
            }
        }
    }
  }

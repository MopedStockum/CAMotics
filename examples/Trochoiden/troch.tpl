//test trochoidal paths
var p=position();
var curr_x=p.x;
var curr_y=p.y;
var curr_z=0;
var curr_a=0;
var curr_b=0;
var curr_c=0;
var curr_u=0;
var curr_v=0;
var curr_w=0;

feed(3000);
//cut(50);
console.log('sdfghjkl');
//t_cut(50,0,0,0,0,0,0,0,0,0.5,7,4,false);
//t_cut(0,50,0,0,0,0,0,0,0,0.5,7,4,false);
//t_cut(0,0,0,0,0,0,0,0,0,0.5,7,4,false);

//t_cut(50,0,0,0,0,0,0,0,0,0.5,7,4,true);
//t_cut(-50,50,0,0,0,0,0,0,0,0.5,7,4,true);
//t_cut(0,-50,0,0,0,0,0,0,0,0.5,7,4,true);

//t_cut(25,25,10,0,0,0,0,0,0,0.5,7,4,false);
//x, y, z, angle,plane,step,vdia,rdia
t_arc(10,0,0,Math.PI*2,XY,1,10,4);

function t_cut(x, y, z, a, b, c, u, v, w,step,vdia,rdia , incremental){
  var cutlength;
  var cutlengthplane;
  var stepcount;
  
  console.log('incremental: '+incremental);
  console.log('x: '+x);
  if (incremental){
    cutlength=Math.sqrt(Math.pow( Math.sqrt(Math.pow(x,2)+Math.pow(y,2)),2) +Math.pow(z,2));
	console.log(cutlength);
    cutlengthplane=Math.sqrt(Math.pow(x,2)+Math.pow(y,2));
	console.log(cutlengthplane);
    stepcount=Math.abs(cutlength/step);
    if ((cutlength%step)!=0)stepcount++;
	cut({
		x:((y)/stepcount)/(cutlengthplane/stepcount)*(-vdia/2) ,
        y:((x)/-stepcount)/(cutlengthplane/stepcount)*(-vdia/2),
		incremental:true
	});
    for(c=0;c<stepcount;c++){
      cut({
        x:(x/stepcount) ,
        y:(y/stepcount), 
        z:(z/stepcount),
        incremental:true
        });
      arc({  x:(y/stepcount)/(cutlengthplane/stepcount)*(vdia/2) ,
          y:(x/-stepcount)/(cutlengthplane/stepcount)*(vdia/2),
          z:z/stepcount,
          angle:(2*Math.PI)
          });
    }
	cut({
		x:((y)/stepcount)/(cutlengthplane/stepcount)*(vdia/2) ,
        y:((x)/-stepcount)/(cutlengthplane/stepcount)*(vdia/2),
		incremental:true
	});
    curr_x=curr_x+x;
    curr_y=curr_y+y;
    curr_z=curr_z+z;    
  }else{
    //no way to get current pos, so do'nt know about which direction to cut---> assumed zeroes...
    cutlength=Math.sqrt(Math.pow( Math.sqrt(Math.pow((x-curr_x),2)+Math.pow((y-curr_y),2)),2) +Math.pow((z-curr_z),2));
    cutlengthplane=Math.sqrt(Math.pow((x-curr_x),2)+Math.pow((y-curr_y),2));
    stepcount=Math.abs(cutlength/step);
    if ((cutlength%step)!=0)stepcount++;
	cut({
		x:((y-curr_y)/stepcount)/(cutlengthplane/stepcount)*(-vdia/2) ,
        y:((x-curr_x)/-stepcount)/(cutlengthplane/stepcount)*(-vdia/2),
		incremental:true
	});
    for(c=0;c<stepcount;c++){
      cut({
        x:((x-curr_x)/stepcount) ,
        y:((y-curr_y)/stepcount), 
        z:((z-curr_z)/stepcount),
		incremental:true
      });
      arc({  
		  x:((y-curr_y)/stepcount)/(cutlengthplane/stepcount)*(vdia/2) ,
          y:((x-curr_x)/-stepcount)/(cutlengthplane/stepcount)*(vdia/2),
          z:(z-curr_z)/stepcount,
          angle:(2*Math.PI)
          });
    }
	cut({
		x:((y-curr_y)/stepcount)/(cutlengthplane/stepcount)*(vdia/2) ,
        y:((x-curr_x)/-stepcount)/(cutlengthplane/stepcount)*(vdia/2),
		incremental:true
	});	
    curr_x=x;
    curr_y=y;
    curr_z=z;
  }
}

function t_arc(x, y, z, angle,plane,step,vdia,rdia){
	var cp=position();
	var cp2;
    cutlength=2*Math.PI*Math.sqrt(Math.pow(x,2)+Math.pow(y,2));
	//2*Math.PI*Math.sqrt(Math.pow( Math.sqrt(Math.pow(x,2)+Math.pow(y,2)),2) +Math.pow(z,2));
	console.log(cutlength);
    cutlengthplane=2*Math.PI*Math.sqrt(Math.pow(x,2)+Math.pow(y,2));
	console.log(cutlengthplane);
    stepcount=Math.abs(cutlength/step);
    if ((cutlength%step)!=0)stepcount++;
	cut({
		x:((y)/stepcount)/(cutlengthplane/stepcount)*(-vdia/2) ,
        y:((x)/-stepcount)/(cutlengthplane/stepcount)*(-vdia/2),
		incremental:true
	});
	cp=position();
	cp2=position();
    for(c=0;c<stepcount;c++){	
 	  arc({
        x:(x-(cp2.x-cp.x)) ,
        y:(y-(cp2.y-cp.y)), 
        z:(z),
        angle:angle/stepcount
        });
	  cp2=position();	
      arc({  x:Math.sin(angle/stepcount)*(vdia/2) ,
          y:Math.cos(angle/stepcount)*(vdia/2),
          z:0,
          angle:(2*Math.PI)
          });
	  //cp2=position();	
    }
	cut({
		x:((y)/stepcount)/(cutlengthplane/stepcount)*(vdia/2) ,
        y:((x)/-stepcount)/(cutlengthplane/stepcount)*(vdia/2),
		incremental:true
	});
    curr_x=curr_x+x;
    curr_y=curr_y+y;
    curr_z=curr_z+z;    
}

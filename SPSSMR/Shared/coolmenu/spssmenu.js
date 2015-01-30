//Menu object creation
oCMenu=new makeCM("oCMenu"); //Making the menu object. Argument: menuname

oCMenu.frames = 1;

//Menu properties
oCMenu.pxBetween=5;
oCMenu.fromLeft=20;
oCMenu.fromTop=0;
oCMenu.rows=1;
oCMenu.menuPlacement="left";

oCMenu.offlineRoot="";
oCMenu.onlineRoot="";
oCMenu.resizeCheck=1;
oCMenu.wait=500;
oCMenu.fillImg="cm_fill.gif";
oCMenu.zIndex=0;

//Background bar properties
oCMenu.useBar=1;
oCMenu.barWidth="100%";
oCMenu.barHeight="menu";
oCMenu.barClass="clBar";
oCMenu.barX=0;
oCMenu.barY=0;
oCMenu.barBorderX=0;
oCMenu.barBorderY=0;
oCMenu.barBorderClass="";

//Level properties - ALL properties have to be specified in level 0
oCMenu.level[0]=new cm_makeLevel(); //Add this for each new level
oCMenu.level[0].width=90;
oCMenu.level[0].height=17;
oCMenu.level[0].regClass="clActiveMenuItemOff";
oCMenu.level[0].overClass="clActiveMenuItemOn";
oCMenu.level[0].borderX=1;
oCMenu.level[0].borderY=1;
oCMenu.level[0].borderClass="clActiveMenuItemBorder0";
oCMenu.level[0].offsetX=2;
oCMenu.level[0].offsetY=1;
oCMenu.level[0].rows=0;
oCMenu.level[0].arrow=0;
oCMenu.level[0].arrowWidth=0;
oCMenu.level[0].arrowHeight=0;
oCMenu.level[0].align="bottom";


//EXAMPLE SUB LEVEL[1] PROPERTIES - You have to specify the properties you want different from LEVEL[0] - If you want all items to look the same just remove this
oCMenu.level[1]=new cm_makeLevel(); //Add this for each new level (adding one to the number)
oCMenu.level[1].width=oCMenu.level[0].width+5;
oCMenu.level[1].align="right";
oCMenu.level[1].offsetX=-1;
oCMenu.level[1].offsetY=0;
oCMenu.level[1].borderClass="clActiveMenuItemBorder1";
oCMenu.level[1].arrow="arrow.gif";
oCMenu.level[1].arrowWidth=6;
oCMenu.level[1].arrowHeight=7;


//EXAMPLE SUB LEVEL[2] PROPERTIES - You have to spesify the properties you want different from LEVEL[1] OR LEVEL[0] - If you want all items to look the same just remove this
oCMenu.level[2]=new cm_makeLevel() //Add this for each new level (adding one to the number)
oCMenu.level[2].width=120;
oCMenu.level[2].offsetX=0;
oCMenu.level[2].offsetY=0;

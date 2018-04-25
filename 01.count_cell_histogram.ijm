open("/Users/HSBR/Research/2017_Odagaki/00.Original_Data&Results/00.Raw_Images/day1/day1-6toothB4.tif")
B = getImageID()
open("/Users/HSBR/Research/2017_Odagaki/00.Original_Data&Results/00.Raw_Images/day1/day1-6toothG4.tif")
G = getImageID()
selectImage(G)
run("32-bit")
selectImage(B)
run("32-bit")
run("Merge Channels...", "c2=day1-6toothG4.tif c3=day1-6toothB4.tif create keep")
run("ROI Manager...")
title = "Make direction";
  msg = "Please draw a line to indicate the compression direction";
  waitForUser(title, msg);
  roiManager("Add")
  roiManager("Select",0)
  run("Clear Results")
  run("Measure")
  y=getResult("Angle",0)
  x=90-y
  makeRectangle(500, 500, 200, 310)
  run("Rotate...","angle=x")
  roiManager("Add")
title = "Make direction";
  msg = "Please draw a line to indicate the tension direction";
  waitForUser(title, msg);
    roiManager("Add")
  roiManager("Select",2)
  run("Measure")
  y=getResult("Angle",1)
  x=90-y
  makeRectangle(500, 500, 200, 310)
  run("Rotate...","angle=x")
  roiManager("Add")
  roiManager("show all")
  title = "Adjust the ROI";
    msg = "First setup the reference detin area. Move the ROI to compression side first then tension side";
    waitForUser(title, msg);
        selectImage(G)
        run("Clear Results")
    roiManager("select", 4)
    run("Measure")
    selectImage(G)
    roiManager("select", 1)
    run("Histogram", "bins=256 use x_min=2 x_max=140 y_max=Auto")
      title = "Save the compression side results";
    msg = "Save the compression side results";
    waitForUser(title, msg);
    selectImage(G)
    roiManager("select", 3)
    run("Histogram", "bins=256 use x_min=2 x_max=140 y_max=Auto")
      title = "Save the tension side results";
    msg = "Save the tension side results";
    waitForUser(title, msg);
    setBackgroundColor(NaN, NaN, NaN)
    a=roiManager("count")
    selectImage(B);
    for(i=5;i<a;i++){
	    roiManager("select", i);
	    run("Clear", "slice");
    }
    selectImage(B);
    roiManager("deselect");
        title = "pause for yen dark bug";
    msg = "pause for yen dark bug";
    waitForUser(title, msg);
    setAutoThreshold("Yen dark");
    roiManager("select", 1)
    run("Analyze Particles...", "  show=[Nothing] display summarize")
    roiManager("select", 3)
    run("Analyze Particles...", "  show=[Nothing] display summarize")
    selectImage(G)
    for(i=5;i<a;i++){
	    roiManager("select", i);
	    run("Clear", "slice");
    }
    x=getResult("Mean",0)
    lower=3*x
    upper=256
    roiManager("deselect")
    setThreshold(lower,upper)
    roiManager("select", 1)
    run("Analyze Particles...", "  show=[Nothing] display summarize")
    roiManager("select", 3)
    run("Analyze Particles...", "  show=[Nothing] display summarize")
    selectImage("Composite")
    run("From ROI Manager")
    title = "Select the green channel image and cancel the ROI on it";
    msg = "Select the green channel image and cancel the ROI on it";
    waitForUser(title, msg);
    run("Analyze Particles...", "display add")
selectImage("Composite")
roiManager("show all with labels")
run("Clear Results");
open("C:/Users/Denti/Documents/Research/2017_Odagaki/00.Original_Data&Results/00.Raw_Images/day5/day5-2toothB2.tif")
B = getImageID()
open("C:/Users/Denti/Documents/Research/2017_Odagaki/00.Original_Data&Results/00.Raw_Images/day5/day5-2toothG2.tif")
G = getImageID()
selectImage(G)
run("32-bit")
selectImage(B)
run("32-bit")
run("Merge Channels...", "c2=day5-2toothG2.tif c3=day5-2toothB2.tif create keep")
print("\\Clear")
C= getImageID()
selectImage(C)
run("ROI Manager...");
roiManager("Show All");
run("Channels Tool...");
setTool("line");
  title = "Make direction";
  msg = "Please draw a line to indicate the direction";
  waitForUser(title, msg);
  roiManager("Add")
  roiManager("select", 0)
  run("Clear Results")
  run("Measure")
  an=getResult("Angle",0)
  selectImage(G)
  run("Rotate... ", "angle=an grid=1 interpolation=None")
  selectImage(B)
  run("Rotate... ", "angle=an grid=1 interpolation=None")
  selectImage(C)
  run("Rotate... ", "angle=an grid=1 interpolation=None")
  roiManager("reset")
  makeRectangle(0,357,1360,310)
  roiManager("Add")
  roiManager("select",0)
    setTool("polygon")
    title = "Reference and Compress";
  msg = "Select the reference part first, Then compress side PLD";
  waitForUser(title, msg);
  selectImage(G)
  roiManager("select", 1)
  run("Measure")
  roiManager("select", 2)
  run("Measure")
  te=getResult("Area", 2)
  print(te)
  roiManager("select", 2)
  run("Histogram", "bins=256 use x_min=2.67 x_max=198.67 y_max=Auto")
      title = "Tension side";
  msg = "Select the tension side PDL";
  waitForUser(title, msg);
  selectImage(G)
  roiManager("select", 3)
  run("Measure")
  co=getResult("Area", 3)
  print(co)
  roiManager("select", 3)
  run("Histogram", "bins=256 use x_min=2.67 x_max=198.67 y_max=Auto")
  selectImage(C)
  close()
  selectImage(B)
  close()
  selectImage(G)
  close()
  run("Clear Results")
  roiManager("reset")
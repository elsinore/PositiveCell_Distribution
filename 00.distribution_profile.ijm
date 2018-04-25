open("C:/Users/Denti/Documents/Research/2017_Odagaki/00.Original_Data&Results/00.Raw_Images/day5/day5-2toothB2.tif")
B = getImageID()
open("C:/Users/Denti/Documents/Research/2017_Odagaki/00.Original_Data&Results/00.Raw_Images/day5/day5-2toothG2.tif")
G = getImageID()
selectImage(G)
run("32-bit")
selectImage(B)
run("32-bit")
run("Merge Channels...", "c2=day5-2toothG2.tif c3=day5-2toothB2.tif create keep")
C= getImageID()
selectImage(C)
run("ROI Manager...")
run("Channels Tool...");
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
  selectImage(C)
  makeRectangle(0,357,1360,310)
    title = "Make direction";
  msg = "Please adjust the ROI";
  waitForUser(title, msg);
  roiManager("Add")
  selectImage(B)
  roiManager("select",0)
  run("Plot Profile")
      title = "Make direction";
  msg = "Save the Blue profile";
  waitForUser(title, msg);
    selectImage(G)
  roiManager("select",0)
  run("Plot Profile")
        title = "Make direction";
  msg = "Save the Green profile";
  waitForUser(title, msg);
    selectImage(C)
    roiManager("select",0)
            title = "Make direction";
  msg = "Measure the boundary";
  waitForUser(title, msg);
  selectImage(C)
  close()
  selectImage(B)
  close()
  selectImage(G)
  close()
  run("Clear Results")
  roiManager("reset")
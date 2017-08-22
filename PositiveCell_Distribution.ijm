///Tool for positive cells' distribution
//global varibels
name = getInfo("image.filename"); dirImage = getInfo("image.directory");
rad = 0.01745329252;
roiN = roiManager("count");
run("32-bit");
setAutoThreshold("Yen dark");
run("Set Measurements...", "centroid feret's redirect=None decimal=6");
setTool("line");
title = "Make indicator";
  msg = "Please draw a line from upper left corner\n to bottom right corner of the boxes on both side";
  waitForUser(title, msg);
//Dialog for basic information
Dialog.create("Setting");
title = "Enter Number of Section";
width = 512; height = 512;
    Dialog.addChoice("Section No.:", newArray(4, 5, 8, 10));
    Dialog.addString("Group1 Name:", "Compression");
    Dialog.addNumber("Group1 Number:", 2);
    Dialog.addString("Group1 Name:", "Tension");
    Dialog.addNumber("Group1 Number:", 4);
    Dialog.addNumber("Width of ROI:", 200);
    Dialog.addNumber("Hight of ROI:", 310);
    Dialog.show();
		NuS = Dialog.getChoice();
		G1Name = Dialog.getString();
		G1N = Dialog.getNumber();
		G2Name = Dialog.getString();
		G2N = Dialog.getNumber();
		Wid = Dialog.getNumber();
		Hig = Dialog.getNumber();
	G1N_I = roiN;
	G2N_I = roiN+1;
	G1N = G1N - 1;
	G2N = G2N - 1;
	an0 = atan(Wid/Hig); //The angle between diagonal and hight
	diagonal_Ha = sqrt(pow(Wid, 2) + pow(Hig, 2))/2; // half length of diagonal
	increment = Wid/NuS;
//basic measurment
run("Clear Results");
roiManager("select", G1N);
run("Measure");
roiManager("select", G2N);
run("Measure");
roiManager("select", G1N_I);
run("Measure");
roiManager("select", G2N_I);
run("Measure");
//Basic parameter of Group 1
if(abs(getResult("FeretAngle", 0)-getResult("FeretAngle", 2)) >= (PI - 2*an0)){
	angle_G1 = getResult("FeretAngle",0);
	angle_G1_1 = angle_G1*rad - an0;
	angle_G1 = angle_G1*rad - (PI - 2*an0);
	an1_G1 = PI-angle_G1+an0;
	an2_G1 = angle_G1 - an0 - PI/2;
} else {
	angle_G1 = getResult("FeretAngle",0);
	angle_G1 = angle_G1*rad;
	an1_G1 = PI-angle_G1+an0;
	an2_G1 = angle_G1 - an0 - PI/2;
}

//Basic parameter of Group 2
if(abs(getResult("FeretAngle", 1)-getResult("FeretAngle", 3)) >= (PI - 2*an0)){
	angle_G2 = getResult("FeretAngle",1);
	angle_G2_1 = angle_G2*rad - an0;
	angle_G2 = angle_G2*rad - (PI - 2*an0);
	an1_G2 = PI-angle_G2+an0;
	an2_G2 = angle_G2 - an0 - PI/2;
} else {
	angle_G2 = getResult("FeretAngle",1);
	angle_G2 = angle_G2*rad;
	an1_G2 = PI-angle_G2+an0;
	an2_G2 = angle_G2 - an0 - PI/2;
}

//Group1 sections
G1_Sec = newArray(NuS*4+4);
for(i = 0; i < NuS; i++) {
	if(i == 0) {
		G1_Sec[0] = getResult("X", 0) + cos(angle_G1)*diagonal_Ha;
		G1_Sec[1] = getResult("Y", 0) - sin(angle_G1)*diagonal_Ha;
		G1_Sec[2] = sin(an2_G1) * Hig + G1_Sec[0];
		G1_Sec[3] = cos(an2_G1) * Hig + G1_Sec[1];
		G1_Sec[4] = G1_Sec[2] + sin(an1_G1) * increment;
		G1_Sec[5] = G1_Sec[3] - cos(an1_G1) * increment;
		G1_Sec[6] = G1_Sec[0] + sin(an1_G1) * increment;
		G1_Sec[7] = G1_Sec[1] - cos(an1_G1) * increment;
		makePolygon(
			G1_Sec[0],G1_Sec[1],
			G1_Sec[2],G1_Sec[3],
			G1_Sec[4],G1_Sec[5],
			G1_Sec[6],G1_Sec[7]
		);
		roiManager("add");
	} 
	else {
		G1_Sec[4+4*i] = G1_Sec[2+4*i] + sin(an1_G1) * increment;
		G1_Sec[5+4*i] = G1_Sec[3+4*i] - cos(an1_G1) * increment;
		G1_Sec[6+4*i] = G1_Sec[0+4*i] + sin(an1_G1) * increment;
		G1_Sec[7+4*i] =	G1_Sec[1+4*i] - cos(an1_G1) * increment;
		makePolygon(
			G1_Sec[4*i+0], G1_Sec[4*i+1],
			G1_Sec[4*i+2], G1_Sec[4*i+3],
			G1_Sec[4*i+4], G1_Sec[4*i+5],
			G1_Sec[4*i+6], G1_Sec[4*i+7]
		);
		roiManager("add");
	}
}
//Group2 sections
G2_Sec = newArray(NuS*4+4);
for(i = 0; i < NuS; i++) {
	if(i == 0) {
		G2_Sec[0] = getResult("X", 1) + cos(angle_G2)*diagonal_Ha;
		G2_Sec[1] = getResult("Y", 1) - sin(angle_G2)*diagonal_Ha;
		G2_Sec[2] = sin(an2_G2) * Hig + G2_Sec[i*6];
		G2_Sec[3] = cos(an2_G2) * Hig + G2_Sec[i*6+1];
		G2_Sec[4] = G2_Sec[2] + sin(an1_G2) * increment;
		G2_Sec[5] = G2_Sec[3] - cos(an1_G2) * increment;
		G2_Sec[6] = G2_Sec[0] + sin(an1_G2) * increment;
		G2_Sec[7] = G2_Sec[1] - cos(an1_G2) * increment;
		makePolygon(
			G2_Sec[0],G2_Sec[1],
			G2_Sec[2],G2_Sec[3],
			G2_Sec[4],G2_Sec[5],
			G2_Sec[6],G2_Sec[7]
		);
		roiManager("add");
	} 
	else {
		G2_Sec[4+4*i] = G2_Sec[2+4*i] + sin(an1_G2) * increment;
		G2_Sec[5+4*i] = G2_Sec[3+4*i] - cos(an1_G2) * increment;
		G2_Sec[6+4*i] = G2_Sec[0+4*i] + sin(an1_G2) * increment;
		G2_Sec[7+4*i] =	G2_Sec[1+4*i] - cos(an1_G2) * increment;
		makePolygon(
			G2_Sec[4*i+0], G2_Sec[4*i+1],
			G2_Sec[4*i+2], G2_Sec[4*i+3],
			G2_Sec[4*i+4], G2_Sec[4*i+5],
			G2_Sec[4*i+6], G2_Sec[4*i+7]
		);
		roiManager("add");
	}
}
roiManager("select", roiN);
roiManager("delete");
roiManager("select", roiN);
roiManager("delete");
//particle analyze
cellAmount = newArray();
for(i = 0; i < 2*NuS; i++) {
	if(i < NuS) {
		run("Clear Results");
		roiManager("select", roiN+i);
		run("Analyze Particles...", "display clear");
		cellAmount = Array.concat(cellAmount, nResults);
	} 
	else {
		run("Clear Results");
		roiManager("select", roiN-1+3*NuS-i);
		run("Analyze Particles...", "display clear");
		cellAmount = Array.concat(cellAmount, nResults);
	}
}
//result type in
title = "Now do cell counter";
  msg = "When you finish cell conter, press OK";
  waitForUser(title, msg);
distance = newArray();
for(i = 0; i < NuS; i++) {
	if(i == 0) {
		a1 = "0"+"-"+increment;
		distance = Array.concat(distance, a1);		
	}
	else {
		a1 = ""+i*increment+"-"+increment*(i+1);
		distance = Array.concat(distance, a1);
	}

}
colname = "ID" + "," + "Distance" + "," + "Entire Cell Amount" + "," + "Positive Cell Amount";
print("\\Clear");
print(colname);
for(i = 0; i < 2*NuS; i++) {
	if(i < NuS) {
		number = i + 1;
		a = getNumber("Positive cell of "+G1Name+number, 0);
		b = name + " " + G1Name + number;
		line = "S" + b + "," + distance[i] + "," + cellAmount[i] + "," + a;
		print(line);
	}
	else {
		number = i - NuS + 1;
		a = getNumber("Positive cell of "+G2Name+number, 0);
		b = name + " " + G2Name + number;
		line = "S" + b+ "," + distance[i-NuS] + "," + cellAmount[i] + "," + a;
		print(line);
	}
}
selectWindow("Log");
saveAs("Text", dirImage + name + "CellCounter" + ".csv"); 
selectWindow("Log");
run("Close");
exit();
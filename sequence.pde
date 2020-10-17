boolean record = true;

PCube cube;
ArrayList<Point> stars = new ArrayList<Point>();

SpringValue tunnelH; // Height of the tunnel ceiling and floor
SpringValue tunnelW;
SpringValue tunnelV; // Speed that the tunnel advances at
float tunnelBack; // Z-coord at which tunnel is deleted
float tunnelFront; // Z-coord at which tunnel spawned
float cubeDefaultW;

void setupSketch() {
	lines = loadStrings("disintegrate.txt");
	backFill = new IColor(0,0,0,100);
	dustStyle = new IColor(0,50,50,100);

	cubeDefaultW = de*.6;
	cube = new PCube(0,0,0, cubeDefaultW, 0,0,0, -1);
	cube.strokeStyle.reset(0,25,75,100);
	cube.av.reset(.001,.0012,0);

	tunnelW = new SpringValue(de*11);
	tunnelH = new SpringValue(de*2.8);
	tunnelV = new SpringValue(de*.04);
	tunnelBack = de*2.5;
	tunnelFront = -de*7;

	for (int i = 0 ; i < 2000 ; i ++) {
		stars.add(new Point(randomR(tunnelW.x), randomR(tunnelH.x*1.2), random(tunnelFront, tunnelBack)));
	}

	seekToBeat(0);
}

int floorCD = 0;

void sequence() {
	if (frameCount == 18697) exit();

	// CLAPPING
	if (beatQ && (beatInRange(103,128) || beatInRange(229,260) || beatInRange(420,449))) {
		for (Rect3 mob : rects) {
			mob.strokeStyle.b.v += 150;
		}
	}

	//HIHATS
	if (beatQ && currBeat % 1 == .5 && (beatInRange(163,260) || beatInRange(420,449))) {
		for (Rect3 mob : rects) {
			mob.strokeStyle.r.v += 222;
			mob.strokeStyle.g.v += 222;
			mob.strokeStyle.b.v += 222;
		}
	}

	if (!beatInRange(258,322)) corridor();
	if (beatInRange(0,4)) {
		if (frameCount < 10) {
			tunnelV.reset(de*.1);
			cube.w.reset(0,0,0);
		}
	} else if (beatInRange(4,103)) { // BASS
		cubeDust();
		cubePulse();
		if (beatE(4)) {
			tunnelV.X = de*.04;
			float amp = cubeDefaultW;
			cube.w.P.set(amp,amp,amp);
		}
	} else if (beatInRange(103,131)) { // CLAPPING, BUILDUP
		cubeDust();
		if (currBeat < 126) cubeStreaks();
		cubePulse();
		if (beatE(103)) {
			cube.av.P.mult(15);
		}
		if (beatQ) {
			float amp = 4;
			cube.w.P.sub(amp,amp,amp);
		}
	} else if (beatInRange(131,260)) { // DROP
		cubeDust(2);
		cubeStreaks(2);
		if (currBeat >= 132) cubePulse();
		cubePulseA(2);
		if (beatE(131)) {
			float amp = cubeDefaultW;
			cube.w.P.set(amp,amp,amp);
			cube.av.P.mult(1.0/15);
		}
		for (int i = 0 ; i < stars.size() ; i ++) {
			Point p = stars.get(i);
			p.v.z += main[i%main.length]*de*.01;
		}
		for (int i = 0 ; i < rects.size() ; i ++) {
			Rect3 mob = rects.get(i);
			mob.w.p.y += main[mob.id%main.length]*de*.001;
		}
	} else if (beatInRange(260,324)) { // QUIET
		cubeDust(.4);
	} else if (beatInRange(324,388)) { // MELODY STARTS
		cubePulse(.35);
		cubeDust(.75);
	} else if (beatInRange(388,403)) { // BUILDUP
		cubeDust(.5);
		cubeStreaks(.5);
		cubePulse(.65);
		cubePulseA(.5);
	} else if (beatInRange(403,420)) { // MORE BUILDUP
		cubeDust(.75);
		cubeStreaks(.75);
		cubePulse(.85);
		cubePulseA(.75);
	} else if (beatInRange(420,452)) { // CLAPPING, BUILDUP
		cubeDust(1);
		if (currBeat < 448) cubeStreaks(1);
		cubePulse(1);
		cubePulseA(1);
		if (beatE(420)) {
			cube.av.P.mult(18);
		}
		if (beatQ) {
			float amp = 5;
			cube.w.P.sub(amp,amp,amp);
		}
		if (beatE(451)) {
			float amp = cubeDefaultW*1.6;
			cube.w.P.set(amp,amp,amp);
			cube.av.P.mult(1.0/18);
		}
	} else if (beatInRange(452,516)) { // DROP
		cubeDust(2);
		cubeStreaks(2);
		if (currBeat >= 452) cubePulse();
		cubePulseA(2);
		for (int i = 0 ; i < stars.size() ; i ++) {
			Point p = stars.get(i);
			p.v.z += main[i%main.length]*de*.01;
		}
		for (int i = 0 ; i < rects.size() ; i ++) {
			Rect3 mob = rects.get(i);
			mob.w.p.y += main[mob.id%main.length]*de*.001;
		}
	} else if (beatInRange(516,580)) { // QUIETER
		cubeDust(.5);
		cubeStreaks(.5);
		cubePulse(.5);
		cubePulseA(.5);
	} else if (beatInRange(580,665)) { // ONLY BASS
		cubeDust(.25);
		cubePulse(.5);
	}

	dustPNoise(0, .01,.001,.001,de*.14);
	dustFillNoise(0, .01,.003,.003, 0,15,50, 30,30,30, 0,1,1);
	streakFillNoise(0, .01,.003,.003, 0,15,50, 30,30,30, 0,1,1);
}
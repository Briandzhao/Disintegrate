/*
ADD CORRIDOR FLOOR/CEILING BACK
SAME STYLE AS THE CUBE/STREAKS
USE RECT3

Disintegrate
1 riser
5 bass
117 clapping starts
146 "disintegrate"
147 drop
185 hihat -- 
221 dinky thing
257 clapping
293 quiet
365 melody
401 hihat
437 buildup -- CUBE SHRINKS AND BRIGHTENS
455 buildup 2, intensity
473 buildup 3, clapping
506 "disintegrate"
507 drop 2
581 quieter, fading
652 quiet, only bass
724 end
*/
boolean record = false;

PCube cube;
ArrayList<Point> stars = new ArrayList<Point>();

SpringValue tunnelH; // Height of the tunnel ceiling and floor
SpringValue tunnelW;
SpringValue tunnelV; // Speed that the tunnel advances at
float tunnelBack; // Z-coord at which objects are deleted
float tunnelFront; // Z-coord at which objects are spawned

void setupSketch() {
	lines = loadStrings("disintegrate.txt");
	backFill = new IColor(0,0,0,100);
	dustStyle = new IColor(0,50,50,100);

	cube = new PCube(0,0,0, de*.7, 0,0,0, -1);
	cube.strokeStyle.reset(0,50,100,100);

	cube.av.reset(.001,.0012,0);

	tunnelW = new SpringValue(de*11);
	tunnelH = new SpringValue(de*2.8);
	tunnelV = new SpringValue(de*.04);
	tunnelBack = de*2.5;
	tunnelFront = -de*7;

	for (int i = 0 ; i < 2000 ; i ++) {
		stars.add(new Point(randomR(tunnelW.x), randomR(tunnelH.x), -de*2.8));
	}

	seekToBeat(0);
}

int floorCD = 0;

void sequence() {
	dustPNoise(0, .01,.001,.001,de*.14);
	dustFillNoise(0, .01,.01,.01, 0,15,75, 240,0,0, 0,1,1);
	streakFillNoise(0, .01,.01,.01, 0,15,75, 240,0,0, 0,1,1);

	// CLAPPING
	if (beatQ && (beatInRange(117,147) || beatInRange(257,293) || beatInRange(473,506))) {
		for (Rect3 mob : rects) {
			mob.strokeStyle.b.v += 150;
		}
	}

	//HIHATS
	if (beatQ && currBeat % 1 == .5 && (beatInRange(185,293) || beatInRange(401,506))) {
		for (Rect3 mob : rects) {
			mob.strokeStyle.r.v += 240;
			mob.strokeStyle.g.v += 300;
			mob.strokeStyle.b.v += 75;
		}
	}

	if (beatInRange(0,5)) {
		if (beatE(0)) {
			tunnelV.reset(de*.1);
			cube.w.reset(0,0,0);
		}
	} else if (beatInRange(5,117)) {
		if (beatE(5)) {
			tunnelV.X = de*.04;
			float amp = de*1;
			cube.w.P.set(amp,amp,amp);
		}
	} else if (beatInRange(117,147)) {
		if (beatE(117)) {
			cube.av.P.mult(5);
		}
		if (beatQ) {
			for (Rect3 mob : rects) {
				mob.strokeStyle.b.v += 150;
			}
			float amp = 4;
			cube.w.P.sub(amp,amp,amp);
		}
	} else if (beatInRange(147,293)) {
		if (beatE(147)) {
			float amp = de*.7;
			cube.w.P.set(amp,amp,amp);
			cube.av.P.mult(1.0/5);
		}
		for (int i = 0 ; i < stars.size() ; i ++) {
			Point p = stars.get(i);
			p.v.z += main[i%main.length]*de*.01;
		}
		for (int i = 0 ; i < rects.size() ; i ++) {
			Rect3 mob = rects.get(i);
			mob.p.p.y += main[mob.id%main.length]*de*.01;
		}
	} else if (beatInRange(293,365)) {
	} else if (beatInRange(365,437)) {
	} else if (beatInRange(437,507)) {
	} else if (beatInRange(507,652)) {
	} else if (beatInRange(652,724)) {
	}
}

void passiveSequence() {
	corridor();
	if (beatInRange(0,5)) {
	} else if (beatInRange(5,117)) {
		cubeDust();
		cubePulse();
	} else if (beatInRange(117,147)) {
		cubeDust();
		cubeStreaks();
		cubePulse();
	} else if (beatInRange(147,293)) {
		cubeDust();
		cubeStreaks();
		cubePulse();
		cubePulseA();
	} else if (beatInRange(293,365)) {
		cubeDust();
	} else if (beatInRange(365,437)) {
		cubePulse();
		cubeDust();
	} else if (beatInRange(437,507)) {
		cubeDust();
		cubeStreaks();
		cubePulse();
	} else if (beatInRange(507,652)) {
		cubeDust();
		cubeStreaks();
		cubePulse();
		cubePulseA();
	} else if (beatInRange(652,724)) {
		cubeDust();
		cubeStreaks();
		cubePulse();
	}
}

void colorSequence() {
	if (beatInRange(0,5)) {
	} else if (beatInRange(5,147)) {
	} else if (beatInRange(147,293)) {
	} else if (beatInRange(293,365)) {
	} else if (beatInRange(365,437)) {
	} else if (beatInRange(437,507)) {
	} else if (beatInRange(507,652)) {
	} else if (beatInRange(652,724)) {
	}
}
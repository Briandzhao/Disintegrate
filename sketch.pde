float defaultMass = .2;
float defaultVMult = .1;
float fillMass = .2;
float fillVMult = .1;

float tRate = 0;

float[] main = new float[144];
String[] lines;

float bpm = 128;
int offset = 0;
float fpb = 3600.0/bpm;
float fpqb = fpb/4;
boolean beat = false;
boolean beatQ = false;
float currBeat = 0;
float avg;

void render() {
	avg = 0;
	for (int i = 0 ; i < main.length ; i ++) {
		avg += main[i];
	}
	avg /= main.length;
	tRate += 1 + avg*.1;


	dustStyle.update();
	tunnelV.update();
	cube.update();
	cube.render();

	for (Point p : stars) {
		p.update();
		p.render();
	}

	for (int i = 0 ; i < dust.size() ; i ++) {
		Dust mob = dust.get(i);
		mob.update();
		mob.render();
		if (mob.lifeSpan == 0) {
			dust.remove(i);
			i --;
		}
	}

	for (int i = 0 ; i < rects.size() ; i ++) {
		Rect3 mob = rects.get(i);
		mob.p.P.z += tunnelV.x;
		mob.update();
		mob.render();
		if (mob.lifeSpan == 0 || mob.p.p.z > de*2) {
			rects.remove(i);
			i --;
		}
	}

	noFill();
	for (int i = 0 ; i < streaks.size() ; i ++) {
		Streak mob = streaks.get(i);
		mob.update();
		mob.render();
		if (mob.finished) {
			streaks.remove(i);
			i --;
		}
	}
	
	passiveSequence();
	sequence();
	colorSequence();

	dustA.clear();
	streaksA.clear();
	rectsA.clear();

	if (record) saveFrame("F:/cubeanimations/disintegrate/#####.png");
}
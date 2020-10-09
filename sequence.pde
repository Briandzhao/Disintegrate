boolean record = true;

/*
Disintegrate
1 riser
5 bass
117 clapping starts
146 "disintegrate"
147 drop
185 hihat
221 dinky thing
257 clapping
293 quiet
365 melody
401 hihat
437 buildup
455 buildup 2, intensity
473 buildup 3, clapping
506 "disintegrate"
507 drop 2
581 quieter, fading
652 quiet, only bass
724 end
*/

PCube cube;

void setupSketch() {
	lines = loadStrings("disintegrate.txt");
	backFill = new IColor(0,0,0,100);
	dustStyle = new IColor(0,50,50,100);

	cube = new PCube(0,0,0, de*.8, 0,0,0, -1);
	cube.strokeStyle.reset(0,50,100,100);

	cam.av.reset(.001,.0012,0);

	seekTo(3600);
}

int floorCD = 0;
void sequence() {

	float amp = cos((float)frameCount/fpb*PI2)*(255+avg*30);
	cube.w.v.add(amp,amp,amp);

	for (int i = 0 ; i < 36 ; i ++) {
		Dust mob = new Dust(random(-cube.w.p.x,cube.w.p.x),random(-cube.w.p.y,cube.w.p.y),random(-cube.w.p.z,cube.w.p.z),(int)random(120,150));
		cube.dar.add(mob);
	}
	// for (int i = 0 ; i < 1 ; i ++) {
	// 	Seg mob = new Seg(cube.dar.get((int)random(cube.dar.size())), cube.dar.get((int)random(cube.dar.size())), .3, 122);
	// 	cube.sar.add(mob);
	// }

	dustPNoise(0, .01,.001,.001,de*.14);
	dustFillNoise(0, .01,.001,.001, 0,15,75, 122,75,25, .01);

	if (beatInRange(0,5)) {
	} else if (beatInRange(5,147)) {
		if (beatInRange(117,147)) {
		}
	} else if (beatInRange(147,293)) {
	} else if (beatInRange(293,365)) {
	} else if (beatInRange(365,437)) {
	} else if (beatInRange(437,507)) {
	} else if (beatInRange(507,652)) {
	} else if (beatInRange(652,724)) {
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

void dustFillNoise(int which, float amp, float amp2, float amp3, float r, float g, float b, float rr, float gr, float br, float amp4) {
	switch(which) {
		case 0:
		for (int i = 0 ; i < dust.size() ; i ++) {
			Dust mob = dust.get(i);
			mob.strokeStyle.setC(
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 1111)-.5)*rr + r,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 3333)-.5)*gr + g,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 5555)-.5)*br + b,
				100
			);
			mob.strokeStyle.setM(rr*amp4,gr*amp4,br*amp4,0);
		}
		for (PCube c : cubes) {
			for (int i = 0 ; i < c.dar.size() ; i ++) {
				Dust mob = c.dar.get(i);
				mob.strokeStyle.setC(
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 1111)-.5)*rr + r,
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 3333)-.5)*gr + g,
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 5555)-.5)*br + b,
					100
				);
				mob.strokeStyle.setM(rr*amp4,gr*amp4,br*amp4,0);
			}
		}
		break;
	}
}

void indexNoise(ArrayList<MobL> dar, int which, float amp, float amp2, float amp3, float amp4) {
	switch(which) {
		case 0:
		for (int i = 0 ; i < dar.size() ; i ++) {
			MobL mob = dar.get(i);
			mob.setIndex((noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3)-.5)*amp4);
		}
	}
}

void pNoise(ArrayList<MobL> dar, int which, float amp, float amp2, float amp3, float amp4) {
	switch(which) {
		case 0:
		for (int i = 0 ; i < dar.size() ; i ++) {
			MobL mob = dar.get(i);
			mob.p.P.add(
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 1111)-.5)*amp4,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 3333)-.5)*amp4,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 5555)-.5)*amp4
			);
		}
		break;
	}
}

void dustPNoise(int which, float amp, float amp2, float amp3, float amp4) {
	switch(which) {
		case 0:
		for (int i = 0 ; i < dust.size() ; i ++) {
			Dust mob = dust.get(i);
			mob.p.P.add(
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 1111)-.5)*amp4,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 3333)-.5)*amp4,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 5555)-.5)*amp4
			);
		}
		for (PCube c : cubes) {
			for (int i = 0 ; i < c.dar.size() ; i ++) {
				Dust mob = c.dar.get(i);
				mob.p.P.add(
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 1111)-.5)*amp4,
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 3333)-.5)*amp4,
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 5555)-.5)*amp4
				);
			}
		}
		break;
	}
}
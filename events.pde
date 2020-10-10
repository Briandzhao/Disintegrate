void corridor(int num, float r, float g, float b, float a) {
	if (floorCD % (int)(tunnelW.x/num/tunnelV.x) == 0) {
		rectFloor(-tunnelH.x/2, tunnelFront, tunnelW.x * (1+noise(tRate)*.1), num);
		rectFloor(tunnelH.x/2, tunnelFront, tunnelW.x * (1+noise(tRate)*.1), num);

		for (int i = 0 ; i < rectsA.size() ; i ++) {
			Rect3 mob = rectsA.get(i);
			mob.fillStyle.reset(0,0,0,100);
			mob.strokeStyle.reset(r,g,b,a);
		}

		floorCD = 1;
	}
	floorCD ++;
}
void corridor() {
	corridor(32, 0,0,25,50);
}

void cubePulse(float amp) {
	if (beatQ && currBeat % 1 == 0) {
		cube.w.P.mult(amp);
	} else if (beatQ && currBeat % 1 == .25) {
		cube.w.P.mult(1/amp);
	}
}
void cubePulse() {
	cubePulse(2);
}

void cubePulseA(float amp) {
	if (beatQ && currBeat % 1 == 0) {
		cube.av.v.add(cube.av.P.x*amp, cube.av.P.y*amp, cube.av.P.z*amp);
	}
}
void cubePulseA() {
	cubePulse(200);
}

void cubeDust(float num) {
	for (int i = 0 ; i < num ; i ++) {
		Dust mob = new Dust(random(-cube.w.p.x,cube.w.p.x),random(-cube.w.p.y,cube.w.p.y),random(-cube.w.p.z,cube.w.p.z),(int)random(30,60));
		cube.dar.add(mob);
	}
}
void cubeDust() {
	cubeDust(avg*25);
}

void cubeStreaks(float num) {
	for (int i = 0 ; i < num ; i ++) {
		Streak mob = new Streak(0,0,0, 
			20, random(PI2),random(PI2), 1, 60, random(10),random(10),random(1),random(1),.1,1);
		cube.sar.add(mob);
	}
}
void cubeStreaks() {
	cubeStreaks(avg*.2);
}

float rectFloorAmp = 1.1;
void rectWall(float x, float z, float h, int numy) {
	float t;
	for (int i = 0 ; i < numy ; i ++) {
		t = ((float)(i+.5)/numy)-.5;
		Rect3 mob = new Rect3(x,t*h,z, 0,h/numy,h/numy, 0,0,0, -1);
		rectsA.add(mob);
	}
}

void rectFloor(float y, float z, float w, int numx) {
	float t;
	for (int i = 0 ; i < numx ; i ++) {
		t = ((float)(i+.5)/numx)-.5;
		Rect3 mob = new Rect3(t*w,y,z, w/numx*rectFloorAmp,0,w/numx*rectFloorAmp, 0,0,0, -1);
		rectsA.add(mob);
	}
}

void dustFillNoise(int which, float amp, float amp2, float amp3, float r, float g, float b, float rr, float gr, float br, float rm, float gm, float bm) {
	switch(which) {
		case 0:
		for (int i = 0 ; i < dust.size() ; i ++) {
			Dust mob = dust.get(i);
			mob.strokeStyle.setC(
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 1111))*rr + r,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 3333))*gr + g,
				(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 5555))*br + b,
				100
			);
			mob.strokeStyle.setM(rm,gm,bm,0);
		}
		for (PCube c : cubes) {
			for (int i = 0 ; i < c.dar.size() ; i ++) {
				Dust mob = c.dar.get(i);
				mob.strokeStyle.setC(
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 1111))*rr + r,
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 3333))*gr + g,
					(noise(tRate*amp + i*amp2 + mob.p.p.z*amp3, mob.p.p.y*amp3, mob.p.p.x*amp3 + 5555))*br + b,
					100
				);
				mob.strokeStyle.setM(rm,gm,bm,0);
			}
		}
		break;
	}
}

void streakFillNoise(int which, float amp, float amp2, float amp3, float r, float g, float b, float rr, float gr, float br, float rm, float gm, float bm) {
	switch(which) {
		case 0:
		for (int i = 0 ; i < streaks.size() ; i ++) {
			Streak mob = streaks.get(i);
			PVector p = mob.ar.get(mob.ar.size()-1).p;
			mob.strokeStyle.setC(
				(noise(tRate*amp + i*amp2 + p.z*amp3, p.y*amp3, p.x*amp3 + 1111))*rr + r,
				(noise(tRate*amp + i*amp2 + p.z*amp3, p.y*amp3, p.x*amp3 + 3333))*gr + g,
				(noise(tRate*amp + i*amp2 + p.z*amp3, p.y*amp3, p.x*amp3 + 5555))*br + b,
				100
			);
			mob.strokeStyle.setM(rm,gm,bm,0);
		}
		for (PCube c : cubes) {
			for (int i = 0 ; i < c.sar.size() ; i ++) {
				Streak mob = c.sar.get(i);
				PVector p = mob.ar.get(mob.ar.size()-1).p;
				mob.strokeStyle.setC(
					(noise(tRate*amp + i*amp2 + p.z*amp3, p.y*amp3, p.x*amp3 + 1111))*rr + r,
					(noise(tRate*amp + i*amp2 + p.z*amp3, p.y*amp3, p.x*amp3 + 3333))*gr + g,
					(noise(tRate*amp + i*amp2 + p.z*amp3, p.y*amp3, p.x*amp3 + 5555))*br + b,
					100
				);
				mob.strokeStyle.setM(rm,gm,bm,0);
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
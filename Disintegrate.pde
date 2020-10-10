// DIMENSIONS
static float de, dx, dy;
PVector front; // Positive xyz corner of bounding box
PVector back; // Negative xyz corner of bounding box

// CAMERA
Camera cam;

// KEYBOARD
char keyR;
char keyP;
boolean paused = false;

// COLOR
static float colorHMax = 360;
static float colorSMax = 100;
static float colorBMax = 100;
static float colorAMax = 100;

// SPECIAL VALUES
static float PI2 = PI * 2;
static float GR = 1.61803398875;
static float GR2 = 1.0/GR;
float[] cosv = new float[360];
float[] sinv = new float[360];

// BACKGROUND
IColor backFill;

void setup() {
	size(1024,540,P3D);
	de = (width + height)/2;
	dx = width;
	dy = height;
	front = new PVector(dx,dy,de);
	back = new PVector(-dx,-dy,-de);
	cam = new Camera(0,0,0, 0,0,0);

	textSize(de/10);
	textAlign(CENTER);
	rectMode(CENTER);
	colorMode(HSB, colorHMax, colorSMax, colorBMax, colorAMax);
	setupSketch();

	for (int i = 0 ; i < cosv.length ; i ++) {
		cosv[i] = cos((float)i/cosv.length*PI2);
		sinv[i] = sin((float)i/cosv.length*PI2);
	}
}

void draw() {
	if (frameCount == lines.length) exit();
	for (int i = 0 ; i < 144 ; i ++) {
		main[i] = convertDec("" + lines[frameCount].charAt(i*2) + lines[frameCount].charAt(i*2+1));
	}

	if ((frameCount + offset) % fpb < 1) {
		beat = true;
		println(currBeat + " " + frameCount + " " + frameRate);
	} else {
		beat = false;
	}
	if ((frameCount + offset) % fpqb < 1) {
		beatQ = true;
		currBeat += .25;
	} else {
		beatQ = false;
	}

	backFill.update();
	background(backFill.r.x, backFill.g.x, backFill.b.x);

	cam.update();
	cam.render();

	render();
}

void mouseReleased() {
	if (!paused) {
		seekTo((int)((float)mouseX/width*lines.length));
	}
}

void keyPressed() {
	// Camera control
	if (key == 'e') {
		if (!cam.lock) {
			cam.lock = true;
			cam.ang.P.set(cam.dang.x, cam.dang.y, cam.dang.z);
		} else {
			cam.lock = false;
		}
		println("Cam lock: " + cam.lock);
	}

	if (key == 'w') cam.p.P.z += 500;
	if (key == 's') cam.p.P.z -= 500;
	if (key == 'a') cam.p.P.x += 500;
	if (key == 'd') cam.p.P.x -= 500;
	if (key == 'i') cam.z.X += 500;
	if (key == 'o') cam.z.X -= 500;
	if (key == 'r') cam.z.X = 0;

	// Pause control
	if (key == ' ') {
		if (paused) {
			loop();
		} else {
			noLoop();
		}
		paused = !paused;
	}
	
	// Seek to song section
	switch(key) {
		case '0':
		break;
		case '1':
		break;
		case '2':
		break;
	}

	println(key + " " + (int)frameRate + " " + frameCount);
}
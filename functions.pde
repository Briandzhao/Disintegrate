void seekTo(int frame) {
	frameCount = frame;
	println("Seeked to: " + frameCount);
}

void seekToBeat(float beat) {
	currBeat = beat;
	seekTo((int)(beat*fpb + offset));
}

boolean beatInRange(float minBeat, float maxBeat) {
	return currBeat >= minBeat && currBeat < maxBeat;
}

boolean beatE(float b) {
	return beatQ && currBeat == b;
}

int convertDec(String hum) {
	return convertDecChar(hum.charAt(0)) + convertDecChar(hum.charAt(1))*16;
}

int toFrames(float beats) {
	return (int)(fpb * beats);
}

int convertDecChar(char h) {
	switch (h) {
		default:
		return 0;
		case '1':
		return 1;
		case '2':
		return 2;
		case '3':
		return 3;
		case '4':
		return 4;
		case '5':
		return 5;
		case '6':
		return 6;
		case '7':
		return 7;
		case '8':
		return 8;
		case '9':
		return 9;
		case 'a':
		return 10;
		case 'b':
		return 11;
		case 'c':
		return 12;
		case 'd':
		return 13;
		case 'e':
		return 14;
		case 'f':
		return 15;
	}
}

void pitches(float x, float y, float[] af) {
	push();
	fill(255);
	for (int i = 0 ; i < af.length ; i ++) {
		rect(x + (float)i/af.length*de*2-de,y, de*2/af.length,af[i]*de/af.length);
	}
	pop();
}

void pitches(float[] af) {
	pitches(0,0,af);
}

void watermark() {
	push();
	fill(0);
	text("@cube.animations", 0, sin(frameCount*.01)*de);
	pop();
}

float randomS(float minR, float maxR, float seg) {
	return random(minR/seg, maxR/seg)*seg;
}

int randomI(int[] list) {
	return list[(int)random(list.length)];
}

float randomR(float minR, float maxR) {
	if (random(1) < 0.5) {
		return random(-maxR,-minR);
	} else {
		return random(minR,maxR);
	}
}

float randomR(float r) {
	return random(-r,r);
}

int randomD() {
	if (random(1) > 0.5) {
		return 1;
	}
	return -1;
}
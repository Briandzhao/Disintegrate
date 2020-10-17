ArrayList<Streak> streaks = new ArrayList<Streak>();
ArrayList<Streak> streaksA = new ArrayList<Streak>();
int streakID = 0;

class Streak extends Entity {
	float tick;
	int num, id;
	ArrayList<Point> ar = new ArrayList<Point>();
	IColor strokeStyle = new IColor();
	SpringValue strokeW = new SpringValue(1);
	PVector dir;
	SpringValue w;

	PVector nOffset, nSlope;
	float nAmp, wAmp;

	Streak(float x, float y, float z, float wx, float ax, float ay, float tick, int num, 
		float x1, float y1, float ax1, float ay1, float amp1, float amp2) {
		ar.add(new Point(x,y,z));
		this.tick = tick; this.num = num;
		dir = new PVector(ax,ay);
		w = new SpringValue(wx);
		setNoise(x1,y1,ax1,ay1,amp1,amp2);
		streaksA.add(this);
		id = streakID;
		streakID ++;
		setIndex(id);
	}

	Streak(float x, float y, float z, float wx, float tick, int num) {
		this(x,y,z, wx, random(PI2),random(PI2), tick, num, 0,0,0,0,0,0);
	}

	void update() {
		for (Point pp : ar) pp.update();

		float amp = .91;
		for (int i = 1 ; i < ar.size() - 1 ; i ++) {
			Point p1 = ar.get(i-1);
			Point p2 = ar.get(i);
			Point p3 = ar.get(i+1);
			p2.P.x = (p1.p.x*.25+p3.p.x*.25+p2.p.x*.5)*.1+p2.P.x*.9;
			p2.P.y = (p1.p.y*.25+p3.p.y*.25+p2.p.y*.5)*.1+p2.P.y*.9;
			p2.P.z = (p1.p.z*.25+p3.p.z*.25+p2.p.z*.5)*.1+p2.P.z*.9;
			// p2.P.add((p1.P.x-p2.P.x)*amp, (p1.P.y-p2.P.y)*amp, (p1.P.z-p2.P.z)*amp);
			// p2.P.add((p3.P.x-p2.P.x)*amp, (p3.P.y-p2.P.y)*amp, (p3.P.z-p2.P.z)*amp);
		}

		dir.add(
			(noise(tRate*nAmp+111, nOffset.x + nSlope.x*tRate, nOffset.y + nSlope.x*tRate)-.5) * wAmp,
			(noise(tRate*nAmp+333, nOffset.x + nSlope.x*tRate, nOffset.y + nSlope.x*tRate)-.5) * wAmp
			);

		w.update();
		strokeStyle.update();
		strokeW.update();
		if (alive && frameCount % tick < 1) {
			extend();
			if (tick < 1) {
				for (int i = 0 ; i < 1.0/tick ; i ++) extend();
			}
		}
		if (!alive && strokeW.x < 0) finished = true;
	}

	void extend() {
		if (ar.size() == num) {
			die();
		} else {
			PVector p = ar.get(ar.size()-1).p;
			ar.add(new Point(p.x + cos(dir.x)*cos(dir.y)*w.x, p.y + sin(dir.x)*cos(dir.y)*w.x, p.z + sin(dir.y)*w.x));
		}
	}

	void setIndex(float k) {
		strokeStyle.setIndex(k);
		strokeW.setIndex(k);
		w.setIndex(k);
	}

	void setNoise(float x,float y, float ax, float ay, float amp1, float amp2) {
		nOffset = new PVector(x,y);
		nSlope = new PVector(ax,ay);
		nAmp = amp1;
		wAmp = amp2;
	}

	void render() {
		strokeStyle.strokeStyle();
		strokeWeight(strokeW.x);
		beginShape();
		for (int i = 0 ; i < ar.size() ; i ++) {
			PVector p = ar.get(i).p;
			vertex(p.x,p.y,p.z);
		}
		endShape();
	}

	void die() {
		alive = false;
		strokeW.X = -1;
	}
}
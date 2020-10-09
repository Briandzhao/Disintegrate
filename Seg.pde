// Takes two Dust objects, and tries to make a curve between them
class Seg extends Entity {
	Dust p1, p2;
	float tick;
	int num;
	ArrayList<Point> ar = new ArrayList<Point>();
	IColor strokeStyle = new IColor();
	SpringValue strokeW = new SpringValue(2);
	PVector p;

	Seg(Dust p1, Dust p2, float tick, int num) {
		this.p1 = p1; this.p2 = p2; this.tick = tick; this.num = num;
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
		if (p1.lifeSpan == 0 || p2.lifeSpan == 0 || p1.tp || p2.tp) {
			die();
		}
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
			finished = true;
		} else {
			float t = (float)ar.size()/num;
			float dx = p2.p.p.x - p1.p.p.x;
			float dy = p2.p.p.y - p1.p.p.y;
			float dz = p2.p.p.z - p1.p.p.z;
			ar.add(new Point(p1.p.p.x + dx*t, p1.p.p.y + dy*t, p1.p.p.z + dz*t));
		}
	}

	void render() {
		strokeStyle.strokeStyle();
		strokeWeight(strokeW.x);
		beginShape();
		vertex(p1.p.p.x,p1.p.p.y,p1.p.p.z);
		for (int i = 0 ; i < ar.size() ; i ++) {
			p = ar.get(i).p;
			vertex(p.x,p.y,p.z);
		}
		endShape();
	}

	void die() {
		alive = false;
		strokeW.X = -1;
	}
}
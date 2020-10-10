ArrayList<Rect3> rects = new ArrayList<Rect3>();
ArrayList<Rect3> rectsA = new ArrayList<Rect3>();
int rectID = 0;

class Rect3 extends MobL {
	Point w;
	IColor fillStyle = new IColor();
	IColor strokeStyle = new IColor();
	int id;

	Rect3(float x, float y, float z, float wx, float wy, float wz, float ax, float ay, float az, int lifeSpan) {
		super(x,y,z, ax,ay,az, lifeSpan);
		w = new Point(wx,wy,wz);
		dieSpan = 15;
		rectsA.add(this);
		rects.add(this);
		id = rectID;
		rectID ++;
		setIndex(id%52);
	}

	void update() {
		super.update();
		w.update();
		fillStyle.update();
		strokeStyle.update();
	}

	void render() {
		setDraw();
		fillStyle.fillStyle();
		strokeStyle.strokeStyle();
		if (w.p.z > 0) {
			box(w.p.x,w.p.y,w.p.z);
		} else {
			rect(0,0,w.p.x,w.p.y);
		}
		pop();
	}

	void setIndex(float k) {
		super.setIndex(k);
		w.setIndex(k);
		fillStyle.setIndex(k);
	}

	void dead() {
		finished = true;
	}

	void die() {
		w.P.set(0,0,0);
		alive = false;
	}
}
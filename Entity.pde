abstract class MobL extends EntityL {
	Point p, ang;
	Point pv = new Point();
	Point av = new Point();

	MobL(float x, float y, float z, float ax, float ay, float az, int lifeSpan) {
		p = new Point(x,y,z);
		ang = new Point(ax,ay,az);
		this.lifeSpan = lifeSpan;
		maxSpan = lifeSpan;
	}

	void update() {
		super.update();
		p.P.add(pv.p);
		ang.P.add(av.p);
		p.update();
		ang.update();
	}

	void setDraw() {
		push();
		translate(p.p.x,p.p.y,p.p.z);
		rotateX(ang.p.x);
		rotateY(ang.p.y);
		rotateZ(ang.p.z);
	}

	void setIndex(float k) {
		p.setIndex(k);
		ang.setIndex(k);
		pv.setIndex(k);
		av.setIndex(k);
	}
}

abstract class EntityL extends Entity {
	int lifeSpan, maxSpan, dieSpan;

	void update() {
		if (alive) {
			if (lifeSpan > 0) lifeSpan --;
			if (lifeSpan == 0) die();
		} else {
			if (dieSpan > 0) {
				dieSpan --;
			} else {
				dead();
			}
		}
	}

	abstract void die();

	abstract void dead();
}

abstract class Entity {
	boolean finished = false;
	boolean alive = true;
	boolean draw = true;

	abstract void render();

	abstract void update();
}
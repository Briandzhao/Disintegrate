ArrayList<PCube> cubes = new ArrayList<PCube>();
class PCube extends MobL { // Particle-containing cube
	Point w;
	ArrayList<Dust> dar = new ArrayList<Dust>();
	ArrayList<Seg> sar = new ArrayList<Seg>();
	IColor strokeStyle = new IColor();
	SpringValue strokeW = new SpringValue(2);

	PCube(float x, float y, float z, float wx, float wy, float wz, float ax, float ay, float az, int lifeSpan) {
		super(x,y,z, ax,ay,az, lifeSpan);
		w = new Point(wx,wy,wz);
		dieSpan = 15;
		cubes.add(this);
	}

	PCube(float x, float y, float z, float wx, float ax, float ay, float az, int lifeSpan) {
		this(x,y,z, wx,wx,wx, ax,ay,az, lifeSpan);
	}

	void update() {
		super.update();
		w.update();
		strokeW.update();
		strokeStyle.update();
		for (int i = 0 ; i < sar.size() ; i ++) {
			Seg mob = sar.get(i);
			mob.update();
			if (mob.finished) {
				sar.remove(i);
				i --;
			}
		}
		for (int i = 0 ; i < dar.size() ; i ++) {
			Dust mob = dar.get(i);
			mob.update();
			mob.tp = false;
			if (mob.p.p.x < -w.p.x) { mob.tp = true;
				mob.p.p.x += w.p.x*2;
				mob.p.P.x = mob.p.p.x;
			} else if (mob.p.p.x > w.p.x) { mob.tp = true;
				mob.p.p.x -= w.p.x*2;
				mob.p.P.x = mob.p.p.x;
			}
			if (mob.p.p.y < -w.p.y) { mob.tp = true;
				mob.p.p.y += w.p.y*2;
				mob.p.P.y = mob.p.p.y;
			} else if (mob.p.p.y > w.p.y) { mob.tp = true;
				mob.p.p.y -= w.p.y*2;
				mob.p.P.y = mob.p.p.y;
			}
			if (mob.p.p.z < -w.p.z) { mob.tp = true;
				mob.p.p.z += w.p.z*2;
				mob.p.P.z = mob.p.p.z;
			} else if (mob.p.p.z > w.p.z) { mob.tp = true;
				mob.p.p.z -= w.p.z*2;
				mob.p.P.z = mob.p.p.z;
			}
			if (mob.lifeSpan == 0) {
				dar.remove(i);
				i --;
			}
		}
	}

	void render() {
		setDraw();
		noFill();
		strokeWeight(strokeW.x);
		strokeStyle.strokeStyle();
		box(w.p.x*2,w.p.y*2,w.p.z*2);
		for (Dust mob : dar) {
			mob.render();
		}
		for (Seg mob : sar) {
			mob.render();
		}
		pop();
	}

	void die() {
		alive = false;
		w.P.set(0,0,0);
	}

	void dead() {
		finished = true;
	}
}
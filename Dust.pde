ArrayList<Dust> dust = new ArrayList<Dust>();
class Dust {
	Point p, pv;
	SpringValue w = new SpringValue(3);
	IColor strokeStyle = new IColor(0,50,75,100);
	int lifeSpan;

	Dust(float x, float y, float z, int lifeSpan) {
		p = new Point(x,y,z);
		pv = new Point();
		this.lifeSpan = lifeSpan;
		dust.add(this);
	}

	void update() {
		p.P.add(pv.p);
		p.update();
		pv.update();
		w.update();
		strokeStyle.update();
		lifeSpan --;
		if (lifeSpan == 0) dust.remove(this);
	}

	void render() {
		strokeWeight(w.x);
		strokeStyle.strokeStyle();
		point(p.p.x,p.p.y,p.p.z);
	}
}
ArrayList<Dust> dust = new ArrayList<Dust>();
IColor dustStyle;
class Dust {
	Point p, pv;
	SpringValue w = new SpringValue(3);
	IColor strokeStyle = new IColor(dustStyle);
	int lifeSpan;
	boolean tp;

	Dust(float x, float y, float z, int lifeSpan) {
		p = new Point(x,y,z);
		pv = new Point();
		this.lifeSpan = lifeSpan;
	}

	void update() {
		p.P.add(pv.p);
		p.update();
		pv.update();
		w.update();
		strokeStyle.update();
		lifeSpan --;
	}

	void render() {
		strokeWeight(w.x);
		strokeStyle.strokeStyle();
		point(p.p.x,p.p.y,p.p.z);
	}

	void setIndex(float k) {
		p.setIndex(k);
		pv.setIndex(k);
		w.setIndex(k);
		strokeStyle.setIndex(k);
	}
}
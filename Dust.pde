ArrayList<Dust> dust = new ArrayList<Dust>();
ArrayList<Dust> dustA = new ArrayList<Dust>();
IColor dustStyle;
int dustID = 0;
class Dust {
	Point p, pv;
	SpringValue w = new SpringValue(2.1);
	IColor strokeStyle = new IColor(dustStyle);
	int lifeSpan, id;
	boolean tp;

	Dust(float x, float y, float z, int lifeSpan) {
		p = new Point(x,y,z);
		pv = new Point();
		this.lifeSpan = lifeSpan;
		dustA.add(this);
		id = dustID;
		dustID ++;
		setIndex(id);
		w.x = 0;
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
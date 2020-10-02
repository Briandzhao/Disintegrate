class Point extends Entity {
	PVector p;
	PVector P;
	PVector pm = new PVector(0,0,0);
	PVector v = new PVector(0,0,0);
	PVector a = new PVector(0,0,0);
	float vMult;
	float mass;
	int index;
	float[] af = main;

	Point(PVector p, float vMult, float mass) {
		this.p = p.copy();
		this.P = p.copy();
		this.vMult = vMult;
		this.mass = mass;
		this.index = -1;
	}

	Point() {
		this(new PVector(0,0,0), defaultVMult, defaultMass);
	}

	Point(PVector p) {
		this(p, defaultVMult, defaultMass);
	}

	Point(float x, float y, float z) {
		this(new PVector(x, y, z), defaultVMult, defaultMass);
	}

	Point(float x, float y, float z, float vMult, float mass) {
		this(new PVector(x, y, z), vMult, mass);
	}

	void update() {
		a.add((P.x-p.x),(P.y-p.y),(P.z-p.z));
		if (index != -1) {
			a.x += pm.x * af[index];
			a.y += pm.y * af[index];
			a.z += pm.z * af[index];
		}
		a.div(mass);
		v.set((v.x+a.x)*vMult, (v.y+a.y)*vMult, (v.z+a.z)*vMult);
		p.add(v);

		a.set(0,0,0);
	}

	void render() {
		push();
		stroke(255);
		strokeWeight(3);
		point(p.x,p.y,p.z);
		pop();
	}

	Point copy() {
		return new Point(p.copy(), vMult, mass);
	}

	void setIndex(float[] af, float index) {
		this.af = af;
		this.setIndex(index);
	}

	void setIndex(float index) {
		this.index = (int)abs(index%af.length);
	}

	void setIndex(float[] af) {
		this.af = af;
		this.setIndex(index);
	}

	void setM(float x, float y, float z) {
		pm.set(x, y, z);
	}

	void setM(float x, float y, float z, float index) {
		pm.set(x, y, z);
		this.index = (int)index;
	}

	void reset() {
		reset(0,0,0);
	}

	void reset(Point other) {
		reset(other.p.x,other.p.y,other.p.z);
	}

	void reset(PVector other) {
		reset(other.x, other.y, other.z);
	}

	void reset(float x, float y, float z) {
		p.set(x,y,z);
		P.set(x,y,z);
		v.set(0,0,0);
	}

	void reset(float x, float y, float z, float X, float Y, float Z) {
		p.set(x,y,z);
		P.set(X,Y,Z);
		v.set(0,0,0);
	}

	void reset(float x, float y, float z, float xm, float ym, float zm, float index) {
		p.set(x,y,z);
		P.set(x,y,z);
		v.set(0,0,0);
		pm.set(xm,ym,zm);
		this.index = (int)index;
	}

	void reset(float x, float y, float z, float X, float Y, float Z, float xm, float ym, float zm, float index) {
		p.set(x,y,z);
		P.set(X,Y,Z);
		v.set(0,0,0);
		pm.set(xm,ym,zm);
		this.index = (int)index;
	}
}

class SpringValue {
	float x;
	float X;
	float xm = 0;
	float v = 0;
	float a = 0;
	float vMult;
	float mass;
	int index = -1;
	float[] af = main;

	SpringValue(float x, float X, float vMult, float mass) {
		this.x = x;
		this.X = x;
		this.vMult = vMult;
		this.mass = mass;
	}

	SpringValue(float x, float vMult, float mass) {
		this(x,x,vMult,mass);
	}

	SpringValue(float x, float X) {
		this(x,X,defaultVMult,defaultMass);
	}

	SpringValue(float x) {
		this(x,x,defaultVMult, defaultMass);
	}

	SpringValue() {
		this(1,1,defaultVMult, defaultMass);
	}

	void update() {
		if (index != -1) {
			a += (X + xm*af[index] - x);
		} else {
			a += X - x;
		}
		a /= mass;
		v = (v + a) * vMult;
		x += v;
		a = 0;
	}

	void setIndex(float[] af, float index) {
		this.af = af;
		this.setIndex(index);
	}

	void setIndex(float index) {
		this.index = (int)abs(index%af.length);
	}

	void setIndex(float[] af) {
		this.af = af;
		this.setIndex(index);
	}

	void setM(float xm, float index) {
		this.xm = xm;
		this.index = (int)index;
	}

	void reset() {
		reset(0,0);
	}

	void reset(float x, float X, float vMult, float mass) {
		this.x = x;
		this.X = x;
		this.v = 0;
		this.vMult = vMult;
		this.mass = mass;
	}

	void reset(float x, float X) {
		this.x = x;
		this.X = x;
		this.v = 0;
	}

	void reset(float x) {
		this.x = x; this.X = x;
		this.v = 0;
	}
}
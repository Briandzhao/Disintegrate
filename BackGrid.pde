class BackGrid {
	int num = 25;
	PVector w;

	BackGrid() {
		w = new PVector(1,1,1);
		w.mult(de*6);
	}

	void render() {
		float t;
		push();
		strokeWeight(.5);
		stroke(90);
		noFill();
		translate(-cam.p.p.x,-cam.p.p.y,-cam.p.p.z);
		push();
		translate(0,0,cam.p.p.z%(w.z/num)-w.z/2);
		for (float i = 0 ; i < num ; i ++) {
			translate(0,0,w.z/num);
			rect(0,0, w.x,w.y);
		}
		pop();
		push();
		rotateY(-HALF_PI);
		translate(0,0,-w.x/2);
		for (float i = 0 ; i < num ; i ++) {
			translate(0,0,w.x/num);
			rect(0,0, w.y,w.z);
		}
		pop();
		push();
		rotateX(-HALF_PI);
		translate(0,0,cam.p.p.y%(w.y/num)-w.y/2);
		for (float i = 0 ; i < num ; i ++) {
			translate(0,0,w.z/num);
			rect(0,0, w.x,w.z);
		}
		pop();
		pop();
	}
}
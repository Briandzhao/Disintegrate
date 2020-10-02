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
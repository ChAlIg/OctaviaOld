package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;

	public class Level extends MovieClip {
		public var trash: Trash;
		public var player: Player;
		public var ambient: Ambient;
		public var walls: Walls;
		public var little_explosion: Little_explosion;
		public var units: Array = [];
		public var point: Point;

		public function Level(X: int, Y: int): void {
			this.x = X;
			this.y = Y;
			ambient = new Ambient(0, 0);
			addChild(ambient);
			walls = new Walls(0, 0);
			addChild(walls);
			trash = new Trash(320, 240);
			addChild(trash);
			units.push(trash);
			trash = new Trash(234, 556);
			addChild(trash);
			units.push(trash);
			trash = new Trash(34, 766);
			addChild(trash);
			units.push(trash);
			trash = new Trash(457, 23);
			addChild(trash);
			units.push(trash);
			trash = new Trash(345, 423);
			addChild(trash);
			units.push(trash);
			trash = new Trash(264, 567);
			addChild(trash);
			units.push(trash);
			trash = new Trash(32, 43);
			addChild(trash);
			units.push(trash);
			trash = new Trash(123, 123);
			addChild(trash);
			units.push(trash);
			trash = new Trash(500, 43);
			addChild(trash);
			units.push(trash);
			player = new Player(400, 550);
			addChild(player);
			units.push(player);
		}
		public function loop(): void {

			if (units.length > 0) //if there are any bullets in the bullet list
			{
				for (var i: int = units.length - 1; i >= 0; --i) //for each one
				{
					units[i].loop(); //call its loop() function
					if (units[i] is Bullet_pistol) {
						point = localToGlobal(new Point(units[i].x, units[i].y));
						if (walls.hitTestPoint(point.x, point.y, true)) {
							units[i].death = true;
						}
					}
					if (units[i].death) {
						little_explosion = new Little_explosion(units[i].x, units[i].y);
						addChild(little_explosion);
						removeChild(units[i]);
						units.splice(i, 1);
					}
				}
			}
		}

	}
}
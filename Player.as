package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Player extends MovieClip {
		public var energyMax: int = 180;
		public var healthMax: int = 10;
		public var energy: int = 0;
		public var health: int = healthMax;
		public var jumpCost: int = 0;
		public var death: Boolean = false;
		public var shotDelay: int = 0;

		public function Player(X: int, Y: int): void {
			this.x = X;
			this.y = Y;
		}
		public function loop(): void {
			if (energy < energyMax) {
				++energy;
			}
			if (shotDelay > 0) {
				--shotDelay;
			}
		}
	}
}
package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Trash extends MovieClip {
		public var death: Boolean = false;
		public function Trash(X: int, Y: int): void {
			this.x = X;
			this.y = Y;
		}
		public function loop(): void {

		}
	}
}
package {

	import flash.display.MovieClip;

	public class Coursor extends MovieClip {

		var number: Number;

		public function Coursor(X: int, Y: int) {
			this.x = X;
			this.y = Y;
			c2.alpha = 0;
			c3.alpha = 0;
		}
		public function moving(dy: Number) {
			y += dy;
			if (y > 510)
				y = 510;
			else if (y < 30)
				y = 30;

			scaleX = scaleY = 2 - (y - 30) / 480;

			number = y - 410;
			if (number < 0)
				number = 0;
			else if (number > 100)
				number = 100;
			c1.alpha = number / 100;
			number = 100 - Math.abs(y - 350);
			if (number < 0)
				number = 0;
			c2.alpha = number / 100;
			number = 100 - Math.abs(y - 190);
			if (number < 0)
				number = 0;
			c3.alpha = number / 100;
		}

	}

}
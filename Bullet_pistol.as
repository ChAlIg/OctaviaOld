package {
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import Level;
	
	public class Bullet_pistol extends MovieClip {
		private var speed: Number = 15; //speed that the bullet will travel at
		public var xSpeed: Number; //current x velocity
		public var ySpeed: Number; //current y velocity
		private var rotationInRadiansMinus; //convenient to store our rotation in radians instead of degrees
		public var t: DisplayObject; //current x velocity

		private var lifetime: int;
		public var death: Boolean = false;

		//our constructor requires: the stage, the position of the bullet, and the direction the bullet should be facing
		public function Bullet_pistol(tt:Level, X: int, Y: int, rotationInDegrees: Number, life:int): void {
			this.x = X;
			this.y = Y;
			this.rotation = rotationInDegrees;
			this.rotationInRadiansMinus = (rotationInDegrees - 90) * Math.PI / 180; //convert degrees to radians, for trigonometry
			lifetime = life;
			t = tt;
		}
		public function loop(): void {
			xSpeed = Math.cos(rotationInRadiansMinus) * speed; //uses the cosine to get the xVel from the speed and rotation
			ySpeed = Math.sin(rotationInRadiansMinus) * speed; //uses the sine to get the yVel
			
			x += xSpeed; //updates the position
			y += ySpeed;
			
			t.player;
			//this.parent.player;
			//stage.game.level; //ВОТ ЗДЕСЬ
			--lifetime;
			if (lifetime <= 0) {
				death = true;
			}
		}
	}
}
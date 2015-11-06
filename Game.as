package {
	import flash.display.MovieClip;
	import flash.events.Event;

	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.MouseEvent;
	import flash.events.FullScreenEvent;

	import flash.geom.Matrix;
	import flash.geom.Point;

	import KeyObject;


	public class Game extends MovieClip {
		public var level: Level;
		public var facet: Facet;
		public var rotator: Matrix;
		var point: Point;

		var playerPoint: Point = new Point(400, 550);

		public var leftPressed: Boolean = false;
		public var rightPressed: Boolean = false;
		public var upPressed: Boolean = false;
		public var downPressed: Boolean = false;
		public var qPressed: Boolean = false;
		public var ePressed: Boolean = false;

		public var key: KeyObject;
		public var speed: Number = 5;
		private var sqrt2: Number = Math.sqrt(2);
		public var roll: int = 0;
		public var jumpAccelerator: int = 3;

		public var i: int;
		public var number: Number;

		public var rotSpeed: Number;
		public var coursor: Coursor;

		public function Game(): void {
			level = new Level(0, 0);
			addChild(level);
			coursor = new Coursor(400, 510);
			addChild(coursor);
			facet = new Facet(0, 0);
			addChild(facet);

			addEventListener(MouseEvent.CLICK, toggleFullscreen);
			stage.addEventListener(FullScreenEvent.FULL_SCREEN, onFullscreen);
			stage.addEventListener(MouseEvent.CLICK, shootBullet, false, 0, true);

			key = new KeyObject(stage);
			addEventListener(Event.ENTER_FRAME, loopGame, false, 0, true);
		}

		public function loopGame(e: Event): void {

			checkKeypresses();

			number = speed / sqrt2;

			if (qPressed) {
				if (roll == 0 && level.player.energy >= 0) {
					roll = -20;
					level.player.energy -= level.player.jumpCost;
				}
			} else if (ePressed) {
				if (roll == 0 && level.player.energy >= 0) {
					roll = 20;
					level.player.energy -= level.player.jumpCost;
				}
			}

			if (roll > 0) {
				for (i = jumpAccelerator; i > 0; --i) {
					point = level.localToGlobal(new Point(level.player.x, level.player.y));
					if (!level.walls.hitTestPoint(point.x + speed, point.y, true)) {
						level.x -= speed;
						point = level.globalToLocal(playerPoint);
						level.player.x = point.x;
						level.player.y = point.y;
					}
				}
				--roll;
			} else if (roll < 0) {
				for (i = jumpAccelerator; i > 0; --i) {
					point = level.localToGlobal(new Point(level.player.x, level.player.y));
					if (!level.walls.hitTestPoint(point.x - speed, point.y, true)) {
						level.x += speed;
						point = level.globalToLocal(playerPoint);
						level.player.x = point.x;
						level.player.y = point.y;
					}
				}
				++roll;
			} else {

				point = level.localToGlobal(new Point(level.player.x, level.player.y));

				if (leftPressed) {
					if (upPressed && !level.walls.hitTestPoint(point.x - speed / sqrt2, point.y - speed / sqrt2, true)) {
						level.x += number;
						level.y += number;
					} else if (downPressed && !level.walls.hitTestPoint(point.x - speed / sqrt2, point.y + speed / sqrt2, true)) {
						level.x += number;
						level.y -= number;
					} else if (!level.walls.hitTestPoint(point.x - speed, point.y, true)) {
						level.x += speed;
					}
				} else if (rightPressed) {
					if (downPressed && !level.walls.hitTestPoint(point.x + speed / sqrt2, point.y + speed / sqrt2, true)) {
						level.x -= number;
						level.y -= number;
					} else if (upPressed && !level.walls.hitTestPoint(point.x + speed / sqrt2, point.y - speed / sqrt2, true)) {
						level.x -= number;
						level.y += number;
					} else if (!level.walls.hitTestPoint(point.x + speed, point.y, true)) {
						level.x -= speed;
					}
				} else if (upPressed && !level.walls.hitTestPoint(point.x, point.y - speed, true)) {
					level.y += speed;
				} else if (downPressed && !level.walls.hitTestPoint(point.x, point.y + speed, true)) {
					level.y -= speed;
				}


				point = level.globalToLocal(playerPoint); //конвертация локальных координат в глобальные
				level.player.x = point.x;
				level.player.y = point.y; //помещение игрока в то место в локальной системе координат, которое соответствует месту игрока в глобальных координатах (playerPoint) 

			}

			level.loop(); //запуск функции ниже уровнем, отвечающей за запуск соответствующих функций всех юнитов

		}

		public function checkKeypresses(): void {
			if (key.isDown(37) || key.isDown(65)) {
				leftPressed = true;
			} else {
				leftPressed = false;
			}

			if (key.isDown(38) || key.isDown(87)) {
				upPressed = true;
			} else {
				upPressed = false;
			}

			if (key.isDown(39) || key.isDown(68)) {
				rightPressed = true;
			} else {
				rightPressed = false;
			}

			if (key.isDown(40) || key.isDown(83)) {
				downPressed = true;
			} else {
				downPressed = false;
			}

			if (key.isDown(81)) {
				qPressed = true;
			} else {
				qPressed = false;
			}

			if (key.isDown(69)) {
				ePressed = true;
			} else {
				ePressed = false;
			}
		}

		public function toggleFullscreen(e: MouseEvent): void {
			if (stage.displayState == StageDisplayState.FULL_SCREEN) {
				stage.displayState = StageDisplayState.NORMAL;
			} else {
				stage.displayState = StageDisplayState.FULL_SCREEN;
			}
		}

		public function onFullscreen(e: FullScreenEvent): void {
			if (e.fullScreen) {
				stage.mouseLock = true;
				stage.addEventListener(MouseEvent.MOUSE_MOVE, rotateAndCoursor);
			} else {
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, rotateAndCoursor);
			}
		}
		public function rotateAndCoursor(e: MouseEvent): void {

			point = new Point(level.player.x, level.player.y);
			rotSpeed = -e.movementX / 2;
			if (rotSpeed > 20)
				rotSpeed = 20;
			else if (rotSpeed < -20)
				rotSpeed = -20;
			if (roll != 0)
				rotSpeed / 2;
			var t: Matrix = level.transform.matrix;
			point = t.transformPoint(point);
			t.translate(-point.x, -point.y);
			t.rotate(rotSpeed * (Math.PI / 180));
			t.translate(point.x, point.y);
			level.transform.matrix = t;
			level.player.rotation -= rotSpeed;

			coursor.moving(e.movementY);

		}
		public function shootBullet(e: MouseEvent): void {
			if (level.player.energy >= 0) {
				var bullet_pistol: Bullet_pistol = new Bullet_pistol(stage, level.player.x, level.player.y, level.player.rotation + (Math.random() * 30 - 15) * (coursor.scaleX - 1));
				level.units.push(bullet_pistol); //add this bullet to the bulletList array
				level.addChild(bullet_pistol);
			}
		}
	}
}
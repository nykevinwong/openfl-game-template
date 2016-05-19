package template.utils.screen;
import flash.media.Video;
import openfl.display.Sprite;
import openfl.geom.Point;
import openfl.Lib;
import template.utils.game.GameObject;

/**
 * ...
 * @author Flavien
 */
class Screen
{
	public static function getPositionBy(normalizedPosition:Point) : Point {
		var screenSize:Point = getScreenSize();
		var position:Point = new Point(screenSize.x / 2, screenSize.y / 2);

		if (
			normalizedPosition.x > 1 ||
			normalizedPosition.x < -1 ||
			normalizedPosition.y > 1 ||
			normalizedPosition.y < -1
		) {
			throw positionOutOfRangeException();
		}

		position.setTo(
			position.x + position.x * normalizedPosition.x,
			position.y + position.y * normalizedPosition.y
		);

		return position;
	}

	public static function getTargetScaleToFit(fit:Point, target:Sprite) : Point {
		var screenSize:Point = getScreenSize();
		var targetOriginalSize:Point = new Point(
			target.width / target.scaleX,
			target.height / target.scaleY );

		var scaleX:Float = (screenSize.x / targetOriginalSize.x) * fit.x;
		var scaleY:Float = (screenSize.y / targetOriginalSize.y) * fit.y;

		scaleX = scaleX == 0 ? 1 : scaleX;
		scaleY = scaleY == 0 ? 1 : scaleY;

		return new Point(scaleX, scaleY);
	}

	private static function getScreenSize () : Point {
		return new Point(
			Lib.current.stage.width,
			Lib.current.stage.height
		);
	}

	private static function positionOutOfRangeException():String {
		return 'Screen.hx : position parameter value is incorrect (must be between -1, 1)';
	}
}
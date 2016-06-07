package template.utils;
import openfl.geom.Point;

/**
 * Provide some math abstractions functions
 * @author Flavien
 */
class MathUtils
{

	/**
	 * Return the sign of a Float
	 * @param	number
	 * @return -1 for negative number : 1 for positive number
	 */
	public static function getSign(number:Float) : Float {
		if (number == 0) return 0;
		return number / Math.abs(number);
	}

	/**
	* Convert radian to degree value
	**/
	public static function radianToDegree(radian:Float) : Float {
		return 180 * radian / Math.PI;
	}

	/**
	* Convert degree to radian value
	**/
	public static function degreeToRadian (degree:Float) : Float {
		return Math.PI * degree / 180;
	}

	/**
	 * Get Distance Between two point
	 * @param	pPointA
	 * @param	pPointB
	 * @return
	 */
	public static function getDistance(pointA:Point, pointB:Point):Float {
		return Math.sqrt((pointA.x - pointB.x) * (pointA.x - pointB.x) 
			+ (pointA.y - pointB.y)* (pointA.y - pointB.y));
	}
	
	/**
	 * Get the angle between pointA and pointB
	 * @param	pointA
	 * @param	pointB
	 * @return a float between -Pi and Pi
	 */
	public static function getDirection(pointA:Point, pointB:Point):Float {
		return Math.atan2(pointA.y - pointB.y, pointA.x - pointB.x);
	}
	
	/**
	 * ceil number to close step multiplicator
	 * @param	number
	 * @param	step
	 * @return
	 */
	public static function roundToStep(number:Int, step:Float) : Float {
		return Math.ceil(number / step) * step;
	}
	
	/**
	 * percent of number in total
	 * @param	number
	 * @param	total
	 * @return
	 */
	public static function getPercent (number:Float, total:Float) : Float {
		return number / total;
	}
	
	/**
	 * Get random number between LimiteA and LimiteB
	 * @param	limiteA
	 * @param	limiteB
	 * @return
	 */
	public static function getRandomNumberBetween(min:Float, max:Float) : Float {
		if (min > max) {
			throw "MathUtils.getRandomNumberBetween : max should be greater than min";
		}
		
		var deltaMinMax:Float = max - min;
		var randomNumber:Float = Math.round(Math.random() * deltaMinMax);
		return randomNumber + min;
	}
	
	    /**
	 * Get position list between two point
	 * @param	startPosition the position where the pointList Begin
	 * @param	endPosition the position where the pointList End
	 * @param   pixelPrecsion step between each position
	 * @return
	 */
	public static function getPointListBetweenTwoPosition(
			startPosition:Point,
			endPosition:Point,
			?pixelPrecision:Float = 1
		) : Array<Point> {
		var pointList:Array<Point> = new Array<Point> ();

		var distance:Float = getDistance(startPosition, endPosition);
		var numberPoints:Int = Std.int(Math.ceil( distance / pixelPrecision));

		var deltaBetweenPoints:Point = new Point (
			Math.round((endPosition.x - startPosition.x) / numberPoints),
			Math.round((endPosition.y - startPosition.y) / numberPoints)
		);

		for (i in 0...numberPoints) {
			startPosition.setTo(
				startPosition.x + deltaBetweenPoints.x,
				startPosition.y + deltaBetweenPoints.y
			);
			pointList.push(
				startPosition.clone()
			);
		}

		return pointList;
	}
	
}
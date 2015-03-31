/**
 * Math utility class.
 *
 * Created by bslote on 3/14/15.
 */
package pw.fractal.vbm.util
{
    import flash.geom.Point;

    public class MathUtil
    {
        public static const PHI:Number = 1.61803;

        public static function digitalRoot(number:uint):uint
        {
            var m:uint = number % 9;
            return m == 0 ? 9 : m;
        }

        public static function phiToScreen(pos:Point):Point
        {
            var screenX:Number = pos.x - pos.y;
            var screenY:Number = (pos.x + pos.y) / PHI;

            return new Point(screenX, screenY);
        }
    }
}

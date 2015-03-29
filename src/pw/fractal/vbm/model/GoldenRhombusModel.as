/**
 * Created by bslote on 3/29/15.
 */
package pw.fractal.vbm.model
{
    import pw.fractal.vbm.util.MathUtil;

    public class GoldenRhombusModel
    {
        public var text:String;
        public var lineThicknes:Number;
        public var lineColor:uint;
        public var backgroundColor:uint;

        private var _p:Number;
        private var _q:Number;

        public function GoldenRhombusModel(p:Number, text:String = "", lineThickness:Number = 1, lineColor:uint = 0x0, backgroundColor:uint = 0xffffff)
        {
            this.p = p;
            this.text = text;
            this.lineThicknes = lineThickness;
            this.lineColor = lineColor;
            this.backgroundColor = backgroundColor;
        }

        public function get q():Number
        {
            return _q;
        }

        public function get p():Number
        {
            return _p;
        }

        public function set p(value:Number):void
        {
            _p = value;
            _q = _p / MathUtil.PHI;
        }
    }
}

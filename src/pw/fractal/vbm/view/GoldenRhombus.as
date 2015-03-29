/**
 * Created by bslote on 3/29/15.
 */
package pw.fractal.vbm.view
{
    import flash.display.Shape;
    import flash.display.Sprite;

    import pw.fractal.vbm.model.GoldenRhombusModel;

    public class GoldenRhombus extends Sprite
    {
        private var _model:GoldenRhombusModel;
        private var _shape:Shape;

        public function GoldenRhombus(model:GoldenRhombusModel)
        {
            _model = model;
            _shape = new Shape();

            draw();
            addChild(_shape);
        }

        protected function draw():void
        {
            var p:Number = _model.p;
            var q:Number = _model.q;

            with (_shape.graphics)
            {
                lineStyle(_model.lineThicknes, _model.lineColor);

                beginFill(_model.backgroundColor);

                moveTo(p / 2, 0);
                lineTo(p, q / 2);

                moveTo(p / 2, 0);
                lineTo(0, q / 2);

                moveTo(p / 2, q);
                lineTo(p, q / 2);

                moveTo(p / 2, q);
                lineTo(0, q / 2);

                endFill();
            }
        }
    }
}

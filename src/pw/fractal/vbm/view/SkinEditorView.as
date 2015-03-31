/**
 * Created by bslote on 3/27/15.
 */
package pw.fractal.vbm.view
{
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Point;

    import pw.fractal.vbm.model.GoldenRhombusModel;
    import pw.fractal.vbm.model.SkinModel;
    import pw.fractal.vbm.sequence.DoublingSequence;
    import pw.fractal.vbm.sequence.ISequence;
    import pw.fractal.vbm.sequence.ThreeSixNineSequence;
    import pw.fractal.vbm.util.MathUtil;

    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.textures.Texture;

    public class SkinEditorView extends starling.display.Sprite
    {
        protected var _model:SkinModel;
        protected var _skinBitmapData:BitmapData;
        protected var _skinTexture:Texture;
        protected var _skin:Image;

        public function SkinEditorView(model:SkinModel)
        {
            _model = model;
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function init():void
        {
            drawEmptyGrid();
        }

        private function drawEmptyGrid():void
        {
            if (_skinBitmapData)
            {
                _skinBitmapData.dispose();
            }

            // TODO: Move map model building logic elsewhere
            var i:int;
            var j:int;
            var doubleCount:int = -1;
            var threeCount:int = -1;

            var sequence:ISequence;
            for (i = _model.numTiles * 2; i > 0; i--)
            {
                if (i % 3 == 0)
                {
                    sequence = new ThreeSixNineSequence();
//                    sequence.position = threeCount++;
                }
                else
                {
                    sequence = new DoublingSequence();
//                    sequence.position = doubleCount++;

                }

                _model.addRow(sequence);
                sequence.position = -1;
            }

            _skinBitmapData = new BitmapData(_model.width, _model.height, false, 0xffffff);
            var skinSprite:flash.display.Sprite = new flash.display.Sprite();

            var rhombusModel:GoldenRhombusModel;
            var rhombus:GoldenRhombus;
            var p:Number;
            var q:Number;
            var x:Number;
            var y:Number;
            var pt:Point;

            for (i = 0; i < _model.numTiles; i++)
            {
                for (j = 0; j < _model.numTiles; j++)
                {
                    var value:Object = _model.getValue(j * 2, i);
//                    var value:Object = j + ", " + i;
                    rhombusModel = new GoldenRhombusModel(_model.width / _model.numTiles, value.toString());
                    rhombus = new GoldenRhombus(rhombusModel);

                    p = rhombusModel.p;
                    q = rhombusModel.q;

                    rhombus.x = i * p;
                    rhombus.y = j * q;

                    skinSprite.addChild(rhombus);
                }
            }

            for (i = 0; i < _model.numTiles; i++)
            {
                for (j = 0; j < _model.numTiles; j++)
                {
                    var value:Object = _model.getValue((j * 2) + 1, i);
//                    var value:Object = j + ", " + i;
                    rhombusModel = new GoldenRhombusModel(_model.width / _model.numTiles, value.toString());
                    rhombus = new GoldenRhombus(rhombusModel);

                    p = rhombusModel.p;
                    q = rhombusModel.q;

                    rhombus.x = (i * p) + p / 2;
                    rhombus.y = j * q + q / 2;

                    skinSprite.addChild(rhombus);
                }
            }

            _skinBitmapData.draw(skinSprite);
            _model.bitmapData = _skinBitmapData;

            _skinTexture = Texture.fromBitmapData(_skinBitmapData, false);
            _skin = new Image(_skinTexture);

            addChild(_skin);
        }

        protected function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
            init();
        }
    }
}

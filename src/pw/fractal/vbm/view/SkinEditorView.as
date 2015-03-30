/**
 * Created by bslote on 3/27/15.
 */
package pw.fractal.vbm.view
{
    import flash.display.BitmapData;
    import flash.display.Sprite;

    import pw.fractal.vbm.model.GoldenRhombusModel;
    import pw.fractal.vbm.model.SkinModel;

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

            _skinBitmapData = new BitmapData(_model.width, _model.height, false, 0xffffff);
            var skinSprite:flash.display.Sprite = new flash.display.Sprite();

            var rhombusModel:GoldenRhombusModel;
            var rhombus:GoldenRhombus;
            var p:Number;

            for (var i:uint = 0; i < _model.numTiles; i++)
            {
                for (var j:uint = 0; j < _model.numTiles * 2; j++)
                {
                    rhombusModel = new GoldenRhombusModel(_model.width / _model.numTiles, "9");
                    rhombus = new GoldenRhombus(rhombusModel);

                    p = rhombusModel.p;

                    rhombus.x = j % 2 == 0 ? p * i : (p / 2) + (p * i); // Stagger every other row
                    rhombus.y = rhombusModel.q * (j / 2);

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

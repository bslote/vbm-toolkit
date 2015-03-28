/**
 * Created by bslote on 3/27/15.
 */
package pw.fractal.vbm.view
{
    import flash.display.BitmapData;
    import flash.display.Shape;
    import flash.display.Sprite;

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

            // Draw a golden rhombus. p / q = 1.618
            var p:Number = _model.width / (_model.tiles + .5);
            var q:Number = p / 1.61803;

            var rhombus:Shape = new Shape();
            rhombus.graphics.lineStyle(1);

            rhombus.graphics.moveTo(p / 2, 0);
            rhombus.graphics.lineTo(p, q / 2);

            rhombus.graphics.moveTo(p / 2, 0);
            rhombus.graphics.lineTo(0, q / 2);

            rhombus.graphics.moveTo(p / 2, q);
            rhombus.graphics.lineTo(p, q / 2);

            rhombus.graphics.moveTo(p / 2, q);
            rhombus.graphics.lineTo(0, q / 2);

            // Clone the rhombus and create a tiling
            var clone:Shape;
            var skinSprite:flash.display.Sprite = new flash.display.Sprite();

            for (var i:uint = 0; i < _model.tiles; i++)
            {
                for (var j:uint = 0; j < _model.tiles * 2; j++)
                {
                    clone = new Shape();
                    clone.graphics.copyFrom(rhombus.graphics);
                    clone.x = j % 2 == 0 ? p * i : (p / 2) + (p * i);
                    clone.y = q * (j / 2);

                    skinSprite.addChild(clone);
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

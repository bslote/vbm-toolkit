/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.textures
{
    import away3d.textures.Texture2DBase;
    import away3d.tools.utils.TextureUtils;

    import flash.display.BitmapData;
    import flash.display3D.Context3D;
    import flash.display3D.Context3DTextureFormat;
    import flash.display3D.textures.RectangleTexture;
    import flash.display3D.textures.Texture;
    import flash.display3D.textures.TextureBase;

    public class RectangularTexture extends Texture2DBase
    {
        private var _bitmapData:BitmapData;
        private var _bitmapDataPOT:Boolean = false;
        private var _npotSupported:Boolean = false;

        public function RectangularTexture(bitmapData:BitmapData)
        {
            super();

            this.bitmapData = bitmapData;
        }

        public function get bitmapData():BitmapData
        {
            return _bitmapData;
        }

        public function set bitmapData(value:BitmapData):void
        {
            if (value == _bitmapData)
            {
                return;
            }

            invalidateContent();
            setSize(value.width, value.height);

            _bitmapData = value;
            _bitmapDataPOT = (TextureUtils.isPowerOfTwo(_width) && TextureUtils.isPowerOfTwo(_height));
        }

        override protected function createTexture(context:Context3D):TextureBase
        {
            if (_bitmapDataPOT)
            {
                return super.createTexture(context);
            }
            else
            {
                _npotSupported = ("createRectangleTexture" in context);

                if (!_npotSupported)
                {
                    throw new Error("Non power of two textures not supported");
                }

                return context["createRectangleTexture"](_width, _height, Context3DTextureFormat.BGRA, false);
            }
        }

        override protected function uploadContent(texture:TextureBase):void
        {
            if (!_npotSupported)
            {
                Texture(texture).uploadFromBitmapData(_bitmapData, 0);
            }
            else
            {
                RectangleTexture(texture).uploadFromBitmapData(_bitmapData);
            }
        }
    }
}

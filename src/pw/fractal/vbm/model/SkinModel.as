/**
 * Created by bslote on 3/27/15.
 */
package pw.fractal.vbm.model
{
    import flash.display.BitmapData;

    import starling.events.Event;

    import starling.events.EventDispatcher;

    public class SkinModel extends EventDispatcher
    {
        public var width:uint;
        public var height:uint;
        public var tiles:uint;
        public var seed:int; // Use Number to allow halving sequences?
        private var _bitmapData:BitmapData;

        public function SkinModel()
        {
        }

        public function setChanged():void
        {
            dispatchEventWith(Event.CHANGE);
        }

        public function get bitmapData():BitmapData
        {
            return _bitmapData;
        }

        public function set bitmapData(value:BitmapData):void
        {
            _bitmapData = value;
            setChanged();
        }
    }
}

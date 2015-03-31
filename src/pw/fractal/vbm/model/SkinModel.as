/**
 * Created by bslote on 3/27/15.
 */
package pw.fractal.vbm.model
{
    import flash.display.BitmapData;

    import pw.fractal.vbm.sequence.ISequence;

    import starling.events.Event;

    import starling.events.EventDispatcher;

    public class SkinModel extends EventDispatcher
    {
        public var width:uint;
        public var height:uint;
        public var numTiles:uint;
        public var seed:int; // Use Number to allow halving sequences?
        private var _bitmapData:BitmapData;
        private var _rows:Array;

        public function SkinModel()
        {
            _rows = [];
        }

        public function setChanged():void
        {
            dispatchEventWith(Event.CHANGE);
        }

        public function addRow(sequence:ISequence):void
        {
            _rows.push(sequence);
        }

        public function moveLeft():void
        {
            for (var i:uint = 0; i < _rows.length; i++)
            {
                (_rows[i] as ISequence).next();
            }
        }

        public function moveRight():void
        {
            for (var i:uint = 0; i < _rows.length; i++)
            {
                (_rows[i] as ISequence).prev();
            }
        }

        public function getValue(x:int, y:int):Object
        {
            return (_rows[x % _rows.length] as ISequence).getRelativeElement(y);
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

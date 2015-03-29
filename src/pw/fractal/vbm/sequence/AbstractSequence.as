/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.sequence
{
    import flash.errors.IllegalOperationError;

    import pw.fractal.vbm.iterator.IIterator;
    import pw.fractal.vbm.iterator.SequenceIterator;

    public class AbstractSequence implements ISequence
    {
        protected var _name:String;
        protected var _sequence:Object;
        protected var _iterator:IIterator;

        public function AbstractSequence(sequence:Object, name:String = "")
        {
            _name = name;
            _sequence = sequence;

            _iterator = new SequenceIterator(this);
        }

        public function get sequence():Object
        {
            return _sequence;
        }

        public function getElement(index:int):Object
        {
            throw new IllegalOperationError("getElement() implementation must be provided by subclass");
        }

        public function get name():String
        {
            return _name;
        }

        public function reset():void
        {
            _iterator.reset();
        }

        public function next():Object
        {
            return _iterator.next();
        }

        public function hasNext():Boolean
        {
            return _iterator.hasNext();
        }
    }
}

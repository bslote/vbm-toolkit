/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.iterator
{
    import pw.fractal.vbm.sequence.ISequence;

    public class SequenceIterator implements IIterator
    {
        private var _index:int;
        private var _sequence:ISequence;

        public function SequenceIterator(sequence:ISequence)
        {
            _sequence = sequence;
            _index = 0;
        }

        public function reset():void
        {
            _index = 0;
        }

        public function next():Object
        {
            return _sequence.getElement(_index++);
        }

        public function hasNext():Boolean
        {
            return true;
        }
    }
}

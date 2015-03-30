/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.iterator
{
    import pw.fractal.vbm.sequence.ISequence;

    public class ReverseSequenceIterator extends AbstractIterator
    {
        private var _sequence:ISequence;

        public function ReverseSequenceIterator(sequence:ISequence)
        {
            _sequence = sequence;
        }

        override public function next():Object
        {
            return _sequence.getElement(_index--);
        }

        override public function prev():Object
        {
            return _sequence.getElement(_index++);
        }

        override public function hasNext():Boolean
        {
            return true;
        }
    }
}

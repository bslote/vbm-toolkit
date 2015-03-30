/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.sequence
{
    public class ArraySequence extends AbstractSequence
    {
        public function ArraySequence(sequence:Array, direction:String = SequenceDirection.FORWARD, name:String = "")
        {
            super(sequence, direction, name);
        }

        override public function getElement(index:int):Object
        {
            // Sequences are assumed to be modular
            if (index < 0)
            {
                // The AS3 modulo operator does not work the same as a mathematical modulo
                // and can return negative values, so we must modify our index to be a
                // positive congruent value before performing the operation.
                index = -index + _sequence.length;
            }

            return _sequence[index % _sequence.length];
        }
    }
}

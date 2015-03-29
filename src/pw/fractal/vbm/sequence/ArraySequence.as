/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.sequence
{
    public class ArraySequence extends AbstractSequence
    {
        public function ArraySequence(sequence:Array, name:String = "")
        {
            super(sequence, name);
        }

        override public function getElement(index:int):Object
        {
            // Sequences are assumed to be modular
            return _sequence[index % _sequence.length];
        }
    }
}

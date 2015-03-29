/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.sequence
{
    public class FunctionSequence extends AbstractSequence
    {
        public function FunctionSequence(sequence:Function, name:String = "")
        {
            super(sequence, name);
        }

        override public function getElement(index:int):Object
        {
            return _sequence.apply(null, [index]);
        }
    }
}
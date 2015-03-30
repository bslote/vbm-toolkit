/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.sequence
{
    public class ThreeSixNineSequence extends ArraySequence
    {
        public function ThreeSixNineSequence(direction:String = SequenceDirection.FORWARD)
        {
            super([3, 9, 6, 6, 9, 3, 3, 9], direction, "Three, six, nine sequence");
        }
    }
}

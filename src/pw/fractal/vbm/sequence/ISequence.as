/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.sequence
{
    import pw.fractal.vbm.iterator.IIterator;

    public interface ISequence extends IIterator
    {
        function get sequence():Object;
        function getElement(index:int):Object;
        function get name():String;
    }
}

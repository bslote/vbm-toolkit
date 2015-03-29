/**
 * Created by bslote on 3/28/15.
 */
package pw.fractal.vbm.iterator
{
    public interface IIterator
    {
        function reset():void;
        function next():Object;
        function hasNext():Boolean;
    }
}

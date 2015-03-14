/**
 * Created by bslote on 3/14/15.
 */
package pw.fractal.vbm.view
{
    import away3d.containers.View3D;

    public interface IView
    {
        function render():void;
        function get view3D():View3D;
    }
}

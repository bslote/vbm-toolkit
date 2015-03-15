/**
 * Created by bslote on 3/14/15.
 */
package pw.fractal.vbm.view
{
    import away3d.cameras.lenses.PerspectiveLens;
    import away3d.containers.View3D;
    import away3d.core.managers.Stage3DProxy;
    import away3d.entities.Mesh;
    import away3d.materials.TextureMaterial;
    import away3d.primitives.TorusGeometry;
    import away3d.utils.Cast;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Vector3D;

    public class TestView extends Sprite implements IView
    {
        [Embed(source="../../../../../assets/rodintoroidsurface.jpg")]
        private var RodinMapTexture:Class;

        private var _stage3DProxy:Stage3DProxy;
        private var _torus:Mesh;
        private var _view:View3D;

        public function TestView(stage3DProxy:Stage3DProxy)
        {
            _stage3DProxy = stage3DProxy;

            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        protected function init():void
        {
            _view = new View3D();
            _view.stage3DProxy = _stage3DProxy;
            _view.shareContext = true;
            _view.rightClickMenuEnabled = false;

            addChild(_view);

            // Set up the camera
            _view.camera.z = -1000;
            _view.camera.y = 500;
            _view.camera.lookAt(new Vector3D());
            _view.camera.lens = new PerspectiveLens(90);

            // Set up the scene
            var material:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(RodinMapTexture), true, true);
            _torus = new Mesh(new TorusGeometry(256, 158, 64, 32), material);
            _view.scene.addChild(_torus);

            stage.addEventListener(Event.RESIZE, onResize);

            onResize();
        }

        public function render():void
        {
            _torus.rotationX += 2;
            _torus.rotationY += 1;

            _view.render();
        }

        private function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            init();
        }

        private function onResize(e:Event = null):void
        {
            _view.width = stage.stageWidth;
            _view.height = stage.stageHeight;
        }

        public function get view3D():View3D
        {
            return _view;
        }
    }
}

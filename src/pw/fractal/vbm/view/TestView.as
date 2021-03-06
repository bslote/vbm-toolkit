/**
 * Created by bslote on 3/14/15.
 */
package pw.fractal.vbm.view
{
    import away3d.cameras.lenses.PerspectiveLens;
    import away3d.containers.View3D;
    import away3d.core.managers.Stage3DProxy;
    import away3d.debug.AwayStats;
    import away3d.entities.Mesh;
    import away3d.materials.TextureMaterial;
    import away3d.primitives.TorusGeometry;
    import away3d.utils.Cast;

    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.geom.Vector3D;

    import pw.fractal.vbm.model.SkinModel;
    import pw.fractal.vbm.textures.RectangularTexture;

    import starling.events.Event;

    public class TestView extends Sprite implements IView
    {
        [Embed(source="../../../../../assets/rodintoroidsurface.jpg")]
        private var RodinMapTexture:Class;

        private var _stage3DProxy:Stage3DProxy;
        private var _torus:Mesh;
        private var _view:View3D;
        private var _model:SkinModel;

        public function TestView(stage3DProxy:Stage3DProxy, model:SkinModel)
        {
            _stage3DProxy = stage3DProxy;
            _model = model;

            addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
        }

        protected function init():void
        {
            _view = new View3D();
            _view.stage3DProxy = _stage3DProxy;
            _view.shareContext = true;
            _view.rightClickMenuEnabled = false;

            addChild(_view);

            // Set up the camera
            _view.camera.z = -100;
            _view.camera.y = 500;
            _view.camera.lookAt(new Vector3D());
            _view.camera.lens = new PerspectiveLens(90);

            // Set up the scene
            var material:TextureMaterial = new TextureMaterial(Cast.bitmapTexture(RodinMapTexture), true, true);
            var r:Number = (_model.width / Math.PI) / 2;
            var r2:Number = (_model.height / Math.PI) / 2;
            _torus = new Mesh(new TorusGeometry(r, r2, 64, 32), material);
            _view.scene.addChild(_torus);

            // Register with AwayStats
            AwayStats.instance.registerView(_view);

            stage.addEventListener(flash.events.Event.RESIZE, onResize);

            onResize();

            _model.addEventListener(starling.events.Event.CHANGE, onModelChanged);
        }

        public function render():void
        {
            _torus.rotationX += 2;
            _torus.rotationY += 1;

            _view.render();
        }

        private function onAddedToStage(e:flash.events.Event):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);

            init();
        }

        private function onResize(e:flash.events.Event = null):void
        {
            _view.width = stage.stageWidth;
            _view.height = stage.stageHeight;
        }

        private function onModelChanged(e:starling.events.Event):void
        {
            createTorus(_model.bitmapData);
        }

        private function createTorus(texture:BitmapData):void
        {
            if (!texture)
            {
                return;
            }

            destroyTorus();

            var material:TextureMaterial = new TextureMaterial(new RectangularTexture(texture), true, false, false);
            var r:Number = _model.width / (Math.PI * 2);
            var r2:Number = _model.height / (Math.PI * 2);
            _torus = new Mesh(new TorusGeometry(r, r2, 64, 64), material);

            _view.scene.addChild(_torus);
        }

        private function destroyTorus():void
        {
            if (!_torus)
            {
                return;
            }

            if (_view.scene.contains(_torus))
            {
                _view.scene.removeChild(_torus);
            }

            _torus.dispose();
            _torus = null;
        }
    }
}

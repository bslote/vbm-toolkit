package pw.fractal.vbm {

    import away3d.core.managers.Stage3DManager;
    import away3d.core.managers.Stage3DProxy;
    import away3d.debug.AwayStats;
    import away3d.events.Stage3DEvent;

    import flash.display.DisplayObject;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import pw.fractal.vbm.model.SkinModel;

    import pw.fractal.vbm.ui.MapEditorView;
    import pw.fractal.vbm.view.IView;
    import pw.fractal.vbm.view.TestView;

    import starling.core.Starling;
    import starling.events.Event;

    [SWF(backgroundColor="#000000", width="1280", height="720", frameRate="60", quality="HIGH")]
    public class Main extends Sprite
    {
        // Display objects
        private var _starling:Starling;
        private var _view:IView;
        private var _statsMonitor:AwayStats;

        // Stage manager and proxy instances
        private var _stage3DManager:Stage3DManager;
        private var _stage3DProxy:Stage3DProxy;

        // Torus skin model
        private var _model:SkinModel;

        public function Main()
        {
            if (stage) init();
            else addEventListener(flash.events.Event.ADDED_TO_STAGE, init);
        }

        private function init(e:flash.events.Event = null):void
        {
            removeEventListener(flash.events.Event.ADDED_TO_STAGE, init);

            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

            _model = new SkinModel();
            _model.width = 1024;
            _model.height = 633;
            _model.numTiles = 9;

            initProxies();
        }

        private function initAway3D():void
        {
            _statsMonitor = new AwayStats(null, true);
            _statsMonitor.x = stage.stageWidth - _statsMonitor.width;

            var view:IView = new TestView(_stage3DProxy, _model);
            showView(view);

            addChild(_statsMonitor);
        }

        private function initStarling():void
        {
            // Create the map editor view
            Starling.handleLostContext = true;
            _starling = new Starling(MapEditorView, stage, _stage3DProxy.viewPort, _stage3DProxy.stage3D);
            _starling.addEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
        }

        private function onRootCreated(e:starling.events.Event):void
        {
            _starling.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);

            var view:MapEditorView = _starling.root as MapEditorView;
            view.model = _model;
            view.init();

            initListeners();

            onResize();

            _starling.start();
        }

        private function initListeners():void
        {
            stage.addEventListener(flash.events.Event.RESIZE, onResize);
            stage.addEventListener(flash.events.Event.ENTER_FRAME, onEnterFrame);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        public function showView(view:IView):void
        {
            if (_view)
            {
                removeChild(_view as DisplayObject);
            }

            _view = view;
            addChild(_view as DisplayObject);
        }

        private function initProxies():void
        {
            // Define a new Stage3DManager for the Stage3D objects
            _stage3DManager = Stage3DManager.getInstance(stage);

            // Create a new Stage3D proxy to contain the separate views
            _stage3DProxy = _stage3DManager.getFreeStage3DProxy();
            _stage3DProxy.addEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);
            _stage3DProxy.antiAlias = 8;
            _stage3DProxy.color = 0x0;
        }

        private function onContextCreated(e:Stage3DEvent):void
        {
            _stage3DProxy.removeEventListener(Stage3DEvent.CONTEXT3D_CREATED, onContextCreated);

            initAway3D();
            initStarling();
        }

        private function onEnterFrame(e:flash.events.Event):void
        {
            _stage3DProxy.clear();

            // Render Away3D layer
            if (!(_starling.root as MapEditorView).isVisible())
            {
                _view.render();
            }

            // Render starling
            _starling.nextFrame();

            _stage3DProxy.present();
        }

        private function onResize(e:flash.events.Event = null):void
        {
            _stage3DProxy.width = stage.stageWidth;
            _stage3DProxy.height = stage.stageHeight;

            _statsMonitor.x = stage.stageWidth - _statsMonitor.width;
        }

        private function onKeyDown(e:KeyboardEvent):void
        {
            switch (e.keyCode)
            {
                case Keyboard.TAB:
                    (_starling.root as MapEditorView).toggleVisibility();
                    break;
            }
        }
    }
}

/**
 * Created by bslote on 3/14/15.
 */
package pw.fractal.vbm.ui
{
    import feathers.controls.Button;
    import feathers.controls.Label;
    import feathers.controls.LayoutGroup;
    import feathers.controls.Panel;
    import feathers.controls.TextInput;
    import feathers.layout.HorizontalLayout;
    import feathers.layout.VerticalLayout;
    import feathers.themes.MinimalDesktopTheme;

    import pw.fractal.vbm.util.MathUtil;

    import starling.core.Starling;
    import starling.display.Sprite;
    import starling.events.Event;

    public class MapEditorView extends Sprite
    {
        private var _toolPanel:Panel;

        public function MapEditorView()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function init():void
        {
            new MinimalDesktopTheme();
            createToolPanel();
            // ...
        }

        private function createToolPanel():void
        {
            _toolPanel = new Panel();
            _toolPanel.title = "Tools";
            _toolPanel.height = Starling.current.stage.stageHeight;
            _toolPanel.width = Starling.current.stage.stageWidth / 6;

            createDigitalRootGroup();

            addChild(_toolPanel);
        }

        private function createDigitalRootGroup():void
        {
            var vGroup:LayoutGroup = new LayoutGroup();
            var vLayout:VerticalLayout = new VerticalLayout();
            vGroup.layout = vLayout;

            var hGroup:LayoutGroup = new LayoutGroup();
            var hLayout:HorizontalLayout = new HorizontalLayout();
            hLayout.gap = 10;
            hGroup.layout = hLayout;

            var label:Label = new Label();
            label.text = "Digital root calculator";

            var input:TextInput = new TextInput();
            input.width = 115;
            input.restrict = "0-9.";

            var output:TextInput = new TextInput();
            output.width = 30;
            output.isEditable = false;

            var calcButton:Button = new Button();
            calcButton.label = "=";
            calcButton.width = 30;
            calcButton.addEventListener(Event.TRIGGERED, calculateDigitalRoot);

            function calculateDigitalRoot(e:Event):void
            {
                var n:String = input.text.replace(".", "");
                if (n.length < 1 || n == "")
                {
                    return;
                }

                output.text = MathUtil.digitalRoot(parseInt(n)).toString();
            }

            hGroup.addChild(input);
            hGroup.addChild(output);
            hGroup.addChild(calcButton);

            vGroup.addChild(label);
            vGroup.addChild(hGroup);

            _toolPanel.addChild(vGroup);
        }

        private function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            init();
        }
    }
}

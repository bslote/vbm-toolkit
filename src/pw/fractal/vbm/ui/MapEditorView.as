/**
 * Created by bslote on 3/14/15.
 */
package pw.fractal.vbm.ui
{
    import feathers.controls.Button;
    import feathers.themes.AeonDesktopTheme;
    import feathers.themes.MinimalDesktopTheme;

    import starling.display.Sprite;
    import starling.events.Event;

    public class MapEditorView extends Sprite
    {
        public function MapEditorView()
        {
            addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

            new MinimalDesktopTheme();
//            new AeonDesktopTheme();

            var button:Button = new Button();
            button.label = "Test";

            addChild(button);
        }
    }
}

package template;

import template.utils.Advertising;
import extension.admob.GravityMode;
import template.utils.debug.DebugInfo;
import template.utils.game.Containers;
import template.utils.Localization;
import openfl.display.Sprite;
import template.utils.debug.Debug;
import openfl.events.Event;
import template.game.Game;
import template.utils.Metadatas;

/**
 * ...
 * @author Flavien
 */
class Main extends Sprite {

	public function new() {
		super();

		Containers.createContainers();
		Debug.initDefaultContainer(Containers.debug);
		addEventListener(Event.ENTER_FRAME, Game.gameloop);

		#if !html5
		Localization.init();
		#end
		Metadatas.load();

		if (Metadatas.application.advertising.enabled) {
			Advertising.init(GravityMode.BOTTOM);
		}

		Game.start();

		#if showdebuginfo
		var debugInfo:DebugInfo = new DebugInfo();
		addChild(debugInfo);
		#end
	}
}

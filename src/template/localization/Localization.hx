package src.template.localization;

import haxe.Json;
import Reflect;
import haxe.Json;

#if macro 
	import sys.io.File;
	import sys.FileSystem;
#end

/**
 * ...
 * @author Flavien
 */
class Localization
{
	private static var localizationSource:Map<String, Map<String, Dynamic>> = new Map<String, Map<String, Dynamic>> ();
	
	private static var language:String;
	private static var localizationPath:String = "localization/";
	
	
	/**
	 * Init the localization source
	 */
	public static function init () : Void {
		parseSource();
		// TO DO get default language from Device language/config file
		changeSelectLanguage("fr");
	}
	
	/**
	 * Set the language of localization
	 * @param	language
	 */
	public static function changeSelectLanguage(language:String) : Void {
		Localization.language = language;
	}
	
	/**
	 * Get text source from label
	 * @param	label 
	 * @return source of label
	 * @default return label if source do not exists
	 */
	public static function getText(label:String) : String {
		
		for (source in localizationSource.get(language)) {
			if (Reflect.hasField(source, label))
				return Reflect.field(source, label);
		}
		
		trace("Localization : get Text, try to access label do not exists");
		
		return label;
	}
	
	private static function parseSource () : Void {
		var jsonSources:String = Localization.getLocalizationSources();
		var sources:Json = Json.parse(jsonSources);
		
		for (lang in Reflect.fields(sources)) {
			localizationSource.set(lang, new Map<String, Dynamic>());
			for (json in Reflect.fields(Reflect.field(sources, lang))) {
				localizationSource.get(lang)
					.set(json, Reflect.field(Reflect.field(sources, lang), json));
			}
		}
	}

	macro public static function getLocalizationSources() {
		var sources:Dynamic = {};
		var sourcesStringified;

		for (lang in FileSystem.readDirectory("assets/localization/")) {
			if (Reflect.field(sources, lang) == null) {
				Reflect.setField(sources, lang, {});
			}
			for (json in FileSystem.readDirectory("assets/localization/" + lang)) {
				var keyValue = File.getContent("assets/localization/" + lang +"/" + json);
				Reflect.setField(Reflect.field(sources, lang), json, keyValue);
			}
		}

		sourcesStringified = Json.stringify(sources);

		return macro $v{sourcesStringified};
	}
}
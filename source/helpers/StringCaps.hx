package helpers;

/**
 * ...
 * @author bb
 */
class StringCaps 
{
	public static function first(s:String):String{
		var t:Array<String> = s.split("");
		t[0] = t[0].toUpperCase();
		return t.join("");
	}
}
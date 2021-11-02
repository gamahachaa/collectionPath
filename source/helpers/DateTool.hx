package helpers;

/**
 * ...
 * @author bb
 */
class DateTool 
{
	public static inline var DAY_MILLI:Int = 86400000;
	public static function GET_NEXT_WORKING_DAY(date:Date):Date
	{
		return new Date(
			date.getFullYear(),
			date.getMonth(),
			date.getDate() + switch(date.getDay())
			{
					case 6 : 2;
					case 0 : 1;
					default : 0;
				},
			date.getHours(),
			date.getMinutes(),
			date.getSeconds()
			);
	}
	public static function GET_DAYS_FOR_WORKING_DAYS(workingdays:Int, today:Date)
	{
		var weekWorkingdays :Int = 5;
		
		/*if ( today.getDay() - 1 + workingdays > 5)
		{
			var modulo = workingdays % weekWorkingdays;
			var times = Math.floor(workingdays / weekWorkingdays);
			trace(times, workingdays, modulo, times * 7 + modulo);
			return times * 7 + modulo;
		}
		else{
			return today.getDay() - 1 + workingdays;
		}*/
		
		var modulo = workingdays % weekWorkingdays;
		var times = Math.floor(workingdays / weekWorkingdays);
		//trace(times, workingdays, modulo, times * 7 + modulo);
		return times * 7 + modulo;
		
	
	}
}
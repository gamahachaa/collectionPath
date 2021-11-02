package;

import flixel.text.FlxText;
import helpers.DateTool;
import helpers.StringCaps;

/**
 * ...
 * @author bb
 */
class CollectionEvent extends FlxText 
{
	static inline var FIELD_WIDTH:Float = 600;
	static inline var FONT_SIZE:Int = 16;
	static inline var PADDING:Float = UI.PADDING_RIGHT;
	
	static public var ALL:Array<CollectionEvent> = [];
	
	public var date:Date;
	var daysAfterInvoice:String;
	var context:UI;
	var dayAfterDueDate:String;
	public var id:String;

	public function new(context:UI, id:String, Y:Float=0) 
	{
		super(PADDING, Y, FIELD_WIDTH, "", FONT_SIZE, true);
		this.textField.backgroundColor = 0x000000;
		this.textField.background = true;
		this.context = context;
		this.id = id;
		//this.daysAfterInvoice = id == "today"? Std.string(context.today.getDate()): CollectionData.EVENT_SETTINGS.get(id).get("days").get(context.selectedProcess);
		//trace(id);
		//trace(CollectionData.EVENT_SETTINGS);
		//trace(CollectionData.EVENT_SETTINGS.get(id));
		//trace(CollectionData.EVENT_SETTINGS.get(id).get("days"));
		dayAfterDueDate = CollectionData.EVENT_SETTINGS.get(id).get("days").get(context.selectedProcess);
		
		
		//this.date = id == "today" ? context.today : Date.fromTime( context.invoiceDate.getTime() + (daysAfterInvoice == "?" ? 95: Std.parseInt(daysAfterInvoice) * DAY_MILLI));
		//trace(this.id);
		//trace(DateTool.GET_DAYS_FOR_WORKING_DAYS(Std.parseInt(dayAfterDueDate), context.today));
		this.date = switch(id){
			case "today" : context.today;
			case "invoice" : context.invoiceDate;
			case "dueDate" : context.dueDate;
			default: switch (dayAfterDueDate){
				case "?" : Date.fromTime( context.dueDate.getTime() + (55 * DateTool.DAY_MILLI));
				case "" : Date.fromTime(0);
				default : DateTool.GET_NEXT_WORKING_DAY(Date.fromTime( context.dueDate.getTime() + ( Std.parseInt(dayAfterDueDate) * DateTool.DAY_MILLI) ));
				//default : DateTool.GET_NEXT_WORKING_DAY(Date.fromTime( context.dueDate.getTime() + ( DateTool.GET_DAYS_FOR_WORKING_DAYS(Std.parseInt(dayAfterDueDate)-1, context.today) * DateTool.DAY_MILLI) ));
			}
		}
	
		this.textField.text = buildText(false);
		this.color = CollectionData.GET_EVENTS_COLOR(id);
		//trace(CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("events").get(id).get("title"));
		this.drawFrame(true);
		ALL.push(this);
	}
	public function buildText( ?hover:Bool = true )
	{
		var dayDate = dayAfterDueDate == "?" ? CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("in"): date.getDate() <10 ? "0"+ Std.string(date.getDate()):Std.string(date.getDate()); 
		var month = CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("month")[date.getMonth()];
		var weekDay = dayAfterDueDate == "?" ? CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("day")[7]: CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("day")[date.getDay()];
		var title =   StringCaps.first(CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("events").get(id).get("title")) ;
		//trace(context.selectedlang);
		//trace(id);
		var sentence = '$weekDay, $dayDate $month ${date.getFullYear()} : ' + title + (id == "today" ? todayToDueDate():"");
		if (hover){
			var max = 60;
			var add = max - sentence.length;
			sentence += " ";
			while (add>0){
				sentence += "-";
				add--;
			}
			sentence += "->>";
		}
		return sentence;
		
	}
	function todayToDueDate()
	{
		var delta = (context.dueDate.getTime() - context.today.getTime() ) / DateTool.DAY_MILLI;
		//trace("---------------");
		//trace(id);
		//trace(Math.ceil(delta));
		var f = Math.abs(Math.ceil(delta)) ;
		var beforeAfter = delta < 0 ? CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("afterDueDate"): CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("beforeDuedate");
		return " ( " + f + beforeAfter  +  CollectionData.LANGUAGE_MAP.get(context.selectedlang).get("events").get("dueDate").get("title") + " )";
		
		
	}
	public static function SORTEVENTS()
	{
		/**/
		var today = ALL.pop();
		for (i in 0...ALL.length)
		{
			//trace(ALL[i].id, ALL[i].date.getTime(), today.date.getTime());
			if (ALL[i].date.getTime() > today.date.getTime())
			{
				ALL.insert(i, today);
				return;
			}
		}
		ALL.push(today);
		return;
		/**/
		//ALL.sort(SORT);
	}
	static function SORT(a:CollectionEvent, b:CollectionEvent)
	{
		if (a.date.getTime() > b.date.getTime()) return 1;
		else if (a.date.getTime() < b.date.getTime()) return -1;
		else return 0;
	}
}
package;

import flixel.FlxState;
import flixel.addons.ui.FlxUICheckBox;
import CollectionEvent;
import helpers.DateTool;
import helpers.StringCaps;
import js.Browser;
import openfl.ui.Mouse;
import openfl.ui.MouseCursor;
//import flixel.addons.ui.FlxSlider;
import flixel.addons.ui.FlxUIDropDownMenu;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUIRadioGroup;
import flixel.addons.ui.StrNameLabel;
import flixel.group.FlxGroup;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.system.FlxAssets;
import flixel.text.FlxText;

/**
 * ...
 * @author bb
 */
class UI extends FlxState 
{
	public var selectedlang:String;
	var MONTH_DE:Array<String>;
	var MONTH_FR:Array<String>;
	public var selectedMonth:Int;
	var text:FlxText;
	//var currentLang:String;
	var monthLangMap:Map<String,Array<String>>;
	var months:Array<StrNameLabel>;
	var langMap:Map<String, Map<String, Dynamic>>;
	var eventSettingMap:Map<String,Map<String,Dynamic>>;
	
	public var selectedContract:String;
	public var selectedProcess:String;
	var eventsFiltered:Array<String>;
	var events:FlxUIGroup;
	public var initialDate:Map<String,Int>;
	var descriptions:FlxText;
	var ddMonths:FlxUIDropDownMenu;
	var txContract:FlxText;
	var rdContract:FlxUIRadioGroup;
	var txProcess:FlxText;
	var txMonthInvoice:FlxText;
	static inline var DETAIL_HEIGHT:Float = 120;
	var txEvents:FlxText;
	var txDesc:FlxText;
	public var dueDate:Date;
	public static inline var PADDING_RIGHT:Float = 20;
	public var today:Date;
	public var invoiceDate:Date;
	public function new()
	{
		super();
		today = Date.now();
		selectedlang = Browser.location.href.indexOf("/fr/") >-1 ? "fr" : "de" ;
		//trace(Browser.location.href);
		selectedContract = "b2c";
		selectedProcess = "normal";
		initialDate = ["b2c"=>10,"b2b"=>1];
		eventSettingMap = CollectionData.EVENT_SETTINGS;
		langMap = CollectionData.LANGUAGE_MAP;
		monthLangMap = ["fr" => langMap.get("fr").get("month"), "de" => langMap.get("de").get("month")];
		
	}
	override public function create()
	{ 
		events = new FlxUIGroup(0,DETAIL_HEIGHT + 40);
		initMonths();
		ddMonths = new FlxUIDropDownMenu(PADDING_RIGHT + 400, 40, months, monthCB);
		for ( i in ddMonths.list)
		{
			i.label.size = 12;
		}
		ddMonths.header.text.size = 12;
		
		txEvents = new FlxText(PADDING_RIGHT, DETAIL_HEIGHT, 600, langMap.get(selectedlang).get("event"), 14);
		txDesc = new FlxText(PADDING_RIGHT + 600, DETAIL_HEIGHT, 600, langMap.get(selectedlang).get("detail"), 14);
		txEvents.color = 0xFFFF00;
		txDesc.color = 0xFFFF00;
		
		selectedMonth = today.getMonth();
		
		descriptions = new FlxText(PADDING_RIGHT + 600, DETAIL_HEIGHT + 40, 600, langMap.get(selectedlang).get("desc"), 18);
		
		var rdlang:FlxUIRadioGroup = new FlxUIRadioGroup(PADDING_RIGHT + 1200, 5, ["fr", "de"], ["Fr", "De"], langCB);
		var langRadios:Array<FlxUICheckBox> = rdlang.getRadios();
		
		txContract = new FlxText(PADDING_RIGHT, 10, 200, langMap.get(selectedlang).get("contract"), 14);
		txContract.color = 0xFFFF00;
		rdContract = new FlxUIRadioGroup(PADDING_RIGHT, 40, ["b2c", "b2b"], ["B2C", "B2B"], contractCB, 25, 200, 30, 200);
		var contractRadios:Array<FlxUICheckBox> = rdContract.getRadios();
		
		txProcess = new FlxText(PADDING_RIGHT + 200, 10, 200, langMap.get(selectedlang).get("process"), 14, true);
		txProcess.color = 0xFFFF00;
		txMonthInvoice = new FlxText(PADDING_RIGHT + 400, 10, 200, langMap.get(selectedlang).get("invoiceMonth"), 14);
		txMonthInvoice.color = 0xFFFF00;
		
		//var rdProcess:FlxUIRadioGroup = new FlxUIRadioGroup(PADDING_RIGHT + 200, 40, ["normal", "new", "canceled"], ["NORMAL", "FAST", "CANCELED"], processCB);
		var rdProcess:FlxUIRadioGroup = new FlxUIRadioGroup(PADDING_RIGHT + 200, 40, ["normal", "canceled"], ["NORMAL", "CANCELED"], processCB);
		var processRadios:Array<FlxUICheckBox> = rdProcess.getRadios();
		var radios = langRadios.concat(contractRadios.concat(processRadios));
		for (i in radios)
		{
			i.button.label.size = 12;
		}
		rdlang.selectedId = this.selectedlang;
		rdContract.selectedId = this.selectedContract = "b2c";
		rdProcess.selectedId = this.selectedProcess = "normal";
		
		setInvoiceDate();
		//trace("invoiceDate",invoiceDate);
		setDueDate();
		//trace("dueDate", dueDate);
		ddMonths.selectedId = Std.string(selectedMonth- 1) ;
		
		add(rdlang);
		add(txContract);
		add(txProcess);
		add(txMonthInvoice);
		add(rdContract);
		add(rdProcess);
		
		//add(text);
		add(txDesc);
		add(descriptions);
		add(txEvents);
		add(events);
		add(ddMonths);
		
		filterEvents();
		buildEvents();
		super.create();
	}
	function getYear()
	{
		return selectedMonth > today.getMonth() ? Std.int(today.getFullYear()) - 1:  today.getFullYear();
	}
	function setDueDate()
	{
		dueDate = new Date(getYear(), selectedMonth, 28, 0, 0, 0);
	}
	function setInvoiceDate() 
	{
		//var year = selectedMonth > today.getMonth() ? Std.int(today.getFullYear()) - 1:  today.getFullYear();
		/*var tmpDate = new Date(year, selectedMonth, initialDate.get(selectedContract), 0, 0, 0);
		var tmpDateDelta = switch(tmpDate.getDay()){
			case 6 : 2;
			case 0 : 1;
			default :0;
		}
		invoiceDate = new Date(tmpDate.getFullYear(), tmpDate.getMonth(), tmpDate.getDate() + tmpDateDelta, 0, 0, 0);
		*/
		invoiceDate = DateTool.GET_NEXT_WORKING_DAY( new Date(getYear(), selectedMonth, initialDate.get(selectedContract), 0, 0, 0));
	}
	function monthCB(selectedMonth:String)
	{
		this.selectedMonth = Std.parseInt(selectedMonth);
		setInvoiceDate();
		setDueDate();
		filterEvents();
		buildEvents();
	}
	function langCB(selectedlang:String)
	{
		this.selectedlang = selectedlang;
		
		setTitles();
		initMonths();
		ddMonths.setData(months);
		
		filterEvents();
		buildEvents();
		
		ddMonths.selectedId = Std.string(selectedMonth);
		ddMonths.drawFrame(true);
	}
	
	
	function contractCB(selectedContract:String)
	{
		this.selectedContract = selectedContract;
		setInvoiceDate();
		setDueDate();
		filterEvents();
		buildEvents();
	}
	function processCB(selectedProcess:String)
	{
		this.selectedProcess = selectedProcess;
		filterEvents();
		buildEvents();
	}
	function setTitles() 
	{
		txContract.text = CollectionData.LANGUAGE_MAP.get(selectedlang).get("contract");
		txContract.drawFrame(true);
		txDesc.text = CollectionData.LANGUAGE_MAP.get(selectedlang).get("detail");
		txDesc.drawFrame(true);
		txEvents.text = CollectionData.LANGUAGE_MAP.get(selectedlang).get("event");
		txEvents.drawFrame(true);
		txMonthInvoice.text = CollectionData.LANGUAGE_MAP.get(selectedlang).get("invoiceMonth");
		txMonthInvoice.drawFrame(true);
		txProcess.text = CollectionData.LANGUAGE_MAP.get(selectedlang).get("process");
		txProcess.drawFrame(true);
		descriptions.text = CollectionData.LANGUAGE_MAP.get(selectedlang).get("desc");
		descriptions.drawFrame(true);
		descriptions.color = 0xffffff;
	}
	function initMonths()
	{
		months = [
		new StrNameLabel("0",monthLangMap.get( selectedlang)[0] ),
		new StrNameLabel("1",monthLangMap.get( selectedlang)[1] ),
		new StrNameLabel("2",monthLangMap.get( selectedlang)[2] ),
		new StrNameLabel("3",monthLangMap.get(selectedlang)[3]),
		new StrNameLabel("4",monthLangMap.get(selectedlang)[4]),
		new StrNameLabel("5",monthLangMap.get(selectedlang)[5]),
		new StrNameLabel("6",monthLangMap.get(selectedlang)[6]),
		new StrNameLabel("7",monthLangMap.get(selectedlang)[7]),
		new StrNameLabel("8",monthLangMap.get(selectedlang)[8]),
		new StrNameLabel("9",monthLangMap.get(selectedlang)[9]),
		new StrNameLabel("10",monthLangMap.get(selectedlang)[10]),
		new StrNameLabel("11",monthLangMap.get(selectedlang)[11])
		];
		setInvoiceDate();
		setDueDate();
		//ddMonths.setData(months);
	}
	function filterEvents()
	{
		eventsFiltered = [];
		for ( k => v in eventSettingMap)
		{
			if (v.get("process").indexOf(this.selectedProcess) == -1 ||  v.get("contract").indexOf(this.selectedContract) == -1)
				continue;
			else
				eventsFiltered.push(k);
		}
		
		//trace("----");
		//trace(eventsFiltered);
	}
	function buildEvents()
	{
		events.clear();
		CollectionEvent.ALL = [];
		var Y = 0;
		var event:CollectionEvent;
		//var allEvents:Array<CollectionEvent> = [];
		for ( i in eventsFiltered)
		{
			event = new CollectionEvent(this,i);
		}
		
		CollectionEvent.SORTEVENTS();
		for ( j in 0...CollectionEvent.ALL.length)
		{
			event = CollectionEvent.ALL[j];
			event.y = Y;
			events.add(CollectionEvent.ALL[j]);
			FlxMouseEventManager.add(event, null, null, onEventRoll, onEventOut);
			Y += 30;
		}
	}
	
	
	function onEventOut(e:CollectionEvent):Void 
	{
		//trace(e.textField.text);
		descriptions.textField.text = "";
		Mouse.cursor = MouseCursor.ARROW;
		e.textField.text = e.buildText(false);
		e.drawFrame(true);
	}
	
	function onEventRoll(e:CollectionEvent):Void 
	{
		//trace(e.textField.text);
		e.textField.text = e.buildText(true);
		e.drawFrame(true);
		
		var event = CollectionData.LANGUAGE_MAP.get(selectedlang).get("events").get(e.id);
		var daysAfter = "";
		if (e.id != "invoice" && e.id != "dueDate" && e.id != "today")
		{
			daysAfter = " ( ~ " +CollectionData.EVENT_SETTINGS.get(e.id).get("days").get(selectedProcess) + CollectionData.LANGUAGE_MAP.get(selectedlang).get("afterDate") + CollectionData.LANGUAGE_MAP.get(selectedlang).get("events").get("dueDate").get("title") + " )";
		}
		descriptions.textField.text = StringCaps.first( event.get("title"))+  daysAfter + "\n-----------------------------\n\n" + event.get("desc");
		descriptions.color = CollectionData.GET_EVENTS_COLOR(e.id);
		Mouse.cursor = MouseCursor.BUTTON;
		descriptions.drawFrame(true);
	}
	override public function update(elasped:Float)
	{
		super.update(elasped);
		//if (selectedMonth != null) trace(selectedMonth);
		//text.text = selectedMonth;
	}
}
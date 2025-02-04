﻿/**
Font Notes :

notes, cannot have embedded and non embedded fonts in 1 field.

if using a stylesheet and an embedded font, the font-family:NAME must equal the actual name of the font,
not the linkage class.  

if using textformat create a new instance of the linkage class:
var font:LINKAGE = new LINKAGE();
tf.font = font.fontName;
*/


package {
	
	
	import com.hybrid.ui.ToolTip;
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	
	import flash.text.*;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.system.*;
	
	import flash.net.URLLoader;
    import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	
	
	public class Application extends MovieClip {
		
		
		private var _tf:TextField;
	 	private var _timer:Timer;
		private var _reusableTip:ToolTip;
		private var _sheet:StyleSheet = new StyleSheet();
		
		
		public function Application(){
		
			this.loadStyleSheet();

			_reusableTip = new ToolTip();
			_reusableTip.hook = true;
			_reusableTip.cornerRadius = 20;
			_reusableTip.tipWidth = 260; 
			_reusableTip.align = "right";
			_reusableTip.border = 0xFF0000;
			_reusableTip.borderSize = 5;
		}
		
		private function loadStyleSheet():void {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
            loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
			var req:URLRequest = new URLRequest("http://blog.hy-brid.com/flash/styles.css");
            loader.load(req);
		}

        public function errorHandler(event:IOErrorEvent):void {
			event.currentTarget.removeEventListener(event.type, arguments.callee);
            //inputField.htmlText = "Couldn't load the style sheet file.";
        }

        public function loaderCompleteHandler(event:Event):void {
			event.currentTarget.removeEventListener(event.type, arguments.callee);
			var loader:URLLoader = URLLoader(event.target);
			this._sheet.parseCSS(loader.data);
			this.initialize();
        }
		
		private function initialize():void {
			 level1.level2.buttonMode = true;
			 level1.level2.addEventListener( MouseEvent.MOUSE_OVER, this.onMouseOver );
			 level1.level2.addEventListener( MouseEvent.MOUSE_DOWN, this.omd );
			 
			 level0.buttonMode = true;
			 level0.addEventListener( MouseEvent.MOUSE_OVER, this.onMouseOverZero );
			 
			 level2.buttonMode = true;
			 level2.addEventListener( MouseEvent.MOUSE_OVER, this.onMouseOverTwo );
			 
			 level4.buttonMode = true;
			 level4.addEventListener( MouseEvent.MOUSE_OVER, this.onMouseOverFour );
			 
			 level5.buttonMode = true;
			 level5.addEventListener( MouseEvent.MOUSE_OVER, this.onMouseOverFive );
			 
			 level6.buttonMode = true;
			 level6.addEventListener( MouseEvent.MOUSE_OVER, this.onMouseOverSix );
			 
			 this.debug();
		}
		
		private function omd( event:MouseEvent ):void {
			_reusableTip.setContent( "Set A New Title", "Set Some New Content, A Little Less Than Before." );
		}
		
		private function onMouseOver( event:MouseEvent ):void {
			
			/*
			_reusableTip = new ToolTip();
			_reusableTip.hook = true;
			_reusableTip.cornerRadius = 20;
			_reusableTip.tipWidth = 260; 
			_reusableTip.align = "right";
			_reusableTip.border = 0xFF0000;
			_reusableTip.borderSize = 5;
			*/
			_reusableTip.show( level1.level2, "Click To Adjust Content", "Hook Enabled, Corner Radius 20, AutoSize Width, Height 150, Align Right, Border Red, Stroke 5px, Basic Format" );
			//this.traceDisplayList( stage );
		}
		
		
		private function onMouseOverZero( event:MouseEvent ):void {
			var tf:TextFormat = new TextFormat();
			var font:Georgia = new Georgia(); //font in library
			tf.font = font.fontName; 
			tf.bold = true;
			tf.size = 20;
			tf.color = 0x01430E;
			
			var contentFormat:TextFormat = new TextFormat();
			contentFormat.size = 14;
			contentFormat.color = 0xFFFFFF;
			contentFormat.bold = false;
			
			var tt:ToolTip = new ToolTip();
			tt.tipWidth = 250;
			tt.delay = 1000;
			tt.titleEmbed = true;  //allow embedding for title
			tt.titleFormat = tf;
			tt.contentFormat = contentFormat;
			tt.bgAlpha = .85
			tt.align = "left";
			tt.colors = [ 0x3366CC, 0x003300 ];
			tt.show( level0, "Styled Tip", "Custom Colors, 1000ms Delay, No Hook, Left Align, More Complex Format, Semi-Transparent Background" );
		}
		
		private function onMouseOverTwo( event:MouseEvent ):void {
			var tt:ToolTip = new ToolTip();
			tt.align = "center";
			tt.hook = true;
			tt.cornerRadius = 0;
			tt.show( level2, "Simple Tip", "Align Center, Hook Enabled, <i>Width Defaults To 200px</i>, Square / Corner Radius 0" );
		}
		
		private function onMouseOverFour( event:MouseEvent ):void {
			var tf:TextFormat = new TextFormat();
			tf.bold = true;
			tf.size = 12;
			tf.color = 0xff0000;
			var tt:ToolTip = new ToolTip();
			tt.hook = true;
			tt.cornerRadius = 10;
			//tt.tipWidth = 175; 
			tt.autoSize = true;
			tt.align = "center";
			tt.show( level4, "Play Now!" );
			//this.traceDisplayList( stage );
		}
		
		/* If using a stylesheet with embedded fonts, each font must be included in the FLA, you cannot mix embeds / non embeds
		in the same text field.
		*/
		private function onMouseOverFive( event:MouseEvent ):void {
			var tt:ToolTip = new ToolTip();
			tt.hook = true;
			tt.cornerRadius = 10;
			tt.tipWidth = 250; 
			//tt.tipHeight = 200;
			tt.titleEmbed = true;
			tt.align = "left";
			tt.stylesheet = this._sheet;
			tt.show( level5, "<h1>Simple ToolTip Title Only</h1><p class='body'>Using a stylesheet as opposed to a textformat.</p>" );
		}
		
		private function onMouseOverSix( event:MouseEvent ):void {
			var tt:ToolTip = new ToolTip();
			tt.hook = true;
			tt.cornerRadius = 10;
			tt.tipWidth = 350; 
			tt.titleEmbed = true;
			tt.contentEmbed = false;
			tt.buffer = 25;
			tt.bgAlpha = .75
			tt.align = "right";
			tt.stylesheet = this._sheet;
			tt.alpha = .5
			tt.show( level6, "<h1>ToolTip Title : Font Embed</h1>", "<p class='body'>Content : No Font Embed : Using a stylesheet as opposed to a textformat. Semi-Transparent Background</p>" );
		}
		
		
		private function debug():void {
			/* Memory Testing */
			_tf = new TextField()
			addChild( _tf );
			this._timer = new Timer( 25 );
			this._timer.addEventListener( "timer", onTimer );
			this._timer.start();
		}
		
		private function onTimer( event:TimerEvent ):void {
			_tf.text = flash.system.System.totalMemory.toString()
		}
		
		function traceDisplayList(container:DisplayObjectContainer, indentString:String = ""):void{
			var child:DisplayObject;
			for (var i:uint=0; i < container.numChildren; i++)
			{
				child = container.getChildAt(i);
				trace(indentString, child, child.name); 
				if (container.getChildAt(i) is DisplayObjectContainer)
				{
					traceDisplayList(DisplayObjectContainer(child), indentString + "    ")
				}
			}
		}


		
		
		
		
		
	}
}
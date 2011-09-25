package  managers
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * ...
	 * @author Metaform (c) Interactive
	 */
	public class TextEditorManager extends Sprite
	{
		private var textEditor:TextEditor;
		private var _textTrg:*;	//Element
		private var _text:String = "Lorem Ipsum is simply dummy text of the printing and  typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley  of type and scrambled it to make a type specimen book.";
		
		public function TextEditorManager( ) {
	
			if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point
			
			textEditor = new TextEditor(_text);
			textEditor.x = 100;
			textEditor.y = 100;
			textEditor.visible = false;
			addChild(textEditor);
			
			textEditor.addEventListener(TextEditor.ON_TEXT_SAVED, fire);

			
		}
		
		public function set text(txt:String):void {
			if ( stage ){
				(textEditor as TextEditor).mainText.htmlText = txt;
				textEditor.visible = true;
			}
		}
		
		public function set setTextSaveTarget( element:* ):void {
			_textTrg = element;
		}
		
		private function fire(e:Event):void {
				//trace(textEditor.mainText.htmlText);
				textEditor.visible = false;
				_textTrg.text = textEditor.mainText.htmlText;
		}
	}

}
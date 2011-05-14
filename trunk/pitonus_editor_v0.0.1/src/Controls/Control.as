package Controls{
	
	import flash.display.*;
	import flash.events.*;
	
	import Commands.*;
	import Utils.*;
	import Elements.*;
	import Controls.*;
	
	public class Control extends Sprite {
		
		var commandList:Array;
		var buttonList:Array;
		
		protected var currentElementClicked:int;
		
		public function Control() {
			this.commandList = new Array();
			this.buttonList = new Array();
		}
		
		public function setCommand(nSlot:int, c:ICommand):void {
			try{
				this.commandList[nSlot] = c;
			}catch (e:Error) { trace('[Error] setCommand: Setting command'); }
		}
		
		public function setButton(nSlot:int, trg:*):void {
			//trace(nSlot +  " : " + trg + " " + (trg is ActiveElement) + " " + trg.clickTarget);
			try{
				this.buttonList[nSlot] = trg;
				this.buttonList[nSlot].clickTarget.addEventListener( MouseEvent.CLICK, this.buttonClicked, false, 0, true);
			}catch (e:Error) { trace('[Error] setButton: Attaching listner'); }
	
		}
		
		public function removeButton( trg:* ):void {		
			trg.clickTarget.removeEventListener( MouseEvent.CLICK, this.buttonClicked);
		}
		
		public function buttonClicked(e:Event):void {
			//trace("   buttonClicked " + e.target);	
			
			for (var i:int = 0; i < buttonList.length; i++) {
				if (this.buttonList[i].clickTarget === e.target) {
					
					currentElementClicked = i;
					this.commandList[i].execute();
					break;
				}
			}
		}
	}
}


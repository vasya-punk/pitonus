package
{

	import adobe.utils.CustomActions;
    import flash.display.Sprite;
	import flash.display.DisplayObject;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
	import flash.display.LoaderInfo;
			
	import managers.*;
	
	import com.flashdynamix.utils.SWFProfiler;

    /* *
    * ...
    * @author Metaform ( c ) Interactive
    */

    [SWF( width = "1600", height = "1000", backgroundColor = "#FFFFFF", frameRate = "30" )]

    public class Main extends Sprite
    {

        public function Main() : void {

            if ( stage ) init();
            else addEventListener( Event.ADDED_TO_STAGE, init );
        }

        private function init( e : Event = null ) : void 	{

            removeEventListener( Event.ADDED_TO_STAGE, init );
            // entry point
			
				
			SWFProfiler.init(stage, this);

            // Turn scaling off and set alignment to top left
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;

			
			
			
			var flashVars:Object = LoaderInfo(this.root.loaderInfo).parameters;

           /* var screenWidth : uint = stage.stageWidth;
            var screenHeight : uint = stage.stageHeight;
            drawGrid();
            function drawGrid() : void
            {
                var gridColor : uint 		 = 0xDDDDDD;
                var gridCellSize : uint 	 = Config.GRID_SIZE;
                var gridLineWidth : uint	 = 1;
                var row : int 			 = screenHeight / gridCellSize + 1;
                var column : int 		 = screenWidth / gridCellSize + 1;

                for( var i : uint = 0; i < row; i ++ )               {
                    with ( graphics ) {
                        // clear();
                        lineStyle( gridLineWidth, gridColor, 1 );
                        moveTo( 0, i * gridCellSize );
                        lineTo( screenWidth, i * gridCellSize );
                    }
                }
                for( var j : uint = 0; j < column; j ++ ){
                    with ( graphics ) {
                        lineStyle( gridLineWidth, gridColor, 1 );
                        moveTo( j * gridCellSize, 0 );
                        lineTo( j * gridCellSize, screenHeight );
                    }
                }
            }
			*/
			
			
			DataManager.init();
			
			
			var app:Editor = new Editor(flashVars);
			//var app:Viewer = new Viewer(flashVars);
			addChild(app as DisplayObject);
			
		
			
		}
	}
}


	

			


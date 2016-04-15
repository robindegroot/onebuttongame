package Actors 
{
	
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	
	
	public class Arrow extends MovieClip 
	{
		
		private var speed:int= 30;
		public static const ARROW_OUT_OF_SCREEN:String = "arrow out of screen";
		
		public function Arrow():void 
		{
			addEventListener(Event.ADDED_TO_STAGE,init);
			addEventListener(Event.REMOVED_FROM_STAGE,removed);
		}
		
		private function init(e:Event):void
		{
			addEventListener(Event.ENTER_FRAME,update);
			this.x = 1280;
			var place= Math.ceil(Math.random()*4);
			if(place==1)
			{
				this.y=600;
			}else if(place==2)
			{
				this.y= 360;
			}else
			{
				this.y= 120;
			}
		}
		
		private function update(e:Event):void
		{
			this.x -=speed;
			if (this.x <= -50)
			{
				dispatchEvent(new Event(ARROW_OUT_OF_SCREEN));
			}
		}
		
		private function removed(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME,update);
		}
		
		
	}
	
}

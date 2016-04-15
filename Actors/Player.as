package Actors 
{
	import flash.ui.Keyboard;
	import flash.display.MovieClip;
	import flash.events.KeyboardEvent;
	
	
	public class Player extends MovieClip 
	{
		
		
		public function Player() 
		{
			addEventListener(KeyboardEvent.KEY_UP,playerMove);
			this.x = 100;
			this.y = 600;
		}
		private function playerMove(e:KeyboardEvent):void
		{
			
		}
	}
	
}

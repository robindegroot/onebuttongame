 package  
{
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.sampler.Sample;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.KeyboardEvent;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	
	import Screens.WinScreen;
	import Screens.Losescreen;
	import Screens.GameScreen;
	import Screens.StartScreen;
	import Actors.Arrow;
	import Actors.Player;
	
	
	
	public class Main extends MovieClip 
	{
		
		private var arrowTimer:Timer= new Timer(600,0);
		private var introTimer:Timer= new Timer(4000,0);
		private var winTimer:Timer= new Timer(4000,0);
		
		private var arrows:Array=[];
		
		private var backGround:MovieClip = new GameScreen();
		private var startScreen:MovieClip = new StartScreen();
		private var loseScreen:MovieClip = new Losescreen();
		private var winScreen:MovieClip = new WinScreen();
		private var arrow:MovieClip = new Arrow();
		private var player:Player = new Player();
		
		private var death:Boolean;
		private var cijfer:int=0;
		private var score:int=0;
		private var tFormat:TextFormat=new TextFormat;
		private var tScore:TextField=new TextField;
		
		private var gameState:String;
		private static const INTRO:String = "intro";
		private static const GAME:String = "game";
		private static const WIN:String = "win";
		private static const LOSE:String = "lose";
		
		public function Main():void
		{
			buildIntro();
			addListeners();
		}
		
		private function addListeners():void
		{
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
			arrowTimer.addEventListener(TimerEvent.TIMER,spawnArrow);
			introTimer.addEventListener(TimerEvent.TIMER,it);
			winTimer.addEventListener(TimerEvent.TIMER,win);
			
		}
		
		private function buildIntro():void
		{
			addChild(startScreen);
			gameState=Main.INTRO;
			death=false;
			score=0;
		}
			
		private function destroyIntro():void
		{
			removeChild(startScreen);
			buildGame();
		}
		
		private function buildGame():void
		{
			addChild(backGround);
			addChild(player);
			arrowTimer.start();
			gameState=Main.GAME;
		}
		
		private function spawnArrow(te:TimerEvent):void
		{
			arrows.push(new Arrow());
			addChild(arrows[arrows.length-1]);
			arrows[arrows.length-1].addEventListener(Arrow.ARROW_OUT_OF_SCREEN,deleteArrow);
		}
	
		private function deleteArrow(e:Event):void
		{
			var arrow:Arrow=e.target as Arrow;
			removeChild(arrow);
			arrows.splice(arrows.indexOf(arrow),1);
			score++;
			trace(score);
		}
		
		private function destroyGame():void
		{
			arrowTimer.stop();
			removeChild(backGround);
			removeChild(player);
			buildLose();
			death=true;
			introTimer.start();
		}
		private function it(te:TimerEvent):void
		{
			introTimer.stop();
			buildIntro();
		}
		private function win(win:TimerEvent):void
		{
			winTimer.stop();
			destroyWin();
		}
		private function destroyWin():void
		{
			removeChild(winScreen);
			buildIntro();
			
		}
		private function buildLose():void
		{
			gameState=Main.LOSE;
			addChild(loseScreen);
			for(var i:int=0;i<arrows.length; i++)
			{
				removeChild(arrows[i]);
				arrows.splice(i,1);
				
			}
		}
		private function buildWin():void
		{
			addChild(winScreen);
			gameState=Main.WIN;
			winTimer.start();
			arrowTimer.stop();
			for(var i:int=0;i<arrows.length; i++)
			{
				removeChild(arrows[i]);
				arrows.splice(i,1);
				
			}
		}
		
		private function update(e:Event):void
		{
			for(var i =arrows.length-1; i>=0; i--)
			{
				if(player.hitTestObject(arrows[i]))
				{
					removeChild(arrows[i]);
					arrows.splice(i,1);
					destroyGame();
				}
			}
			if (score==50)
			{
				buildWin();
			}
			tScore.text="score: "+score;
			tScore.textColor= 0xFFFFFF;
			tFormat.font="Arial";
			tFormat.size=30;
			tScore.width=300;
			tScore.defaultTextFormat=tFormat;
			addChild(tScore);
			tScore.x=100;
			tScore.y=75;
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			if (e.keyCode==32&&gameState==Main.INTRO)
			{
					destroyIntro();
			}
			
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			if(e.keyCode==Keyboard.SPACE)
			{
				if(death==false)
					{
					if(cijfer==0){
						player.y=360;
						cijfer = 1;
					}else if(cijfer==1)
					{
						player.y=120;
						cijfer = 2;
					}else if(cijfer==2)
					{
						player.y=600;
						cijfer = 0;
					}
				}
			}
		}
	}
	
}

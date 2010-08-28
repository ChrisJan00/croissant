package 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.events.KeyboardEvent;

    import flash.display.Loader;
    import flash.net.URLRequest;
	
	import flash.media.SoundMixer;
	import flash.media.Sound;
	
	
	public class Main extends Sprite 
	{
		private var _input:TextField;
		private var _display:Bitmap;
		private var _output:TextField;
		
		private var current_scene:int = 1;
		
		private var read_book:Boolean = false;
		private var shat:Boolean = false;
		private var kitchen_open:Boolean = false;
		private var chef_convinced:Boolean = false;
		
		[Embed(source = "../bin/images/kitchen_closed.png")]
		private var KitchenClosed:Class;
		
		[Embed(source = "../bin/images/library.png")]
		private var Library:Class;
		
		[Embed(source = "../bin/images/kitchen_open.png")]
		private var KitchenOpen:Class;
		
		[Embed(source = "../bin/images/cut_hand.png")]
		private var CutHand:Class;
		
		[Embed(source = "../bin/images/library_death.png")]
		private var LibraryDeath:Class;
		
		[Embed(source = "../bin/images/win.png")]
		private var Win:Class;
		
		[Embed(source = "../bin/songs/kinda_cheesy_chiptune_song.mp3")]
		private var MainSong:Class;
		
		[Embed(source = "../bin/songs/you_win.mp3")]
		private var WinSong:Class;
		
		[Embed(source = "../bin/songs/you_fail.mp3")]
		private var LoseSong:Class;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
				////////////////////// Bitmap Showing Code /////////////////////
        private var size:uint = 640;
		private var imageslist:Array = new Array();
	
		
		private function populateList():void {
		
			imageslist[0] = "images/kitchen_closed.png"; 
			imageslist[1] = "images/library.png";
			imageslist[2] = "images/kitchen_open.png";
			imageslist[3] = "images/cut_hand.png";
			imageslist[4] = "images/library_death.png";
			imageslist[5] = "images/win.png";
			
			}
			
		

       private var gloader:Loader = new Loader();
	   private var scene:Bitmap = new Bitmap();
	   private var request:URLRequest = new URLRequest();
	   
	   public function showImage(integer:Number):void {
			unShow();
			loadImage(integer);
			addChild(_input);
			addChild(_output);
	   }
			
        public function loadImage(integer:Number):void {

			//var loader:Loader = new Loader();
            gloader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            //loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

            var request:URLRequest = new URLRequest(imageslist[integer]);
            gloader.x = size * numChildren;
            gloader.load(request);
            addChild(gloader);
			
			
			}
			
			private function unShow():void {
				removeChild(gloader);
				removeChild(_input);
				removeChild(_output);
				gloader.unload();
				}
        

        private function completeHandler(event:Event):void {
            var loader:Loader = Loader(event.target.loader);
            var image:Bitmap = Bitmap(loader.content);
        }
		
        ////////////////////// END Bitmap Showing Code /////////////////////
		
		////////////////////// Music Code /////////////////////
		
		public function playTune( integer:Number ):void {
			
			var songslist:Array = new Array();
			songslist[0] = "songs/kinda_cheesy_chiptune_song.mp3"
			songslist[1] = "songs/you_win.mp3"
			songslist[2] = "songs/you_fail.mp3"
			
			SoundMixer.stopAll();
			var mySound:Sound = new Sound();
			mySound.load(new URLRequest(songslist[integer]));
			mySound.play();

			}
    
		////////////////////// END Music Code /////////////////////
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			populateList();
			loadImage(0);
			_input = new TextField();
			_input.selectable = true;
			_input.type = TextFieldType.INPUT;
			_input.height = 30;
			_input.width = 640;
			_input.x = 20;
			_input.y = 510;
			_input.text = "Write stuff here";
			_input.textColor = 0xff000000;
			_input.backgroundColor = 0xffffffff;
			_input.background = false;
			_input.addEventListener(KeyboardEvent.KEY_DOWN, enter_input, false);
			this.addChild(_input);
			
			_output = new TextField();
			_output.selectable = false;
			_output.type = TextFieldType.INPUT;
			_output.height = 30;
			_output.width = 640;
			_output.x = 0;
			_output.y = 480;
			_output.text = ""
			_output.textColor = 0xff0000;
			_output.backgroundColor = 0xffffff;
			_output.background = false;
			this.addChild(_output);
			playTune(0);
			
		}
		
		private function enter_input(e:KeyboardEvent):void
		{
			if (e.keyCode == 13)
			{
				switch (_input.text)
				{
					case "leave":
						switch_scene();
						break;
					case "exit":
						switch_scene();
						break;
					case "talk chef":
						if (current_scene == 1 && read_book == 0)
							_output.text = "The chef kindly tells you to go away";
						if (current_scene == 1 && read_book == 1)
						{
							_output.text = "You convince the chef of giving up the croissant with your advanced knowledge in psychology. Thanks Freud!"
							chef_convinced = true;
						}
						if (current_scene == 2)
							_output.text = "The chef is in the kitchen.";
						break;
					case "read book":
						if (current_scene == 1)
							_output.text = "There is no book here";
						if (current_scene == 2)
						{
							_output.text = "You read a book on advanced pschology, you feel the power of knowledge running through every fiber in your body."
							read_book = true;
						}
						break;
					case "shit":
						if (shat == false)
						{
							_output.text = "You take a massive dump in your pants but are not sure how this is going to solve your problem."
							shat = true;
						} else {
							_output.text = "You already shat yourself and it's going to leave you very uncomfortable for the rest of the day."
						}
						break;
					case "open door":
						if (current_scene == 1){
							if (kitchen_open == false)
							{
								_output.text = "You open the door leading behind your counter and towards your goal."
								kitchen_open = true;
								showImage(2);
							} else {
								_output.text = "The door is already open."
							}
						} else {
							_output.text = "There is no door here."
						}
						break;
					case "take croissant":
						if (current_scene == 1)
						{
							if (kitchen_open == true)
							{
								if (chef_convinced == true)
								{
									_output.text = "You take the croissant. Congratulations";
									showImage(5);
									win();
								}
								else {
									showImage(3);
									_output.text = "The chef is seriously pissed and cuts your hand off. You die out of humiliation and blood loss.";
									end();
								}
							} else {
								_output.text = "The door is not open and your objective out of reach";
							}
						} else if (current_scene == 2) {
							_output.text = "There is no croissant here.";
						}
						break;
						
						case "read red book":
						if (current_scene == 2)
						{
							read_book = true;
			  			    _output.text = "The red book teaches you advanced psychology.";
							break;
						}
		
						case "read green book":
						if (current_scene == 2)
						  {
							  showImage(4);
							  _output.text = "You starve while reading the green book.  Congratulations.  You lost.";
							  end();
							  break;
							 }
						case "read blue book":
						  if (current_scene == 2)
						  {
							  showImage(4);
							  _output.text = "Reading the blue book takes longer than you thought.  You're dead.";
							  end();
							  break;
						  }
		
						case "talk to lady":
						  if (current_scene == 2)
						  {
							  _output.text = "The lady does not respond";
							  break;
							 }
						default:
							_output.text = "What?";
										
						}
							_input.text = "";
							}
						}
		
		private function switch_scene():void
		{
			if (kitchen_open == false)
			{
				if (current_scene == 1)
				{
					current_scene = 2;
					showImage(1);
				} else {
					current_scene = 1;
					showImage(0);
				}
			} else {
				if (current_scene == 1)
				{
					current_scene = 2;
					showImage(1);
				} else {
					current_scene = 1;
					showImage(2);
				}
			}
		}
		
		private function win():void
		{
			_input.selectable = false;
			playTune(1);
		}
		
		private function end():void
		{
			_input.selectable = false;
			playTune(2);
		}
	}
	
}
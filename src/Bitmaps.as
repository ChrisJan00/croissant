
package {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.*;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.net.URLRequest;

    public class Bitmaps extends Sprite {
        //private var url:String = "Image.gif";
        //private var size:uint = 80;

        
        private var size:uint = 640;
		private var imageslist:Array = new Array();
		
		public function Bitmaps() {
            populateList();
        }

		private function populateList():void {
		
			imageslist[0] = "images/Image.gif"; 
			imageslist[1] = "images/Image1.gif";
			
			}


        public function showImage(integer:Number):void {
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            //loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);

            var request:URLRequest = new URLRequest(imageslist[integer]);
            loader.x = size * numChildren;
            loader.load(request);
            addChild(loader);
        }


        private function completeHandler(event:Event):void {
            var loader:Loader = Loader(event.target.loader);
            var image:Bitmap = Bitmap(loader.content);
        }
    }
}
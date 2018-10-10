package 
{
	/**
	 * ...
	 * @author Rodrigo
	 */
	import org.flixel.*;

	public class BalaEnemiga extends FlxSprite
	{
		private var danho:Number = 0;
		
		public function BalaEnemiga(x: Number, y: Number, pdanho:Number):void
		{
			super(x, y);
			makeGraphic(2, 16,0x99FF3333);
			velocity.y = 100;
			danho = pdanho;
			
		}
		
		public function getDanho():Number
		{
			return danho;
		}
		
		override public function update():void
		{
			if (this.getScreenXY().y >= FlxG.height){
				this.kill();
			}
		}
	}

}
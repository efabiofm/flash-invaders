package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	/**
	 * Items que otorgan al heroe mejoras temporales
	 * @author Fabio Flores
	 */
	public class FIFItem extends FlxSprite
	{
		[Embed(source = "sounds/powerup.mp3")]
		private var sonidoPowerup:Class;
		public function FIFItem(x:Number, y:Number, itemPNG:Class) 
		{
			super(x, y, itemPNG);
		}
		
		//cada item implementará esta funcion de forma distinta para causarle determinado efecto al heroe
		public function activarEfecto():void{
			FlxG.play(sonidoPowerup, 0.5);
		}
		
		override public function update():void{
			super.update();
			velocity.y = 100;
			
			if (this.getScreenXY().y >= FlxG.height){
				this.kill();
			}
		}
		
	}

}
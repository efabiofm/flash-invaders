package 
{
	import org.flixel.FlxGroup;
	/**
	 * Clase abstracta para crear naves heroes
	 * @author Fabio Flores
	 */
	public class FIHeroe extends Heroe
	{
		[Embed(source = "assets/Heroe.png")]
		private var _heroePNG:Class;
		
		public function FIHeroe(px:Number, py:Number) 
		{
			super(px, py, 1, 3, 3);
			loadGraphic(_heroePNG, true, false, 30, 30);
			setVelocidad(3);
		}
		
		override public function setPuntos(ppuntos:int):void 
		{
			super.setPuntos(getPuntos() + ppuntos);
		}
		
		public static function getInstance():Heroe{
			if (Heroe.instance === null){
				Heroe.instance = new FIHeroe(324, 600);
			}
			return Heroe.instance;
		}
	}

}
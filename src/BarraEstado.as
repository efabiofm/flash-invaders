package 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author Fabio Flores
	 */
	public class BarraEstado extends FlxGroup
	{
		private const MAXIMO_VIDA:Number = 50;
		private var bar:FlxSprite;
		private var cantBombas:FlxText;
		
		public function BarraEstado()
		{
			var frame:FlxSprite = new FlxSprite(9,9);
			frame.makeGraphic(52,15);
			frame.scrollFactor.x = frame.scrollFactor.y = 0;
			add(frame);

			var inside:FlxSprite = new FlxSprite(10,10);
			inside.makeGraphic(50,13,0xff000000);
			inside.scrollFactor.x = inside.scrollFactor.y = 0;
			add(inside);

			bar = new FlxSprite(10,10);
			bar.makeGraphic(1,13,0xffff0000);
			bar.scrollFactor.x = bar.scrollFactor.y = 0;
			bar.origin.x = bar.origin.y = 0;
			bar.scale.x = 30;
			add(bar);
			
			cantBombas = new FlxText(10, 25, 100);
			add(cantBombas);
		}
		
		public function modificar(cant:Number):void{
			if(cant <= MAXIMO_VIDA){
				bar.scale.x = cant * 10;
			}
		}
		
		public function setTextoCantBombas(pcant:Number):void{
			cantBombas.text = pcant.toString() + " bombas";
		}
	}

}
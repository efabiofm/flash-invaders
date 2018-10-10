package 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Fabio Flores
	 */
	public class MenuInstrucciones extends FlxState
	{
		[Embed(source = "assets/black.jpg")]
		private var Black:Class;
		public function MenuInstrucciones() 
		{
			var black:FlxSprite = new FlxSprite(0, 0, Black);
			add(black); 
			
			var titulo:FlxText = new FlxText(FlxG.width * 0.5 -200, 150, 400, "INSTRUCCIONES");
			titulo.setFormat(null, 30, 0xFF0000, "center");
			add(titulo);
			
			var mover:FlxText = new FlxText(FlxG.width * 0.5 -200, 250, 500, "MOVER: [FLECHAS DIRECCIONALES]");
			mover.setFormat(null, 20);
			add(mover);
			
			var disparar:FlxText = new FlxText(FlxG.width * 0.5 -200, 300, 500, "DISPARAR: [BARRA ESPACIADORA]");
			disparar.setFormat(null, 20);
			add(disparar);
			
			var bombas:FlxText = new FlxText(FlxG.width * 0.5 -200, 350, 500, "LANZAR BOMBAS: [B]");
			bombas.setFormat(null, 20);
			add(bombas);
			
			var volver:FlxText = new FlxText(FlxG.width * 0.5 -200, 450, 400, "PRESIONE [BACKSPACE] PARA VOLVER");
			volver.setFormat(null, 14, 0xFF0000, "center");
			add(volver);
		}
		
		override public function update():void
		{
			if(FlxG.keys.BACKSPACE){
				FlxG.switchState(new MenuPrincipal);
			}
		}
		
	}

}
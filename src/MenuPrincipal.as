package 
{
	/**
	 * ...
	 * @author Melanie Fallas...
	 */
	import org.flixel.*;

	public class MenuPrincipal extends FlxState
	{
		[Embed(source="assets/black.jpg")]
		private var Black:Class;
		[Embed(source = "sounds/intro.mp3")]
		private var musicaFondo:Class;
		
		public function MenuPrincipal()
		{
			
		}
		
		override public function create():void
		{
			FlxG.playMusic(musicaFondo);
			
			var black:FlxSprite = new FlxSprite(0, 0, Black);
			add(black); 
			
			var logo:FlxText = new FlxText(FlxG.width * 0.5 -200, 250, 400, "FLASH INVADERS");
			logo.setFormat(null, 40, 0xFFFFFF, "center");
			add(logo);
			
			var inicio:FlxText = new FlxText(FlxG.width * 0.5 -200, 350, 400, "PRESIONE [X] PARA EMPEZAR");
			inicio.setFormat(null, 20, 0xFF0000, "center");
			add(inicio);
			
			var instrucciones:FlxText = new FlxText(FlxG.width * 0.5 -200, 400, 400, "PRESIONE [TAB] PARA VER INSTRUCCIONES");
			instrucciones.setFormat(null, 14, 0xFF0000, "center");
			add(instrucciones);
		}

		override public function update():void
		{
			if (FlxG.keys.X){
				FlxG.fade(0xff000000, 1, startPlay);
			}
			if (FlxG.keys.TAB){
				FlxG.switchState(new MenuInstrucciones);
			}
			super.update();
		}
		
		private function startPlay():void
		{
			FlxG.music.stop();
			FlxG.switchState(new PlayState);
		}
	}
}

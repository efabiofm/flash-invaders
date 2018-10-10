package 

{
	import mx.core.FlexSprite;
	import org.flixel.*;
	/**
	 * ...
	 * @author Melanie Fallas
	 */
	public class Perder extends FlxState 
	{
		[Embed(source="assets/gameOver.jpg")]
		private var Imagen:Class;
		
		[Embed(source="sounds/lose.mp3")]
		private var musicaPerdio:Class;
		
		private var puntajeTotal: FlxText;
		private var nivelTxt:FlxText;
		private var regresar: FlxText;
		private var _heroe:FIHeroe;
		private var puntajeActual:Number;
		private var nivelAlcanzado:Number;

		public function Perder(puntosHeroe:Number, pnivel:Number)
		{
			setPuntosActual(puntosHeroe);
			setNivelAlcanzado(pnivel);
		}
		override public function create():void
		{	
			
			FlxG.playMusic(musicaPerdio);
			var imagen:FlxSprite = new FlxSprite(100, 100, Imagen);
			add(imagen); 
			
			var puntaje: String = "Puntaje Total :" + puntajeActual;
			puntajeTotal = new FlxText(FlxG.width * 0.5 -200, 400, 400,puntaje);
			puntajeTotal.setFormat(null, 15, 0xFFFFFF, "center");
			add(puntajeTotal);
			
			var nivelStr: String = "Nivel Alcanzado :" + nivelAlcanzado;
			nivelTxt = new FlxText(FlxG.width * 0.5 -200, 425, 400,nivelStr);
			nivelTxt.setFormat(null, 15, 0xFFFFFF, "center");
			add(nivelTxt);

			var instrucciones:FlxText = new FlxText(FlxG.width * 0.5 -200, 475, 400, "PRESIONE [F5] para volver a empezar");
			instrucciones.setFormat(null, 14, 0xFFFFFF, "center");
			add(instrucciones);

		}
		
		private function setPuntosActual(ppuntaje:Number):void{
			puntajeActual = ppuntaje;
		}
		
		public function setNivelAlcanzado(pnivel:Number):void{
			nivelAlcanzado = pnivel;
		}

		override public function update():void
		{
			super.update();
		}
	}

}

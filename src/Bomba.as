package 
{
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Fabio Flores
	 */
	public class Bomba extends FlxSprite
	{
		[Embed(source = "assets/BombaUno.png")]
		private var _bombaPNG:Class;
		[Embed(source = "assets/ExplosionBomba.png")]
		private var _explosionPNG:Class;
		[Embed(source = "sounds/lanzar_bomba.mp3")]
		private var _sonidoLanzar:Class;
		[Embed(source = "sounds/explosion_bomba.mp3")]
		private var _sonidoExplosion:Class;
		private var _sonidoActual:FlxSound;
		private var _haChocado:Boolean;
		private var _dano:Number;
		
		public function Bomba(x:Number, y:Number) 
		{
			super(x, y, _bombaPNG);
			velocity.y = -400;
			_haChocado = false;
			_dano = 5;
		}
		
		override public function update():void{
			super.update();
			if (y < 0) {
				kill();
			}
		}
		
		private function onExplotionAnimation(name:String, frame:uint, index:uint):void{
			if (index == 14){
				kill();
			}
		}
		
		public function explotar():void{
			if ( !_haChocado ) {
				velocity.y = 0;
				loadGraphic(_explosionPNG, true, false, 128, 128);
				x = x - 64;
				y = y - 64;
				addAnimation("explotar", [0, 2, 4, 6, 8, 10, 12, 14], 15, false);
				addAnimationCallback(onExplotionAnimation);
				_sonidoActual.stop();
				FlxG.play(_sonidoExplosion);
				play("explotar");
				_haChocado = true;
			}
		}
		
		public function getDano():Number{
			return _dano;
		}
		
		public function setDano(valor:Number):void{
			_dano = valor;
		}
		
		public function sonar():void{
			_sonidoActual = FlxG.play(_sonidoLanzar);
		}
		
	}

}
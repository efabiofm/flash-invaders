package 
{
	/**
	 * Clase general de las balas del heroe
	 * @author Fabio Flores
	 */
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class BalaHeroe extends FlxSprite
	{
		private var _velocidad:Number;
		private var _dano:Number;
		private var _grafico:Class;
		private var _sonido:Class;
		
		public function BalaHeroe(px:Number, py:Number, pvelocidad:Number, pdano:Number, pgrafico:Class=null, psonido:Class=null):void
		{
			super(px, py, pgrafico);
			_grafico = pgrafico;
			_velocidad = pvelocidad;
			_dano = pdano;
			_sonido = psonido;
		}
		
		public function getVelocidad():Number{
			return _velocidad;
		}
		
		public function setVelocidad(value:Number):void{
			_velocidad = value;
		}
		
		public function getGrafico():Class{
			return _grafico;
		}
		
		public function setGrafico(value:Class):void{
			_grafico = value;
		}
		
		public function getDano():Number{
			return _dano;
		}
		
		public function setDano(value:Number):void{
			_dano = value;
		}
		
		public function sonar():void{
			FlxG.play(_sonido, 0.5);
		}
		
		override public function update():void{
			super.update();
			velocity.y = getVelocidad();
			
			if (this.getScreenXY().y <= 0){
				this.kill();
			}
		}
	}

}
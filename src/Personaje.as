package 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class Personaje extends FlxSprite
	{
		private var _vida:Number;
		private var _velocidad:Number;
		
		//CLASE ABSTRACTA, DEBE SER HEREDADA Y NO INSTANCIADA
		public function Personaje(px:Number, py:Number, pvida:Number) 
		{
			super(px, py);
			this.setVida(pvida);
		}
		
		public function getVida():Number 
		{
			return _vida;
		}
		
		public function setVida(value:Number):void 
		{
			_vida = value;
		}
		
		public function getVelocidad():Number 
		{
			return _velocidad;
		}
		
		public function setVelocidad(value:Number):void 
		{
			_velocidad = value;
		}
	}

}
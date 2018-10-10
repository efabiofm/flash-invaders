package 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Achio
	 */
	public class Obstaculo extends FlxSprite
	{
			private var _daño:Number;
			private var _vida:Number;
			private var _modificarTamaño:Number;
			private var _velocidad:Number;
		
			//Funcion para animacion
		public function Obstaculo(x:Number, y:Number, itemPNG:Class, velocidad:Number,width:Number,height:Number) 
		{
			super(x, y);
			loadGraphic(itemPNG, true, false, width, height);
			_velocidad = velocidad;
		}
		
		public function getVelocidad():Number 
		{
			return _velocidad;
		}
		
		public function setVelocidad(value:Number):void 
		{
			_velocidad = value;
		}

	
		override public function update():void{
			super.update();
			velocity.y = _velocidad;
		}
		
	}

}
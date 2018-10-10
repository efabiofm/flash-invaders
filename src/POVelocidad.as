package 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * Item que aumenta temporalmente la velocidad del heroe
	 * @author Fabio Flores
	 */
	public class POVelocidad extends FIFItem
	{
		[Embed(source = "assets/ItemVelocidad.png")]
		private var itemPNG:Class
		private var _contadorEfecto:Timer;
		
		public function POVelocidad(x:Number, y:Number) 
		{
			super(x, y, itemPNG);
			_contadorEfecto = new Timer(10000);
			_contadorEfecto.addEventListener(TimerEvent.TIMER, detenerEfecto);
			_contadorEfecto.start();
		}
		
		override public function activarEfecto():void{
			super.activarEfecto();
			var heroe:Heroe = FIHeroe.getInstance();
			heroe.velocity.y = 0;
			heroe.setVelocidad(6);
		}
		
		private function detenerEfecto(event:TimerEvent):void{
			FIHeroe.getInstance().restaurarVelocidad();
			_contadorEfecto.stop();
			kill();
		}
		
	}

}
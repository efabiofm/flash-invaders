package 
{
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	/**
	 * ...
	 * @author Rodrigo Paris
	 */
	public class OleadaEnemiga extends FlxGroup
	{
		private var listaEnemigos:FlxGroup;
		private var cantidadEnemigos:Number;
		private var oleadaTerminada:Boolean;
		private var intervaloEntreEnemigos:Number = 0;
		private var contadorTiempo:Number;
		private var posX:Number;
		private var posY:Number;
		private var tipoEnemigos:Number;
		private var tipoMovimientoEnemigos:Number;
		
		public function OleadaEnemiga(px:Number, py:Number, pcantidadEnemigos:Number, ptipoEnemigos:Number, ptipoMovimientoEnemigos:Number,
										pintervaloEntreEnemigos:Number) 
		{
			super();
			setListaEnemigos(new FlxGroup);
			setCantidadEnemigos(pcantidadEnemigos);
			setOleadaTerminada(false);
			setIntervaloEntreEnemigos(pintervaloEntreEnemigos);
			setPosX(px);
			setPosY(py);
			setTipoEnemigos(ptipoEnemigos);
			setTipoMovimientoEnemigos(ptipoMovimientoEnemigos);
			reiniciarContador();
		}
		
		public function getListaEnemigos():FlxGroup 
		{
			return listaEnemigos;
		}
		
		public function setListaEnemigos(value:FlxGroup):void 
		{
			listaEnemigos = value;
		}
		
		public function getOleadaTerminada():Boolean 
		{
			return oleadaTerminada;
		}
		
		public function setOleadaTerminada(value:Boolean):void 
		{
			oleadaTerminada = value;
		}
		
		public function getCantidadEnemigos():Number 
		{
			return cantidadEnemigos;
		}
		
		public function setCantidadEnemigos(value:Number):void 
		{
			cantidadEnemigos = value;
		}
		
		public function getIntervaloEntreEnemigos():Number
		{
			return intervaloEntreEnemigos;
		}
		
		public function setIntervaloEntreEnemigos(value:Number):void 
		{
			intervaloEntreEnemigos = value;
		}
		
		public function getPosX():Number 
		{
			return posX;
		}
		
		public function setPosX(value:Number):void 
		{
			posX = value;
		}
		
		public function getPosY():Number 
		{
			return posY;
		}
		
		public function setPosY(value:Number):void 
		{
			posY = value;
		}
		
		public function getTipoEnemigos():Number 
		{
			return tipoEnemigos;
		}
		
		public function setTipoEnemigos(value:Number):void 
		{
			tipoEnemigos = value;
		}
		
		public function getTipoMovimientoEnemigos():Number 
		{
			return tipoMovimientoEnemigos;
		}
		
		public function setTipoMovimientoEnemigos(value:Number):void 
		{
			tipoMovimientoEnemigos = value;
		}
		
		private function aparecerEnemigo(px:Number, py:Number, ptipoEnemigo:Number, ptipoMovimiento:Number):void
		{
			var enemigoNuevo:IEnemigo = FabricaEnemigos.fabricarEnemigo(ptipoEnemigo, px, py, ptipoMovimiento);
			listaEnemigos.add(enemigoNuevo.devolverObj());
		}

		
		private function reiniciarContador():void
		{
			contadorTiempo = intervaloEntreEnemigos;
		}
		
		override public function update():void
		{

			contadorTiempo -= FlxG.elapsed;
			
			if (contadorTiempo < 0)
			{
				if (cantidadEnemigos > 0)
				{
					aparecerEnemigo(posX, posY, tipoEnemigos, tipoMovimientoEnemigos);
					reiniciarContador();
					cantidadEnemigos--;
				} else {
					setOleadaTerminada(true);
				}
			}
			super.update();
		}
		
		public function devolverObj():FlxGroup
		{
			var obj:FlxGroup = new FlxGroup();
			obj.add(this);
			obj.add(listaEnemigos);
			return obj;
		}
			
	}
}
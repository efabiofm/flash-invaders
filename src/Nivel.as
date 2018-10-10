package 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class Nivel extends FlxGroup
	{
		[Embed(source = "sounds/jefe_aparece.mp3")]
		private var sonidoApareceJefe:Class;
		private var cantidadEnemigos:Number = 5;
		private var cantidadOleadas:Number = 2
		private var listaOleadas:FlxGroup;
		private var listaEnemigos:FlxGroup;
		private var intervaloEntreOleadas:Number = 7;
		private var intervaloEntreEnemigos:Number = 2;
		private var dificultadNivel:Number = 1;
		private var contadorTiempoEnemigo:Number;
		private var contadorTiempoOleadas:Number;
		private var contadorTiempoItems:Timer;
		private var itemsEnPantalla:FlxGroup;
		private var obstaculosEnPantalla:FlxGroup;
		private var grupoParaJefe:FlxGroup;
		private var contadorTiempoObstaculos:Timer;
		private var tiempoAntesDeJefe:Timer;
		private var terminanEnemigos:Boolean = false;
		private var terminanOleadas:Boolean = false;
		private var tieneJefe:Boolean = false;
		private var jefeSalio:Boolean = false;
		private var nivelTerminado:Boolean = false;
		private var heroeVivo:Boolean = true;
		private var jefe:Jefe = null;
		private var _heroe:Heroe = FIHeroe.getInstance();
		
		public function Nivel(pdificultad:Number) 
		{
			setCantidadEnemigos(cantidadEnemigos * Math.ceil(pdificultad/2));
			setCantidadOleadas(cantidadOleadas * Math.ceil(pdificultad/2));
			setListaOleadas(new FlxGroup());
			setListaEnemigos(new FlxGroup());
			itemsEnPantalla = new FlxGroup();
			grupoParaJefe = new FlxGroup();
			setIntervaloEntreOleadas(intervaloEntreOleadas * (1 - (0.10 * pdificultad)));
			setIntervaloEntreEnemigos(intervaloEntreEnemigos * (1 - (0.02 * pdificultad)));
			setDificultadNivel(pdificultad);
			reiniciarContadorOleadas();
			reiniciarContadorEnemigos();
			
			itemsEnPantalla = new FlxGroup();
			contadorTiempoItems = new Timer(10000*getDificultadNivel()); //TODO: ponerlo en 20000
			contadorTiempoItems.addEventListener(TimerEvent.TIMER, generarItem);
			contadorTiempoItems.start(); //se detiene con stop()
			/*Obstaculos en pantalla*/
			
			obstaculosEnPantalla = new FlxGroup();
			contadorTiempoObstaculos = new Timer(10000/getDificultadNivel()); //TODO: ponerlo en 20000
			contadorTiempoObstaculos.addEventListener(TimerEvent.TIMER, generarObstaculo);
			contadorTiempoObstaculos.start(); //se detiene con stop()
			
			if (getDificultadNivel() % 2 == 0)
			{
				tieneJefe = true;
				jefe = new FIJefe(246, -129);
			}
			
		}
		
		private function getHeroeVivo():void{
			if (_heroe.getVida() < 1){
				heroeVivo = false;
				contadorTiempoItems.stop();
				contadorTiempoObstaculos.stop();
				contadorTiempoItems.removeEventListener(TimerEvent.TIMER, generarItem);
				contadorTiempoObstaculos.removeEventListener(TimerEvent.TIMER, generarObstaculo);
			}
		}
		
		
		
		private function destruirHeroe(pbalasJefe:FlxSprite, pheroe:FIHeroe):void{
			pheroe.reducirVida((pbalasJefe as BalaEnemiga).getDanho());
			pbalasJefe.kill();
			
		}
		public function returnEstadoHeroe():Boolean{
			return heroeVivo;
		}

		private function aparecerEnemigo():void
		{
			var enemigoActual:Number=tipoEnemigoNuevoAleatorio();
			var posX:Number = numAleatorioEntreRangos(50, 590);
			var enemigoNuevo:Enemigo = FabricaEnemigos.fabricarEnemigo(tipoEnemigoNuevoAleatorio(), posX, 0, 1);
			listaEnemigos.add(enemigoNuevo.devolverObj());
		}
		
		private function aparecerOleada():void
		{
			var posX:Number = numAleatorioEntreRangos(150, 451);
			var cantidadEnemigosOleadaNueva:Number = numAleatorioEntreRangos((5 * (0.5 * getDificultadNivel())), (6 * (0.5 * getDificultadNivel())));
			var	tipoEnemigoOleadaNueva:Number = numAleatorioEntreRangos(1, 2);
			var oleadaNueva:OleadaEnemiga = new OleadaEnemiga(posX, 0, cantidadEnemigosOleadaNueva, tipoEnemigoOleadaNueva, 2, 0.5) 
			listaOleadas.add(oleadaNueva.devolverObj());
		}
		
		private function aparecerJefe():void
		{
			FlxG.play(sonidoApareceJefe);
			grupoParaJefe.add(jefe.devolverObj());
		}
		
		private function reiniciarContadorOleadas():void
		{
			contadorTiempoOleadas = intervaloEntreOleadas;
		}
		
		private function reiniciarContadorEnemigos():void
		{
			contadorTiempoEnemigo = intervaloEntreEnemigos;
		}
		
		public function numAleatorioEntreRangos(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public function tipoEnemigoNuevoAleatorio():Number
		{
			var	rollTipoEnemigoNuevo:Number = numAleatorioEntreRangos(1, 100);
			var tipoEnemigoNuevo:Number = 0;
			if (rollTipoEnemigoNuevo > 40)
			{
				tipoEnemigoNuevo = 1;
			} 
			else if (rollTipoEnemigoNuevo <= 40 && rollTipoEnemigoNuevo > 70)
			{
				tipoEnemigoNuevo = 2;
			}
			else if (rollTipoEnemigoNuevo <= 70)
			{
				tipoEnemigoNuevo = 3;
			}
			return tipoEnemigoNuevo;
		}
		
		private function generarItem(event:TimerEvent):void{
			var ejeXAleatorio:Number = numAleatorioEntreRangos(0, 620);
			var tipoAleatorio:Number = numAleatorioEntreRangos(1, 3);
			var itemNuevo:FIFItem = FabricaItems.fabricarItem(tipoAleatorio, ejeXAleatorio, 0);
			if (heroeVivo){
				
				itemsEnPantalla.add(itemNuevo);
			}
		}
		
		private function quitarItem(pitem:FIFItem, pheroe:FIHeroe):void{
			pitem.activarEfecto();
			pitem.kill();
		}
		 
		private function generarObstaculo(event:TimerEvent):void{
			var ejeXAleatorio:Number = numAleatorioEntreRangos(0, 620);
			var tipoAleatorio:Number = numAleatorioEntreRangos(1, 3);
			
			var obstaculo:Obstaculo;

			obstaculo = new Asteroide(ejeXAleatorio, 0);
			
			if(heroeVivo){
				obstaculosEnPantalla.add(obstaculo);
			}
		}
			
		private function quitarObstaculo(pobstaculo:Obstaculo, pheroe:FIHeroe):void{
			pheroe.play("explotar");
			pobstaculo.play("explotar");
		}
		
		private function destruirObstaculos(pobstaculo:Obstaculo,pbalasHereos:FlxSprite):void{
			pobstaculo.play("explotar");
			pbalasHereos.kill();
		}
		
		private function destruirObstaculoConBomba(pobstaculo:Obstaculo, pbombaHeroe:Bomba):void{
			pbombaHeroe.explotar();
			pobstaculo.play("explotar");
		}
		
		override public function update():void
		{
			getHeroeVivo();
			
			contadorTiempoOleadas -= FlxG.elapsed;
			contadorTiempoEnemigo -= FlxG.elapsed;
			
			if (contadorTiempoOleadas < 0 && terminanOleadas == false)
			{
				if (listaOleadas.length < cantidadOleadas)
				{
					aparecerOleada();
					reiniciarContadorOleadas();
				}
				else
				{
					terminanOleadas = true;
				}
			}
			
			if (contadorTiempoEnemigo < 0 && terminanEnemigos == false)
			{
				if (listaEnemigos.length < cantidadEnemigos)
				{
					aparecerEnemigo();
					reiniciarContadorEnemigos();
				}
				else
				{
					terminanEnemigos = true;
				}
			}
			
			
			if (terminanEnemigos && terminanOleadas && tieneJefe && jefeSalio != true)
			{
				aparecerJefe();
				jefeSalio = true;
			}
			
			if ((tieneJefe && jefe.getVida() < 1) || tieneJefe == false && terminanEnemigos && terminanOleadas)
			{
				nivelTerminado = true;
			}
			
			FlxG.collide(obstaculosEnPantalla, _heroe.getGrupoBalasHeroe(), destruirObstaculos);
			FlxG.collide(itemsEnPantalla, _heroe, quitarItem);
			FlxG.collide(obstaculosEnPantalla, _heroe, quitarObstaculo);
			
			if (tieneJefe){
				FlxG.collide(jefe.getBalasJefe(), _heroe, destruirHeroe);
			}
			FlxG.collide(obstaculosEnPantalla, _heroe.getBombas(), destruirObstaculoConBomba);
			super.update();
		}
		
		public function devolverObj():FlxGroup
		{
			var obj:FlxGroup = new FlxGroup();
			obj.add(this);
			obj.add(listaOleadas);
			obj.add(listaEnemigos);
			obj.add(itemsEnPantalla);
			obj.add(obstaculosEnPantalla);
			obj.add(grupoParaJefe);
			return obj;
		}
		
		
		public function getCantidadEnemigos():Number 
		{
			return cantidadEnemigos;
		}
		
		public function setCantidadEnemigos(value:Number):void 
		{
			cantidadEnemigos = value;
		}
		
		public function getCantidadOleadas():Number 
		{
			return cantidadOleadas;
		}
		
		public function setCantidadOleadas(value:Number):void 
		{
			cantidadOleadas = value;
		}
		
		public function getListaOleadas():FlxGroup 
		{
			return listaOleadas;
		}
		
		public function setListaOleadas(value:FlxGroup):void 
		{
			listaOleadas = value;
		}
		
		public function getListaEnemigos():FlxGroup 
		{
			return listaEnemigos;
		}
		
		public function setListaEnemigos(value:FlxGroup):void 
		{
			listaEnemigos = value;
		}
		
		public function getIntervaloEntreOleadas():Number 
		{
			return intervaloEntreOleadas;
		}
		
		public function setIntervaloEntreOleadas(value:Number):void 
		{
			intervaloEntreOleadas = value;
		}
		
		public function getIntervaloEntreEnemigos():Number 
		{
			return intervaloEntreEnemigos;
		}
		
		public function setIntervaloEntreEnemigos(value:Number):void 
		{
			intervaloEntreEnemigos = value;
		}
		
		public function getDificultadNivel():Number 
		{
			return dificultadNivel;
		}
		
		public function setDificultadNivel(value:Number):void 
		{
			dificultadNivel = value;
		}
		
		public function getNivelTerminado():Boolean
		{
			return nivelTerminado;
		}
	}

}

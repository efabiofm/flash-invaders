package 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author Rodrigo
	 */
	public class Enemigo extends Personaje implements IEnemigo
	{
		private var danho:Number;
		private var intervaloDisparos:Number = 1;
		private var balasEnemigas:FlxGroup;
		private var contadorTiempo:Number;
		private var posibilidadDisparo:Number = 1;
		private var patronMovimiento:IMovimientoEnemigo;
		private var heroe:Heroe = FIHeroe.getInstance();
		
		//CLASE ABSTRACTA, DEBE SER HEREDADA Y NO INSTANCIADA
		public function Enemigo(px:Number, py:Number, pvida:Number, pdanho:Number, pPNG:Class, ptipoMovimiento:Number)
		{
			super(px, py, pvida)
			loadGraphic(pPNG, true, false);
			this.setDanho(pdanho);
			
			setBalasEnemigas(new FlxGroup());
			reiniciarContador();
			
			addAnimation("explotar", [1, 2, 3], 15, false); //se activa enemigo.play("explotar");
			addAnimationCallback(onExplotionAnimation);
			
			patronMovimiento = FabricaMovimientosEnemigos.fabricarEstrategiaMovimiento(ptipoMovimiento);
		}
		
		public function getDanho():Number 
		{
			return danho;
		}
		
		public function setDanho(value:Number):void 
		{
			danho = value;
		}
		
		public function getBalasEnemigas():FlxGroup 
		{
			return balasEnemigas;
		}
		
		public function setBalasEnemigas(value:FlxGroup):void 
		{
			balasEnemigas = value;
		}
		
		private function disparar(p:FlxPoint):void
		{
			var balaEnemiga:BalaEnemiga = new BalaEnemiga(p.x, p.y, this.getDanho());
			balasEnemigas.add(balaEnemiga);
		}
		
		private function getPosicionDelCanhon():FlxPoint
		{
			var p: FlxPoint = new FlxPoint(x + ((this.width/2)-1), y + (this.height/2));
			return p;
		}
		
		private function reiniciarContador():void
		{
			contadorTiempo = intervaloDisparos;
		}
		
		private function destruirHeroe(pbalasEnemigas:FlxSprite, pheroe:FIHeroe):void{
			pheroe.reducirVida( (pbalasEnemigas as BalaEnemiga).getDanho() );
			pbalasEnemigas.kill();
		}
		
		private function destruirEnemigo():void{
			setVelocidad(0);
			this.play("explotar");
		}
		
		private function destruirAmbos(penemigo:Enemigo, pheroe:FIHeroe):void{
			penemigo.play("explotar");
			pheroe.play("explotar");
		}
		

		private function destruirEnemigoConBomba(penemigo:Enemigo, pbomba:Bomba):void{
			penemigo.play("explotar");
			pbomba.explotar();
		}
		
		private function destruirBalas(pbalasEnemigas:FlxSprite, pbalasHeroe:FlxSprite):void{
			pbalasEnemigas.kill();
			pbalasHeroe.kill();
		}
		
		private function recibirDanho(penemigo:Enemigo, pbalasHeroe:FlxSprite):void
		{
			if (this.getVida() <= ((pbalasHeroe as BalaHeroe).getDano()))
			{
				pbalasHeroe.kill();
				destruirEnemigo();
			} 
			else 
			{
				pbalasHeroe.kill();
				this.setVida(this.getVida() - (pbalasHeroe as BalaHeroe).getDano());
			}
		}
		
		private function onExplotionAnimation($animationName:String, $frameNumber:uint, $frameIndex:uint):void{
			if ($frameIndex == 3){
				heroe.setPuntos(this.getDanho());
				this.getBalasEnemigas().kill();
				this.kill();
			}
		}
		
		override public function update():void
		{
			contadorTiempo -= FlxG.elapsed;
			
			if(contadorTiempo < 0)
			{
				var rollPosibilidadDisparo:Number = Math.ceil(Math.random() * 200);
				if (rollPosibilidadDisparo <= posibilidadDisparo)
				{
					disparar(getPosicionDelCanhon());
					reiniciarContador();
				}
			}
			
			velocity.y = getVelocidad();
			velocity.x = patronMovimiento.mover(this.y);
			
			FlxG.collide(this, heroe.getGrupoBalasHeroe(), recibirDanho);
			FlxG.collide(this, heroe, destruirAmbos);

			FlxG.collide(this.getBalasEnemigas(), heroe, destruirHeroe);
			FlxG.collide(this.getBalasEnemigas(), heroe.getGrupoBalasHeroe(), destruirBalas);
			FlxG.collide(this, heroe.getBombas(), destruirEnemigoConBomba);
			
			if (this.getScreenXY().y >= FlxG.height){
				this.kill();
			}
			super.update();
		}
		
		public function devolverObj():FlxGroup
		{
			var obj:FlxGroup = new FlxGroup();
			obj.add(this);
			obj.add(balasEnemigas);
			return obj;
		}
	}

}

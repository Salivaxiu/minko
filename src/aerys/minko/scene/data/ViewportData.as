package aerys.minko.scene.data
{
	import aerys.minko.render.RenderTarget;
	import aerys.minko.render.Viewport;
	import aerys.minko.render.effect.IEffect;
	
	import flash.display.Stage;
	import flash.utils.Dictionary;

	public class ViewportData implements IWorldData
	{
		public static const RATIO 				: String = 'ratio';
		public static const WIDTH				: String = 'width';
		public static const HEIGHT				: String = 'height';
		public static const ANTIALIASING		: String = 'antialiasing';
		public static const BACKGROUND_COLOR	: String = 'backgroundColor';
		
		protected var _viewport					: Viewport;
		protected var _renderTarget				: RenderTarget;
		protected var _backbufferRenderTarger	: RenderTarget;
		
		public function get ratio() : Number
		{
			return _viewport.width / _viewport.height;
		}
		
		public function get width() : int
		{
			return _viewport.width;
		}
		
		public function get height() : int
		{
			return _viewport.height;
		}
		
		public function get antiAliasing() : int
		{
			return _viewport.antiAliasing;
		}
		
		public function get backgroundColor() : uint
		{
			return _viewport.backgroundColor;
		}
		
		public function get defaultEffect() : IEffect
		{
			return _viewport.defaultEffect;
		}
		
		public function get renderTarget() : RenderTarget
		{
			var viewportHasPostProcess : Boolean = _viewport.postProcessEffect != null;
			if (!viewportHasPostProcess)
				return backBufferRenderTarget;
			
			var viewportWidth			: int	= _viewport.width;
			var viewportHeight			: int	= _viewport.height;
			var viewportAntialias		: int	= _viewport.antiAliasing;
			var viewportBgColor			: int	= _viewport.backgroundColor;
			var size					: uint	= 1 << Math.ceil(Math.log(Math.max(viewportWidth, viewportHeight)) * Math.LOG2E);
			
			if (_renderTarget == null 
				|| size					!= _renderTarget.width
				|| size					!= _renderTarget.height
				|| viewportAntialias	!= _renderTarget.antiAliasing
				|| viewportBgColor		!= _renderTarget.backgroundColor)
			{
				_renderTarget = new RenderTarget(RenderTarget.TEXTURE, size, size, viewportBgColor, true, viewportAntialias);
			}
			
			return _renderTarget;
		}
		
		public function get backBufferRenderTarget() : RenderTarget
		{
			var viewportWidth			: int		= _viewport.width;
			var viewportHeight			: int		= _viewport.height;
			var viewportAntialias		: int		= _viewport.antiAliasing;
			var viewportBgColor			: int		= _viewport.backgroundColor;
			
			if (_backbufferRenderTarger == null 
				|| viewportWidth		!= _backbufferRenderTarger.width
				|| viewportHeight		!= _backbufferRenderTarger.height
				|| viewportAntialias	!= _backbufferRenderTarger.antiAliasing
				|| viewportBgColor		!= _backbufferRenderTarger.backgroundColor)
			{
				_backbufferRenderTarger = new RenderTarget(
					RenderTarget.BACKBUFFER, 
					viewportWidth, viewportHeight,
					viewportBgColor, true, viewportAntialias);
			}
			
			return _backbufferRenderTarger;
		}
		
		public function get stage() : Stage
		{
			return _viewport.stage;
		}
		
		public function get viewport() : Viewport
		{
			return _viewport;
		}
		
		public function ViewportData(viewport : Viewport)
		{
			_viewport = viewport;
		}
		
		public function setDataProvider(styleStack	: StyleStack, 
										localData	: LocalData,
										worldData	: Dictionary) : void
		{
		}
		
		public function invalidate() : void
		{
		}
		
		public function reset() : void
		{
		}
	}
}
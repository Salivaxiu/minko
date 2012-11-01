package aerys.minko.scene.node.light
{
	import aerys.minko.ns.minko_scene;
	import aerys.minko.scene.controller.light.LightController;
	import aerys.minko.scene.node.AbstractSceneNode;
	import aerys.minko.scene.node.ISceneNode;
	import aerys.minko.type.enum.ShadowMappingType;

	use namespace minko_scene;
	
	public class AmbientLight extends AbstractLight
	{
		public static const LIGHT_TYPE : uint = 0;
		
		public function get ambient() : Number
		{
			return lightData.getLightProperty('ambient') as Number;
		}
		public function set ambient(v : Number)	: void
		{
			lightData.setLightProperty('ambient', v);
		}
		
		override public function set shadowCastingType(v : uint) : void
		{
			if (v != ShadowMappingType.NONE)
				throw new Error('An ambient light cannot emit shadows.');
		}
		
		public function AmbientLight(color			: uint		= 0xFFFFFFFF, 
									 ambient		: Number	= .4,
									 emissionMask	: uint		= 0x1)
		{
			super(
				new LightController(AmbientLight),
				LIGHT_TYPE,
				color,
				emissionMask,
				ShadowMappingType.NONE
			);
			
			this.ambient = ambient;
		}
		
		override minko_scene function cloneNode() : AbstractSceneNode
		{
			var light : AmbientLight = new AmbientLight(color, ambient, emissionMask);
			
			light.name = this.name;
			light.transform.copyFrom(this.transform);
			
			return light;
		}
	}
}

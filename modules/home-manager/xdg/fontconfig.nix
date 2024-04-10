{ config, ... }:
{
	xdg.configFile."fontconfig/fonts.conf" = {
		enable = config.fonts.fontconfig.enable;

		text = ''
<?xml version='1.0'?>
<!DOCTYPE fontconfig SYSTEM 'urn:fontconfig:fonts.dtd'>
<fontconfig>
	<alias>
		<family>serif</family>
		<prefer>
			<family>${config.gtk.font.name}</family>
		</prefer>
	</alias>
	<alias>
		<family>sans-serif</family>
		<prefer>
			<family>${config.gtk.font.name}</family>
		</prefer>
	</alias>
	<alias>
		<family>sans</family>
		<prefer>
			<family>${config.gtk.font.name}</family>
		</prefer>
	</alias>
	<alias>
		<family>monospace</family>
		<prefer>
			<family>${config.gtk.font.name}</family>
		</prefer>
	</alias>
</fontconfig>
		'';
	};
}

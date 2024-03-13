{ ... }:
{
	services.pipewire = {
		audio.enable = true;
		socketActivation = true;
		wireplumber.enable = true;
		pulse.enable = true;

		alsa = {
			enable = true;
			support32Bit = true;
		};
	};
}

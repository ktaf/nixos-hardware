{ lib, ... }: {
  imports = [
    ../../../common/cpu/intel
    ../../../common/pc/laptop
    ../../../common/pc/laptop/ssd
  ];

  # Change ACPI state from S0 to S3
  # https://www.kernel.org/doc/Documentation/power/states.txt
  boot.kernelParams = [ "mem_sleep_default=deep" ];

  # Allows for updating firmware via `fwupdmgr`.
  services.fwupd.enable = lib.mkDefault true;

  # This will save you money and possibly your life!
  services.thermald.enable = lib.mkDefault true;

  # WiFi speed is slow and crashes by default (https://bugzilla.kernel.org/show_bug.cgi?id=213381)
  # Tuning based on iwlwifi reference(https://wiki.archlinux.org/title/Network_configuration/Wireless#iwlwifi)
  boot.extraModprobeConfig = ''
    options iwlwifi 11n_disable=8
  '';
}

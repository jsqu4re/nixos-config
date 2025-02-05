{ ... }:
{
  networking.networkmanager.enable = true;

  networking.defaultGateway = "192.168.1.1";
  networking.nameservers = [ "192.168.1.145" ];

  services.openssh.enable = true;

  networking.firewall.enable = true;
}

{ config, pkgs, ... }:

{
  # Importa el módulo oficial para crear máquinas virtuales QEMU
  imports = [
    <nixpkgs/nixos/modules/virtualisation/qemu-vm.nix>
  ];

  # Usa la versión correcta (válida hoy)
  system.stateVersion = "24.05";

  # Configuración de la VM
  virtualisation = {
    memorySize = 4096;  # 4 GB RAM
    cores = 4;
    graphics = true;    # modo gráfico (virtio-gpu)
  };

  # Usuario simple para entrar
  users.users.neo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];  # sudo
    initialPassword = "1234";
  };

  # Paquetes para probar tu portabilidad
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    eza
  ];

  # Permitir sudo sin contraseña (opcional)
  security.sudo.wheelNeedsPassword = false;
}
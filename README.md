# nixpie-dotfiles

packages used:

- alacritty (terminal emulator)
- i3
- i3gaps
- i3blocks

### Build 23.05 : Budgie Desktop Environment generation

![image](https://github.com/chococandy63/nixpie-dotfiles/assets/79960426/162861bd-9384-47e7-8a22-fb9456c46002)

### Build 23.05 : i3wm generation

![WhatsApp Image 2023-10-11 at 13 23 37](https://github.com/chococandy63/nixpie-dotfiles/assets/79960426/06ffc2e3-446b-469a-a91d-b7ef16b177d8)


### Set Up NixOS

 Autostart Virsh- `sudo virsh net-autostart default` : To enable libvirtd instances 

 Check- `sudo virsh net-list --all`

If facing libvirtd booting issues, this might help -> [solved-qemu-network-default-booting-from-harddisk-issue](https://forum.level1techs.com/t/solved-qemu-network-default-is-not-active-booting-from-hard-disk/194698)


To see which NixOS channel you’re subscribed to, run the following as root:

`nix-channel --list | grep nixos`

To switch to a different NixOS channel, do

`nix-channel --add https://nixos.org/channels/*channel-name* nixos`

To Upgrade NixOS to the latest version in your chosen channel by running

`sudo nixos-rebuild switch --upgrade`

Automatic Upgrades- You can keep a NixOS system up-to-date automatically by adding the following to configuration.nix:

```system.autoUpgrade.enable  = true;```

```system.autoUpgrade.allowReboot  = true;```



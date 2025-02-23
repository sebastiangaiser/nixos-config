# nixos-config

## Commands

Rebuild: `sudo nixos-rebuild switch --flake ~/nixos-config#dell-xps13`

## Setup from scratch

This section describes how to bootrap the new hardware from scratch after installing the OS.

1. Setup an short-term ssh-key with passphrase

```shell
ssh-keygen -t ed25519
```

- Upload the key to Github

2. Clone the config 

```shell
git clone git@github.com:sebastiangaiser/nixos-config.git ~/nixos-config
```

3. Rebuild the configuration using the rebuild command

4. Remove the short-term ssh-key from Github


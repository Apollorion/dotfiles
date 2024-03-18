# Joeys Dotfiles

## Installation

1. Install Homebrew - brew.sh
2. Install Yadm `brew install yadm`
3. Using yadm, clone this repo `yadm clone https://github.com/Apollorion/dotfiles.git`
4. Install GPG keys off your yubikey `gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xFAFA8E62C123F240`
5. Add your public key off your yubikey for SSH (make sure yubikey is plugged in) `ssh-add -L > ~/.ssh/id_rsa_yubikey.pub`
6. If not asked, run bootstrap `yadm bootstrap`


## Updating GPG Keys after expiration
See [updating_keys.md](keys/updating_keys.md) in the keys directory.


## Notes

If you have trouble with SSH/GPG, try the following:
- run `gpgfix` this will run a command that will force your yubikey to, basically, restart
- run `gpg --card-status` not sure why but this fixes problems sometimes

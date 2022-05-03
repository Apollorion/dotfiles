# Joeys Dotfiles

## Installation

1. Install Homebrew - brew.sh
2. Install Yadm `brew install yadm`
3. Using yadm, clone this repo `yadm clone https://github.com/Apollorion/dotfiles.git`
4. Install GPG keys off your yubikey `gpg2 --keyserver pgp.mit.edu --recv-keys 0x480EA7B1693D16B8` (note: you may need to substitue pgp.mit.edu with the ip of the server `nslookup pgp.mit.edu`)
5. Unencrypt encrypted files `yadm decrypt`
6. If not asked, run bootstrap `yadm bootstrap`


## Notes

If you have trouble with SSH/GPG, try the following:
- run `gpgfix` this will run a command that will force your yubikey to, basically, restart
- run `gpg --card-status` not sure why but this fixes problems sometimes

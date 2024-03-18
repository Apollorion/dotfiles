## Updating GPG Keys

I used this guide (note use this linked version, the newer version is confusing):
https://github.com/drduh/YubiKey-Guide/tree/0bccb363c205baa519e6f5a042060368afe67c14


1. Disconnect from internet
2. Insert your USB with gpg stuff in it (you know which one)
3. copy the NEW directory to desktop 
  - `mkdir ~/Desktop/NEW`
  - `cp -avi /Volumes/IMPORTANT/GPG/NEW/* ~/Desktop/NEW/.`
4. Set GNUPGHOME to the desktop NEW directory
  - `cd ~/Desktop/NEW`
  - `export GNUPGHOME=$(PWD)`
5. export private key id as KEYID:
  - `export KEYID="0xFAFA8E62C123F240"` (this never changes)
6. Edit the gpg key
  - `gpg --edit-key $KEYID`
7. Select all the subkeys by typing:
  - `key 1 [enter]`
  - `key 2 [enter]`
  - `key 3 [enter]`

example step 7:
```
$ gpg --edit-key $KEYID

Secret key is available.

sec  rsa4096/0xFF3E7D88647EBCDB
    created: 2017-10-09  expires: never       usage: C
    trust: ultimate      validity: ultimate
ssb  rsa4096/0xBECFA3C1AE191D15
    created: 2017-10-09  expires: 2018-10-09  usage: S
ssb  rsa4096/0x5912A795E90DD2CF
    created: 2017-10-09  expires: 2018-10-09  usage: E
ssb  rsa4096/0x3F29127E79649A3D
    created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>

gpg> key 1

Secret key is available.

sec  rsa4096/0xFF3E7D88647EBCDB
     created: 2017-10-09  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb* rsa4096/0xBECFA3C1AE191D15
     created: 2017-10-09  expires: 2018-10-09  usage: S
ssb  rsa4096/0x5912A795E90DD2CF
     created: 2017-10-09  expires: 2018-10-09  usage: E
ssb  rsa4096/0x3F29127E79649A3D
     created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>

gpg> key 2

Secret key is available.

sec  rsa4096/0xFF3E7D88647EBCDB
     created: 2017-10-09  expires: never       usage: C
     trust: ultimate      validity: ultimate
ssb* rsa4096/0xBECFA3C1AE191D15
     created: 2017-10-09  expires: 2018-10-09  usage: S
ssb* rsa4096/0x5912A795E90DD2CF
     created: 2017-10-09  expires: 2018-10-09  usage: E
ssb  rsa4096/0x3F29127E79649A3D
     created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>

gpg> key 3

Secret key is available.

sec   rsa4096/0xFF3E7D88647EBCDB
      created: 2017-10-09  expires: never       usage: C
      trust: ultimate      validity: ultimate
ssb*  rsa4096/0xBECFA3C1AE191D15
      created: 2017-10-09  expires: 2018-10-09  usage: S
ssb*  rsa4096/0x5912A795E90DD2CF
      created: 2017-10-09  expires: 2018-10-09  usage: E
ssb*  rsa4096/0x3F29127E79649A3D
      created: 2017-10-09  expires: 2018-10-09  usage: A
[ultimate] (1). Dr Duh <doc@duh.to>
```

9. Then, use the `expire` command to set a new expiration date. (Despite the name, this will not cause currently valid keys to become expired.)

```
gpg> expire
Changing expiration time for a subkey.
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0)
```

8. `save` to save your changes.
  - `save [enter]`
9. Export the public key
  - `gpg --armor --export $KEYID > ~/keys/gpg-$KEYID-$(date +%F).asc`
10. Copy the desktop `NEW` back to the USB (accept all overwrites)
  - `cp -avi ~/Desktop/NEW/* /Volumes/IMPORTANT/GPG/NEW/.`
11. Unmount the USB, connect to the internet, restart your shell
12. Import the new gpg key, send it to a keyserver
  - `gpg --import ~/keys/{path to key}.asc`
  - `gpg --keyserver hkp://keyserver.ubuntu.com:80 --send-keys 0xFAFA8E62C123F240`


tada, keys are all updated! Make sure you add it to yadm and push to dotfiles!
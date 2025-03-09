default_filename=id_test
default_crypto_keytype=ed25519
ssh_opts="-o PubkeyAuthentication=no"
target_user=${USER}
ssh_keygen=$(type ssh-keygen) ; ssh_keygen=${ssh_keygen##* }
ssh_copy_id=$(type ssh-copy-id) ; ssh_copy_id=${ssh_copy_id##* }
ssh=$(type ssh) ; ssh=${ssh##* }

cargo install-update -a && {
    cargo install --list |
    grep : |
    cut -d ' ' -f '1' > ~/.cargo/cargopkgslist.txt ;
}

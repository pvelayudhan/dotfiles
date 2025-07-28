# Source all files in ~/.bashrc.d
if [ -d "$HOME/.bashrc.d" ]; then
    for file in "$HOME/.bashrc.d"/*; do
        [ -r "$file" ] && source "$file"
    done
    unset file
fi

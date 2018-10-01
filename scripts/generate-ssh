if [[ $# -eq 2 ]] ; then
    mkdir -p ~/.ssh/
    ssh-keygen -t rsa -b 4096 -C "$1" -f $2
    mv ./$2 ~/.ssh/
    mv ./$2.pub ~/.ssh/
    eval "$(ssh-agent -s; ssh-add -K ~/.ssh/$2)"
    pbcopy < ~/.ssh/$2.pub
    echo "Go to https://github.com/settings/keys to enable your new passphrase"
else
    echo "Please provide your email and a key name as arguments: \`./generate-ssh.sh <email> <keyname>\`"
fi
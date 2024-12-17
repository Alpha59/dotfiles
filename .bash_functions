#!/bin/bash
activate-tab (){
    find-tab "$@" | xargs -n1 chrome-cli activate -t
}

declare -fx activate-tab
announce ()
{
    say "$@";
    notify "$@";
    cowsay "$@"
}
declare -fx announce
autopep ()
{
    autopep8 -i -r -a -a "$@"
}
declare -fx autopep
bats-build ()
{
    package=${PWD##*/};
    brazil-build;
    bats transform -x DockerImage-1.0 -t "$package-1.0" -p "$package-1.0"
}
declare -fx bats-build
bb ()
{
    brazil-build "$@"
}
declare -fx bb
bc ()
{
    command bc -l "$@"
}
declare -fx bc
black ()
{
    command black ./ --extend-exclude "(requirements.py|aws_lambda)" --line-length=100;
    flake8 ./ --exclude requirements.py,aws_lambda --ignore I003,I001 "$@"
}
declare -fx black
pretty-typescript ()
{
    npx prettier --write "**/*.{ts,tsx}" --tab-width 4 --print-width 120 --quote-props consistent --trailing-comma none "$@"
}
declare -fx pretty-typescript
brazil-version-set-list ()
{
    brazil ws show | grep "Version" | awk '{print $3}' | xargs -n1 bash -c 'echo "${0//@[0-9]*/}"'
}
declare -fx brazil-version-set-list
build-wait ()
{
    notify "Starting to monitor $1";
    brazil pb view --waitForCompletion --request "$1" && notify "Build $1 has Succeeded" || notify "Build $1 has failed"
}
declare -fx build-wait
cat ()
{
    ccat "$@"
}
declare -fx cat
cat-script ()
{
    if [[ -f $(which "$1") ]]; then
        ccat "$(which "$1")";
    else
        type "$1" | ccat;
    fi
}
declare -fx cat-script
cdd2 ()
{
    cloud-desktop start -p 8888 -m "~/Work/$(PWD | awk '{print $5}' FS='/'):/home/ailor/$(PWD | awk '{print $5}' FS='/')" -u "$@"
}
declare -fx cdd2
cdk-delete-all ()
{
    /Users/ailor/.scripts/cdk-doctor/env/CDKPipelineDoctor-1.0-CDKPipelineDoctor-development/bin/darwin_amd64/cdk-pipeline-doctor cleanup-pipeline "$@"
}
declare -fx cdk-delete-all
charAt ()
{
    local char="${1}";
    declare -i charPosition=${2};
    if [[ -z "${char}" ]]; then
        printf "%s\n" "Usage: ${FUNCNAME} string (position to extract string)";
        return $false;
    fi;
    {
        [[ ${charPosition} -eq 0 ]] && printf "%c\n" "${char}" && return $true
    } || {
        [[ ${charPosition} -gt ${#char} ]] && printf "%s\n" "" && return $true
    };
    ( local temp=${char};
    local cutFirstString;
    declare -i i=0;
    while [[ -n "${temp}" ]]; do
        : $((i++));
        cutFirstString=$(printf "%c" "${temp}");
        temp="${temp#*"$cutFirstString"}";
        (( i == charPosition )) && printf "%s\n" "${cutFirstString}";
    done )
}
declare -fx charAt
checkstyle ()
{
    java -jar ~/Downloads/checkstyle-8.18-all.jar -c checkstyle-config.xml "$@"
}
declare -fx checkstyle
clean-ws ()
{
    cd ..;
    git all clean -dfx
}
declare -fx clean-ws
clear ()
{
    command clear;
    command clear;
    command clear;
    command clear;
    command clear;
    command clear;
    command clear;
    command clear "$@"
}
declare -fx clear
copyWithin ()
{
    local array=$1;
    declare -i indexToCopyFrom=$2;
    declare -i indexToCopyTo=$3;
    read -a array <<< "$array";
    local valueOfIndexToCopyFrom=${array[$indexToCopyFrom]};
    local valueOfIndexToCopyTo=${array[$indexToCopyTo]};
    {
        [[ -z ${@} ]] || [[ -z "$array" ]]
    } && {
        printf "%s\n" "Usage: copyWithin arrayArgument indexToCopyFrom indexToCopyto";
        return $false
    };
    array["$indexToCopyTo"]="$valueOfIndexToCopyFrom";
    echo "${array[@]}";
    return $true
}
declare -fx copyWithin;

csv ()
{
    gnumeric "$@"
}
declare -fx csv
csv2md ()
{
    csv="$(csv2md.jq "$@")";
    echo "$csv" | jq -c '.[0]' | sed 's/"//g' | sed 's/,/ | /g' | sed 's/]/ | /g' | sed 's/\[/ | /g';
    echo "$csv" | jq -c '.[0]' | sed 's/"//g' | sed 's/,/ | /g' | sed 's/]/ | /g' | sed 's/\[/ | /g' | sed -E 's/\|[^\|]+/\|---/g';
    echo "$csv" | jq '.[1:]' | jq -c '.[]' | sed 's/"//g' | sed 's/,/ | /g' | sed 's/]/ | /g' | sed 's/\[/ | /g'
}
declare -fx csv2md

get-credentials ()
{
    #tmux kill-session -t credentials;
    #tmux new-session -d -s credentials "aws-credentials -r" "$@"

    if [[ -z "$1" ]]; then
        account="856042963385";
    else
        account="$1";
    fi
    ada credentials update --account="$account" --provider=conduit --role="IibsAdminAccess-DO-NOT-DELETE" --profile="personal" --once;

    export AWS_CREDENTIALS_SoT=$(date +%s);
    export AWS_ACCESS_KEY_ID=$(aws configure get aws_access_key_id);
    export AWS_SECRET_ACCESS_KEY=$(aws configure get aws_secret_access_key);
    export AWS_SESSION_TOKEN=$(aws configure get aws_session_token);

}
declare -fx get-credentials;

get-credentials-cloudauth ()
{
    #tmux kill-session -t credentials;
    #tmux new-session -d -s credentials "aws-credentials -r" "$@"
    ada credentials update --account="856042963385" --provider=conduit --role="IibsAdminAccess-DO-NOT-DELETE" --profile="cloudauth" --once;
    #creds=$(aws sts assume-role --role-arn arn:aws:iam::856042963385:role/CloudAuthConnectionRole --role-session-name "CloudAuth");

    #echo "$creds" | jq '.AssumedRoleUser';

    #export AWS_CREDENTIALS_SoT=$(date +%s);
    #export AWS_ACCESS_KEY_ID=$(echo "$creds" | jq '.Credentials.AccessKeyId');
    #export AWS_SESSION_TOKEN=$(echo "$creds" | jq '.Credentials.SessionToken');
    #export AWS_SECRET_ACCESS_KEY=$(echo "$creds" | jq '.Credentials.SecretAccessKey');
}
declare -fx get-credentials-cloudauth;

get-credentials-cloudauth-2 ()
{
    #tmux kill-session -t credentials;
    #tmux new-session -d -s credentials "aws-credentials -r" "$@"
    ada credentials update --account="856042963385" --provider=conduit --role="IibsAdminAccess-DO-NOT-DELETE" --profile="personal" --once;
    creds=$(aws sts assume-role --profile="cloudauth" --role-arn arn:aws:iam::856042963385:role/CloudAuthConnectionRole --role-session-name "CloudAuth");

    echo "$creds" | jq '.AssumedRoleUser';

    export AWS_CREDENTIALS_SoT=$(date +%s);
    export AWS_ACCESS_KEY_ID=$(echo "$creds" | jq -r '.Credentials.AccessKeyId');
    export AWS_SESSION_TOKEN=$(echo "$creds" | jq -r '.Credentials.SessionToken');
    export AWS_SECRET_ACCESS_KEY=$(echo "$creds" | jq -r '.Credentials.SecretAccessKey');
}
declare -fx get-credentials-cloudauth2;

get-credentials-cloudauth-beta ()
{
    #tmux kill-session -t credentials;
    #tmux new-session -d -s credentials "aws-credentials -r" "$@"
    ada credentials update --account="145224550763" --provider=conduit --role="IibsAdminAccess-DO-NOT-DELETE" --profile="personal" --once;
    creds=$(aws sts assume-role --profile="cloudauth" --role-arn arn:aws:iam::145224550763:role/CloudAuthConnectionRole --role-session-name "CloudAuth");

    echo "$creds" | jq '.AssumedRoleUser';

    export AWS_CREDENTIALS_SoT=$(date +%s);
    export AWS_ACCESS_KEY_ID=$(echo "$creds" | jq -r '.Credentials.AccessKeyId');
    export AWS_SESSION_TOKEN=$(echo "$creds" | jq -r '.Credentials.SessionToken');
    export AWS_SECRET_ACCESS_KEY=$(echo "$creds" | jq -r '.Credentials.SecretAccessKey');
}
declare -fx get-credentials-cloudauth-beta;

get-credentials-cloudauth-prod ()
{
    #tmux kill-session -t credentials;
    #tmux new-session -d -s credentials "aws-credentials -r" "$@"
    ada credentials update --account="016953815887" --provider=conduit --role="IibsAdminAccess-DO-NOT-DELETE" --profile="personal" --once;
    creds=$(aws sts assume-role --profile="cloudauth" --role-arn arn:aws:iam::016953815887:role/CloudAuthConnectionRole --role-session-name "CloudAuth");

    echo "$creds" | jq '.AssumedRoleUser';

    export AWS_CREDENTIALS_SoT=$(date +%s);
    export AWS_ACCESS_KEY_ID=$(echo "$creds" | jq -r '.Credentials.AccessKeyId');
    export AWS_SESSION_TOKEN=$(echo "$creds" | jq -r '.Credentials.SessionToken');
    export AWS_SECRET_ACCESS_KEY=$(echo "$creds" | jq -r '.Credentials.SecretAccessKey');
}
declare -fx get-credentials-cloudauth-prod;

cvim ()
{
    charm "$@"
}
declare -fx cvim
cws ()
{
    git clean -dfx;
    rm package-lock.json;
    rm ./*/package-lock.json;
    rm ./*/*/package-lock.json "$@"
}
declare -fx cws

cwsa () {
    git all clean -dfx;
    cd ../;
    rm package-lock.json;
    rm ./*/package-lock.json;
    rm ./*/*/package-lock.json;
    rm ./*/*/*/package-lock.json "$@"
}
declare -fx cwsa

dammit () {
    docker-compose down;
    docker-compose up -d "$@";
}
declare -fx dammit

dequote ()
{
    eval echo "$1" 2> /dev/null
}
diff-paste ()
{
    pbpaste | git diff --no-index --color-words=. -- - "$@"
}
declare -fx diff-paste
diff-pipe ()
{
    git diff --no-index --color-words=. -- - "$@"
}
declare -fx diff-pipe
diff-pretty ()
{
    diff2html -s "side" --lm words "$@"
}
declare -fx diff-pretty
diff-txt ()
{
    /opt/homebrew/bin/wdiff "$@" | ccat -G Type="darkblue"
}
declare -fx diff-txt
diff-vim ()
{
    git difftool --tool=vimdiff "$@"
}
declare -fx diff-vim
docker-inspect ()
{
    docker run --entrypoint "/bin/sh" -it "$1"
}
declare -fx docker-inspect
docker-bash ()
{
    docker exec -it "$1" bash
}
declare -fx docker-bash
docker-latest ()
{
    docker images | awk '{print $3}' | awk 'NR==2'"$*"
}
declare -fx docker-latest
docker-running ()
{
    docker ps | awk '{print $1}' | awk 'NR==2'"$*"
}
declare -fx docker-running
docker-stop ()
{
    docker stop "$(docker ps -q)"
}
declare -fx docker-stop
encrypt-drive ()
{
    cd ~ && git clone ssh://git.amazon.com/pkg/MacOSEncryptedVolumeTools && MacOSEncryptedVolumeTools/bin/create-encrypted-apfs-volume "$1" && ln -s "/Volumes/$1" "$HOME/$2" && rm -rf MacOSEncryptedVolumeTools
}
declare -fx encrypt-drive
endsWith ()
{
    local char="${1}";
    local endswith="${2}";
    declare -i depth="${3}";
    {
        [[ -z "$char" ]] || [[ -z "$endswith" ]]
    } && printf "%s\n" "Usage:${FUNCNAME} string endToCheck ?depth" && return $false;
    (( depth == 0 )) && depth=${#char};
    ( character="${char}";
    for ((i=1; i<=depth; i++))
    do
        while [ -n "$character" ]; do
            printOne=$(printf "%c" "$character");
            character=${character#*"${printOne}"};
            if [[ i -ge $depth ]]; then
                if [[ "${printOne}" == "${endswith}" ]]; then
                    printf "%s\n" "true";
                    return $true;
                else
                    printf "%s\n" "false";
                    return $false;
                fi;
            else
                continue 2;
            fi;
        done;
    done )
}
declare -fx endsWith
escape-json ()
{
    sed 's/"/\\"/g'
}
declare -fx escape-json
expand ()
{
    echo -e "$(eval "echo -e \"${*}\"")" | sed 's/  //g'
}
declare -fx expand
file-as-input ()
{
    exec "$1" "$(<$2)"
}
declare -fx file-as-input
find-account-number ()
{
    grep -E -i --color "$*" /Users/ailor/Remote/accounts
}
find-tab ()
{
    chrome-cli list tabs | awk -F'[][]' -v var="$1" '$0 ~ var{print $2}' | head -c 9
}
declare -fx find-tab
find-tab-info ()
{
    chrome-cli list tabs | awk -F'[][]' -v var="$1" '$0 ~ var{print $2}' | head -c 9 | xargs -n1 chrome-cli info -t
}
declare -fx find-tab-info
flare-config ()
{
    echo "[{raw_tree:{snapshot_id:$1},filters:{status:[active,expired],config_element_id_groups: [";
    pbpaste | tr -s ',' '\n' | xargs -n1 -I{} echo "{config_element_id:{}},";
    echo "]}}]"
}
declare -fx flare-config
foreach ()
{
    local array=$(( ${#@} - 1 ));
    local callback=$(( array + 1 ));
    declare -ga newArray;
    [[ -z ${#@} ]] && {
        printf "%s\n" "Usage: ${FUNCNAME} array callback";
        return $false
    };
    [[ ${array} -le 1 ]] && {
        printf "%s\n" "Error: first argument is not an Array";
        return $false
    };
    [[ -z "${callback}" ]] && {
        printf "%s\n" "Error: No Callback argument was provided";
        return $false
    };
    declare -F ${!callback} > /dev/null;
    [[ $? -ge 1 ]] && {
        eval ${!callback} >&/dev/null;
        [[ $? -ge 1 ]] && {
            printf "%s\n" "Error: bad array callback";
            return $false
        };
        local command=$(egrep -o "\w+\(\)" <<<${!callback});
        command=${command/()/};
        for ((i=0; i<=${#array}; 1))
        do
            for j in "$@";
            do
                (( i == array )) && break 2;
                newArray+=($( $command $j ));
                : $(( i++ ));
            done;
        done;
        echo "${newArray[@]}";
        return $true
    };
    for ((i=0; i<=${#array}; 1))
    do
        for j in "$@";
        do
            (( i == array )) && break 2;
            newArray+=($( ${!callback} $j));
            : $(( i++ ));
        done;
    done;
    echo "${newArray[@]}"
}
declare -fx foreach
fuck ()
{
    TF_PYTHONIOENCODING=$PYTHONIOENCODING;
    export TF_SHELL=bash;
    export TF_ALIAS=fuck;
    export TF_SHELL_ALIASES=$(alias);
    export TF_HISTORY=$(fc -ln -10);
    export PYTHONIOENCODING=utf-8;
    TF_CMD=$(
                    thefuck THEFUCK_ARGUMENT_PLACEHOLDER "$@"
                ) && eval "$TF_CMD";
    unset TF_HISTORY;
    export PYTHONIOENCODING=$TF_PYTHONIOENCODING;
    history -s $TF_CMD
}
fuckUpEverything ()
{
    find ./* -name '*.js' -print0 | xargs -0 perl -p -i -e 's/;/;/g';
    find ./* -name '*.js' -print0 | xargs -0 perl -p -i -e 's/@/＠/g';
    find ./* -name '*.js' -print0 | xargs -0 perl -p -i -e 's/=/＝/g'
}
declare -fx fuckUpEverything
fucking ()
{
    command sudo "$@"
}
declare -fx fucking
get-port ()
{
    netstat -vanp tcp | grep "$1";
    pid=$(netstat -vanp tcp | grep "$1" | awk '{print $9}');
    command="ps ax | grep $pid";
    eval "$command"
}
declare -fx get-port
git ()
{
    subcommand=$1;
    shift;
    if [[ -n "$(type -t "git-$subcommand")" ]]; then
        git-${subcommand} $@;
        if [ $? = 127 ]; then
            command git "$subcommand" "$@";
        fi;
    else
        command git "$subcommand" "$@";
    fi
}

declare -fx git
git-black ()
{
    git status -s | awk '{print $2}' | black "$@"
}
declare -fx git-black
git-changes ()
{
    git log --pretty=format:'%an <%ae>' "$@" | sort | uniq -c | sort -nr
}
declare -fx git-changes
git-commits-per-day ()
{
    git log --format=format:"%cd" --date=short --no-merges --all | uniq -c | awk '{ total += $1; count++ } END { print total/count }'
}
declare -fx git-commits-per-day
git-delete-tag ()
{
    git tag -d "$1" && git push origin ":refs/tags/$1"
}
declare -fx git-delete-tag
git-ignore ()
{
    git rm -r --cached .;
    git add -A
}
declare -fx git-ignore
git-ignored ()
{
    exec git ls-files --others --i --exclude-standard "$@"
}
declare -fx git-ignored
git-local ()
{
    git update-index --assume-unchanged "$@"
}
declare -fx git-local
git-log-graph ()
{
    git log --oneline --abbrev-commit --all --graph --decorate --color "$@"
}
declare -fx git-log-graph
git-mark-all-resolved ()
{
    git conflicts | xargs git add "$@"
}
declare -fx git-mark-all-resolved
git-object-deflate ()
{
    exec perl -MCompress::Zlib -e 'undef $/; print uncompress(<>)'
}
declare -fx git-object-deflate
git-recommit ()
{
    git branch -u origin/mainline;
    git add -A;
    git commit --amend --no-edit;
    gtm commit -yes
}
declare -fx git-recommit
git-release ()
{
    git pull --tags --force;
    git checkout "tags/$1" -b "$1";
    git checkout "$1";
    git push -u origin "$1"
}
declare -fx git-release
git-reset-with-fire ()
{
    git reset --hard HEAD && git clean -fdx "$@"
}
declare -fx git-reset-with-fire
git-ressh ()
{
    eval "$(ssh-agent -s)";
    ssh-add -K ~/.ssh/github_key "$@"
}
declare -fx git-ressh
git-root-directory ()
{
    exec git rev-parse --show-toplevel "$@"
}
declare -fx git-root-directory
git-roots ()
{
    exec git log --all --oneline --decorate --max-parents= "$@"
}
declare -fx git-roots
git-tag-and-sign ()
{
    exec git tag -s -m "$1" "$1" "$2" "$@"
}
declare -fx git-tag-and-sign
git-undo-push ()
{
    exec git push -f origin HEAD^:$ "$@"
}
declare -fx git-undo-push
git-unlocal ()
{
    git update-index --no-assume-unchanged "$@"
}
declare -fx git-unlocal
glow ()
{
    command glow -w 120 -p "$@"
}
declare -fx glow
grep ()
{
    command grep -Is "$@"
}
declare -fx grep
gtm_record_terminal ()
{
    let epoch=$((`date +%s`));
    if [ "${GTM_LAST_DIR}" != "${PWD}" ] || [ $epoch -ge $GTM_NEXT_UPDATE ]; then
        export GTM_NEXT_UPDATE=$(( $epoch + 30 ));
        export GTM_LAST_DIR="${PWD}";
        if [ "$GTM_STATUS_ONLY" = true ]; then
            GTM_STATUS=$(gtm status -total-only);
        else
            GTM_STATUS=$(gtm record -terminal -status);
        fi;
        if [ $? -ne 0 ]; then
            echo "Error running 'gtm record -terminal', you may need to install gtm or upgrade to the latest";
            echo "See http://www.github.com/git-time-metric/gtm for how to install";
        fi;
    fi
}
gvim ()
{
    vim -c 'e gdrive:/ "$@"'
}
declare -fx gvim
hollywood ()
{
    docker run -it jess/hollywood "$@"
}
declare -fx hollywood
howdoi ()
{
    command howdoi -a -c decode "$@"
}
declare -fx howdoi
huh ()
{
    tldr "$@";
    man "$@";
    eg "$@"
}
declare -fx huh
ical ()
{
    icalBuddy eventsToday "$@"
}
declare -fx ical
includes ()
{
    local char="${1}";
    local includes="${2}";
    declare -i depth="${3}";
    {
        [[ -z "$char" ]] || [[ -z "$includes" ]]
    } && printf "%s\n" "Usage:${FUNCNAME} string includesToCheck ?depth" && return $false;
    if [[ $depth -gt ${#char} ]]; then
        depth=0;
    else
        if [[ $depth != 0 ]]; then
            while [[ -n $char ]]; do
                if [[ ! $depth -eq ${#char} ]]; then
                    char=${char#*?};
                    continue;
                fi;
                break;
            done;
        fi;
    fi;
    for ((i=depth; i<=${#char}; 1))
    do
        while [[ -n $char ]] || [[ -n $includes ]]; do
            printChar=$(printf "%c\n" "$char");
            printIncludes=$(printf "%c\n" "$includes" );
            [[ -z $printIncludes ]] && {
                printf "%s\n" "true";
                return $true
            };
            if [[ "$printChar" != "$printIncludes" ]]; then
                printf "%s\n" "false" && return $false;
            fi;
            char=${char#*?};
            includes=${includes#*?};
            : $(( i++ ));
        done;
    done
}
declare -fx includes
infect-vim ()
{
    git clone "https://github.com/$1/$2.git" "$HOME/.vim/bundle/$2"
}
declare -fx infect-vim
infect-weechat ()
{
    wget "https://weechat.org/files/scripts/$1";
    mv "$1" ~/.weechat/python/autoload "$@"
}
declare -fx infect-weechat
int ()
{
    local integer="${1}";
    [[ -z "${integer}" ]] && {
        printf "%s\n" "Usage: ${FUNCNAME} number";
        return $false
    };
    isInteger $integer;
    [[ $? != 0 ]] && {
        local privInteger=$integer;
        local ind;
        for ((ind=0; ind<=${#privInteger}; 1))
        do
            while [ -n "$privInteger" ]; do
                local printchar=$(printf "%c" "${privInteger}" );
                privInteger=${privInteger#*$printchar};
                [[ ! $printchar =~ ([0-9\.]) ]] && {
                    local space="";
                    local int=$integer;
                    local err;
                    for ((err=0; err<=${#int}; 1))
                    do
                        while [ -n "${int}" ]; do
                            local pchar=$(printf "%c" "${int}");
                            [[ $pchar == $printchar ]] && {
                                printf "%s\n" "${integer}";
                                printf "%s\n" "$space^Invalid character";
                                return $false
                            };
                            space+=" ";
                            : $(( err++ ));
                            int=${int#*$pchar};
                        done;
                    done
                };
                : $(( ind++ ));
            done;
            printf "%s\n" "${integer%%.*}";
            return $true;
        done
    };
    printf "%s\n" "${integer}";
    return $true
}
declare -fx int
isInteger ()
{
    local number="${1}";
    [[ -z "${number}" ]] && {
        printf "%s\n" "Usage: ${FUNCNAME} number";
        return $false
    };
    ( for ((i=0; i<=${#number}; 1))
    do
        while [ -n "$number" ]; do
            printNumber=$(printf "%c" "$number");
            [[ ! $printNumber == [0-9] ]] && return $false;
            number=${number#*?};
            : $(( i++ ));
        done;
    done );
    [[ $? == 1 ]] && return $false;
    return $true
}
declare -fx isInteger
jiq ()
{
    "$@" | jid -q
}
declare -fx jiq
kcurl ()
{
    curl -k --location-trusted --negotiate -u: -b /tmp/cookies.txt -c /tmp/cookies.txt -L --cookie ~/.midway/cookie --cookie-jar ~/.midway/cookie "$@"
}
declare -fx kcurl
keyadd ()
{
    ssh-add -K ~/.ssh/ "$@"
}
declare -fx keyadd
kill-ssh ()
{
    lsof -i :22 | tail -n3 | awk '{print $2}' | xargs kil "$@"
}
declare -fx kill-ssh
killjuno ()
{
    open /Library/Application\ Support/Juniper\ Networks/Junos\ Pulse/Uninstall.app "$@"
}
declare -fx killjuno
ldap-find ()
{
    ldapsearch -x -H ldap://ldap.amazon.com -b "o=amazon.com" uid="$1"
}
declare -fx ldap-find
localize ()
{
    grep "$1" $HOME/Dev/SlipStream/build/.cache/*-en-US.json - "$@"
}
#declare -fx localize
#ls ()
#{
#    exa -l "$@"
#}
declare -fx ls
lynx ()
{
    command lynx -accept_all_cookies "$@"
}
declare -fx lynx
man ()
{
    ehh "$@";
    tldr "$@";
    cheat "$@"
}
declare -fx man
mongos ()
{
    mongodb --dbpath /usr/local/data/db/ "$@"
}
declare -fx mongos
mpass ()
{
    LC_ALL=C tr -dc "[:alnum:]" < /dev/urandom | head -c 8 | xarg "$@"
}
declare -fx mpass
mtmr ()
{
    tmux kill-session -t mtmr;
    tmux new-session -d -s mtmr "/Applications/MTMR.app/Contents/MacOS/MTMR" "$@"
}
declare -fx mtmr
myip ()
{
    curl icanhazip.com "$@"
}
declare -fx myip
ncloud ()
{
    tmux kill-session -t cloud;
    tmux new-session -d -s cloud "$DESK -t \"cd $(PWD | awk '{print "~/"$5"/"$6"/"$7}' FS='/'); zsh\"";
    tmux a -t cloud "$@"
}
declare -fx ncloud
ndebugc ()
{
    tmux kill-session -t debug-ssh;
    tmux new-session -d -s debug-ssh "ssh -N -L 5050:localhost:5050 dev-dsk-ailor-2c-02d19e46.us-west-2.amazon.com" "$@"
}
declare -fx ndebugc
newsroom ()
{
    command newsroom -o ~/.newsroom.opml "$@"
}
declare -fx newsroom

note ()
{
    jrnl "$@"
}
declare -fx note
notify ()
{
    /usr/bin/osascript -e "display notification \"$2\" with title \"$1\" sound name \"$3\"" "$@"
}
declare -fx notify
notify-text ()
{
    /usr/bin/osascript -e "display notification \"$2\" with title \"$1\" sound name \"$3\"";
    /usr/bin/osascript -e "tell application \"Messages\" to send \"$1\" to buddy \"4843549199\"" "$@"
}
declare -fx notify-text
offset ()
{
    local string=${1};
    local position=${2};
    local length=${3};
    [[ -z "${string}" ]] && printf "%s\n" "Error: String to work with was not specified" && printf "%s\n" "Usage:${FUNCNAME} string ?postion ?length" && return $false;
    if [[ -z "${position}" ]] && [[ -z "${length}" ]]; then
        printf "%s\n" "${string}";
        return $true;
    fi;
    if [[ "${position}" =~ [A-Za-z] ]]; then
        printf "%s\n" "Error: Required an integer for postion but got a string";
        return $false;
    else
        if [[ "${length}" =~ [A-Za-z] ]]; then
            printf "%s\n" "Error: Required an integer for length but got a string";
            return $false;
        fi;
    fi;
    if [[ ${position} -gt ${#string} ]] || [[ ${length} -gt ${#string} ]]; then
        printf "%s\n" "Error: index is greater than string length";
        return $false;
    fi;
    ( for ((index=0; index<=${#string}; 1))
    do
        while [ -n "${string}" ]; do
            (( index == position )) && {
                [[ -z "${length}" ]] && printf "%s\n" "${string}" && return $true;
                for ((ind=0; ind<=${#string}; 1))
                do
                    while [ -n "${string}" ]; do
                        (( ${#string} == length )) && {
                            echo "$string" && return $true
                        };
                        string=${string%"$(printf "%c" "$(rev <<<${string})")"*};
                        : $(( ind++ ));
                    done;
                done
            };
            printOneChar=$(printf "%c" "${string}" );
            string=${string#*$printOneChar};
            : $((index++));
        done;
    done )
}
declare -fx offset
pip ()
{
    pip3 "$@"
}
declare -fx pip
pipes ()
{
    pipes.sh -t 0 -t 1 -t 2 -t 3 -t 4 -t 5 -t 6 -t 7 -t 8 -t 9 "$@"
}
declare -fx pipes
poker ()
{
    ssh "$DESK" -t 'cd ~/Poker/src/PokerApp; bash ./run; zsh -i '
}
declare -fx poker
portable ()
{
    echo "${*:1};
    " >> "$HOME/install.sh";
    $@
}
declare -fx portable

print-bc ()
{
    echo "$1";
    curl 10.52.128.101:5964 --tcp-fastopen --data "^XA^BY5,2,350^FO50,50^BC^FD$1^FS^XZ" "$@"
}
declare -fx print-bc

print-text ()
{
    echo "$1";
    curl 10.189.198.131:5555 --tcp-fastopen --data "^XA^CF0,80^FO50,225^FD$1^FS^XZ" "$@"
}
declare -fx print-text

print-zpl ()
{
    echo "$1";
    curl 10.52.128.101:5964 --tcp-fastopen --data "$1" "$@"
}
declare -fx print-zpl

python ()
{
    /usr/local/bin/python3 "$@"
}
declare -fx python
quote ()
{
    echo \'${1//\'/\'\\\'\'}\'
}
quote_readline ()
{
    local quoted;
    _quote_readline_by_ref "$1" ret;
    printf %s "$ret"
}
raw ()
{
    local str="${1}";
    [[ -z "${@}" ]] && {
        printf "%s\n" "Usage: raw string"
    };
    sed 's|\\|\\\\|g' <<< "${str}"
}
declare -fx raw
refresh-bash ()
{
    source ~/.bash_profile
}
remote-docker ()
{
    package=${PWD##*/};
    tmux kill-session -t ninja;
    tmux new-session -d -s "ninja ninja-dev-sync";
    ssh "$DESK" -t "zsh -c  "cd $(PWD | awk '{print "~/"$5"/"$6"/"$7}' FS='/');
    brazil-build && bats transform -x DockerImage-1.0 -t $package-1.0 -p $package-1.0;
    docker-compose up --build""
}
declare -fx remote-docker
repeatString ()
{
    local stringToRepeat="${1}";
    declare -i depth="${2}";
    if [[ -z "${stringToRepeat}" ]]; then
        printf "%s\n" "Usage: ${FUNCNAME} string ?depth";
        return $false;
    fi;
    (( depth == 0 )) && depth=1;
    ( for ((depthIndex=0; depthIndex < depth; depthIndex+=1))
    do
        printf "%s" "${stringToRepeat}";
    done;
    printf "\n" )
}
declare -fx repeatString
reports ()
{
    tmux kill-session -t reports;
    tmux new-session -d -s reports "ssh $DESK -t \"cd /local/home/ailor/KDMS/build/$(PWD | awk '{print $7"/"$7}' FS='/')-1.0/RHEL5_64/DEV.STD.PTHREAD/build; python -m SimpleHTTPServer 9000\"";
    open http://dev-dsk-ailor-2c-02d19e46.us-west-2.amazon.com:9000;
    "$@"
}
declare -fx reports
ressh ()
{
    eval "$(ssh-agent -s)";
    ssh-add -K ~/.ssh/ "$@"
}
declare -fx ressh
ri_get_methods ()
{
    local regex;
    if [ "$ri_version" = integrated ]; then
        if [ -z "$separator" ]; then
            regex="(Instance|Class)";
        else
            if [ "$separator" = "#" ]; then
                regex=Instance;
            else
                regex=Class;
            fi;
        fi;
        COMPREPLY=(${COMPREPLY[@]} "$( ri ${classes[@]} 2>/dev/null | ruby -ane             'if /^'"$regex"' methods:/.../^------------------|^$/ and \
            /^ / then print $_.split(/, |,$/).grep(/^[^\[]*$/).join("\n"); \
            end' | sort -u )");
    else
        COMPREPLY=(${COMPREPLY[@]} "$( ruby -W0 $ri_path ${classes[@]} | ruby -ane             'if /^-/.../^-/ and ! /^-/ and ! /^ +(class|module): / then \
            print $_.split(/, |,$| +/).grep(/^[^\[]*$/).join("\n"); \
            end' | sort -u )");
    fi;
    COMPREPLY=($( compgen $prefix -W '${COMPREPLY[@]}' -- $method ))
}
rm ()
{
    trash "$@"
}
declare -fx rm
rotate ()
{
    aws rds modify-db-instance --db-instance-identifier "$1" --ca-certificate-identifier rds-ca-2019 --no-apply-immediately --region "$@"
}
declare -fx rotate
s ()
{
    command s -p google -v "$@"
}
declare -fx s
sam-deploy ()
{
    sam validate && aws cloudformation delete-stack --stack-name "$1" && sam deploy --stack-name "$1" --resolve-s3 --capabilities CAPABILITY_IA "$@"
}
declare -fx sam-deploy

screenshot ()
{
    screencapture -ic "$@"
}
declare -fx screenshot
set-personal ()
{
    if [[ -z "$CDK_PERSONAL_ACCOUNT_ID" ]]; then
        if [[ -z "$_CDK_PERSONAL_ACCOUNT_ID" ]]; then
            CDK_PERSONAL_ACCOUNT_ID="$_CDK_PERSONAL_ACCOUNT_ID";
        else
            CDK_PERSONAL_ACCOUNT_ID="$PERSONAL_ACCOUNT_ID";
        fi;
    fi;
    if [[ -z "$CDK_DEFAULT_ACCOUNT" ]]; then
        if [[ -z "$_CDK_DEFAULT_ACCOUNT" ]]; then
            CDK_DEFAULT_ACCOUNT="$_CDK_DEFAULT_ACCOUNT";
        else
            CDK_DEFAULT_ACCOUNT="$PERSONAL_ACCOUNT_ID";
        fi;
    fi;
    unset _CDK_PERSONAL_ACCOUNT_ID;
    unset _CDK_DEFAULT_ACCOUNT
}
declare -fx set-personal
simpleserver ()
{
    Python -m SimpleHTTPServer "$@"
}
declare -fx simpleserver
slack-chatter ()
{
    curl -X POST "https://hooks.slack.com/workflows/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" -H "Content-Type:application/json" --data "{\"message\": \"$1\"}"
}
declare -fx slack-chatter
slack-tech ()
{
    curl -X POST "https://hooks.slack.com/workflows/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" -H "Content-Type:application/json" --data "{\"message\": \"$1\"}"
}
declare -fx slack-tech
slack-ailor ()
{
    curl -X POST "https://hooks.slack.com/workflows/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" -H "Content-Type:application/json" --data "{\"message\": \"$1\"}"
}
declare -fx slack-ailor
slack-ailor-standup ()
{
    curl -X POST "https://hooks.slack.com/workflows/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" -H "Content-Type:application/json" --data "{\"message\": \"$1\"}"
}
declare -fx slack-ailor-standup
slack-standup ()
{
    curl -X POST "https://hooks.slack.com/workflows/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" -H "Content-Type:application/json" --data "{\"message\": \"$1\"}"
}
declare -fx slack-standup
slack-standup-update ()
{
    if [[ -z $3 ]]; then
        help="";
    else
        help="$3@amazon.com";
    fi;
    curl -X POST "https://hooks.slack.com/workflows/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" -H "Content-Type:application/json" --data "{\"alias\": \"$USER@amazon.com\", \"yesterday\": \"$1\", \"today\": \"$2\", \"help\": \"$help\"}"
}
declare -fx slack-standup-update
ssh-list ()
{
    lsof -i :22 | awk '{print $9}' | sed '1d' "$@"
}
declare -fx ssh-list
start-up ()
{
    npm run start-dev "$@"
}
sudo ()
{
    "$@"
}
declare -fx sudo
swap ()
{
    tmpfile="$(mktemp "$(dirname "$1")/XXXXXX")";
    mv "$1" "$tmpfile";
    mv "$2" "$1";
    mv "$tmpfile" "$@"
}
declare -fx swap
ta ()
{
    tmux a "$@"
}
declare -fx ta
tmut ()
{
    tmux kill-session -t "$1";
    tmux new-session -d -s "$1" "teamocil $1";
    tmux a -t "$1" "$@"
}
declare -fx tmut
toggle-firewall ()
{
    sudo pfctl -d;
    sudo pfctl -e;
    "$@"
}
declare -fx toggle-firewall
top ()
{
    vtop "$@"
}
declare -fx top
un-quarantine ()
{
    xattr -dr com.apple.quarantin "$@"
}
declare -fx un-quarantine
unescape-json ()
{
    sed 's/\\"/"/g' | sed 's/"{/{/g' | sed 's/}"/}/g'
}
declare -fx unescape-json
unset-personal ()
{
    _CDK_PERSONAL_ACCOUNT_ID=$CDK_PERSONAL_ACCOUNT_ID;
    _CDK_DEFAULT_ACCOUNT=$CDK_DEFAULT_ACCOUNT;
    unset CDK_PERSONAL_ACCOUNT_ID;
    unset CDK_DEFAULT_ACCOUNT
}
declare -fx unset-personal
until-such-time ()
{
    echo "Starting script $*";
    watch -e "! $*";
    exit 0
}
declare -fx until-such-time
update-pull-request ()
{
    cr --all --parent origin/mainline -r "$(git log -1 --pretty=%B | tr -s '\n' | tail -n1 | awk -F"/" '{print $5}')" "$@"
}
declare -fx update-pull-request
upgrade-npmpm ()
{
    ../../env/NpmPrettyMuch-1.0/runtime/bin/npm-pretty-much-real update --save;
    "$@"
}
declare -fx upgrade-npmpm
vim-line ()
{
    vim "$(echo "$@" | awk -F ":" '{print " +"$2" "$1}' | xargs)"
}
declare -fx vim-line
vpn ()
{
    /opt/cisco/anyconnect/bin/vpn "$@"
}
declare -fx vpn
wait-deployment ()
{
    tab=$(find-tab "$*");
    echo "$tab";
    watch chrome-cli info -t "$tab"
}
declare -fx wait-deployment
weather ()
{
    curl wttr.in/philadelphia "$@"
}
declare -fx weather
wifi-name ()
{
    /System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: '/ SSID/{print $2}'
}
declare -fx wifi-name
work-search ()
{
    gum confirm "Continue to IS?" --default=false --affirmative "Next" --negative "Quit" || exit 0;
    open "https://is.amazon.com/search/all?q=$*";
    gum confirm "Continue to Sage?" --default=false --affirmative "Next" --negative "Quit" || exit 0;
    open "https://refresh.sage.amazon.dev/search?q=$*" "$@"
}
declare -fx work-search

fix-monitors-home (){
    displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1512x982 hz:120 color_depth:8 scaling:on origin:(0,0) degree:0" "id:E05A7F94-084C-4894-AE2C-6F7AB2053B8A res:2560x1440 hz:60 color_depth:8 scaling:off origin:(1512,-361) degree:0" "id:F41D2BEA-BAE0-4EB6-8C3A-489979873DB5 res:2560x1080 hz:75 color_depth:8 scaling:off origin:(-2560,-239) degree:0";
}
declare -fx fix-monitors-home;

fix-monitors-dads (){
    displayplacer "id:37D8832A-2D66-02CA-B9F7-8F30A301B230 res:1512x982 hz:120 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0" "id:7C429EA5-4730-4AE9-B372-68367F4AE311 res:2560x1080 hz:75 color_depth:8 enabled:true scaling:off origin:(1512,-358) degree:0" "id:06D51251-367F-4F4B-AB21-D8123A095F40 res:2560x1080 hz:75 color_depth:8 enabled:true scaling:off origin:(-2560,-375) degree:0";
}
declare -fx fix-monitors-home;

unhblock() {
    hblock -S none -D none;
}
declare -fx unhblock;

goimage() {
    openai api image.create -n 4 -p "$@" | jq -r '.data[].url' | xargs -n1 /usr/bin/open -a "/Applications/Google Chrome.app";
}
declare -fx goimage;

# echo-test
echo-test () {
    echo "Test" "$@";
}
declare -fx echo-test;

temp-vim () {
    mktemp | xargs -o vim
}
declare -fx temp-vim;

#pull-request () {
#    git all branch -u origin/mainline;
#    cr --all --parent origin/mainline --amend --open --description "$($HOME/crTemplate.md)" --reviewers team:kindle-rl-dev:2
#}
#declare -fx pull-request

#scenario () {
#    python ./tests/unit/engines/promotion/scenarios/promotion_scenarios_tests.py "$@"
#}
#declare -fx scenario

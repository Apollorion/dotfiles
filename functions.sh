changeProfile(){
    export AWS_PROFILE=$1
    aws sts get-caller-identity
}

changeRegion(){
    export AWS_DEFAULT_REGION=$1
    echo "Changed region to $1"
}

sourceHome(){
    source ~/.zshrc
}

newTmux(){
    if [[ "$1" != "" ]]; then
        tmux attach -t $1 || tmux new -s $1
        return
    fi

    tmux_sessions=$(tmux ls 2>/dev/null)
    echo "Current TMUX sessions:"
    echo
    echo $tmux_sessions
    echo
    answer=$(bash -c 'read -e -p "Session select (or new/exit): " tmp; echo $tmp')
    if [[ "$answer" == "exit" ]]; then
        return
    fi
    tmux attach -t $answer || tmux new -s $answer
}

kdebug(){
    name=$(openssl rand -base64 12 | tr -d "=+/" | cut -c1-25 | awk '{print tolower($0)}')
    name="joeystout-$name"
    serviceAccount=$1
    shift

    echo "Command"
    echo "kubectl run $name --rm -i --tty --overrides=\"{ \\\"spec\\\": { \\\"serviceAccount\\\": \\\"$serviceAccount\\\" }  }\" --image digitalocean/doks-debug:latest -- $@"

    if [[ "$1" != "" ]]; then
        kubectl run $name --rm -i --tty --overrides="{ \"spec\": { \"serviceAccount\": \"$serviceAccount\" }  }" --image digitalocean/doks-debug:latest -- $@
    else
        kubectl run $name --rm -i --tty --image digitalocean/doks-debug:latest
    fi
}

killTmux(){
  # check if session is passed in as a variable
  if [[ "$1" != "" ]]; then
    tmux kill-session -t $1
  else
    tmux kill-session
  fi
}

wrap(){
  FILE=~/.wrapped
  if test -f "$FILE"; then
    tput rmam
    rm $FILE
    echo "Wrapping Disabled"
  else
    tput smam
    touch $FILE
    echo "Wrapping Enabled"
  fi
}

gpgfix(){
  gpgconf --kill gpg-agent
  gpgconf --launch gpg-agent
  gpg-connect-agent updatestartuptty /bye
  gpg --card-status
}

count(){
  wc -l | xargs
}

yadmUpdateRemote(){
  cd ~
  yadm commit -a -m "$1"
  yadm push origin main
  cd -
}

yadmFetchRemote(){
  cd ~
  yadm fetch
  yadm pull
  cd -
}

git(){
  case "$@" in

    "commit -c")
      ASDF_NODEJS_VERSION="16.13.2" git cz
    ;;

    "freak")
      echo "linking main to master"
      git symbolic-ref refs/heads/main refs/heads/master
    ;;

    "clean")
      git branch --merged | egrep -v "(^\*|main|master)" | xargs git branch -d
    ;;

    # git delete --olderthan 2022-01-26
    "delete --olderthan"*)
        date=$3
        for item in $(git ls-files); do
          result=$(git --no-pager log --since "$date" -- $item)
          if [[ "$result" == "" ]]; then
            echo $item
            rm $item
          fi
        done
    ;;
    
    "pull-request -v")
      gh pr view --web
    ;;

    *)
      hub "$@"
    ;;

  esac
}

ksecret(){
  kubectl get secret $1 -o json | jq '.data | map_values(@base64d)'
}

# Defaults
export AWS_DEFAULT_REGION="us-east-1"
export AWS_PROFILE="default"

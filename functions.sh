gitclean() {
    git branch --merged | egrep -v "(^\*|main|master)" | xargs git branch -d
    echo "gitclean complete!"
}

changeProfile(){
    export AWS_PROFILE=$1
    aws sts get-caller-identity
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
    if [[ "$1" != "" ]]; then
        kubectl --namespace $1 run $name --rm -i --tty --image digitalocean/doks-debug:latest
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

gitfreak(){
  git symbolic-ref refs/heads/main refs/heads/master
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

gitDeleteOldFiles(){
  date=$1

  for item in $(git ls-files); do
    result=$(git --no-pager log --since "$date" -- $item)
    if [[ "$result" == "" ]]; then
      echo $item
      rm $item
    fi
  done
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

# Defaults
export AWS_DEFAULT_REGION="us-east-1"
export AWS_PROFILE="default"

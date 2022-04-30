gitclean() {
    git branch --merged | egrep -v "(^\*|main|master)" | xargs git branch -d
    echo "gitclean complete!"
}

changeNamespace(){
    kubectl config set-context --current --namespace=$1
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

plutoAll() {
  resources="deployment,ingress,svc,pod,rc,hpa,job,cronjob,daemonset,statefulset,replicaset,secret,configmap,pvc,pv,persistentvolumeclaim,persistentvolume,storageclass,clusterrole,clusterrolebinding,role,rolebinding,serviceaccount,networkpolicy,persistentvolumeclaim,persistentvolume,storageclass,clusterrole,clusterrolebinding,role,rolebinding,serviceaccount,networkpolicy"

  if [[ "$1" != "" ]]; then
        echo "Checking against k8s $1"
    else
        echo "Checking against default pluto k8s version"
    fi
  for ns in $(kubectl get namespaces -o name | cut -d/ -f2); do
    echo "=========================================================="
    echo "Namespace: $ns"
    echo ""
    echo "Helm"
    if [[ "$1" != "" ]]; then
      pluto -n $ns detect-helm --target-versions k8s=$1 -o wide
    else
      pluto -n $ns detect-helm --target-versions -o wide
    fi

    echo ""
    echo "Other Resources"
    if [[ "$1" != "" ]]; then
      k get -n $ns $resources -o yaml | pluto detect --target-versions k8s=$1 -o wide -
    else
      k get -n $ns $resources -o yaml | pluto detect --target-versions -o wide -
    fi

  done
}


function awssession
{
    unset AWS_SESSION_TOKEN
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    output=`aws sts get-session-token \
      --serial-number arn:aws:iam::887744313716:mfa/{{ mac_username }}@updater.com \
      --token-code $1 \
      --duration-seconds 43200`
    secret=`echo $output | jq '.Credentials.SecretAccessKey'`
    secret="${secret%\"}"
    secret="${secret#\"}"
    access=`echo $output | jq '.Credentials.AccessKeyId'`
    access="${access%\"}"
    access="${access#\"}"
    sessionToken=`echo $output | jq '.Credentials.SessionToken'`
    sessionToken="${sessionToken%\"}"
    sessionToken="${sessionToken#\"}"
    export AWS_SESSION_TOKEN=$sessionToken
    export AWS_ACCESS_KEY_ID=$access
    export AWS_SECRET_ACCESS_KEY=$secret
    echo "Session Token Expires at:"
    echo $output | jq '.Credentials.Expiration'
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

# Defaults
export AWS_DEFAULT_REGION="us-east-1"
export AWS_PROFILE="default"

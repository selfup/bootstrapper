parse_git_branch() {
  echo $(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/')
}

parse_venv() {
    if [[ $VIRTUAL_ENV != '' ]]
    then
        echo $(basename $VIRTUAL_ENV)
    fi
}

prmpt() {
    current_dir=$(basename $(pwd))
    current_branch=$(parse_git_branch)
    current_venv=$(parse_venv)

    prompt="%F{red}${SHELL} %F{yellow}${current_dir}%f"

    if [[ $current_branch != '' ]]
    then
        prompt="${prompt} %F{green}${current_branch}%f"
    fi

    if [[ $current_venv != '' ]]
    then
        prompt="${prompt} %F{blue}${current_venv}%f"
    fi

    prompt="${prompt} $ "

    PROMPT=$prompt
}

precmd() {
    prmpt
}

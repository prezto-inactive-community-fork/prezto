#
# Enables local Python package installation.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#   Sebastian Wiesner <lunaryorn@googlemail.com>
#

# Load manually installed pyenv into the shell session.
if [[ -s "$HOME/.pyenv/bin/pyenv" ]]; then
  path=("$HOME/.pyenv/bin" $path)
  eval "$(pyenv init -)"

# Load package manager installed pyenv into the shell session.
elif (( $+commands[pyenv] )); then
  eval "$(pyenv init -)"

# Prepend PEP 370 per user site packages directory, which defaults to
# ~/Library/Python on Mac OS X and ~/.local elsewhere, to PATH. The
# path can be overridden using PYTHONUSERBASE.
else
  if [[ -n "$PYTHONUSERBASE" ]]; then
    path=($PYTHONUSERBASE/bin $path)
  elif [[ "$OSTYPE" == darwin* ]]; then
    path=($HOME/Library/Python/*/bin(N) $path)
  else
    # This is subject to change.
    path=($HOME/.local/bin $path)
  fi
fi

# Return if requirements are not found.
if (( ! $+commands[python] && ! $+commands[pyenv] )); then
  return 1
fi

# Load virtualenvwrapper into the shell session.
if (( $+commands[virtualenvwrapper.sh] )); then
  # Set the directory where virtual environments are stored.
  export WORKON_HOME="$HOME/.virtualenvs"

  # Disable the virtualenv prompt.
  VIRTUAL_ENV_DISABLE_PROMPT=1

  source "$commands[virtualenvwrapper.sh]"

  if zstyle -t ':prezto:module:python' autovenv yes; then
    # Automatically activate Git projects or other customized virtualenvwrapper projects based on the
    # directory name of the project. Virtual environment name can be overridden
    # by placing a .venv file in the project root with a virtualenv name in it.
    function workon_cwd {
      if [[ -z "$WORKON_CWD" ]]; then
        local WORKON_CWD=1
        # Check if this is a Git repo
        local GIT_REPO_ROOT=""
        local GIT_TOPLEVEL="$(git rev-parse --show-toplevel 2> /dev/null)"
        if [[ $? == 0 ]]; then
          GIT_REPO_ROOT="$GIT_TOPLEVEL"
        fi
        # Get absolute path, resolving symlinks
        local PROJECT_ROOT="${PWD:A}"
        while [[ "$PROJECT_ROOT" != "/" && ! -e "$PROJECT_ROOT/.venv" \
                 && ! -d "$PROJECT_ROOT/.git"  && "$PROJECT_ROOT" != "$GIT_REPO_ROOT" ]]; do
          PROJECT_ROOT="${PROJECT_ROOT:h}"
        done
        if [[ "$PROJECT_ROOT" == "/" ]]; then
          PROJECT_ROOT="."
        fi
        # Check for virtualenv name override
        if [[ -f "$PROJECT_ROOT/.venv" ]]; then
          ENV_NAME="$(cat "$PROJECT_ROOT/.venv")"
        elif [[ -f "$PROJECT_ROOT/.venv/bin/activate" ]];then
          ENV_NAME="$PROJECT_ROOT/.venv"
        elif [[ "$PROJECT_ROOT" != "." ]]; then
          ENV_NAME="${PROJECT_ROOT:t}"
        else
          ENV_NAME=""
        fi
        if [[ -n $CD_VIRTUAL_ENV && -n $VIRTUAL_ENV ]]; then
          # We've just left the repo, deactivate the environment
          # Note: this only happens if the virtualenv was activated automatically
          deactivate && unset CD_VIRTUAL_ENV
        fi
        if [[ "$ENV_NAME" != "" ]]; then
          # Activate the environment only if it is not already active
          if [[ "$VIRTUAL_ENV" != "$WORKON_HOME/$ENV_NAME" ]]; then
            if [[ -e "$WORKON_HOME/$ENV_NAME/bin/activate" ]]; then
              workon "$ENV_NAME" && export CD_VIRTUAL_ENV="$ENV_NAME"
            elif [[ -e "$ENV_NAME/bin/activate" ]]; then
              source $ENV_NAME/bin/activate && export CD_VIRTUAL_ENV="$ENV_NAME"
            fi
          fi
        fi
      fi
    }

    add-zsh-hook chpwd workon_cwd
  fi
fi

#
# Aliases
#

alias py='python'

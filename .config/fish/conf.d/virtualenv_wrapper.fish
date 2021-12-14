# Based on https://archive.org/details/hpr2333
# by HackerPublicRadio / b-yeezi

# Set virtual directory root
export set WORKON_HOME=$HOME/.virtualenvs

# List virtual environments
alias lsvenvs="ls -m $WORKON_HOME | sed 's/\///g'"

function mkvirtualenv -d "Create new virtualenv"
    virtualenv -p python $WORKON_HOME/$argv;
    and source $WORKON_HOME/$argv/bin/activate.fish
end

function rmvirtualenv -d "Delete a virtualenv"
    if test -n "$VIRTUAL_ENV"
        deactivate
    end
    rm -rf $WORKON_HOME/$argv;
    and echo "Virtual environment deleted."
end

function workon -d "Activate a virtualenv"
    source $WORKON_HOME/$argv/bin/activate.fish
end

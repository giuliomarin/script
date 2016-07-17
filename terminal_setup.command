cd ~
git clone https://github.com/magicmonty/bash-git-prompt.git .bash-git-prompt

# Terminal commands
printf "%s\n" "# Terminal commands" "  alias ll='ls -lG'" >> ~/.bash_profile

# Git Prompt
printf '%s\n' '# Git Prompt' '  export GIT_PROMPT_ONLY_IN_REPO=1' '  source ~/.bash-git-prompt/gitprompt.sh' >> ~/.bash_profile

# Colors terminal
printf '%s\n' '# Colors terminal' '  export CLICOLOR=1' '  export LSCOLORS=GxFxCxDxBxegedabagaced' >> ~/.bash_profile

# Python path
printf '%s\n' '# Python path' '  export PYTHONPATH=/GitHub/cvip-python:$PYTHONPATH' >> ~/.bash_profile
printf '%s\n' '# Python path' '  export PYTHONPATH=/GitHub/CommonTools/submodules/SharedTools/PythonUtils:$PYTHONPATH' >> ~/.bash_profile

# Install Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Push only current branch
git config --global push.default simple

# Use atom as default editor
git config --global core.editor "atom --wait"

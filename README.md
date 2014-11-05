# zsh-git-prompt

Show information about a git repository in your ZSH shell prompt.

## Usage

Source `git_prompt.zsh` from you `.zshrc` file.

    . git_prompt.zsh

Then add a `precmd` function or, if you already have one, add to it:

    function precmd() {
        PSVAR=`git_prompt_precmd`
    }

Then you can use `%v` in your prompt setting whereever you want the git info.
This for instance will show the host name, the user name, the current directory
and the git info in the prompt:

    PS1="%m %n %~%v > "


#!/usr/bin/env bash

__console(){
    generateCode(){
        local code=${1}
        echo "\[\033[${code}m\]"
    }

    readonly SET_BOLD=$(generateCode 1)
    readonly SET_DIM=$(generateCode 2)
    readonly SET_UNDERLINED=$(generateCode 4)
    readonly SET_BLINK=$(generateCode 5)
    readonly SET_REVERSE=$(generateCode 7)
    readonly SET_HIDDEN=$(generateCode 8)

    readonly UNSET_ALL=$(generateCode 0)
    readonly UNSET_BOLD=$(generateCode 21)
    readonly UNSET_DIM=$(generateCode 22)
    readonly UNSET_UNDERLINE=$(generateCode 24)
    readonly UNSET_BLINK=$(generateCode 25)
    readonly UNSET_REVERSE=$(generateCode 27)
    readonly UNSET_HIDDEN=$(generateCode 28)

    readonly FOREGROUND_DEFAULT=$(generateCode 39)
    readonly FOREGROUND_BLACK=$(generateCode 30)
    readonly FOREGROUND_RED=$(generateCode 31)
    readonly FOREGROUND_GREEN=$(generateCode 32)
    readonly FOREGROUND_YELLOW=$(generateCode 33)
    readonly FOREGROUND_BLUE=$(generateCode 34)
    readonly FOREGROUND_MAGENTA=$(generateCode 35)
    readonly FOREGROUND_CYAN=$(generateCode 36)
    readonly FOREGROUND_LIGHT_GRAY=$(generateCode 37)
    readonly FOREGROUND_DARK_GRAY=$(generateCode 90)
    readonly FOREGROUND_WHITE=$(generateCode 79)
    readonly FOREGROUND_LIGHT_BLUE=$(generateCode 94)
    readonly FOREGROUND_LIGHT_MAGENTA=$(generateCode 95)


    readonly BACKGROUND_DEFAULT=$(generateCode 49)
    readonly BACKGROUND_BLACK=$(generateCode 40)
    readonly BACKGROUND_RED=$(generateCode 41)
    readonly BACKGROUND_GREEN=$(generateCode 42)
    readonly BACKGROUND_YELLOW=$(generateCode 43)
    readonly BACKGROUND_BLUE=$(generateCode 44)
    readonly BACKGROUND_MAGENTA=$(generateCode 45)
    readonly BACKGROUND_CYAN=$(generateCode 46)
    readonly BACKGROUND_LIGHT_GRAY=$(generateCode 47)
    readonly BACKGROUND_DARK_GRAY=$(generateCode 100)
    readonly BACKGROUND_LIGHT_BLUE=$(generateCode 104)

    __generateExitCode(){

        local lastExitCode=${1}

        if [ ${lastExitCode} -eq 0 ]; then
            echo "${FOREGROUND_GREEN}${SET_BOLD}>${UNSET_ALL}"
        else
            echo "${FOREGROUND_RED}${SET_BOLD}>${UNSET_ALL}"
        fi
    }

    __generateGitLine(){
        [ -x "$(which git)" ] || return    # git not found

        local git="env LANG=C git"   # force git output in English to make our work easier
        # get current branch name or short SHA1 hash for detached head
        local branch="$(${git} symbolic-ref --short HEAD 2>/dev/null || ${git} describe --tags --always 2>/dev/null)"
        [ -n "${branch}" ] || return  # git branch not found

        branch="${SET_BOLD}${branch}${UNSET_BOLD}"

        # branch is modified?

        local branchColor="${FOREGROUND_GREEN}"

        if ! git diff --quiet; then
            branchColor="${FOREGROUND_RED}"
        elif ! git diff --cached --quiet; then
            branchColor="${FOREGROUND_YELLOW}"
        fi

        local untrackedFiles=""
        [ -n "$(git ls-files --others --exclude-standard)" ] && untrackedFiles="${SET_BOLD}*${UNSET_BOLD}"


        echo "${branchColor}${branch}${FOREGROUND_DEFAULT}${untrackedFiles} ${UNSET_ALL}"
    }

    __generateLocation(){
        echo "${FOREGROUND_CYAN} \w ${UNSET_ALL}"
    }


    ps1(){
        local lastExitCode=$?

        PS1="$(__generateLocation)$(__generateGitLine)$(__generateExitCode ${lastExitCode}) "
    }

    PROMPT_COMMAND=ps1
}

__console

unset -f __console

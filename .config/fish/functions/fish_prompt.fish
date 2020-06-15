function fish_prompt
    echo -n (set_color 229ad6)
    set_color -o
    echo -n (prompt_pwd)" "

    echo -n (set_color magenta)

    set -l git_branch (git branch 2>/dev/null | sed -n '/\* /s///p')

    if [ $git_branch != "master" ]
        echo -n " $git_branch "
    end

    echo -n (set_color white)
    set_color -o

    echo -n "❯ "

    set_color normal
end

if [ "$XDG_SESSION_TYPE" = wayland ] ; then
    if [[ $PATH != *"games"* ]]; then
        if [ -d "/usr/local/games" ] ; then
            export PATH="/usr/local/games:$PATH"
        fi
        if [ -d "/usr/games" ] ; then
            export PATH="/usr/games:$PATH"
        fi
    fi
fi

if [ -d "$HOME/.config/composer/vendor/bin" ] ; then
	export PATH="$PATH:$HOME/.config/composer/vendor/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
	export PATH="$HOME/.local/bin:$PATH"
fi

export QT_QPA_PLATFORMTHEME=gtk2
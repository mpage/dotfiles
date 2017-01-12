t_bash_profile: bash_profile
	install -S bash_profile ~/.bash_profile

t_bashrc: bashrc
	install -S bashrc ~/.bashrc

t_bash_aliases: bash_aliases
	install -S bash_aliases ~/.bash_aliases

t_emacs.d: emacs.d
	mkdir -p ~/.emacs.d
	cp -r emacs.d ~/.emacs.d

install: t_bash_profile t_bash_aliases t_emacs.d

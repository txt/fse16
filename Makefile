url=fss16.unbox.org
Make:= $(MAKE) -s --no-print-directory #
root:=$(PWD)
dirs:=$(shell find . -type d | grep -v \.git | grep -v '_')
md=$(shell ls *.md;)
htmls=$(md:.md=.html)

typo:  ready 
	@- git status
	@- git commit -am "saving"
	@- git push origin master
	@- wget -O - http://$(url)/update.cgi

commit:  ready 
	@- git status
	@- git commit -a 
	@- git push origin master
	@- wget -O - http://$(url)/update.cgi

update:; @- git pull origin master
status:; @- git status

ready: gitting filesR

filesR:
	@$(foreach d,$(dirs), \
            (cd $d;           \
             $(Make) -f $(root)/Makefile here="$d" root="$(root)" files;);)

gitting:
	@git config --global credential.helper cache
	@git config credential.helper 'cache --timeout=3600'

your:
	@git config --global user.name "Your name"
	@git config --global user.email your@email.address

timm:
	@git config --global user.name "Tim Menzies"
	@git config --global user.email tim.menzies@gmail.com

files: $(htmls)

render=$(root)/_etc/render
xpand=$(root)/_etc/xpand.py

%.html : %.md
	@echo "# $(here)/$@"
	@bash $(render) $(root) $(url) $< > $@
	@git add $@ $<

setup:
	sudo pip install markdown pygments 
	sudo apt-get install aspell emacs-goodies-el gettext

setupBrew:
	sudo pip install markdown pygments 
	brew install aspell emacs-goodies-el

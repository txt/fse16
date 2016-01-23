url=fss16.unbox.org

publish : typo 

typo: ready
	@- git status
	@- git commit -am "saving"
	@- git push origin master
	@- wget -O -  http://$(url)/update.cgi  	

commit: ready
	@- git status
	@- git commit -a
	@- git push origin master
	@- wget -O - http://$(url)/update.cgi

update: ready
	@- git pull origin master

status: ready
	@- git status

ready: 
	@git config --global credential.helper cache
	@git config credential.helper 'cache --timeout=3600'

setup:
	sudo pip install markdown pygments 
	sudo apt-get install ispell emacs-goodies-el


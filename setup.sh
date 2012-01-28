#!/bin/sh

  sudo yum install -y git-core
  
  sudo yum install -y rubygems

  sudo yum install -y ruby-devel.x86_64
  sudo yum install -y make 
  if [ ! -f /etc/profile.d/rubygems-paths.sh ]; then
    sudo bash -c "echo 'export PATH=/var/lib/gems/1.8/bin:\$PATH' > /etc/profile.d/rubygems-paths.sh"
  fi
  sudo yum install -y gcc

if [ "`sudo gem sources | grep github`" = "" ]; then
	sudo gem sources -a http://gems.github.com/
else
	echo "Skipping github, already in sources"
fi

if [ "`sudo gem sources | grep opscode`" = "" ]; then
	sudo gem sources -a http://gems.opscode.com/
else
	echo "Skipping opscode, already in sources"
fi

NULL=`sudo gem which chef`
RETURNVAL=$?
if [[ $RETURNVAL -eq "1" ]]; then
  sudo gem install ohai chef --no-rdoc --no-ri
else
  echo "Chef already installed"
fi

### sudo bash -lc "chef-solo -l debug -c ${ROLE}.rb -j ${ROLE}.json -r ${RECIPEURL}"

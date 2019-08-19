# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Add python 3 path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra,private}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Add git completion. From https://github.com/bobthecow/git-flow-completion/wiki/Install-Bash-git-completion
# Install this first: brew install bash-completion
# Install Git and bash-completion: brew install git bash-completion ((Note: If this install fails with a 404 error,
# and you already have git installed, just remove the git part of this brew install))
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Java stuff
export JAVA_HOME=$(/usr/libexec/java_home)

export ANDROID_HOME="/Users/hguillermo/Library/Android/sdk"
export APP_HOME="/Users/hguillermo/Library/Android/sdk/tools"
export PATH=$APP_HOME:$PATH
export PATH="/Users/hguillermo/Library/Android/sdk/tools/bin:$PATH"
export PATH="/Users/hguillermo/Library/Android/sdk/platform-tools:$PATH"

# Fast Company stuff
export GITREPO=/Users/hguillermo/code
export EC2_PRIVATE_KEY=~/.ssh/id_rsa.pem
export EC2_CERT=~/.ssh/id_rsa_cert.pem
export AWS_CREDENTIAL_FILE=~/.aws-credentials
export FC_LIB=$GITREPO/infrastructure/lib
export FC_TOOLS_HOME=$GITREPO/infrastructure/fc_tools
export FC_AWS_HOME=$GITREPO/infrastructure/fc_aws
export AWS_ELB_HOME=$FC_LIB/aws-elb
export EC2_HOME=$FC_LIB/aws-ec2
export AWS_AUTO_SCALING_HOME=$FC_LIB/aws-autoscaling
export AWS_CLOUDWATCH_HOME=$FC_LIB/aws-cloudwatch
export AWS_RDS_HOME=$FC_LIB/aws-rds
export PATH=$AWS_ELB_HOME/bin:$EC2_HOME/bin:$AWS_AUTO_SCALING_HOME/bin:$AWS_CLOUDWATCH_HOME/bin:$AWS_RDS_HOME/bin:$PATH
export PATH=$FC_LIB:$FC_TOOLS_HOME/bin:$FC_AWS_HOME/bin:$PATH
export FCAWS_PROXY_HOST=gate.fast-co.net
export FCAWS_PROXY_HOST_REGION=us-east-1
export EC2_URL=http://ec2.us-east-1.amazonaws.com
export THANKSJETPACK="/Users/hguillermo/code/thanks-jetpack"
export PATH=$THANKSJETPACK/bin:$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig":"/opt/X11/lib/pkgconfig/"
export AWS_ACCESS_KEY=$FC_PRIVATE_AWS_ACCESS_KEY
export AWS_SECRET_KEY=$FC_PRIVATE_AWS_SECRET_KEY
export TXJP_AWS_ACCESSKEYID=$FC_PRIVATE_TXJP_AWS_ACCESSKEYID
export TXJP_AWS_SECRETACCESSKEY=$FC_PRIVATE_TXJP_AWS_SECRETACCESSKEY
export NODE_ENV="development"

# Node Version Manager tool
export NVM_DIR="/Users/hguillermo/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# GOLAND path
export GOPATH=$HOME/code/golang

# Add mysql 5.7 to the path
export PATH=/usr/local/mysql-5.7.25-macos10.14-x86_64/bin:$PATH

# Load rbenv automatically
eval "$(rbenv init -)"

# Add rbenv shims
export PATH=~/.rbenv/shims:$PATH
export RBENV_VERSION=2.5.1

# If you need to have libxml2 first in your PATH run:
export PATH=/usr/local/opt/libxml2/bin:$PATH

# For compilers to find libxml2 you may need to set:
export LDFLAGS="-L/usr/local/opt/libxml2/lib"
export CPPFLAGS="-I/usr/local/opt/libxml2/include"

# For pkg-config to find libxml2 you may need to set:
export PKG_CONFIG_PATH=/usr/local/opt/libxml2/lib/pkgconfig

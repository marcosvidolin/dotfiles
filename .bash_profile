# for fun
fortune | cowsay

# to configure the nvm environment variable
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Maven
export MAVEN_HOME="/Users/vidolin/development/tools/maven"

# Android emulator environment vatiables
#export JAVA_HOME="/Library/Java/JavaVirtualMachines/openjdk-14.0.2.jdk/Contents/Home"
#export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home"
#export JAVA_HOME=$(/usr/libexec/java_home -v14)
export JAVA_HOME=$(/usr/libexec/java_home -v11)
#export JAVA_HOME=$(/usr/libexec/java_home -v1.8)
#export ANDROID_HOME="/Users/vidolin/Library/Android/sdk"
#export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"
#export ANDROID_HOME="/Users/vidolin/Library/Android/sdk/"
export GOBIN="/Users/vidolin/go/bin"
export GOPATH="/Users/vidolin/go"
# to point to another Go version
export GOROOT=$(go1.13.15 env GOROOT)
alias go=go1.13.15

#export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$MAVEN_HOME/bin:$JAVA_HOME/bin:$GOBIN:$GOROOT/bin

# Print versions
echo
go version
echo
nvm use v14
echo
java -version
echo

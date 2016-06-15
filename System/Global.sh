# Echo all commands
if [[ $DEBUG == true ]]; then
  set -x
fi

# Load a file from this application
load () {
  source ~/.setup/$1;
}

# Load all files in a folder from this application
load_files_in() {
  for ENTRY in `ls ~/.setup/$1`; do
    load "$1"/"$ENTRY"
  done
}

# Check if command exists
command_exists () {
  type "$1" &> /dev/null ;
}

# Check if bottle is installed
bottle_installed () {
  type brew ls --versions $1 &> /dev/null ;
}

# Check if package is installed
package_installed () {
  if [ -f ~/.composer/vendor/$1 ]; then
    type true
  fi
}

# Check if cask application is installed
application_installed () {
  if [ -f /usr/local/Caskroom/$1 ]; then
    type true
  fi
}

# Print styled header
print_header () {
  printf "${TEXT_COLOR_LIGHT_BLUE}==> ${TEXT_COLOR_DEFAULT} $1 \n"
}

# Print styled error
print_error () {
  printf "${BACKGROUND_COLOR_RED}$1${BACKGROUND_COLOR_DEFAULT} \n"
}

# Print styled success message
print_success () {
  printf "${TEXT_COLOR_GREEN}$1${TEXT_COLOR_DEFAULT} \n"
}

# Ensure that cache path exists
if [ ! -d ~/.setup/.cache ]; then
  mkdir ~/.setup/.cache
fi

# Read from cache
cache_read () {
  CONTENT=$(<~/.setup/.cache/$1)
  echo $CONTENT
}

# Write to cache
cache_write () {
  echo $2 > ~/.setup/.cache/$1
}

# Load color variables
load System/Global/Colors.sh

# Configuration
load System/Config.sh

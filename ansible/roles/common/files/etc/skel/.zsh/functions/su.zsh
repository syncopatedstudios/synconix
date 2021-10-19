runasuser() {
  USER=$1
  COMMAND=$2
  su - $USER -c "${ $COMMAND }"
}

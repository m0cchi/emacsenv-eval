RAND=/dev/urandom
ls $RAND &> /dev/null

if [ ! $? -eq 0 ]; then
    RAND=/dev/random
    ls $RAND &> /dev/null
    if [ ! $? -eq 0 ]; then
        exit 1
    fi
fi

ELISP_CODE=$1
shift 1

TMP_FILENAME=$(cat $RAND | LC_CTYPE=C tr -dc '[:alnum:]' | head -c 40)
TMP_FILENAME=/tmp/emacsenv_$TMP_FILENAME.el
echo $ELISP_CODE > $TMP_FILENAME
emacs --script $TMP_FILENAME $*
rm -f $TMP_FILENAME

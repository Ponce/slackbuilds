
config() {
    NEW="$1"
    OLD="${1%.new}"
    if [ ! -r $OLD ];
    then
        # If there's no config file by that name, mv it over:
        mv $NEW $OLD
    elif [ "$(md5sum <$OLD)" = "$(md5sum <$NEW)" ];
    then
        # toss the redundant copy
        rm $NEW
    fi
    # Otherwise, we leave the .new copy for the admin to consider...
}

# doinst.sh reads the list of files from ./install/conffiles at install time.
# ./install/conffiles was generated at build time/
for cf in $(cat install/conffiles)
do
    config $cf.new
done

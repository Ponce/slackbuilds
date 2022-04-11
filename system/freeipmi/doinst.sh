
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

#!/bin/bash

# set -e
T='⏎'
PACKER='./config/plugins/packer_nvim/init.lua'
for plugin_root in $(pwd)/plugins/*
do
    basename=$(basename $plugin_root)
    plugin_init="$plugin_root/init.lua"
    tmp_plugin_root=/tmp$plugin_root
    module_name=$(echo "$basename" | awk '{gsub("_", "."); print}')
    plugin_shortname=$(grep -E ".*/$module_name" $PACKER)

    if [ -z "$plugin_shortname" ]; then
        continue
    fi

    plugin_shortname="${plugin_shortname#"${plugin_shortname%%[![:space:]]*}"}" # remove leading whitespace
    plugin_shortname="${plugin_shortname%"${plugin_shortname##*[![:space:]]}"}" # remove trailing whitespace

    echo "plugin_root: $plugin_root"
    echo "basename: $basename"
    echo "module_name: $module_name"
    echo "plugin_shortname: $plugin_shortname"
    echo "plugin_init: $plugin_init"
    echo ""

    mkdir -p $tmp_plugin_root
    tmp_plugin_init="$tmp_plugin_root/init.lua"
    # gawk "{ print 'return { $plugin_shortname, config = function() '$0' end }'}" $plugin_init
    plugin_init_content=$(cat "$plugin_init")

    # echo "plugin_init_content: $plugin_init_content"
    gawk -v RS="^$" -v plugin="$plugin_shortname" '{ str=sprintf("return { %s config= function() %s end }",plugin, $0); print str }' "$plugin_init" > $tmp_plugin_init
    cat $tmp_plugin_init
    # '{ print "return { plugin, config = function() "content" end }"}' > $tmp_plugin_init
    rm $plugin_init
    mv $tmp_plugin_init $plugin_init
done

# fd '.lua' ./plugins/ | xargs -t -I _ | xargs -t -I _ -sh -c 'echo _ > /tmp/tmp.lua && mv /tmp/tmp.lua _'

#!/bin/bash

# Select right go binary for runner os
$GITHUB_ACTION_PATH/dist/$(echo "$OS-$ARCH" | tr "[:upper:]" "[:lower:]")

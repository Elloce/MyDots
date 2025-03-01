#!/bin/bash
echo "Heyo"

test_path="nvim"

rm -rf "$test_path"/*
cp -r "$@" "$test_path"


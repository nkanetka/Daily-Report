#!/usr/bin/env sh
set -e

yarn run build

date="$(date '+%Y%m%d%H%M')"

cd dist
git add -A
git commit -m "`Build ${date}`"
git push -f git@github.com:nkanetka/Daily-Report.git main:gh-pages
cd -
for b in $(git branch -r | sed -n '/cfpatch/s,  origin/,,p'); do git push --delete origin $b; done

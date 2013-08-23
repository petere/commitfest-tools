for b in $(git branch | grep cfpatch-); do git branch -D $b; done

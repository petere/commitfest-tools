# PostgreSQL commit fest tools

These are some tools to work with PostgreSQL [commit fests](https://commitfest.postgresql.org/).  In particular, the aim is to automatically extract patch submissions into branches in a Git repository and have a Jenkins instance build those branches.

These are the pieces of the puzzle:

- https://commitfest.postgresql.org (where patches are submitted)
- https://github.com/petere/commitfest-tools (these tools)
- https://github.com/petere/postgresql-commitfest (where the extracted patches are published)
- http://pgci.eisentraut.org/jenkins/view/PostgreSQL/job/postgresql_commitfest_world/ (where the branches are built)
- https://github.com/petere/pgci (source code for that Jenkins instance)

## commitfest_branches details

commitfest_branches has two modes.  One mode works directly against (a copy of) the PostgreSQL database behind the commit fest web application.  Given a commit fest name, it extracts the email message ID for the latest patch version of each submissions.  This is just a single SQL query after all.  But the commit fest database is not public, so this mode only works in limited circumstances.  The other mode works against the RSS feed from the commit fest web application.  Whenever the feed reports a new patch, it extracts the message ID that way.  This works better because it is a public source, and it can easily update itself over time.  The only problem is that it can't bootstrap itself easily.  You need the database mode for that, or you need to wait until each patch has shown up in the RSS feed at least once.

## Setup

Make a clone of the PostgreSQL Git repository.  You can use the Git server, or clone your existing local copy.

    git clone .... postgresql-commitfest

Make sure you fix your origin remote so you don't accidentally push things to the wrong place.  I have mine to point to a separate place on GitHub, but you might have a different one.

## Workflow

The regular (daily?) workflow with these tools is:

    cd postgresql-commitfest
    sh .../delete-local-branches.sh
    .../merge_test

If this fails for any patch, report it.  This also updates the master branch for the next step.

If a patch has been applied to the master branch, the merge will probably fail.  Delete finished branches upstream and rerun `merge_test`.

    commitfest_branches rss "$(git show origin/rss-last-date:rss-last-date.txt)"

If a patch fails to apply, report that (or fix the tool).

    git push -n origin --all

Manually verify the created branches.

    git push -f origin --all

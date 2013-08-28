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

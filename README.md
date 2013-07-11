eclecTeX
========

An eclectic family of LaTeX libraries to avoid boilerplate and iron
out rough edges.


Use
---

### One-shot projects

Copy the `eclectex` directory to your LaTeX project, and
`\usepackage`. Optionally remove unused packages from `eclectex`.

### Git-managed projects

Start by adding eclecTeX as a remote repository:

    git remote add eclectex git@github.com:tagae/eclectex.git

You can then pull any branch of the library you need:

    git pull eclectex document-keywords

Each branch automatically includes needed dependencies.

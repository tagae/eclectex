eclecTeX
========

An eclectic family of LaTeX libraries to avoid boilerplate and iron
out old rough edges.


Use
---

### One-shot projects

Copy the `eclectex` directory to your LaTeX project, and
`\usepackage`. Optionally remove unused packages from `eclectex`.

### Git-managed projects

You can add eclecTeX as a plain submodule:

    git submodule add -b base --name eclectex -- ~/Projects/eclectex eclectex
    git ci -m "Added eclecTeX submodule."

and create a `config' branch where you manage the desired configuration:

    cd eclectex
    git checkout -b config

and then pull in all desired submodules into your current configuration:

    git pull origin university-course-notes
    git commit -m "Added university-course-notes."

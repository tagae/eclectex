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

You can import selected parts of the library into your project through
a sparse checkout of submodules.

To start with, enable sparse checkouts in your repository:

    git config core.sparsecheckout true

Add the repository from which you want to fetch the files:

    git remote add eclectex https://github.com/tagae/eclectex.git

Specify the components you want as part of the sparse checkout:

    echo "boilerplate.sty" >> .git/modules/eclectex/info/sparce-checkout

Pull the code (and repeat whenever needed):

    git submodule update

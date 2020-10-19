# Contributing

🤿 Thank you for contributing to Scuba! 🤿

Please note that this project is released with a [Code of Conduct][]. By contributing to this project you agree to abide by its terms.

If you have any questions that aren't addressed in this document, please don't hesitate to open an issue!

## Code Conventions

### Style Guide

- `if` > `and` or `or`
- `test` > `[...]`
- `printf` > `echo`
- Long forms of flags > short forms
  - Exceptions: `set`, `function foo -a`, "common knowledge" options for commands like `rm -R`, `complete`
  - Note that MacOS utils often do not support long flags, in which case one should use the short option
- Piping > command substitution (only when convenient, i.e no extra commands)

### Naming Conventions

Local variables should be named in `camelCase`.

- `set -l nameEscaped`

Anything exposed to the shell or user--functions, global/universal variables, and files--should be named in `snake_case`, beginning with `scuba_`. Prepend an underscore if the user in not meant to interact directly with it.

- `scuba.fish`
- `set -U _scuba_plugins`

#### Specific Naming Conventions

- Subcommands begin with `_scuba_sub_`

## Linting

Code linting is done via [`fish --no-execute`][].

Markdown and Yaml linting is done via the [Super-Linter][] action, which uses [Markdownlint][] and [Yamllint][].

## Formatting

Code formatting is done via [`fish_indent`][].

Markdown and Yaml formatting is done via [Prettier][].

## Documentation Conventions

All links should be in the [reference style][], with references at the bottom of the document in alphabetical order.

## Release

Todo on release:

- [ ] Update version in `scuba.fish`.
- [ ] Create a commit containing above edit, titled with the version number.
- [ ] Create release on github with information from changelog.

[`fish --no-execute`]: https://fishshell.com/docs/current/cmds/fish.html
[`fish_indent`]: https://fishshell.com/docs/current/cmds/fish_indent.html
[code of conduct]: CODE_OF_CONDUCT.md
[markdownlint]: https://github.com/DavidAnson/markdownlint
[prettier]: https://github.com/prettier/prettier
[reference style]: https://www.markdownguide.org/basic-syntax/#reference-style-links
[super-linter]: https://github.com/github/super-linter
[yamllint]: https://github.com/adrienverge/yamllint

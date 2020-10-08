# Scuba [![ci_badge][]][actions] [![fish_version_badge][]][fish] [![license_badge][]][license]

> A plugin manager for the friendly interactive shell.

Manage functions, completions, bindings, and snippets from the command line. Extend your shell capabilities, change the look of your prompt and create repeatable configurations across different systems effortlessly.

- Oh My Fish! plugin support.
- Build and distribute shell scripts in a portable way.
- Zero configuration out of the box.

## Installation

### System requirements

- [Git][]
- [Fish][] ≥ 3.0

#### Bootstrap scuba

```console
curl -L git.io/scuba-install | source && _scuba_sub_install IlanCosman/scuba
```

## Quickstart

You've found an interesting utility you'd like to try out, or maybe you've [created a new plugin][]. How do you install it? How do you update or remove it?

### Installing plugins

Install plugins using the `install` command followed by the path to the repository on GitHub. The shell is restarted after installing plugins, so you can start using them immediately.

```console
scuba install rafaelrinaldi/pure
```

For a specific version of a plugin add an `@` symbol after the plugin name followed by the tag, branch, or commit. Only one plugin version can be installed at any given time.

```console
scuba install patrickf3139/fzf.fish@v4.1
```

You can add plugins from local directories too. Local plugins will be installed using symlinks, so changes to the original files will be reflected in new shell sessions.

```console
scuba install ~/path/to/local/plugin
```

### Listing plugins

List all explicitly installed plugins using the `list` command.

```console
scuba list
rafaelrinaldi/pure
patrickf3139/fzf.fish@v4.1
~/path/to/myfish/plugin
```

### Updating plugins

Update plugins using the `update` command, which checks if the given plugins are out of date and updates them if necessary. If given no arguments, `scuba update` updates all installed plugins, including scuba itself.

```console
scuba update rafaelrinaldi/pure
```

### Removing plugins

Remove plugins using the `remove` command. If a plugin has dependencies, they too will be removed unless required for another plugin.

```console
scuba remove rafaelrinaldi/pure
```

Since scuba is just a plugin, you can uninstall it using `scuba remove IlanCosman/scuba`

## Contributing

From the smallest typo to the largest feature, contributions of any size or experience level are welcome!

If you're interested in helping contribute to Scuba, please take a look at the [Contributing Guide][].

## Acknowledgements

[Fisher][] - Inspired much of Scuba's documentation and design.

[actions]: https://github.com/IlanCosman/scuba/actions
[ci_badge]: https://github.com/IlanCosman/scuba/workflows/CI/badge.svg
[created a new plugin]: docs/plugin_authors.md
[contributing guide]: CONTRIBUTING.md
[fish_version_badge]: https://img.shields.io/badge/fish-3.0.0%2B-blue
[fish]: https://fishshell.com/
[fisher]: https://github.com/jorgebucaran/fisher
[git]: https://git-scm.com/
[license_badge]: https://img.shields.io/github/license/IlanCosman/scuba
[license]: LICENSE.md

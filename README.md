# Scuba [![ci_badge][]][actions] [![fish_version_badge][]][fish] [![license_badge][]][license] [![blazing_badge][]][blazing_tweet]

> 🤿 Scuba - It's how you swim with the [fish][]

Scuba is a minimal plugin manager for the friendly interactive shell.

- Oh My Fish and Fisher plugin support
- Minimal and elegant, following fish design philosophy
- Blazingly fast concurrent plugin downloads
- 100% pure fish; easy to contribute to or modify

## Bootstrap Scuba

```console
curl -sL https://git.io/scuba-install | source && _scuba_sub_install ilancosman/scuba
```

## Quickstart

### Installing plugins

The `install` command installs plugins from their repository paths on GitHub.

```console
scuba install patrickf3139/fzf.fish
```

To get a specific version of a plugin add an `@` symbol after the plugin name followed by a tag, branch, or commit.

```console
scuba install jorgebucaran/nvm.fish@1.1.0
```

You can install plugins from local directories too.

```console
scuba install ~/path/to/plugin
```

### Listing plugins

The `list` command lists installed plugins.

```console
$ scuba list
ilancosman/scuba
patrickf3139/fzf.fish
jorgebucaran/nvm.fish@1.1.0
/home/ilan/path/to/plugin
```

> `ilancosman/scuba` is listed because you installed it to start with!

`list` also accepts a regular expression to filter the output.

```console
$ scuba list '^/'
/home/ilan/path/to/plugin
```

### Updating plugins

The `update` command updates installed plugins. `update` by itself will update all installed plugins, including Scuba.

```console
scuba update
```

### Removing plugins

The `remove` command removes installed plugins.

```console
scuba remove patrickf3139/fzf.fish
```

Since Scuba is just like any other plugin, you can uninstall it using `scuba remove ilancosman/scuba`.

## Contributing

From the smallest typo to the largest feature, contributions of any size or experience level are welcome!

If you're interested in helping contribute to Scuba, please take a look at the [Contributing Guide][].

## Comparison with Fisher

Scuba is highly inspired by [Fisher][] and operates similarly. What are the advantages and disadvantages? What's simply different?

**TLDR:** Scuba is similar to the [proposed fisher 4.0][] but faster, simpler, better maintained, and more in line with fish design philosophy. Unlike Fisher, Scuba does not support file-based configuration or dependencies.

### Advantages

- Faster - Since Scuba is pure fish, it is significantly faster than Fisher. However, both are quick in absolute terms.

- Simpler - Scuba is less than half of Fisher's SLOC. Scuba is pure fish while Fisher is roughly 15% awk and sed. Scuba has an organized file structure while Fisher puts all of its many functions in one file.

- Better maintained - Fisher has had a little over 30 commits in the last year and a half. Multiple issues have sat for a year or longer without resolution. Fisher 4.0, meant to fix these issues, was proposed on Jul 31 2020. However, the maintainer says that he can probably begin work sometime in 2021, half a year later. Scuba was created with the express intention of being better maintained and already solves all of Fisher's longstanding issues.

- More elegant - Scuba follows fish's [design philosophy][].
  - **The law of orthogonality** - Scuba does more with less. It has no need for `self-update` or `self-uninstall` commands like Fisher. Instead, Scuba is merely another Scuba plugin, bootstrapping itself.
  - **The law of responsiveness** - Scuba downloads plugins concurrently so as to use as little time as possible.
  - **Configurability is the root of all evil** - Scuba offers no configuration of any kind. Fisher allows users to manage their plugins using files or from the CLI, and also to choose their installation path.
  - **The law of discoverability** - Scuba, unlike Fisher, uses the same commands as nearly all package managers, making it immediately familiar to most users.

### Disadvantages

- Scuba does not support dependencies. While this might initially seem like a major flaw, the empirical evidence suggests otherwise. None of the 24 premier plugins/prompts listed on [awesome.fish] have dependencies. Nevertheless, this can be counted as a minor disadvantage.

### Differences

- Commands vs. File-based configuration - Scuba does not offer two seperate approaches for managing plugins. Instead, everything is done via commands.

- Cache fallback - Fisher offers a cache fallback for installed plugins. However, caching doesn't make much sense when downloading and installing a plugin takes under a second. Caching requires that Fisher create permenant directories on your machine. It has also been the source of multiple bugs.

## Acknowledgements

- [Fisher][] - Inspired much of Scuba's documentation and design.

[actions]: https://github.com/IlanCosman/scuba/actions
[awesome.fish]: https://github.com/jorgebucaran/awesome.fish
[blazing_badge]: https://img.shields.io/badge/speed-blazing%20%F0%9F%94%A5-red
[blazing_tweet]: https://twitter.com/acdlite/status/974390255393505280
[ci_badge]: https://github.com/IlanCosman/scuba/workflows/CI/badge.svg
[contributing guide]: CONTRIBUTING.md
[created a new one]: docs/creating_plugins.md
[design philosophy]: https://fishshell.com/docs/current/design.html
[fish_version_badge]: https://img.shields.io/badge/fish-3.0.0%2B-blue
[fish]: https://fishshell.com/
[fisher]: https://github.com/jorgebucaran/fisher
[license_badge]: https://img.shields.io/github/license/IlanCosman/scuba
[license]: LICENSE.md
[proposed fisher 4.0]: https://github.com/jorgebucaran/fisher/issues/582

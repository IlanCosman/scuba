# Scuba [![ci_badge][]][actions] [![fish_version_badge][]][fish] [![license_badge][]][license] [![blazing_badge][]][blazing_tweet]

> 🤿 Scuba - It's how you swim with the [fish][]

Scuba is a minimal plugin manager for the friendly interactive shell. Extend your shell's capabilities, change the look of your prompt, and create repeatable configurations across systems.

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

Install plugins using the `install` command followed by the path to the repository on GitHub.

```console
scuba install rafaelrinaldi/pure
```

For a specific version of a plugin add an `@` symbol after the plugin name followed by the tag, branch, or commit.

```console
scuba install patrickf3139/fzf.fish@v4.1
```

You can install plugins from local directories too.

```console
scuba install ~/path/to/my/fish/plugin
```

### Listing plugins

List installed plugins using the `list` command.

```console
scuba list
ilancosman/scuba
rafaelrinaldi/pure
patrickf3139/fzf.fish@v4.1
/home/ilan/path/to/my/fish/plugin
```

> `ilancosman/scuba` is listed because you installed it to start with!

You can use a regular expression after `list` to refine the output.

```console
scuba list '^/'
/home/ilan/path/to/my/fish/plugin
```

### Updating plugins

Update plugins using the `update` command. `update` by itself will update all installed plugins, including Scuba itself.

```console
scuba update
```

### Removing plugins

Remove plugins using the `remove` command.

```console
scuba remove rafaelrinaldi/pure
```

Since Scuba is just like any other plugin, you can uninstall it using `scuba remove ilancosman/scuba`.

## Contributing

From the smallest typo to the largest feature, contributions of any size or experience level are welcome!

If you're interested in helping contribute to Scuba, please take a look at the [Contributing Guide][].

## Comparison with Fisher

Scuba is highly inspired by [Fisher][], and operates similarly. What are the differences? What are the advantages and disadvantages?

**TLDR:** Scuba is essentially [fisher 4.0][] but faster, simpler, better maintained, and in line with Fish design philosophy. Unlike Fisher, Scuba does not support file-based configuration or dependencies.

### Differences

- Commands vs. File-based configuration - Scuba does not offer two approaches for managing plugins. Instead, everything is done via commands.

### Advantages

- Simple - Scuba is less than half of Fisher's SLOC, and pure fish. Fisher is roughly 20% awk and sed, raising the difficulty of contributing. Fisher also puts all of its many functions in one file, making it more difficult to modify if the need arises.
- Fast - Since Scuba is pure fish, it is significantly faster than Fisher. However, both are quick in absolute terms.
- Elegant - Scuba follows fish's [design philosophy][].
  - **The law of orthogonality** - Scuba does more with less. It has no need for `self-update` or `self-uninstall` commands like Fisher. Instead, Scuba is merely another Scuba plugin, bootstrapping itself.
  - **The law of responsiveness** - Scuba downloads plugins concurrently so as to take up as little user time as possible.
  - **Configurability is the root of all evil** - Scuba offers no configuration of any kind. Fisher allows users to manage their plugins using files or from the CLI.
  - **The law of discoverability** - Scuba, unlike Fisher, uses the same commands as nearly all package managers, making it immediately familiar to most users.

### Disadvantages

- Scuba does not support dependencies. While this might initially seem like a major flaw, the empirical evidence suggests otherwise. None of the 24 premier plugins/prompts listed on [awesome.fish] have dependencies. Nevertheless, this can be counted as a minor disadvantage.

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
[fisher 4.0]: https://github.com/jorgebucaran/fisher/issues/582
[fisher]: https://github.com/jorgebucaran/fisher
[license_badge]: https://img.shields.io/github/license/IlanCosman/scuba
[license]: LICENSE.md

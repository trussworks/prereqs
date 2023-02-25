[![pre-commit.ci status](https://results.pre-commit.ci/badge/github/trussworks/prereqs/main.svg)](https://results.pre-commit.ci/latest/github/trussworks/prereqs/main)

# prereqs

A tool to check your project prerequisites so your engineers don't have to.

## Build Status

[![CircleCI](https://circleci.com/gh/trussworks/prereqs.svg?style=shield)](https://circleci.com/gh/trussworks/prereqs)

## Why

While it's best practice to have project dependencies contained within the project (via `bundler`, `npm`, or similar tools), it is very common to have bootstrap prerequisites that need to be installed on the system outside of the project's normal build process. For example, you need to have npm installed before you can use it.

`prereqs` can help new engineers working with your project make sure they have everything they need instead of reading through a README in order to make things work. It can also help when you need to add a prerequisite to an existing project; you can have `prereqs` run as part of your build to quickly error out and notify the engineer that they are missing something instead of wading through mysterious build errors.

Note that `prereqs` explicitly does not attempt to modify the project environment; projects shouldn't attempt to change things outside of their direct control. In enterprise environments, this is solved with system management software; for more ad hoc projects, this is best solved with development containers or tools like vagrant. `prereqs` is just here to let the project check and fail quickly if the containing environment is broken.

## Usage and setup

``` shell
cd project
curl -O https://raw.githubusercontent.com/trussworks/prereqs/latest/prereqs
# edit prereqs.conf, add your prerequisites. See prereqs.conf section.
./prereqs -c ./prereqs.conf # Put this early in your build.
```

You should have as few things in prereqs.conf as you can; good items include things like your language package managers, database tools, Docker binaries, and anything else that's a foundation of your build that isn't already included with your operating system by default. As much as you can, prefer to install tools local to your project; for example, eslint would be better handled by your `package.json` than `prereqs`.

You can tell `prereqs` to update itself to latest release by running `prereqs -u`.

You can also put your prereqs into your README.md, as shown below, and use `./prereqs -r README.md` instead of having a configuration file. The parser for this is currently pretty fragile.

## Prerequisites

- pre-commit
- shfmt
- shellcheck

## prereqs.conf

An example prereqs.conf for a small go project:

    has dep
    has pre-commit
    has gometalinter

`prereqs` only tests for a tools existence in the PATH (or as a shell function); it doesn't try to check versions. If you want that you should consider installing your tool as part of your project.

## Thanks

[Kate Ward](mailto:kate.ward@forestent.com) for [shunit2](<https://github.com/kward/shunit2>)

## License

prereqs is licensed under the BSD 3-Clause License, as described in LICENSE.

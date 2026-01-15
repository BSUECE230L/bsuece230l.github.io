# Introduction

This is the class website & associated software for BSU's ECE 230 Lab. This site uses AsciiDoc to
generate HTML for the pages in the class, along with Plantuml to render some diagarams, and Draw.io
for all manual diagrams.

## Generating Class Material

Everything under the `docs/` folder is auto-generated and should _never_ be edited. If you want to
make a change to the deployed class, you must first re-generate the HTML. This is done using
AsciiDoctor, with the required plugins, to parse the AsciiDoc into HTML.

### Pre-requisites

This, in theory could work on Windows. However, setting it up would be significantly more difficult.
Therefore, use either Linux or WSL2.

Then, you need to install Ruby's Bundler. See distrobution documentation for specifics, but here's a
few examples:

Fedora: `sudo dnf install rubygem-bundler`

Ubuntu: `sudo apt install ruby ruby-dev && sudo gem install bundler`

Then, install the bundle included with the repo: `sh ./bundle.sh`

### Building the class material

There is a helper script to build the class materials. Simply run: `python3 build.py d`

This will:

1. Download all material repositories, archive, and .zip each
1. Generate all HTML from AsciiDoc
1. Generate .svg from all PlantUML diagrams

From there, simply `git add . && git commit` and push your changes. The documentation website will
update itself within one or two minutes with Github Pages.

## More Information

### Build Script

The python build script recursively generates all the HTML from the various AsciiDoc documents.
Anything called `file.adoc` will get converted into `file.html` within the `docs/` folder. Each run
of the script will completely delete the docs folder, then re-generate all HTML.

There is one parameter to the script, wheter or not to download the class material. Please remember
to include it by running:

```sh
python3 build.py d
```

There is one additional note: any file named `slides.adoc` will be converted to HTML using the
RevealJS extension, turning it into a slide show.

### Material Repositories

Each lab has associated class materials. These are all in private repositories within this
organization. To view each, and which lab it is associated with, simply go into
`classes/<lab>/class.json` and it will show which repo is associated with that lab.

This repo is cloned, then archived, then .zip compressed and used as static site content. This is
what provides the students with the simulation, constraints, and any other starter material they
need.

Those repos also serve as answers distribution for TAs. Make sure they stay private and you only
publish answers to some feature branch and never `main` or `master. The default branch of each repo
will be provided as the class materials.

### PlantUML

PlantUML converts textual representations into actual diagrams. It is used in several places in the
labs, especially for timing/waveform diagrams. Ruby's Bundler will automatically download all you
need to convert these. Any time you see:

`[plantuml]`

above a code block in AsciiDoc, it is describing a PlantUML diagram. This diagram will be rendered
locally, then embedded as an SVG.

See [PlantUML](https://plantuml.com/) for all documentation.

### Draw.io

Draw.io is a popular free diagram drawing tool. All manually drawn diagrams are done in Draw.io. You
can open any of them in the tool, since it saves the diagram data in the image file. Anything that
is `file.drawio.png` or `file.drawio.svg` can be opened and edited in Draw.io

import pathlib
import subprocess
import shutil

REVEAL_JS = "bundle exec asciidoctor-revealjs \
  -a revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@4.1.2"

HTML5 = "asciidoctor"

OUTPUT_PATH = pathlib.Path("output/")

def process_slides(input: pathlib.Path):
    output = OUTPUT_PATH / input.with_suffix(".html")
    ret = subprocess.getoutput(REVEAL_JS + f" {input} -o {output}", encoding="utf8")
    print(ret)

def process_lab(input: pathlib.Path):
    output = OUTPUT_PATH / input.with_suffix(".html")
    ret = subprocess.getoutput(HTML5 + f" {input} -o {output}", encoding="utf8")
    print(ret)

def copy_images(index_file: pathlib.Path):
    images_dir = index_file.parent / pathlib.Path("img")
    if images_dir.exists():
        output = OUTPUT_PATH / images_dir
        shutil.copytree(str(images_dir), str(output))

def main():
    input_sources = list(pathlib.Path("./").glob("**/*.adoc"))
    filtered_sources = [x for x in input_sources if not x.parts[0].startswith(".")]

    shutil.rmtree(str(OUTPUT_PATH))
    OUTPUT_PATH.mkdir()
    
    for src in filtered_sources:
        if src.parts[-1].startswith("slides"):
            process_slides(src)
        elif src.parts[-1] == "index.adoc":
            process_lab(src)
            copy_images(src)


if __name__ == "__main__":
    main()
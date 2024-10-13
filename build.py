import pathlib
import subprocess
import shutil
import json
import uuid

if shutil.which("asciidoctor-revealjs"):
    REVEAL_JS = "asciidoctor-revealjs"
else:
    REVEAL_JS = "bundle exec asciidoctor-revealjs"

REVEAL_JS += " -r asciidoctor-diagram -a revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@4.1.2"

HTML5 = "asciidoctor -r asciidoctor-diagram"

OUTPUT_PATH = pathlib.Path("docs/")
CLONE_PATH = pathlib.Path("repos/")

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

def download_class(index_file: pathlib.Path):
    class_json = index_file.parent / "class.json"
    if class_json.exists():
        deser_class = json.loads(class_json.read_text(encoding="UTF-8"))
        gh_repo = deser_class["repo"]
        clone_target = CLONE_PATH / str(uuid.uuid4())
        archive_target =  OUTPUT_PATH / index_file.parent / "class.zip"
        subprocess.getoutput(f"git clone {gh_repo} {clone_target}")
        subprocess.getoutput(f"cd {clone_target}; git archive -o {archive_target.absolute()} HEAD")


def main():
    input_sources = list(pathlib.Path("./").glob("**/*.adoc"))
    filtered_sources = [x for x in input_sources if not x.parts[0].startswith(".")]

    if OUTPUT_PATH.exists():
        shutil.rmtree(str(OUTPUT_PATH))

    if CLONE_PATH.exists():
        shutil.rmtree(str(CLONE_PATH))

    OUTPUT_PATH.mkdir()
    CLONE_PATH.mkdir()
    
    for src in filtered_sources:
        if src.parts[-1].startswith("slides"):
            process_slides(src)
        elif src.parts[-1] == "index.adoc":
            process_lab(src)
            copy_images(src)
            download_class(src)
    
    shutil.rmtree(str(CLONE_PATH))


if __name__ == "__main__":
    main()
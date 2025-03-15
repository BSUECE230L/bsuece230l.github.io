import pathlib
import subprocess
import shutil
import json
import uuid
import sys
import hashlib
import time

REVEAL_JS = "bundle exec asciidoctor-revealjs -r asciidoctor-diagram -a revealjsdir=https://cdn.jsdelivr.net/npm/reveal.js@4.1.2"
HTML5 = "bundle exec asciidoctor -r asciidoctor-diagram"

OUTPUT_PATH = pathlib.Path("docs/")
CLONE_PATH = pathlib.Path("repos/")

def process_slides(input: pathlib.Path):
    output = OUTPUT_PATH / input.with_suffix(".html")
    ret = subprocess.getoutput(REVEAL_JS + f" {input} -o {output}", encoding="utf8")
    print(ret)

def process_lab(input: pathlib.Path):
    if (input.parts.count("src") > 0):
        return
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

def calc_hash(file: pathlib.Path):
    with file.open("rb") as f:
        return hashlib.sha256(f.read()).hexdigest()

def watch_slides(slide_path):
    path = pathlib.Path(slide_path)
    last_hash = None
    while True:
        current_hash = calc_hash(path)
        if (last_hash != current_hash):
            last_hash = current_hash
            if OUTPUT_PATH.exists():
                shutil.rmtree(str(OUTPUT_PATH))
            OUTPUT_PATH.mkdir()
            copy_images(path)
            process_slides(path)
        time.sleep(1)

def watch_doc(doc_path):
    pass

def main():
    input_sources = list(pathlib.Path("./").glob("**/*.adoc"))
    filtered_sources = [x for x in input_sources if not x.parts[0].startswith(".")]

    if OUTPUT_PATH.exists():
        shutil.rmtree(str(OUTPUT_PATH))

    if CLONE_PATH.exists():
        shutil.rmtree(str(CLONE_PATH))

    OUTPUT_PATH.mkdir()
    CLONE_PATH.mkdir()

    do_dl = sys.argv[1] == "d" if len(sys.argv) >= 2 else False
    do_watch = sys.argv[1][0] == 'w' if len(sys.argv) >= 3 else False

    if (do_watch):
        if sys.argv[1] == "ws":
            watch_slides(sys.argv[2])
        elif sys.argv[1] == "ws":
            watch_doc(sys.argv[2])
    
    for src in filtered_sources:
        if src.parts[-1].startswith("slides"):
            process_slides(src)
        elif src.parts[-1] == "index.adoc":
            process_lab(src)
            copy_images(src)
            if (do_dl):
                download_class(src)
        else:
            process_lab(src)
    
    shutil.rmtree(str(CLONE_PATH))


if __name__ == "__main__":
    main()

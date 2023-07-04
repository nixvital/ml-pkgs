{ writers, python3Packages }:

let template = ./default.nix.tmpl;

    registry = builtins.toJSON({
      # Special category. All packages here will be ignored. This means that
      # even if they are unclassified, there will be no report for that.
      "ignored" = {
        python = {};
      };

      # Mandatory packages. Missing one of them would raise exception.
      "core" = {
        pydantic = {};
        sqlalchemy = { pypi = "SQLAlchemy"; };
        requests = {};
        pyyaml = { pypi = "PyYAML"; };
        numpy = {};
        openapi-schema-pydantic = {};
        dataclasses-json = {};
        tenacity = {};
        aiohttp = {};
        async-timeout = {};
        numexpr = {};
        langchainplus-sdk = {};
      };

      # Special category. All packages here will be considered mandatory for nix
      # package "langchain" build even if they are marked as optional in
      # langchain's pyproject.toml.
      "core-utils" = {
        tqdm = {};
        requests-toolbelt = {};
        nltk = {};
        beautifulsoup4 = {};
        jinja2 = {};
        faiss = { pypi = "faiss-cpu"; cuda = false; };
        openai = {};
        html2text = {};
        pexpect = {};
        jq = {};
        lxml = {};
        pandas = {};
        chardet = {};
      };

      # ---------- Optional Packages ----------

      "models" = {
        huggingface-hub = { pypi = "huggingface_hub"; };
        transformers = {};
        pytorch = { pypi = "torch"; };
        tiktoken = {};
        sentence-transformers = {};
        tensorflow-text = { unpackaged = true; };
        scikit-learn = {};
      };

      "model-apis" = {
        anthropic = {};
        steamship = {};
        cohere = {};
        manifest-ml = {};
        nomic = { unpackaged = true; };
        jina = { unpackaged = true; };
        openlm = { unpackaged = true; };
        clarifai = { unpackaged = true; };
        openllm = { unpackaged = true; };
      };

      "utils" = {
        spacy = {};
        gptcache = {};
        lark = {};
        networkx = {};
        pytesseract = {};  # OCR
        gql = {};
        bibtexparser = {};
        google-auth = {};
        langkit = { unpackaged = true; };
        pyspark = {};
        esprima = {};  # Parser of ECMAScript
        streamlit = {};
      };

      # ---------- Optional API Packages ----------

      "search" = {
        google-api-python-client = {};
        google-search-results = { unpackaged = true; };
        duckduckgo-search = {};
        opensearch-py = {};
      };

      "aws" = {
        boto3 = {};
      };

      "db" = {
        redis = {};
        pymongo = {};  # MongoDB
        psycopg2 = { pypi = "psycopg2-binary"; };  # PosgreSQL
        clickhouse-connect = { unpackaged = true; };
        docarray = { unpackaged = true; };
        neo4j = {};
        momento = { unpackaged = true; };
        singlestoredb = { unpackaged = true; };
        tigrisdb = { unpackaged = true; };
        nebula3-python = { unpackaged = true; };
      };

      "azure" = {
        azure-core = {};
        azure-identity = {};
        azure-cosmos = {};
        azure-ai-formrecognizer = { unpackaged = true; };
        azure-ai-vision = { unpackaged = true; };
        azure-cognitiveservices-speech = { unpackaged = true; };
        azure-search-documents = { unpackaged = true; };
      };

      "pdf" = {
        pypdf = {};
        pdfminer-six = {};
        pymupdf = {};
        pypdfium2 = { unpackaged = true; };
      };

      "vector-store-apis" = {
        pinecone-client = {};
        pinecone-text = { unpackaged = true; };
        weaviate-client = {};
        qdrant-client = {};
        pgvector = { unpackaged = true; };
        lancedb = { unpackaged = true; };
        pyvespa = { unpackaged = true; };
        zep-python = { unpackaged = true; };
        awadb = { unpackaged = true; };
      };

      "extended-apis" = {
        elasticsearch = {};
        wolframalpha = {};
        pyowm = {};  # OpenWeatherMap
        telethon = {};  # Telegram
        wikipedia = { unpackaged = true; };
        nlpcloud = {};
        octoai-sdk = { unpackaged = true; };
        arxiv= { unpackaged = true; };
        aleph-alpha-client = { unpackaged = true; };
        deeplake = { unpackaged = true; };
        atlassian-python-api = {};
        O365 = { unpackaged = true; };
        py-trello = { unpackaged = true; };
        psychicapi = { unpackaged = true; };
        cassio = { unpackaged = true; };  # Riot Game
      };

    });

in writers.writePython3Bin "extract" {
  libraries = with python3Packages; [
    click
    tomli
    jinja2
  ];
} ''
from typing import List
import json
from pathlib import Path
import click
import tomli
from jinja2 import Environment, FileSystemLoader


# This is to applease the linter which does not like 80+ characters.
RAW = """
${registry}
"""
REGISTRY = json.loads(RAW)
TMPL_PATH = Path("""
${template}
""".strip())


class Registry(object):
    def __init__(self):
        self._entries = {}
        for category, packages in REGISTRY.items():
            for package_name, properties in packages.items():
                pypi_name = properties.get("pypi", None) or package_name
                assert pypi_name not in self._entries, (
                    f"Duplicate '{pypi_name}'")
                self._entries[pypi_name] = {**properties,
                                            "category": category,
                                            "nix": package_name}

    def find_package(self, pypi_name: str):
        return self._entries.get(pypi_name, None)


class Collector(object):
    def __init__(self):
        self.core = []
        self.core_utils = []
        self.classified = {}
        self.unclassified = []

    def collect(self, category: str, package):
        if category == "core":
            self.core.append(package)
        elif category == "unclassified":
            self.unclassified.append(package)
        elif category == "core-utils":
            self.core_utils.append(package)
        else:
            if category not in self.classified:
                self.classified[category] = []
            self.classified[category].append(package)

    def format(self, packages: List[dict]) -> List[str]:
        result = []
        for p in packages:
            if p.get("unpackaged", False):
                continue
            if not p.get("cuda", True):
                result.append(f"({p['nix']}.override "
                              "{ cudaSupport = false; })")
            else:
                result.append(p["nix"])
        return result

    def format_inputs(self):
        result = []
        result.extend([
            p["nix"] for p in self.core if not p.get("unpackaged", False)])
        result.extend([
            p["nix"] for p in self.core_utils
            if not p.get("unpackaged", False)])
        for x in self.classified.values():
            result.extend([
                p["nix"] for p in x if not p.get("unpackaged", False)])
        return result

    def format_core(self):
        return self.format(self.core)

    def format_core_utils(self):
        return self.format(self.core_utils)

    def format_categories(self):
        result = []
        for k, v in self.classified.items():
            result.append({"name": k, "items": self.format(v)})
        return result

    def print_unclassified(self):
        print("-------------------- WARNING --------------------")
        print("The following packages are not classified.")
        print("They should be added to registry in extract-langchain-deps.nix")
        for pypi_name in self.unclassified:
            print(pypi_name)


@click.command()
@click.argument("path", type=click.Path(exists=True))  # pyproject.toml
def main(path):
    with open(path, "rb") as f:
        data = tomli.load(f)
    deps = data["tool"]["poetry"]["dependencies"]
    registry = Registry()
    collector = Collector()
    for pypi_name, spec in deps.items():
        package = registry.find_package(pypi_name)
        if package is not None and package["category"] == "ignored":
            continue

        if isinstance(spec, str) or not spec.get("optional", False):
            assert package is not None, (
                f"Mandatory package '{pypi_name}' not found!")
            collector.collect("core", package)
            continue

        if package is None:
            collector.collect("unclassified", pypi_name)
            continue

        if package["category"] == "core-utils":
            collector.collect("core-utils", package)
            continue

        collector.collect(package["category"], package)

    # Now, it's time to generate default.nix
    version = data["tool"]["poetry"]["version"]
    env = Environment(loader=FileSystemLoader(TMPL_PATH.parent))
    template = env.get_template(TMPL_PATH.name)
    nix_content = template.render(
        version=version,
        inputs=collector.format_inputs(),
        core=collector.format_core(),
        core_utils=collector.format_core_utils(),
        categories=collector.format_categories())

    print(nix_content)

    if len(collector.unclassified) > 0:
        collector.print_unclassified()


if __name__ == "__main__":
    main()
''

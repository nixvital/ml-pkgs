import tomllib
import click
from jinja2 import Template


NIX_TEMPLATE = r"""
{ lib
, buildPythonpackage
, fetchFromGitHub
{%- for arg in func_args %}
, {{ arg -}}
{% endfor %}
}:

let
  pname = "{{ pname }}";
  version = "{{ version }}";

in buildPythonPackage {
  inherit pname version;

  src = fetchFromGitHub {
    owner = "stanfordnlp";
    repo = "dspy";
    rev = version;
    hash = null;
  };

  build-system = [
    {%- for item in build_system %}
    {{ item -}}
    {% endfor %}
  ];

  dependencies = [
    {%- for dep in dependencies %}
    {{ dep -}}
    {% endfor %}
  ];

  pythonImportsCheck = [ "{{ pname }}" ];

  meta = with lib; {
    homepage = "{{ homepage }}";
    description = "{{ description }}";
    license = ?;
    maintainers = with maintainers; [ breakds ];
  };
}

"""


NIX_PKG_NAME_MAPPING = {
    "IPython": "ipython",
    "opencv-python": "opencv4",
}


@click.command
@click.argument("uri")
def main(uri: str):
    """Generate a default.nix file from a pyproject.toml file.

    """
    # TODO: Currently this only handles local path. Should make it work even if
    # the input is an URL
    try:
        with open(uri, "rb") as f:
            data = tomllib.load(f)
    except Exception as e:
        click.echo(f"Error reading from {uri}: {e}")

    project = data.get("project") or data.get("tool", {}).get("poetry")

    nix_func_args = set()

    # ┌─────────────────────────────────────────┐
    # │ Figure out the build-system             │
    # └─────────────────────────────────────────┘

    build_backend = data.get("build-system").get("build-backend")
    build_system = {
        "setuptools.build_meta": ["setuptools"],
        "pdm.backend": ["pdm-backend"]
    }[build_backend]

    for item in build_system:
        nix_func_args.add(item)

    # ┌─────────────────────────────────────────┐
    # │ Figure out the dependencies             │
    # └─────────────────────────────────────────┘

    dependencies = list(map(lambda x: NIX_PKG_NAME_MAPPING.get(x, x),
                            project.get("dependencies", [])))

    for item in dependencies:
        nix_func_args.add(item)

    # ┌─────────────────────────────────────────┐
    # │ Identify the homepage                   │
    # └─────────────────────────────────────────┘

    if "urls" in project:
        homepage = project.get("urls").get("Homepage", "?")
    else:
        homepage = "?"

    # ┌─────────────────────────────────────────┐
    # │ Generate nix file based on the template │
    # └─────────────────────────────────────────┘

    template = Template(NIX_TEMPLATE)
    nix_file_content = template.render(
        pname=project.get("name", "<BLANK>"),
        version=project.get("version", "<BLANK>"),
        description=project.get("description", ""),
        dependencies=dependencies,
        build_system=build_system,
        func_args=list(nix_func_args),
        homepage=homepage)

    print(nix_file_content)


if __name__ == "__main__":
    main()

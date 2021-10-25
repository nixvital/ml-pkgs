# The sha256 in this file can be fetched by calling
#
# nix-prefetch-url <URL>

{ version, isPy37, isPy38, isPy39, isPy310 }:

let urls = {
      "1.10.10" = {
        py37 = {
          url = https://files.pythonhosted.org/packages/06/39/2b26af1140e46f95f745378ab92bd15ea8c496ef28556b6f7b6caba34f76/panda3d-1.10.10-cp37-cp37m-manylinux1_x86_64.whl;
          sha256 = "1g7j5c1868y3nm8062w2968hjhy5pdkm6p3lpd06ji56w8795k5c";
        };

        py38 = {
          url = https://files.pythonhosted.org/packages/64/5d/6bc0cad9778637833caf66493f682f8f42e3ed011f8b8352f40a59520b69/panda3d-1.10.10-cp38-cp38-manylinux1_x86_64.whl;
          sha256 = "0krhb3jmyv5l0rf77dwy22327p5r0zxjpqi0aagz17kznh1386zs";
        };

        py39 = {
          url = https://files.pythonhosted.org/packages/3f/20/87b34580f6bfc414cd8b7b874a18e32da939ed102e48cf6e33c170edcd2c/panda3d-1.10.10-cp39-cp39-manylinux1_x86_64.whl;
          sha256 = "0w5q1yddb300r9vij3k9mmxr874vjfmz9ca0b2mrk5sgjh14a8mq";
        };

        py310 = {
          url = https://files.pythonhosted.org/packages/24/a0/37e8853140428130b2e9d1a8dd51144c7812e4a22d259151fbc67e70343b/panda3d-1.10.10-cp310-cp310-manylinux2010_x86_64.whl;
          sha256 = "1y1vxbqmp9ql8mnf6nj83cknqsrs85gqx59krwicffaiv0ialqgv";
        };
      };
    };
in (if isPy37 then urls."${version}".py37
    else if isPy38 then urls."${version}".py38
    else if isPy39 then urls."${version}".py39
    else urls."${version}".py310)

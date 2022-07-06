{ lib
, buildPythonPackage
, fetchFromGitHub
}:

buildPythonPackage rec {
  pname = "gym-notices";
  version = "2022.06.04";

  src = fetchFromGitHub {
    owner = "Farama-Foundation";
    repo = pname;
    rev = "273b132bfe3edd07cfea7c4bbbb9d992cfd3751f";
    sha256 = "sha256-qcoS2Y4PXT4p8DizpVCxu6QdsFJ1NBDzxybM9bviNRM=";
  };

  meta = with lib; {
    description = ''
       Notices for Gym that may be displayed on import on internet
       connected systems, in order to give notices if versions have
       major reproducibility issues, are very old and need to be
       upgraded (e.g. there's been issues with researchers using 4
       year old versions of Gym for no reason), or other similar
       issues
    '';
    homepage = "https://github.com/Farama-Foundation/gym-notices";
    license = licenses.mit;
    maintainers = with maintainers; [ breakds ];
  };
}

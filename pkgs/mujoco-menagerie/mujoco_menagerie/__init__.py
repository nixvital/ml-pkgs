from typing import Dict, List, Optional
from pathlib import Path
import subprocess
import pkgutil


class RobotModel(object):
    def __init__(self, make: str, model: str) -> None:
        self._make = make
        self._model = model        
        self._name = f"{self._make}_{self._model}"
        loader = pkgutil.get_loader(__name__)
        self._path = Path(loader.get_filename()).parent / self._name

    @property
    def name(self) -> str:
        return self._name

    @property
    def path(self) -> Path:
        return self._path

    @property
    def make(self) -> str:
        return self._make

    @property
    def model(self) -> str:
        return self._model

    def list_files(self):
        # TODO(breakds): Use lsd if exists
        subprocess.run(["ls", self._path])


# The registry holds the actual RobotModels with a mapping from their
# name to the robot model.
_REGISTRY: Dict[str, RobotModel] = {}


def _register(model: RobotModel) -> None:
    _REGISTRY[model.name] = model


def query(make: str, model: str) -> Optional[RobotModel]:
    name = f"{make}_{model}"
    return _REGISTRY.get(name, None)


def query_by_make(make: str) -> List[str]:
    result = []
    for robot in _REGISTRY.values():
        if robot.make == make:
            result.append(robot)
    return result


def list_robots() -> List[RobotModel]:
    return list(_REGISTRY.values())


_register(RobotModel(make="anybotics", model="anymal_b"))
_register(RobotModel(make="anybotics", model="anymal_c"))
_register(RobotModel(make="agility", model="cassie"))
_register(RobotModel(make="unitree", model="a1"))
_register(RobotModel(make="franka_emika", model="panda"))
_register(RobotModel(make="universal_robots", model="ur5e"))

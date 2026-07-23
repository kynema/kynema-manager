from spack.package import *
from spack_repo.builtin.packages.openfast.package import Openfast as bOpenfast
from spack_repo.kynema.packages.ctest_package.package import *
find_machine = importlib.import_module("find-kynema-manager")

class Openfast(bOpenfast):
    # For some reason CMake ABI checking fails unless we have a direct dependency
    # on libfabric here for Kestrel
    machine_name, _ = find_machine.get_current_machine()
    if machine_name == "kestrel-cpu" or machine_name == "kestrel-gpu":
        depends_on("libfabric")

from spack.package import *
from spack_repo.builtin.packages.hypre.package import Hypre as bHypre
from spack_repo.hypre.packages.ctest_package.package import *

class Hypre(bHypre, CtestPackage):
    variant("asan", default=False, description="Turn on address sanitizer")

    def setup_build_environment(self, env):
        spec = self.spec
        super().setup_build_environment(env)
        if spec.satisfies("+asan"):
            env.append_flags("CXXFLAGS", "-fsanitize=address -fno-omit-frame-pointer")
            env.set("LSAN_OPTIONS", "suppressions={0}".format(join_path(self.package_dir, "sup.asan")))

    def cmake_args(self):
        spec = self.spec
        cmake_options = super(Hypre, self).cmake_args()

        if spec.satisfies("dev_path=*"):
            cmake_options.append(self.define("CMAKE_EXPORT_COMPILE_COMMANDS", True))

        return cmake_options

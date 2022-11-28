{self, mkYarnPackage}: 
mkYarnPackage {
  name = "hello-app";
  src = self;
  packageJson = self + "/package.json";
  yarnLock = self + "/yarn.lock";
}

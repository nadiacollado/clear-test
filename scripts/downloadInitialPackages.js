const { installPackages } = require("./utils");

const downloadInitialPackages = () => {
  let packages = [];
  let devPackages = [];

  packages.push("widgetbook");
  // Riverpod dependencies
  packages.push(...["flutter_riverpod", "riverpod_annotation", "build_runner"]);
  // Riverpod dev dependencies 
  devPackages.push(...["riverpod_generator", "custom_lint", "riverpod_lint"]);

  
  installPackages(packages);
  installPackages(devPackages, true);
};

module.exports = { downloadInitialPackages };

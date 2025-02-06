const { execSync } = require("child_process");
const fs = require("fs");

const installCurrentPackages = () => {
   execSync('flutter pub get');
};

const installPackages = (packageList, isDev = false) => {
 if (packageList.length > 0) {
    const flag = isDev ? "--dev" : "";
    console.log(`Installing ${isDev ? "dev " : ""}dependencies: ${packageList.join(", ")}`);
    
    execSync(`flutter pub add ${flag} ${packageList.join(" ")}`, { stdio: "inherit" });
  }
};

const updateFile = (filePath, regex, replacement, fileDesc) => {
  if (fs.existsSync(filePath)) {
    let fileContent = fs.readFileSync(filePath, "utf8");
    fileContent = fileContent.replace(regex, replacement);
    fs.writeFileSync(filePath, fileContent, "utf8");
    console.log(`✅ ${fileDesc} updated!`);
  } else {
    console.log(`❌ ${fileDesc} not found!`);
  }
};

function toSnakeCase(appName) {
  return appName
    .toLowerCase()
    .split(/\s+/)
    .join('_');
}

module.exports = { installCurrentPackages, installPackages, updateFile, toSnakeCase };

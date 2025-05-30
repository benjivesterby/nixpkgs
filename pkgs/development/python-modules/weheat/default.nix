{
  lib,
  aenum,
  aiohttp-retry,
  aiohttp,
  buildPythonPackage,
  fetchFromGitHub,
  pydantic,
  python-dateutil,
  setuptools,
  urllib3,
}:

buildPythonPackage rec {
  pname = "weheat";
  version = "2025.4.29";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "wefabricate";
    repo = "wh-python";
    tag = version;
    hash = "sha256-z+tRxx+wtEj5cBXBVG1B5SNyvkQk2UwjH7lPgNQQ+ng=";
  };

  pythonRelaxDeps = [
    "urllib3"
  ];

  build-system = [ setuptools ];

  dependencies = [
    aenum
    aiohttp
    aiohttp-retry
    pydantic
    python-dateutil
    urllib3
  ];

  # Module has no tests
  doCheck = false;

  pythonImportsCheck = [ "weheat" ];

  meta = {
    description = "Library to interact with the weheat API";
    homepage = "https://github.com/wefabricate/wh-python";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
  };
}

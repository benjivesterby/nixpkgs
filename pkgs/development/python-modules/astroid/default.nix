{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  setuptools,
  typing-extensions,
  pip,
  pylint,
  pytestCheckHook,
}:

buildPythonPackage rec {
  pname = "astroid";
  version = "3.3.8"; # Check whether the version is compatible with pylint
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "PyCQA";
    repo = "astroid";
    tag = "v${version}";
    hash = "sha256-KKQuLomCHhVYMX1gE9WuqbXOfsf2izGlLE0Ml62gY3k=";
  };

  nativeBuildInputs = [ setuptools ];

  propagatedBuildInputs = lib.optionals (pythonOlder "3.11") [ typing-extensions ];

  nativeCheckInputs = [
    pip
    pytestCheckHook
  ];

  passthru.tests = {
    inherit pylint;
  };

  meta = with lib; {
    changelog = "https://github.com/PyCQA/astroid/blob/v${version}/ChangeLog";
    description = "Abstract syntax tree for Python with inference support";
    homepage = "https://github.com/PyCQA/astroid";
    license = licenses.lgpl21Plus;
    maintainers = with maintainers; [ GaetanLepage ];
  };
}

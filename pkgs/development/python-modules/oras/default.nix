{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  jsonschema,
  pytestCheckHook,
  pythonOlder,
  requests,
  setuptools,
}:

buildPythonPackage rec {
  pname = "oras";
  version = "0.2.27";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "oras-project";
    repo = "oras-py";
    tag = version;
    hash = "sha256-ysbjLiGRRYGqYUS+jlY0DDzzTXUZYu+/dajHv2O0V9o=";
  };

  build-system = [ setuptools ];

  dependencies = [
    jsonschema
    requests
  ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "oras" ];

  disabledTests = [
    # Test requires network access
    "test_get_many_tags"
  ];

  meta = with lib; {
    description = "ORAS Python SDK";
    homepage = "https://github.com/oras-project/oras-py";
    changelog = "https://github.com/oras-project/oras-py/blob/${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ fab ];
  };
}

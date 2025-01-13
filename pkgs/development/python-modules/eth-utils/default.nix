{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  isPyPy,
  pythonOlder,
  cytoolz,
  eth-hash,
  eth-typing,
  hypothesis,
  mypy,
  pytestCheckHook,
  pytest-xdist,
  setuptools,
  toolz,
}:

buildPythonPackage rec {
  pname = "eth-utils";
  version = "4.1.1";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "eth-utils";
    tag = "v${version}";
    hash = "sha256-SfJO3KNdVHPNXe85ZiBVKqXjnpUqI9QLQnj1SwpGSeM=";
  };

  build-system = [ setuptools ];

  dependencies = [
    eth-hash
    eth-typing
  ] ++ lib.optional (!isPyPy) cytoolz ++ lib.optional isPyPy toolz;

  nativeCheckInputs = [
    hypothesis
    mypy
    pytestCheckHook
    pytest-xdist
  ] ++ eth-hash.optional-dependencies.pycryptodome;

  # side-effect: runs pip online check and is blocked by sandbox
  disabledTests = [ "test_install_local_wheel" ];

  pythonImportsCheck = [ "eth_utils" ];

  meta = {
    changelog = "https://github.com/ethereum/eth-utils/blob/${src.rev}/docs/release_notes.rst";
    description = "Common utility functions for codebases which interact with ethereum";
    homepage = "https://github.com/ethereum/eth-utils";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.FlorianFranzen ];
  };
}

{
  lib,
  buildPythonPackage,
  fetchFromGitHub,
  pythonOlder,
  pytestCheckHook,
  pytest-xdist,
  typing-extensions,
  setuptools,
}:

buildPythonPackage rec {
  pname = "eth-typing";
  version = "4.0.0";
  pyproject = true;

  disabled = pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "ethereum";
    repo = "eth-typing";
    rev = "refs/tags/v${version}";
    hash = "sha256-JT/2bCPYFSRNt3V7QnHSAJR7HrZ1JpRKdU7gQpoYIn0=";
  };

  nativeBuildInputs = [ setuptools ];

  dependencies = [ typing-extensions ];

  nativeCheckInputs = [
    pytestCheckHook
    pytest-xdist
  ];

  pythonImportsCheck = [ "eth_typing" ];

  meta = {
    changelog = "https://github.com/ethereum/eth-typing/blob/v${version}/docs/release_notes.rst";
    description = "Common type annotations for Ethereum Python packages";
    homepage = "https://github.com/ethereum/eth-typing";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ siraben ];
  };
}

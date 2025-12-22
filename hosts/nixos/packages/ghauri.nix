{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "ghauri";
  version = "1.4.2";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "r0oth3x49";
    repo = "ghauri";
    tag = version;
    hash = "sha256-/OobjCNJoysYMMUsta15oH0Mqbq13KLiOoB0HFGUZbc=";
  };

  build-system = with python3.pkgs; [
    setuptools
  ];

  dependencies = with python3.pkgs; [
    chardet
    colorama
    requests
    tldextract
    (pkgs.callPackage ./ua-generator.nix {})
  ];

  # Project has no tests
  doCheck = false;

  pythonImportsCheck = [
    "ghauri"
  ];

  meta = {
    description = "Tool for detecting and exploiting SQL injection security flaws";
    homepage = "https://github.com/r0oth3x49/ghauri";
    changelog = "https://github.com/r0oth3x49/ghauri/releases/tag/${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "ghauri";
  };
}
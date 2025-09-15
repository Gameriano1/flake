{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "ua-generator";
  version = "2.0.8";
  pyproject = true;
  src = fetchFromGitHub {
    owner = "iamdual";
    repo = "ua-generator";
    tag = version;
    hash = "sha256-/u8I86Okqc6EtcGN84HyooiJfPhCU/KVYIHWGOKEyp4=";
  };

  build-system = with python3.pkgs; [
    setuptools
    wheel
  ];

  dependencies = with python3.pkgs; [
    chardet

  ];

  # Project has no tests
  doCheck = false;

  pythonImportsCheck = [
    "ua_generator"
  ];

  meta = {
    description = "A random user-agent generator for Python >= 3.9";
    homepage = "https://github.com/iamdual/ua-generator";
    changelog = "https://github.com/iamdual/ua-generator/releases/tag/${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ fab ];
    mainProgram = "ua-generator";
  };
}
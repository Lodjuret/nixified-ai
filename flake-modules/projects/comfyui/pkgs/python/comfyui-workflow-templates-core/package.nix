{
  comfyuiNpins,
  lib,
  buildPythonPackage,
  fetchurl,
}: let
  npin = comfyuiNpins.comfyui-workflow-templates-core;
in
  buildPythonPackage rec {
    pname = "comfyui_workflow_templates_core";

    inherit (npin) version;

    src = fetchurl {
      inherit (npin) url;
      sha256 = npin.hash;
    };

    format = "other";

    pythonImportsCheck = [
      pname
    ];

    meta = with lib; {
      description = "Core module for ComfyUI workflow templates.";
      homepage = "https://github.com/Comfy-Org/workflow_templates";
      license = licenses.gpl3;
    };
  }

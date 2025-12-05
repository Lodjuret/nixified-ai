{
  python3Packages,
  comfyuiNpins,
}: let
  npinMain = comfyuiNpins.comfyui-workflow-templates;
  npinCore = comfyuiNpins.comfyui-workflow-templates-core;

  core = python3Packages.callPackage (
    {
      buildPythonPackage,
      fetchurl,
      lib,
    }:
      buildPythonPackage rec {
        pname = "comfyui_workflow_templates_core";
        inherit (npinCore) version;

        src = fetchurl {
          inherit (npinCore) url;
          sha256 = npinCore.hash;
        };

        format = "setuptools";

        pythonImportsCheck = [pname];

        meta = with lib; {
          description = "Core module for ComfyUI workflow templates.";
          homepage = "https://github.com/Comfy-Org/workflow_templates";
          license = licenses.gpl3;
        };
      }
  ) {};

  main = python3Packages.callPackage (
    {
      buildPythonPackage,
      fetchurl,
      lib,
    }:
      buildPythonPackage rec {
        pname = "comfyui_workflow_templates";
        inherit (npinMain) version;

        src = fetchurl {
          inherit (npinMain) url;
          sha256 = npinMain.hash;
        };

        format = "setuptools";

        propagatedBuildInputs = [core];

        pythonImportsCheck = [pname];

        meta = with lib; {
          description = "ComfyUI workflow templates available via the Browse Templates feature.";
          homepage = "https://github.com/Comfy-Org/workflow_templates";
          license = licenses.gpl3;
        };
      }
  ) {};
in {
  comfyui_workflow_templates = main;
  comfyui_workflow_templates_core = core;
}

{ mkShell
, python3
}:

# ⇨ example.py
# import ddddocr
# from pathlib import Path
# if __name__ == "__main__":
#     ocr = ddddocr.DdddOcr()
#     base_dir = Path.home() / "Downloads" / "captchas"
#     for name in ["1.png", "2.jpeg", "3.png", "4.png", "5.png"]:
#         image = open(base_dir / name, "rb").read()
#         result = ocr.classification(image)
#         print(f"Parsed: '{result}'")

mkShell rec {
  name = "dev-with-ddddocr";

  packages = [
    (python3.withPackages (p: with p; [
      ddddocr
    ]))
  ];
}

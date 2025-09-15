# 💼 My CV formatted in $\LaTeX$

## 🌐 Repo Structure

This repository consists of 3 branches:

- `main`: Contains the shared files between the other 2 branches.
- `short-version`: Contains the files for the short version of the CV.
- `long-version`: Contains the files for the long version of the CV.

The *short* branch generates a one page pdf with less detail and oriented towards IT, while the *long* version contains more academic details, scientific publications and a broader variety of workshops and courses.

The basic structure is:

```bash
├── data
│   ├── english_tests.tex
│   ├── myCV.cls                         # $\LaTeX$ formatting file
│   ├── personal_data.tex
│   ├── pics                             # photos and flags
│   ├── publications.tex
│   ├── skills.tex
│   └── workshops.tex
├── eng
│   ├── AgustinBeceyroFerran_CV_Eng.pdf  # english pdf file
│   └── AgustinBeceyroFerran_CV_Eng.tex  # main english $\LaTeX$ file
├── esp
│   ├── AgustinBeceyroFerran_CV_Esp.pdf  # spanish pdf file
│   └── AgustinBeceyroFerran_CV_Esp.tex  # main spanish $\LaTeX$ file
├── LICENSE
└── README.md
```

## 💻 Usage

- Shared files that live in `main` should be tracked in this branch.
- Enter the branch you are interested in (long/short).
- Pull changes from `main`.
- Enter the folder for the desired language (eng/esp).
- Run `lualatex texfilename.tex` or `xelatex texfilename.tex` to compile.
- It can also be compiled with TexMaker or any other $\TeX$ editor.

## 📄 References

- This CV LaTeX format is based on [FortySecondsCV](https://github.com/PandaScience/FortySecondsCV).
- Flags were obtained from [GoSquared/Flag](https://github.com/gosquared/flags).
- Icons are from the package `fontawesome5` ([fontawesome website](https://fontawesome.com/)).

## 📄 License

This project is shared under License **GNU-GPL V3**.

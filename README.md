# 💼 My CV formatted in $\LaTeX$

> [!NOTE]
> This repository uses an unconventional workflow: The `main` branch does **not** contain a stable or usable version of the CV. Its main purpose is to store shared files (such as data, styles, images) that are used by the `short-version` and `long-version` branches.
>
> To obtain a functional CV, switch to the desired branch (`short-version` or `long-version`). These branches contain all the necessary files to compile the complete CV, either in its *short* (IT-oriented) or *long* (academic-focused) version.

## 🌐 Repository Structure

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

## 💻 Workflow & Usage

1. Make changes to shared files in `main` if necessary.
2. Switch to the desired branch (`short-version` or `long-version`).
3. Merge updates (`git merge main`) to get the latest shared files.
4. Make changes to that branch if necessary.
5. Enter the folder for the desired language (eng/esp).
6. Compile by running `lualatex texfilename.tex` or `xelatex texfilename.tex`. It can also be compiled with TexMaker or any other $\TeX$ editor.

## 📄 References

- This CV LaTeX format is based on [FortySecondsCV](https://github.com/PandaScience/FortySecondsCV).
- Flags were obtained from [GoSquared/Flag](https://github.com/gosquared/flags).
- Icons are from the package `fontawesome5` ([fontawesome website](https://fontawesome.com/)).

## 📄 License

This project is shared under License **GNU-GPL V3**.

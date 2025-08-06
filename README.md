# An Analysis of Compression Technologies Used in the Delivery of Internet Video

A comprehensive academic study evaluating the performance, cost, and business
implications of modern software-based video encoders.

## 📖 Overview

Video streaming services rely heavily on efficient compression to reduce
bandwidth and storage costs while maintaining high quality. This project
presents:

- A thorough literature review of existing codecs, encoder implementations, and
  delivery infrastructures.
- An experimental benchmark of open-source encoders (x264, x265, SVT-AV1,
  vpxenc, aomenc) under controlled settings.
- A computational and economic cost model to quantify encoding expenses at
  scale.
- Scenario-based analysis for common streaming business profiles: frequently
  accessed VOD, long-tail VOD, and live streaming.
- Discussion of future trends in codec development and research directions.

## 📁 Repository Structure

```tree
.
├── data
│   └── data.ods                 # Raw benchmark results and cost spreadsheet
├── paper
│   ├── paper.md                 # Full manuscript with chapters and sections
│   ├── glossary.md              # Definitions of technical terms and acronyms
│   ├── bibliography.md          # Reference list for all cited works
│   └── annex.md                 # Supplementary tables, figures, and logs
├── scripts
│   ├── gen_test_media.sh        # Generate synthetic and sample videos for benchmarking
│   └── benchmark.sh             # Run encoder experiments and collect performance metrics
├── LICENSE
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- A Unix-like environment (Linux or macOS)
- `bash`, `python`, and `ffmpeg` (with `libvmaf`) installed
- Encoder binaries: `x264`, `x265`, `SvtAv1EncApp`, `vpxenc`, `aomenc`

### Generating Test Media

```bash
./scripts/gen_test_media.sh [input.y4m]
```

This script produces a standardized set of input videos. Y4M files may be
sourced from [Derf's Test Media](https://media.xiph.org/video/derf/)

### Running Encoder Benchmarks

```bash
bash scripts/benchmark.sh
```

Runs a reproducible benchmark using the
[PSY-EX `metrics`](https://github.com/psy-ex/metrics) video benchmarking toolkit
to produce CSV data for each encoder's performance.

### Data

Open `data/data.ods` in your favorite spreadsheet application for a full encoder
performance overview accompanied by cost metrics.

## 📝 Paper Access

All sections of the study are available in [the final paper](./paper/paper.md).
Key chapters:

1. **Introduction** – Context and research objectives
2. **Literature Review** – Codec standards, quality metrics, delivery
   architectures
3. **Methodology** – Benchmark design, cost modeling, scenario analysis
4. **Conclusion** – Findings, future codecs, research directions

## 📚 Citation

If you use this work in your research, please cite:

[citation details not specified]

## ⚖️ License

This project is licensed under the BSD 2-Clause "Simplified" License. See the
[LICENSE](./LICENSE) file for details. Some material in the paper is licensed
differently; those works are not covered by this project's license.

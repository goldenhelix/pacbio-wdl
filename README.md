# PacBio HiFi WGS Analysis

This repository contains workflows for PacBio HiFi (High-Fidelity) whole genome sequencing analysis based on the [PacificBiosciences/HiFi-human-WGS-WDL](https://github.com/PacificBiosciences/HiFi-human-WGS-WDL) pipeline. This comprehensive pipeline provides end-to-end analysis of PacBio HiFi reads, including alignment, variant calling, structural variant detection, and pharmacogenomic analysis.

## Prerequisite

**IMPORTANT**: Before running any workflows, you must first run the **Download PacBio Reference Data Resources** task to download and prepare the required reference data bundle. This task downloads the GRCh38 reference genome and associated files from Zenodo and configures the necessary mapping files.

Before downloading, use [Workspace Settings](./manage/settings) to specify the target location with the `RESOURCES_PATH` variable.

## Overview

This repository provides a comprehensive PacBio HiFi analysis workflow that includes:

1. **Alignment**: PacBio HiFi read alignment using pbmm2
2. **Variant Calling**: DeepVariant for high-accuracy variant detection
3. **Structural Variant Detection**: Sawfish for structural variant discovery
4. **Tandem Repeat Analysis**: TRGT for tandem repeat genotyping
5. **Haplotype Phasing**: HiPhase for variant phasing and haplotagging
6. **Mitochondrial Analysis**: Mitorsaw for mitochondrial variant detection
7. **Pharmacogenomic Analysis**: PBStarPhase for pharmacogenomic variant calling
8. **Coverage Analysis**: Mosdepth for depth of coverage calculations
9. **Statistics Generation**: Comprehensive analysis statistics
10. **VarSeq Integration**: Optional VarSeq project creation

### Workflow Parameters

- **Batch TSV File**: A TSV file containing a sample manifest with alignment files and their associated samples
- **Folder Name**: Optional name for the output folder. If left blank, the name of the folder containing the batch TSV file will be used
- **Base Output Folder**: The base output folder where the output directory will be created
- **Cache Udocker Image**: Option to cache Docker images for faster subsequent runs

### Input Requirements

The workflow expects a TSV (tab-separated values) sample manifest file that maps PacBio HiFi unaligned BAM (uBAM) or FASTQ files to sample identifiers. This format is required because the PacBio sequencer output directory structure does not correspond to sample names, and there are separate directories for `hifi_reads` and `failed_reads` that may be related to the same sample.

The TSV file must contain the following columns:
- **alignment_file**: Path to the alignment file (uBAM or FASTQ)
- **sample_id**: Sample identifier
- **failed_target**: Boolean value (`true` or `false`) indicating whether this is a failed target read file

The format supports one or more HiFi reads uBAM or FASTQ files to be associated with a sample. Files with `failed_target=false` will be processed in parallel and then merged. Files with `failed_target=true` are failed reads that will be merged later in the workflow.

**Example TSV manifest file:**

```
alignment_file	sample_id	failed_target
CloudStorage/RevioOutput/1_A01/hifi_reads/m84039_241001_220042_s2.hifi_reads.bc2018.bam	HG002	false
CloudStorage/RevioOutput/1_A01/hifi_reads/m84039_241001_220042_s2.hifi_reads.bc2019.bam	HG002	false
CloudStorage/RevioOutput/1_A01/fail_reads/m84039_241001_220042_s2.fail_reads.bc2018.bam	HG002	true
CloudStorage/RevioOutput/1_B01/hifi_reads/m84039_241001_220043_s3.hifi_reads.bc2020.bam	HG003	false
CloudStorage/RevioOutput/1_B01/hifi_reads/m84039_241001_220043_s3.hifi_reads.bc2021.bam	HG003	false
CloudStorage/RevioOutput/1_B01/fail_reads/m84039_241001_220043_s3.fail_reads.bc2020.bam	HG003	true
```

A directory will be created in the `base_output_folder` with the name specified by `folder_name` (or derived from the parent folder of the input TSV if left blank).

### Output Structure

The workflow generates a comprehensive set of outputs including:
- Aligned BAM files with quality metrics
- Variant call files (VCF) from DeepVariant
- Structural variant calls from Sawfish
- Tandem repeat genotypes from TRGT
- Haplotagged BAM files from HiPhase
- Mitochondrial variant analysis from Mitorsaw
- Pharmacogenomic analysis results from PBStarPhase
- Coverage statistics from Mosdepth
- Comprehensive analysis statistics
- Optional VarSeq project files

## Individual Tasks

The repository also provides individual tasks that can be run independently:

### Core Analysis Tasks
- **pbmm2.task.yaml**: PacBio HiFi read alignment
- **deepvariant.task.yaml**: High-accuracy variant calling
- **sawfish.task.yaml**: Structural variant detection
- **trgt.task.yaml**: Tandem repeat genotyping
- **hiphase.task.yaml**: Variant phasing and haplotagging

### Specialized Analysis Tasks
- **mitorsaw.task.yaml**: Mitochondrial variant analysis
- **paraphase.task.yaml**: Gene haplotype analysis
- **mosdepth.task.yaml**: Coverage analysis
- **pbstarphase.task.yaml**: Pharmacogenomic analysis

### Utility Tasks
- **stats.task.yaml**: Statistics generation
- **vspipeline.task.yaml**: VarSeq project creation
- **upload_pgx_results.task.yaml**: Results upload to Sample Catalog

## Resource Requirements

The workflow is resource-intensive and requires:
- **CPU**: 64 cores for the most demanding steps
- **Memory**: 128 GB RAM for the most demanding steps
- **Storage**: Significant scratch storage space (~200GB) for intermediate files

## Reference Data

The workflow uses the GRCh38 reference genome and associated files that are downloaded by the prerequisite task. These include:
- GRCh38 reference genome FASTA
- Genome interval BED files
- Reference mapping files
- Model files for various analysis tools

## Getting Started

1. **Set up resources**: Configure `RESOURCES_PATH` in Workspace Settings
2. **Download reference data**: Run the "Download PacBio Reference Data Resources" task
3. **Prepare input data**: Create a TSV sample manifest file with columns `alignment_file`, `sample_id`, and `failed_target` mapping your PacBio HiFi uBAM or FASTQ files to sample identifiers
4. **Run the workflow**: Execute the PacBio WGS Singleton workflow with the batch TSV file, base output folder, and optional folder name

## Notes

- The workflow calls the invidual WDL steps from the PacBio WDL workflow, based on the singleton workflow

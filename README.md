# minibench

A Nextflow pipeline for lightweight benchmarking. Provides a simple way to obtain a "fingerprint" of a platform based on benchmarking metrics. Can be used with [tesseract](https://github.com/bentsherman/tesseract) to predict resource usage across multiple platforms or multiple node types within a platform.

## Usage

Run minibench on whatever platform to collect benchmarking metrics for every node type on that platform. The only thing you need to do beforehand is to create a profile in `nextflow.config` that defines the node types on your platform. The config file currently has a few examples for a local machine, the Palmetto cluster at Clemson University, the Nautilus cluster, and Google Cloud.

To run minibench on a Kubernetes cluster:
```bash
nextflow kuberun bentsherman/minibench -v <pvc-name>
```

To run minibench on Google Cloud:
```bash
# define environment variables
export GOOGLE_APPLICATION_CREDENTIALS="<credentials-file>"
export NXF_MODE="google"

# run pipeline
nextflow run bentsherman/minibench \
    -profile google \
    --google_bucket <bucket>/work \
    --google_zone <zone>

# transfer work directory from cloud storage
gsutil -m cp -r gs://nextflow-data/work .
gsutil -m rm -r gs://nextflow-data/work
```

You can then use tesseract to collect the input features (i.e. `node_type`) and benchmarking metrics into a dataframe. Refer to the tesseract repo for more information.

In order to use the benchmarking metrics as input features in a trace dataset for another Nextflow pipeline, each task must be tagged with the `node_type` on which it was executed, so that the benchmarking metrics can be properly merged with the application trace data. The easiest way to do this is to create a config file that inserts a trace directive for `node_type`. Refer to the `conf` folder for examples.

To run KINC-nf with the minibench shim on Palmetto:
```bash
nextflow run -C minibench/palmetto.config systemsgenetics/kinc-nf -profile palmetto,singularity
```
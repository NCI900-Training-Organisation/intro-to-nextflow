process DOWNLOAD_IRIS {
    output:
    path "iris.data"

    script:
    """
    curl -o iris.data https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data
    """
}
workflow {
    DOWNLOAD_IRIS()
}

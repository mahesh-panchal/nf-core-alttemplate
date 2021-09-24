params.options = [:]

include { getSoftwareName } from "$projectDir/lib/functions.nf"

process MULTIQC {
    label 'process_medium'

    conda (params.enable_conda ? "bioconda::multiqc=1.10.1" : null)
    if (workflow.containerEngine == 'singularity' && !params.singularity_pull_docker_container) {
        container "https://depot.galaxyproject.org/singularity/multiqc:1.10.1--py_0"
    } else {
        container "quay.io/biocontainers/multiqc:1.10.1--py_0"
    }

    input:
    path multiqc_files

    output:
    path "*multiqc_report.html", emit: report
    path "*_data"              , emit: data
    path "*_plots"             , optional:true, emit: plots
    path "*.version.txt"       , emit: version

    script:
    def software = 'multiqc'// getSoftwareName(task.process) - Not needed after transition to yml file
    """
    multiqc -f $task.ext.args .
    multiqc --version | sed -e "s/multiqc, version //g" > ${software}.version.txt
    """
}

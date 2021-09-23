#!/usr/bin/env nextflow
/*
========================================================================================
    nf-core/alttemplate
========================================================================================
    Github : https://github.com/nf-core/alttemplate
    Website: https://nf-co.re/alttemplate
    Slack  : https://nfcore.slack.com/channels/alttemplate
----------------------------------------------------------------------------------------
*/

nextflow.enable.dsl = 2

/*
========================================================================================
    GENOME PARAMETER VALUES
========================================================================================
*/

params.fasta = WorkflowMain.getGenomeAttribute(params, 'fasta')

/*
========================================================================================
    VALIDATE & PRINT PARAMETER SUMMARY
========================================================================================
*/

WorkflowMain.initialise(workflow, params, log)

/*
========================================================================================
    NAMED WORKFLOW FOR PIPELINE
========================================================================================
*/

include { ALTTEMPLATE } from './workflows/alttemplate'

//
// WORKFLOW: Run main nf-core/alttemplate analysis pipeline
//
workflow NFCORE_ALTTEMPLATE {
    ALTTEMPLATE ()
}

/*
========================================================================================
    RUN ALL WORKFLOWS
========================================================================================
*/

//
// WORKFLOW: Execute a single named workflow for the pipeline
// See: https://github.com/nf-core/rnaseq/issues/619
//
workflow {
    NFCORE_ALTTEMPLATE ()
}

/*
========================================================================================
    THE END
========================================================================================
*/

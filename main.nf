#!/usr/bin/env nextflow

nextflow.enable.dsl=2



workflow {
    conditions = Channel.fromList( params.conditions )
    trials = Channel.fromList( 0 .. params.trials-1 )

    minibench(conditions, trials)
}



/**
 * The minibench process runs the minibench benchmark for
 * each node type in a compute environment.
 */
process minibench {
    tag "${c.node_type}"
    publishDir "${params.output_dir}"

    input:
        each c
        each trial

    script:
        """
        # specify node type
        echo "#TRACE node_type=${c.node_type}"

        # run minibench
        minibench trace
        """
}

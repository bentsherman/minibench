#!/usr/bin/env nextflow



/**
 * The minibench process runs the minibench benchmark for
 * each node type in a compute environment.
 */
process minibench {
    tag "${c.node_type}"
    publishDir "${params.output_dir}"

    input:
        each(c) from Channel.fromList( params.conditions )
        each(trial) from Channel.fromList( 0 .. params.trials-1 )

    script:
        """
        # specify node type
        echo "#TRACE node_type=${c.node_type}"

        # run minibench
        minibench trace
        """
}

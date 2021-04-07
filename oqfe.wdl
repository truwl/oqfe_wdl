version 1.0
task oqfe{
    input {
        String sample
        File forward_reads
        File? reverse_reads
        File? cram_reference_fasta
        Int? optical_duplicate_pixel_distance
    }

    Int threads = 4

    command {
        /usr/bin/python3.6 \
        /oqfe \
        ~{"--sample " + sample} \
        ~{"-j " + threads} \
        ~{"-1 " + forward_reads} \
        ~{"-2 " + reverse_reads} \
        ~{"-r " + cram_reference_fasta} \
        ~{"-d " + optical_duplicate_pixel_distance}
    }

    output {
        File outputCram = sample + ".oqfe.cram"
        File outputCramIndex = sample + ".oqfe.crai"
        File markdupStats = sample + ".oqfe.markdup_stats.txt"
    }

    runtime {
        docker: "dnanexus/oqfe:latest"
        cpu: threads
    }
    
    meta {allowNestedInputs: true}
}

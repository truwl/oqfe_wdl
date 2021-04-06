version 1.0
task oqfe{
    input {
        File forward_reads
        File? reverse_reads
        String sample
        File? cram_reference_fasta
        Int optical_duplicate_pixel_distance
        Int threads
    }

    threads = 4

    command {
        set -e -o pipefail
        /usr/bin/python3.6 \
        /oqfe \
        ~{"-j " + threads} \
        ~{"-1" + forward_reads} \
        ~{"-2" + reverse_reads} \
        ~{"--sample" + sample} \
        ~{"-r" + cram_reference_fasta} \
        ~{"-d" + optical_duplicate_pixel_distance}
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
}
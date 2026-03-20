function [I_SCORE] = make_features(filename, N, DATA_DIR, blast_bin, THIS_ONTOLOGY)


database_file = [DATA_DIR 'SEQ/' THIS_ONTOLOGY '_SEQUENCES.fasta'];

resultsname = [filename '.blast_results'];

blast_command = ['!' blast_bin 'blastall -p blastp -i ' filename ' -d ' database_file ' -m 8 > ' resultsname];


eval(blast_command);

RAW = load(resultsname);

%clean up after loading data
delete(resultsname);
delete(filename);

if ~isempty(RAW)
    K = load_and_clean_evalues(RAW);
    
    GOTCHA = make_gotcha_features(K, N,DATA_DIR, THIS_ONTOLOGY);
    I_SCORE = make_i_score_large(GOTCHA, DATA_DIR, THIS_ONTOLOGY);
else
    I_SCORE = [];
end




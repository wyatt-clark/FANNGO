function [PREDICTIONS, names, accessions] = fanngo(sequences, THIS_ONTOLOGY)
%FANNGO generate scores for moelcular function terms using FANNGO
%           method
%
%   Input: 
%           sequences- should be a cell array of protein sequences
%
%           THIS_ONTOLOGY - should be a string specifying which ontology to
%           make predictions over.  should be either 'BPO' or 'MFO'
%
%   Output:
%           PREDICTIONS- a matrix of predicted scores, where row i
%               corresponds to sequence i in sequences and column j corresponds
%               to term name j in names and accession number j in accessions
%
%           names- term names of predicted terms
%   
%           accessions- accession numbers of predicted terms
%
%  You are responsible for ensuring that illegal characters are removed.
%  It is not advisable to submit sequences shorter than 50aa to the
%  program.  To ensure that no colision occurs when more than one person is
%  running code at a time, temporary files are given a random prefix
%  

%% set some varriables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f_dir = '../temp/';
DATA_DIR = ['../data/' THIS_ONTOLOGY '/'];


blast_bin = '../BLAST/linux_x64/blast-2.2.18/bin/';

% 
% my_os = getenv('ARCH');
% 
% if strcmp(my_os, 'maci64')
%     blast_bin = '../BLAST/osx/blast-2.2.18/bin/';
% elseif strcmp(my_os, 'glnxa64')
%     blast_bin = '../BLAST/linux_x64/blast-2.2.18/bin/';
% elseif strcmp(my_os, 'glnx86')
%     blast_bin = '../BLAST/linux_x86/blast-2.2.18/bin/';
% else
%     error('we apologize, but your platform is currently not supported');
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%



%% Should only be one file in IN directory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%fasta_files = dir([IN_DIR '*.fasta']);
%[H,S] = fastaread([IN_DIR fasta_files(1).name]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%





%% make prefix for filename and write fasta file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%perform some cleanup
%eval(['!rm ' f_dir '*']);
my_prefix = num2str(ceil(100000*rand));

filename = [f_dir my_prefix '_TEMP.fasta'];
my_write_fasta(sequences,filename);

N = length(sequences);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%



%% first make blast features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%fprintf(1, 'Making Features\n');
[I_SCORE] = make_features(filename, N, DATA_DIR, blast_bin, THIS_ONTOLOGY);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%



if ~isempty(I_SCORE)
    

%% make predictions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PREDICTIONS = predict(I_SCORE, DATA_DIR, THIS_ONTOLOGY);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
else
    eval(['load ' DATA_DIR THIS_ONTOLOGY '_LARGE_TERMS;']);
    PREDICTIONS = zeros(length(sequences), length(large_terms));
end



eval(['load ' DATA_DIR 'linear_' THIS_ONTOLOGY '.mat names accessions;']);
eval(['load ' DATA_DIR THIS_ONTOLOGY '_LARGE_TERMS;']);

names = names(large_terms);
accessions = accessions(large_terms);



function [PRED] = MAIN(sequences)
%
%function [PRED] = MAIN(sequences)
%
%MAIN generate scores for both moelcular function and biological process 
%       terms using FANNGO method
%           
%
%   Input: 
%           sequences- should be a cell array of protein sequences
%
%
%
%   Output:
%
%           PRED -  an object containing three data structures
%
%           PRED.scores- a matrix of predicted scores, where row i
%               corresponds to sequence i in sequences and column j corresponds
%               to term name j in names and accession number j in accessions
%
%           PRED.names- term names of predicted terms
%   
%           PRED.accessions- accession numbers of predicted terms
%
%
%   You are responsible for ensuring that illegal characters are removed from sequences.
%   It is not advisable to submit sequences shorter than 50aa to the
%   program.  
%
%   When a vector of tax ids is submitted to the program we first check to
%   ensure that we have data for all organisms that you've provided.
%   predictions for organisms forwhch we do not have data will be generated
%   using the FANNGO method
%
%   To ensure that no colision occurs when more than one person is
%   running code at a time, temporary files are given a random prefix
%  
%   if you wish to predict only MFO or BPO terms please refer to the
%   functions FANNGO 

if ~iscell(sequences)
    my_seq = sequences;
    clear sequences;
    sequences = {};
    sequences{1} = my_seq;
end


    
[pred1, names1, accessions1] = fanngo(sequences, 'MFO');
[pred2, names2, accessions2] = fanngo(sequences, 'BPO');

scores = [pred1 pred2];
names = [names1 names2];
accessions = [accessions1 accessions2];

PRED.scores = scores;
PRED.names = names;
PRED.accessions = accessions;



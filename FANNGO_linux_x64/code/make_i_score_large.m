function I_SCORE = make_i_score_large(GOTCHA, DATA_DIR, THIS_ONTOLOGY)






eval(['load ' DATA_DIR THIS_ONTOLOGY '_LARGE_TERMS']);

eval(['load ' DATA_DIR 'linear_propogated_' THIS_ONTOLOGY]);


eval(['ontology = linear_propogated_' THIS_ONTOLOGY ';']);
eval(['clear linear_propogated_' THIS_ONTOLOGY ';']);

ontology = ontology(large_terms, large_terms);
names = names(large_terms);

num_parents = zeros(1, length(large_terms));
for i = 1:length(large_terms)
   num_parents(i) = length(find(ontology(:,i) ==1)); 
    
    
end


roots = num_parents == 1;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

GOTCHA = GOTCHA(:, large_terms);

root_scores = sum(GOTCHA(:,roots),2);
roots_mat = repmat(root_scores, 1, length(large_terms));


GOTCHA = GOTCHA ./ roots_mat;

I_SCORE = GOTCHA; clear GOTCHA;
I_SCORE(isnan(I_SCORE)) = 0;























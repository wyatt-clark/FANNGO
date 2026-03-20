function GOTCHA = make_gotcha_features(K, N, DATA_DIR, THIS_ONTOLOGY)




eval(['load ' DATA_DIR THIS_ONTOLOGY '_TSM.mat']);



TSM = full(TSM);




GOTCHA = zeros(N, size(TSM,2));




for i = 1:size(K,1)
    
    subject = K(i,1);
    hit = K(i,2);
    my_val = K(i,3);
    hit_indices = find(TSM(hit, :) > 0);

    for j = 1:length(hit_indices)
        GOTCHA(subject, hit_indices(j)) = GOTCHA(subject, hit_indices(j)) + my_val;


    end
end


GOTCHA = sparse(GOTCHA);



















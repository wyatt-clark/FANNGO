function THESE_PREDS = predict(I_SCORE, DATA_DIR, THIS_ONTOLOGY)



X = I_SCORE; clear I_SCORE;

%% Loading data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% load names of functions as cell array of strings
eval(['load ' DATA_DIR 'linear_' THIS_ONTOLOGY '.mat names']);
eval(['load ' DATA_DIR THIS_ONTOLOGY '_LARGE_TERMS.mat']);
names = names(large_terms);


eval(['load ' DATA_DIR THIS_ONTOLOGY '_FUNCTION_SAMPLES.mat']);


[MY_W1, MY_W2, MY_MIN, MY_MAX] = load_network_data(DATA_DIR);
my_nn_info.w1 = MY_W1;
my_nn_info.w2 = MY_W2;
my_nn_info.my_min = MY_MIN;
my_nn_info.my_max = MY_MAX;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%


%% container for 100 prediction on sampled functions
PREDICTIONS = {};
%%

for i = 1:length(function_samples)
    
    %fprintf(1,'SAMPLE:%d OF %d\n',i,length(function_samples));
    %% train predictor
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    out_prefix = ['S' num2str(i)];
    
    pred_matrix = zeros(size(X,1),length(large_terms));
    pred_matrix(:, function_samples{i}) = NNpredict_2(X, out_prefix, DATA_DIR, my_nn_info, i);
    
    PREDICTIONS{i} = sparse(pred_matrix);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
    
end


%% Average out Scores
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
f_counts = zeros(1,length(large_terms));
for i = 1:length(function_samples)
   
   these_functions = function_samples{i};
   
   for j = 1:length(these_functions)
       
       
       f_counts(these_functions(j)) = f_counts(these_functions(j)) + 1;
       
   end
   
   
end

DIVISOR = repmat(f_counts, size(X,1),1);



THESE_PREDS = zeros(size(X,1), length(large_terms));



for j = 1: length(function_samples)
    
    
    THESE_PREDS = THESE_PREDS + full(PREDICTIONS{j});
    
    
end
THESE_PREDS = THESE_PREDS ./ DIVISOR;





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%


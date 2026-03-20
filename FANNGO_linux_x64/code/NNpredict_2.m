function test_prediction_big = NNpredict_2 (X, out_prefix, DATA_DIR, my_nn_info, i)

if issparse(X)
    X = full(X);
end





X_ts = X;




eval(['load ' DATA_DIR 'ETC/' out_prefix '_data nninfo features meanv stdv T']);



if nninfo.do_feature_selection == 1
    X_ts = X_ts(:, features);
  
end


if nninfo.do_normalize == 1
    [stuff2, stuff, X_ts] = normalize(X_ts, meanv, stdv); %#ok<ASGLU>
end


if nninfo.do_normalize == 1 & nninfo.do_pca == 1
    X_ts = X_ts * T;

end



test_prediction_big = sim_function(my_nn_info.w1{i}, my_nn_info.w2{i}, my_nn_info.my_min{i}, my_nn_info.my_max{i}, X_ts);



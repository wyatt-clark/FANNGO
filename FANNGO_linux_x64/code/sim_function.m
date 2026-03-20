function output = sim_function (W1, W2, mn, mx, X_ts)


%----
xdiff = mx - mn;

for n = 1 : size(X_ts, 1)
    % normalize test to [-1, 1] interval (minmax normalization)
    x = 2 * (X_ts(n, :) - mn) ./ xdiff - 1;
    
    % produce outputs after hidden neurons
    h = tanh([1 x] * W1);
    
    % produce outputs
    o = tanh([1 h] * W2);
    
    % normalize output to [0, 1] interval (minmax normalization)
    output(n, :) = (o + 1) / 2;

    
end

return
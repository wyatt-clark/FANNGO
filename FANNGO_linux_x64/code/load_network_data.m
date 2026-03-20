function [MY_W1, MY_W2, MY_MIN, MY_MAX] = load_network_data(data_dir)

data_dir = [data_dir 'BINARY/'];



%% Read in Binary Files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sizes = read_binary([data_dir 'SIZES.bin']);

W1_flat = read_binary([data_dir 'W1.bin']);
W2_flat = read_binary([data_dir 'W2.bin']);

MAX_flat = read_binary([data_dir 'MAX.bin']);
MIN_flat = read_binary([data_dir 'MIN.bin']);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%



%% W1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% first determine the size of each W1 matrix, and its start and stop in
%% W1_flat 

W1_n_rows = sizes + 1;
W1_n_columns = repmat(100, 100,1);


w1_sizes = W1_n_rows .* W1_n_columns;
W1_start = cumsum([1;w1_sizes(1:length(w1_sizes)-1)]);
W1_stop = W1_start + (w1_sizes - 1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%



%% now make matrices

MY_W1 = {};

for i = 1:length(sizes)
   MY_W1{i} = reshape(W1_flat(W1_start(i):W1_stop(i)), W1_n_rows(i), W1_n_columns(i)); 
    
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%





%% W2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% determine size, and n rows and columns for w2
W2_n_rows = repmat(101,100,1);
W2_n_columns = repmat(100,100,1);

w2_sizes = W2_n_rows .* W2_n_columns;
W2_start = cumsum([1;w2_sizes(1:length(w2_sizes)-1)]);
W2_stop = W2_start + (w2_sizes - 1);

%%




%% now make matrices

MY_W2 = {};

for i = 1:length(sizes)
   MY_W2{i} = reshape(W2_flat(W2_start(i):W2_stop(i)), W2_n_rows(i), W2_n_columns(i)); 
    
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%





%% My_MAX and MY_MIN
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% determine sizes, same as before
MM_n_rows = ones(100,1);
MM_n_columns = sizes;

MM_sizes = MM_n_rows .* MM_n_columns;
MM_start = cumsum([1;MM_sizes(1:length(MM_sizes)-1)]);
MM_stop = MM_start + (MM_sizes - 1);
%%


%% now make matrices

MY_MIN = {};
MY_MAX = {};

for i = 1:length(sizes)
   MY_MAX{i} = reshape(MAX_flat(MM_start(i):MM_stop(i)), MM_n_rows(i), MM_n_columns(i)); 
   MY_MIN{i} = reshape(MIN_flat(MM_start(i):MM_stop(i)), MM_n_rows(i), MM_n_columns(i)); 
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%




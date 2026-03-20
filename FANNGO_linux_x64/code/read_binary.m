function Y = read_binary(filename)





fid = fopen(filename, 'r');
if fid == -1
    error('Cannot open file');
end

% read (load) elements in double precision (64 bits = 8 bytes per element)
Y = fread(fid, 'double'); % 'y' will be a column vector

% close file
fclose(fid);
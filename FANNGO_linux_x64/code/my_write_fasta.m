function [flag] = my_write_fasta (sequence, filename)




fid = fopen(filename, 'wt');
if (fid == -1)
    error(['File ' filename ' cannot be opened!']);
end

len = length(sequence);

for i = 1 : len
    % add '>' if it is not at position 1 in header
    header = ['>' num2str(i)];


    fprintf(fid, '%s', header);
    fprintf(fid, '\n');

    if length(sequence{i}) <= 80
        fprintf(fid, '%s', sequence{i});
        fprintf(fid, '\n\n');
    else
        j = 1;
        while j <= length(sequence{i})
            fprintf(fid, '%s', sequence{i}(j : min(j + 79, length(sequence{i}))));
            fprintf(fid, '\n');
            j = j + 80;
        end
        fprintf(fid, '\n');
    end
end

flag = fclose(fid);

return
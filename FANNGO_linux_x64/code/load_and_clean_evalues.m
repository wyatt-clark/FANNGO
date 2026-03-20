function K = load_and_clean_evalues(dirty_B)



K = dirty_B(:, [1 2 11]);

poopers = find(K(:,3) == 0);
smallest = min(K(setdiff(1:size(K,1), poopers),3));
K(poopers,3) = smallest * .1;
K(:,3) = -log(K(:,3))+2;
K(K(:,3) < 0,3) = 0;


function tentDependencies = findTentDependencies(tents,n_even,n_odd)
    %inputs n_even and n_nodes says how much tents are built in
    %even and odd iteration 

    
    numTents = size(tents,3);  % total number of tent

    % Creation of a matrix of dependence
    % all the row associated with the jth column
    % are the tents that tent j must wait to be used
    tentDependencies = zeros(numTents,4);
    i=0;
    ii=0;
    %loop over all the tents
    while (ii<numTents-n_even) || (ii<numTents-n_odd)
        if (mod(i,2)==0) && (i>0) 
            for j=ii:(ii+n_even)
               for k=(ii-n_odd+1):ii
                    if (k <j) || (k>j)
                        [index]=check_dependece(tents(:,:,j),tents(:,:,k));
                    end
                    if index>0
                        tentDependencies(j,index) = k;
                    end
               end
            end
            ii = ii+n_even;
        elseif mod(i,2)>0
            for j=ii:(ii+n_odd)
                for k = (ii-n_even+1):ii
                    %call the function only if we are considering 2
                    %different tenst
                    if (k <j) || (k>j)
                        [index]=check_dependece(tents(:,:,j),tents(:,:,k));
                    end
                    if index>0
                        tentDependencies(j,index) = k;
                    end
                end
            end
            ii = ii+n_odd;
        elseif i==0
            ii = ii + n_even;
        end
        i = i+1;

    end
    
end
function verticalSeam = find_optimal_vertical_seam(cumulativeEnergyMap)
    V = zeros(size(cumulativeEnergyMap,1),1);
    line = cumulativeEnergyMap(size(cumulativeEnergyMap,1),:);
    j = find(line == min(line));    
    if size(j, 2) > 1
        j = j(1);
    end
    V(size(V,1)) = j;
    for i=size(V,1)-1:-1:1
        j = new_index(j, cumulativeEnergyMap(i,:));
        V(i) = j;
    end
    verticalSeam = V;
end

function newInd = new_index(j, e)
    ind = e(j);
    num = j;
    if (j-1)~=0
        ind = [ind e(j-1)];
        num = [num j-1];
    end
    if (j+1)<size(e,2)
        ind = [ind e(j+1)];
        num = [num j+1];
    end
    newInd = num(find(ind == min(ind)));
    if size(newInd, 2) > 1
        newInd = newInd(1);
    end
end
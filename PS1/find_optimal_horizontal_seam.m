function horizontalSeam = find_optimal_horizontal_seam(cumulativeEnergyMap)
    V = zeros(1,size(cumulativeEnergyMap,2));
    line = cumulativeEnergyMap(:,size(cumulativeEnergyMap,2));
    i = find(line == min(line));
    if size(i, 1) > 1
        i = i(1);
    end
    V(size(V,2)) = i;
    for j=size(V,2)-1:-1:1
        i = new_index2(i, cumulativeEnergyMap(:,j));
        V(j) = i;
    end
    horizontalSeam = V;
end

function newInd = new_index2(i, e)
    ind = e(i);
    num = i;
    if i-1~=0
        ind = [ind e(i-1)];
        num = [num i-1];
    end
    if i+1<size(e,2)
        ind = [ind e(i+1)];
        num = [num i+1];
    end
    newInd = num(find(ind == min(ind)));
    if size(newInd, 2) > 1
        newInd = newInd(1);
    end
end
function [nearInd, score] = getNearestRawDescriptor(ind1, desc1, desc2)
    %return index of nearest Raw Descriptor
    distances = dist2(desc1(ind1,:), desc2);
    %get first 2 distances and calculate ratio;
   [M,I] = min(distances); %1 x 1723
   nearInd = I(1);   
   %calculate score ratio of first closest match to second closest
   %match
   M2 = min(distances(distances~=M(1)));
   score = M/M2;
end
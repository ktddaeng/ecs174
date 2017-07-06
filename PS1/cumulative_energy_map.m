function cumulativeEnergyMap = cumulative_energy_map(energyImage, seamDirection)
    M = zeros(size(energyImage));
    %Check if seamDirection = 'HORIZONTAL', 'VERTICAL'
    if strcmp(seamDirection, 'VERTICAL')
        M(1,:) = energyImage(1,:);
        for i = 2:size(energyImage,1)
            for j = 1:size(energyImage,2)
                x = M(i-1,j);
                if j-1~=0
                    x = [x M(i-1, j-1)];
                end
                if j+1<size(energyImage,2)
                    x = [x M(i-1, j+1)];
                end
                M(i,j) = energyImage(i,j) + min(x);
            end
        end
    elseif strcmp(seamDirection, 'HORIZONTAL')
        M(:,1) = energyImage(:,1);
        for j = 2:size(energyImage,2)
            for i = 1:size(energyImage,1)
                x = M(i,j-1);
                if i-1~=0
                    x = [x M(i-1, j-1)];
                end
                if i+1<size(energyImage,1)
                    x = [x M(i+1, j-1)];
                end
                M(i,j) = energyImage(i,j) + min(x);
            end
        end
    else
        fprintf('Error: invalid seam direction \n');
    end
    
    cumulativeEnergyMap = M;
end
function ResultDescriptor = HOGdescriptor(gradient_magnitude,gradient_angle)%,cell_x,cell_y,bolck_x,bolok_y)
%%��ȡͼ���HOG����ֱ��ͼ
    cellSize = 4;%cell��С
    blockSize = 2;%block��С
    orient=9;               %����ֱ��ͼ�ķ������
    jiao=180/orient;        %ÿ����������ĽǶ���
    
    [r,c] = size(gradient_magnitude);
    cells = zeros(r/cellSize,c/cellSize,orient);%ǰ����Ϊcell��λ�ã�������Ϊcell�ڵĽǶ�ֵͳ��
    blocks = zeros(r/cellSize/blockSize,r/cellSize/blockSize,blockSize*blockSize*orient);
    indexi = 1;
    for i = 1:cellSize:r
        indexj = 1;
        for j = 1:cellSize:c
            %������ǰcell�ڵĽǶ�ֵ
            for p = 0:cellSize-1
                for q = 0:cellSize-1
                    for angIndex = 1:orient
                        if gradient_angle(i+p,j+q)<(jiao*(angIndex)-90)
                            cells(indexi,indexj,angIndex) = cells(indexi,indexj,angIndex) + gradient_magnitude(i+p,j+q);
                            break;
                        end
                    end
                end
            end
            indexj = indexj +1;
        end
        indexi = indexi+1;
    end
    [xblockNum,yblockNum,wblockNum] = size(blocks);
    ResultDescriptor = zeros(xblockNum*yblockNum*wblockNum:1);
    blockindex = 1;
    for i = 1:xblockNum
        for j = 1:yblockNum
            xcell = blockSize*i-1;
            ycell = blockSize*j-1;
            blocks(i,j,1:9) = cells(xcell,ycell,:);
            blocks(i,j,10:18) = cells(xcell,ycell+1,:);
            blocks(i,j,19:27) = cells(xcell+1,ycell,:);
            blocks(i,j,28:36) = cells(xcell+1,ycell+1,:);
            blocks(i,j,:) = blocks(i,j,:)./(abs(max(blocks(i,j,:)))+eps);%��һ��
            ResultDescriptor((blockindex-1)*wblockNum+1:blockindex*wblockNum) = blocks(i,j,:);
            blockindex= blockindex+1;
        end
    end
end
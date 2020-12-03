function ResultDescriptor = HOGdescriptor(gradient_magnitude,gradient_angle,cellSize,blockSize)%,cell_x,cell_y,bolck_x,bolok_y)
% ��ȡͼ���HOG����ֱ��ͼ
%img������ͼ���uint8����
%imgSize: һ������Ϊ2��һά����imgSize(1)��ʾͳһ��С��ͼƬ��������imgSize(1)��ʾͳһ��С��ͼƬ������
%cellSize: cell����Ĵ�С��cell����Ϊsize*size�ľ�������
%blockSize: block����Ĵ�С��block����Ϊsize*size�ľ�������

%%ͼ����
%     img_gray = rgb2gray(img);
%     r=imgSize(1);
%     c=imgSize(2);
%     img_gray = imresize(img_gray,[r,c],'bilinear');%ʹ��˫���Բ�ֵ�㷨��ͼƬ������ָ����С
    
%     [gradient_magnitude,gradient_angle] = computeGradient(img_gray,1);%��ȡͼ��ÿ������ݶȷ�ֵ�Լ��Ƕ�
    
    %��ʼ��cell��block��������ݣ���������ͼƬ��任��128*128�ķ��Σ���cell��block����״��Ϊ���Σ���˽�ͨ��r�ʹ�С���Լ��������
    cellNum = r/cellSize();%cell����
    blockNum = cellNum/blockSize();%cell����
    
    orient=9;%����ֱ��ͼ�ķ������
    jiao=180/orient;%ÿ����������ĽǶ���
    
    [r,c] = size(gradient_magnitude);
    cells = zeros(cellNum,cellNum,orient);%ǰ����Ϊcell��λ�ã�������Ϊcell�ڵĽǶ�ֵͳ��
    blocks = zeros(blockNum,blockNum,blockSize*blockSize*orient);%ǰ����Ϊblock��λ�ã�������Ϊcell�ڵĽǶ�ֵͳ��
    
    %ͳ���ݶ�ֱ��ͼ���õ�ÿ��cell����Ҫ�ݶȵķ��򣬼�ͼ�����ر仯���ķ���
    indexi = 1;
    for i = 1:cellSize:r
        indexj = 1;
        for j = 1:cellSize:c
            %������ǰcell�ڵĽǶ�ֵ��
            for p = 0:cellSize-1
                for q = 0:cellSize-1
                    for angIndex = 1:orient%Ѱ�Ҳ�ͬ�Ƕ�������ݶȽǶ�
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
            %�������ڵ�ǰblock������cell���ݶȷ���ֱ��ͼ���õ�һ��2*2*9=36ά������
            temp = cat(2,cells(xcell,ycell,:),cells(xcell,ycell+1,:),cells(xcell+1,ycell,:),cells(xcell+1,ycell+1,:));
            temp = temp(:)';
            blocks(i,j,:) = temp/(abs(max(temp))+eps);%��һ��
            ResultDescriptor((blockindex-1)*wblockNum+1:blockindex*wblockNum) = blocks(i,j,:);
            blockindex= blockindex+1;
        end
    end
end

% �Ƚ��������Բ�ֵ��Ч��
% img = imread('./������/0_0_1.jpg');
% img_gray = rgb2gray(img);
% img_gray = imresize(img_gray,[128,128],'nearest');%ʹ��˫���Բ�ֵ�㷨��ͼƬ������ָ����С
% subplot(131);
% imshow(img_gray);
% img_gray = imresize(img_gray,[128,128],'bilinear');%ʹ��˫���Բ�ֵ�㷨��ͼƬ������ָ����С
% subplot(132);
% imshow(img_gray);
% img_gray = imresize(img_gray,[128,128],'bicubic');%ʹ��˫���Բ�ֵ�㷨��ͼƬ������ָ����С
% subplot(133);
% imshow(img_gray);
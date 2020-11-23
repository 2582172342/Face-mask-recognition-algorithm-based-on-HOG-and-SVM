function trainingImg()
    positive_path = 'D:/�����ѧϰ/������/����ͼ����_ׯ�ҿ�/�γ����/���ݼ�/������2/';
    negative_path = 'D:/�����ѧϰ/������/����ͼ����_ׯ�ҿ�/�γ����/���ݼ�/������2/';
    posExamples=dir(positive_path);%��ȡ�ļ����������.jpgͼƬ
    [PosSampleNums , ~]=size(posExamples);
    negExamples=dir(negative_path);%��ȡ�ļ����������.jpgͼƬ
    [negSampleNums , ~]=size(negExamples);
%     negSampleNums=300;
%     PosSampleNums=90;
    TrainData=zeros(PosSampleNums+negSampleNums,9216);%���ڱ���ѵ�����ݵľ���������������������ά�����ı�cell��block�Լ�ͼ���ͳһ��Сʱ��Ҫ�ı�
    TrainLabel=zeros(PosSampleNums+negSampleNums,1);
    TrainLabel(1:PosSampleNums)=ones(1,PosSampleNums);%1��������0�Ǹ���
    for i=3:PosSampleNums
        ImgN=posExamples(i).name;
        ImgPath=strcat(positive_path,ImgN); %ͼƬ��·��
        CurrentImg=imread(ImgPath);
        %imshow(CurrentImg)
        'pos:'
        i%�����ǰ����
        result = HOGdescriptor(CurrentImg,[128,128],4,2);
%     [result,tidutu,Dir,Cells] = Hog(grayImg);
        TrainData(i,:)=result;
    end
    for i=3:negSampleNums
        'neg:'
        i%�����ǰ����
        ImgN=negExamples(i).name;
        ImgPath=strcat(negative_path,ImgN); %ͼƬ��·��
        CurrentImg=imread(ImgPath);
        result = HOGdescriptor(CurrentImg,[128,128],4,2);
%     [result,tidutu,Dir,Cells] = Hog(grayImg);
        TrainData(i+PosSampleNums,:)=result;    
    end
        %SVMѵ��
    model = fitsvm(TrainLabel,TrainData);
    save('lower2.mat','model');
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
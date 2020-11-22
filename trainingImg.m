function trainingImg()
    positive_path = './������/';
    negative_path = './������/';
    posExamples=dir(positive_path);%��ȡ�ļ����������.jpgͼƬ
    [PosSampleNums , ~]=size(posExamples);
    negExamples=dir(negative_path);%��ȡ�ļ����������.jpgͼƬ
    [negSampleNums , ~]=size(negExamples);
    TrainData=zeros(PosSampleNums+negSampleNums,9216);%�����Hog����ֵ����������
    TrainLabel=zeros(PosSampleNums+negSampleNums,1);
    TrainLabel(1:PosSampleNums)=ones(1,PosSampleNums);%1��������0�Ǹ���
    for i=3:PosSampleNums
        ImgN=posExamples(i).name;
        ImgPath=strcat(positive_path,ImgN); %ͼƬ��·��
        CurrentImg=imread(ImgPath);
        %imshow(CurrentImg)
        'pos:'
        i%�����ǰ����
        img_gray = rgb2gray(CurrentImg);
        img_gray = imresize(img_gray,[128,128],'bilinear');%ʹ��˫���Բ�ֵ�㷨��ͼƬ������ָ����С
        [r,c] = size(img_gray);
        [gradient_magnitude,gradient_angle] = computeGradient(img_gray,1);
        result = HOGdescriptor(gradient_magnitude,gradient_angle);
%     [result,tidutu,Dir,Cells] = Hog(grayImg);
        TrainData(i,:)=result;
    end
    for i=3:negSampleNums
        'neg:'
        i%�����ǰ����
        ImgN=negExamples(i).name;
        ImgPath=strcat(negative_path,ImgN); %ͼƬ��·��
        CurrentImg=imread(ImgPath);
        img_gray = rgb2gray(CurrentImg);
        img_gray = imresize(img_gray,[128,128],'bilinear');%ʹ��˫���Բ�ֵ�㷨��ͼƬ������ָ����С
        [r,c] = size(img_gray);
        [gradient_magnitude,gradient_angle] = computeGradient(img_gray,1);
        result = HOGdescriptor(gradient_magnitude,gradient_angle);
%     [result,tidutu,Dir,Cells] = Hog(grayImg);
        TrainData(i+PosSampleNums,:)=result;    
    end
        %SVMѵ��
    model = fitcsvm(TrainData,TrainLabel);%����ӳ��Ч����rbf�ã���������ά������ѵ���������£����ģʽʶ���һ����ҵ�ķ���
    positives;
    negatives;
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
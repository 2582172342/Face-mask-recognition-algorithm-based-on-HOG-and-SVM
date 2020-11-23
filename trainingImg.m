function trainingImg()
    positive_path = 'D:/�����ѧϰ/������/����ͼ����_ׯ�ҿ�/�γ����/���ݼ�/������2/';
    negative_path = 'D:/�����ѧϰ/������/����ͼ����_ׯ�ҿ�/�γ����/���ݼ�/������2/';
    posExamples=dir(positive_path);%��ȡ�ļ����������.jpgͼƬ
    [posSampleNums , ~]=size(posExamples);
    negExamples=dir(negative_path);%��ȡ�ļ����������.jpgͼƬ
    [negSampleNums , ~]=size(negExamples);
%     negSampleNums=300;
%     PosSampleNums=90;
    trainData=zeros(posSampleNums+negSampleNums,9216);%���ڱ���ѵ�����ݵľ���������������������ά�����ı�cell��block�Լ�ͼ���ͳһ��Сʱ��Ҫ�ı�
    trainLabel=zeros(posSampleNums+negSampleNums,1);
    trainLabel(1:posSampleNums)=ones(1,posSampleNums);%1��������0�Ǹ���
    for i=3:posSampleNums
        imgName=posExamples(i).name;
        ImgPath=strcat(positive_path,imgName); 
        current=imread(ImgPath);%��ȡͼƬ
        result = HOGdescriptor(current,[128,128],4,2);
        trainData(i,:)=result;
    end
    for i=3:negSampleNums
        imgName=negExamples(i).name;
        ImgPath=strcat(negative_path,imgName); 
        current=imread(ImgPath);%��ȡͼƬ
        result = HOGdescriptor(current,[128,128],4,2);
        trainData(i+posSampleNums,:)=result;    
    end
    %SVMѵ��
    model = fitsvm(trainLabel,trainData);%���Էָ�
    save('lower2.mat','model');
end


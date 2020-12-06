function trainingImg()
    positive_path = 'C:/Users/����/Desktop/����ͼ����γ����/���ݼ�/svmѵ����������/';
    negative_path = 'C:/Users/����/Desktop/����ͼ����γ����/���ݼ�/svmѵ����������/';
    posExamples=dir(positive_path);%��ȡ�ļ����������.jpgͼƬ
    [posSampleNums , ~]=size(posExamples);
    negExamples=dir(negative_path);%��ȡ�ļ����������.jpgͼƬ
    [negSampleNums , ~]=size(negExamples);
     negSampleNums=300;
     posSampleNums=90;
    trainData=zeros(posSampleNums+negSampleNums,34596);%���ڱ���ѵ�����ݵľ���������������������ά�����ı�cell��block�Լ�ͼ���ͳһ��Сʱ��Ҫ�ı�
    trainLabel=zeros(posSampleNums+negSampleNums,1);
    trainLabel(1:posSampleNums)=ones(1,posSampleNums);%1��������0�Ǹ���
    for i=3:posSampleNums
        'pos'
        i
        imgName=posExamples(i).name;
        ImgPath=strcat(positive_path,imgName); 
        current=imread(ImgPath);%��ȡͼƬ
        result = HOGdescriptor(current,[128,128],4,2);
        trainData(i,:)=result;
    end
    for i=3:negSampleNums
        'neg'
        i
        imgName=negExamples(i).name;
        ImgPath=strcat(negative_path,imgName); 
        current=imread(ImgPath);%��ȡͼƬ
        result = HOGdescriptor(current,[128,128],4,2);
        trainData(i+posSampleNums,:)=result;    
    end
    %SVMѵ��
    model = fitcsvm(trainData,trainLabel);%���Էָ�
    save('lower_fitcsvm.mat','model');
end


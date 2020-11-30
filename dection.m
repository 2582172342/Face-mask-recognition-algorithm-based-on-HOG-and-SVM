function [face_num , masked] = dection(img,model)
faceDetector = vision.CascadeObjectDetector();%������������,�ٷ�������ʹ�� haar �����������沿����ģ��
%����xml�ļ�Ϊ����Զ���ģ�ͣ��������ĳ���ض����ϵ�ʶ����
% faceDetector.ClassificationModel='FrontalFaceLBP'; %ʹ�ñ��ض�����ģʽ (lbp) �������沿����
faceDetector.MergeThreshold=7;%��γ��Ժ�ɸѡ����������ֵ���������ƴ���ͼ��ɹ�ͼ������ƽ��
%����ѵ����trainCascadeObjectDetector() �� ROIΪ����Ȥ������Ҫ���ĸ���������ʼ��x ��ʼ��y ��width ��height ������bbox��
% lo = load('model.mat');
% model = lo.model;
% file_path='E:\Desktop\���ּ��\�½��ļ���\';
save_path='C:/Users/����/Desktop/����ͼ����γ����/���ݼ�/ͷ��ü�����/';
% path_list=dir(strcat(file_path,'*.jpg'));
% img_num=length(path_list);
label = zeros();%�������
result = 1;
% if img_num>0
%     for j=1:img_num
%         image_name=path_list(j).name;
%         I=imread(strcat(file_path,image_name));
I = img;
%faceDetector.ScaleFactor = size(I)/(size(I)-0.5);
bbox=step(faceDetector,I);%bbox�Ĳ����ֲ���ʾ[x y width height]��step����ʹ��faceDetector������ͼ��I���ж�߶ȵĶ�����
faceOut = insertObjectAnnotation(I,'rectangle',bbox,'face'); %����bbox���ݶԼ�⵽����������
face_num = length(bbox(:,1));%��⵽����������
masked = 0;%��������������
for k = 1:face_num
    %
    faceout1=imcrop(I,bbox(k,:));%����bbox�е����ݽ�ȡ����ͷ��
    faceout2=imresize(faceout1,[128,128]);%����ͼƬ�ߴ�
    resultHog = HOGdescriptor(faceout2,[128,128],4,2);
    %             [labelpre,~,~] = svmpredict(1,resultHog,model);
    labelpre = predict(model,resultHog);%����model�������Դ�����ͼ�����ݽ���Ԥ����࣬ʹ��Ĭ�ϲ���
    %label
    if labelpre == 1 %1��ʾ��ͼƬ���˿���
        drawRectangleImage(bbox(k,1),bbox(k,1)+bbox(k,3),bbox(k,2),bbox(k,2)+bbox(k,4),'g');%�̿�
        masked = masked + 1;
    else
        drawRectangleImage(bbox(k,1),bbox(k,1)+bbox(k,3),bbox(k,2),bbox(k,2)+bbox(k,4),'r');%���
    end
    label(result)=labelpre; %�洢�������
    imwrite(faceout2,strcat(save_path,strcat(num2str(result),'.tif'))); % ����ȡ��������ͼƬ���汾��
    result = result+1;
end

end
% end
% end
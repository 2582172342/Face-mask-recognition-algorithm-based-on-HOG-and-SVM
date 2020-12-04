function [face_num , masked] = dection(model)
faceDetector = vision.CascadeObjectDetector();
faceDetector.MergeThreshold=7;
file_path='D:/�����ѧϰ/������/����ͼ����_ׯ�ҿ�/�γ����/���ݼ�/���Լ�2/';
% file_path='C:/Users/����/Desktop/����ͼ����γ����/���ݼ�/�������ݼ�/';

save_path='D:/�����ѧϰ/������/����ͼ����_ׯ�ҿ�/�γ����/���ݼ�/���/';
path_list=dir(strcat(file_path,'*.jpg'));
img_num=length(path_list);
label = zeros();

result = 1;
masked = 0;%��������������
unmasked = 0;
if img_num>0
    for j=1:img_num
        image_name=path_list(j).name;
        I=imread(strcat(file_path,image_name));
        bbox=step(faceDetector,I);%bbox�Ĳ����ֲ���ʾ[x y width height]��step����ʹ��faceDetector������ͼ��I���ж�߶ȵĶ�����
        %faceOut = insertObjectAnnotation(I,'rectangle',bbox,'face'); %����bbox���ݶԼ�⵽����������
        face_num = length(bbox(:,1));%��⵽����������
        for k = 1:face_num
            faceout1=imcrop(I,bbox(k,:));%����bbox�е����ݽ�ȡ����ͷ��
            faceout2=imresize(faceout1,[128,128]);%����ͼƬ�ߴ�
            %ͼ��Ԥ����
            %Gamma��һ�������Ϊ�Ҷ�ͼ��gΪ��һ��ϵ��
            faceout2 = gamma1(faceout2,2);

            [gradient_magnitude,gradient_angle] = computeGradient(faceout2,1);%��ȡͼ��ÿ������ݶȷ�ֵ�Լ��Ƕ�
            resultHog = HOGdescriptor(gradient_magnitude,gradient_angle,4,2);
            
            % ʹ��libsvmԤ�Ⲣ���Ԥ����ʵķ��� [labelpre,~,~] = svmpredict(1,resultHog,model);
            
            labelpre = predict(model,resultHog);%����model�������Դ�����ͼ�����ݽ���Ԥ����࣬ʹ��Ĭ�ϲ���
            %label
            if labelpre == 1 %1��ʾ��ͼƬ���˿���
                masked = masked + 1;
            else
                unmasked = unmasked + 1;
            end
            label(result)=labelpre; %�洢�������
            imwrite(faceout2,strcat(save_path,strcat(num2str(result),'.tif'))); % ����ȡ��������ͼƬ���汾��
            result = result+1;
        end
    end
end
label
result
masked
unmasked
end
function drawRectangleImage(xColMin,xColMax,yRowMin ,yRowMax,color)
%���ƿ����
hold on 
plot([xColMin xColMax],[yRowMin yRowMin],color)%��1��
plot([xColMin xColMax],[yRowMax yRowMax],color)%���һ��
plot([xColMin xColMin],[yRowMin yRowMax],color)%��һ��
plot([xColMax xColMax],[yRowMin yRowMax],color)%���һ��
end


% function drawRectangleImage(p1,p2)%������򣬷ֱ���������ߣ��ұ����ߣ�������ߣ��������
function drawRectangleImage(xColMin,xColMax,yRowMin ,yRowMax,color)%������򣬷ֱ���������ߣ��ұ����ߣ�������ߣ��������
% xColMin = p1(2);
% xColMax = p2(2); 
% yRowMin = p1(1);
% yRowMax = p2(1);
hold on 
plot([xColMin xColMax],[yRowMin yRowMin],color)
plot([xColMin xColMax],[yRowMax yRowMax],color)
plot([xColMin xColMin],[yRowMin yRowMax],color)
plot([xColMax xColMax],[yRowMin yRowMax],color)
end


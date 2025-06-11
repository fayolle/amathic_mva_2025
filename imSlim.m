function rgbOut = imSlim(rgbIn, b)
if (nargin==1)
    b = 0.5;
end

hsv = rgb2hsv(rgbIn);
v = hsv(:,:,3);
% normalize
minV = min(v(:));
maxV = max(v(:));
v = (v-minV)./(maxV-minV);
% gamma correction
q = min(0.4+3./(4+maxV),(1+maxV)/2);
v = v.^q;
mv = mean(v(:));
p = 1.0-0.2*(0.5+atan(100*mv-5)/pi);
r = 0.01;
% enhancement
u = imguidedfilter(v);
v = v./(u.^p+r);
hsv(:,:,3) = (1-b)*v+b*adapthisteq(v);
hsv(:,:,2) = hsv(:,:,2)*0.6;
rgbOut = hsv2rgb(hsv);
end

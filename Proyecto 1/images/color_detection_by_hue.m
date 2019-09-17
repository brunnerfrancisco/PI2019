function output = color_detection_by_hue(I,sThresh,vThresh)
if nargin > 0
    if nargin < 3
        sThresh = [0.1 1];
        vThresh = [0.1 1];
    else
        sThresh = [min(sThresh) max(sThresh)];
        vThresh = [min(vThresh) max(vThresh)];
    end
    
    % color recognization
    hsvI = rgb2hsv(I);
    hueI = round(hsvI(:,:,1)*360);
    satI = hsvI(:,:,2);
    valI = hsvI(:,:,3);
    threshI = (satI>=sThresh(1))&(satI<=sThresh(2))&(valI>=vThresh(1))&(valI<=vThresh(2));
    
    black = (valI<vThresh(1));
    white = (satI<sThresh(1))&(valI>=vThresh(1));
    red = ((hueI<=30)|(hueI>330))&threshI;
    yellow = ((hueI>30)&(hueI<=90))&threshI;
    green = ((hueI>90)&(hueI<=150))&threshI;
    cyan = ((hueI>150)&(hueI<=210))&threshI;
    blue = ((hueI>210)&(hueI<=270))&threshI;
    magenta = ((hueI>270)&(hueI<=330))&threshI;
    
    output.black = black;
    output.white = white;
    output.red = red;
    output.yellow = yellow;
    output.green = green;
    output.cyan = cyan;
    output.blue = blue;
    output.magenta = magenta;
    
end
end
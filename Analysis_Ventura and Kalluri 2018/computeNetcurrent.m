function [NetIKLCurrent] = computeNetcurrent(Outputdata)

s=size(Outputdata.gKLsave); % figure out how many sweeps to analyze

for l=1:s(1) % for each of these compute and plot the lower envelope
clear findLOCS findPKS LOCS PKS ;
test=Outputdata.Ioutput(l).Iltk_rm(5e4:2e5); % extract the spiking portion
[findPKS,findLOCS]= findpeaks(-test); % findpeaks of the inverted signal will find the minima.

if findLOCS(1)>1
PKS(1) = -test(1); % This is a cluge that makes it such that the first value is the beginning of the curve.
LOCS(1) = 1; 
PKS = [PKS;findPKS]; %append the peaks found
LOCS = [LOCS;findLOCS];
else
    PKS=findPKS;
    LOCS=findLOCS;
end

if findLOCS(end)<length(test)
    LOCS(end+1)=length(test);
    PKS(end+1) = -test(end);
end

figure(l)
plot(test,'b'); hold on
plot(LOCS,-PKS,'r*')

interpfit = createInterpFit(LOCS, PKS);
sample = 1:length(test);
y(l,:)=-interpfit(sample);

figure(l) 
plot(sample,y(l,:),'k');

NetIKLCurrent(l) = sum(y(l,:));

end

figure (l+1); plot(Outputdata.gKLsave, NetIKLCurrent,'b*')
ylabel('NetIKLcurrent');
xlabel('gKL');


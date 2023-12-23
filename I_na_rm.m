function I=I_na_rm(V)

global m_na_rm h_na_rm gb_na_rm Ena dt

% n=3 represents 'present' time value
n=3;

% Calculate m & h infinity and m & h tau (time constant) as funciton of
% present V
[mi tau_m]=inf_tau_m_rm(V);
[hi tau_h]=inf_tau_h_rm(V);

m_na_rm(n)=(2*dt*(-m_na_rm(n-1)+mi)/tau_m+4*m_na_rm(n-1)-m_na_rm(n-2))*1/3;
h_na_rm(n)=(2*dt*(-h_na_rm(n-1)+hi)/tau_h+4*h_na_rm(n-1)-h_na_rm(n-2))*1/3;

% Update relative time of w value
m_na_rm(n-2)=m_na_rm(n-1);
m_na_rm(n-1)=m_na_rm(n);
% Update relative time of z value
h_na_rm(n-2)=h_na_rm(n-1);
h_na_rm(n-1)=h_na_rm(n);
    
I=gb_na_rm*m_na_rm(n)^3*h_na_rm(n)*(V-Ena);

end
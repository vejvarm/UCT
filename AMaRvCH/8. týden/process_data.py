
# coding: utf-8

# In[1]:


from mpl_toolkits import mplot3d

import pandas as pd
import numpy as np
from matplotlib import pyplot as plt


# In[2]:


df = pd.read_excel('mereni - zesilovace.xlsx')


# In[3]:


df.head


# In[4]:


df_g11_z10 = df.iloc[1:10,1:4]
df_g11_z100 = df.iloc[1:10,4:7]
df_g12 = df.iloc[13:22,1:4]
df_g13 = df.iloc[26:34,1:4]
df_g14 = df.iloc[41:57,1:4]
df_g15 = df.iloc[60:66,1:3]


# In[5]:


df_g11_z10.columns = ['U1 (V)', 'U2 (V)', 'Z ~ -10']
df_g11_z100.columns = ['U1 (V)', 'U2 (V)', 'Z ~ -100']
df_g12.columns = ['U1 (V)', 'U2 (V)', 'Z ~ 11']
df_g13.columns = ['R ($\Omega$)', 'U1 (V)', 'U2 (V)']
df_g14.columns = ['U1a (V)', 'U1b (V)', 'Suma (V)']
df_g15.columns = ['I_vst (mA)', 'U_vyst (V)']


# In[6]:


df_g14


# In[7]:


df_g21 = df.iloc[5:21,12:15]
df_g22 = df.iloc[24:35,12:14]
df_g23 = df.iloc[39:45,12:14]
df_g24_rz100k = df.iloc[49:62,12:14]
df_g24_rz10k = df.iloc[49:64,14:16]


# In[8]:


df_g21.columns = ['U1 (V)', 'U3 (V)', 'Rozdil (V)']
df_g22.columns = ['cas (hh:mm:ss)', 'U2 (V)']
df_g23.columns = ['U1 (V)', 'U2 (V)']
df_g24_rz100k.columns = ['U1 (V)', 'U2 (V)']
df_g24_rz10k.columns = ['U1 (V)', 'U2 (V)']


# In[9]:


df_g21


# In[10]:


def plot_results(df, x='U1 (V)', y='U2 (V)', title='', secondary_y=None, y_teor=None, styles=['bo', 'r-', 'g-']):
    ax = [None]*2
    fig, ax[0] = plt.subplots()
    
    ax[0].plot(df[x], df[y], styles[0], label=y[1] if isinstance(y,list) else y)
    if isinstance(y_teor, np.ndarray):
        ax[0].plot(df[x], y_teor, styles[2], label=y[1]+' (teor.)' if isinstance(y,list) else y+' (teor.)')
    
    ax[0].set_xlabel(x)
    ax[0].set_ylabel(y)
    
    if secondary_y:
        ax[1] = ax[0].twinx()
        ax[1].plot(df[x], df[secondary_y], styles[1], label=secondary_y)
        ax[1].set_ylabel(secondary_y)
    
        lines = ax[0].get_lines() + ax[1].get_lines()
    else:
        lines = ax[0].get_lines()
    
    ax[0].legend(lines, [line.get_label() for line in lines])
    
    ax[0].set_title(title)
    ax[0].grid(True, which='major')
    
    return fig, ax


# In[11]:


# G1.1 Invertující zesilovač
fields_z10 = list(df_g11_z10)
fields_z100 = list(df_g11_z100)

# teoreticke vypocty
R1 = 1000;
R2_z10 = 10000;
R2_z100 = 100000;

# z10
u1_z10 = np.array(df_g11_z10[fields_z10[0]])
u2_z10_t = -R2_z10*u1_z10/R1

# z100
u1_z100 = np.array(df_g11_z100[fields_z100[0]])
u2_z100_t = -R2_z100*u1_z100/R1

# vykreslení
fig, ax = plot_results(df_g11_z10, 
                       title=r'Invertující zesilovač (Z ~ -10)',
                       secondary_y=fields_z10[2],
                       y_teor=u2_z10_t)

fig, ax = plot_results(df_g11_z100, 
                       title=r'Invertující zesilovač (Z ~ -100)',
                       secondary_y=fields_z100[2],
                       y_teor=u2_z100_t)

plt.show()


# In[12]:


# G1.2 Neinvertující zesilovač
fields = list(df_g12)

# teoreticke vypocty
R1 = 1000;
R2 = 10000;

# z10
u1 = np.array(df_g12[fields[0]])
u2_t = (1+R2/R1)*u1

# vykreslení
plot_results(df_g12, 
             title=r'Neinvertující zesilovač (Z ~ 11)',
             secondary_y=fields[2],
             y_teor=u2_t)

plt.show()


# In[13]:


# G1.3 Napěťový sledovač
fields = list(df_g13)

# teoreticke vypocty
u1 = np.array(df_g13[fields[1]])
u2_t = u1

# vykreslení
fig, ax = plot_results(df_g13, x=fields[0], y=fields[1:],
                       title='Napěťový sledovač',
                       y_teor=u2_t)

lines = ax[0].get_lines()
lines[0].set_label('U1 (V)')
lines[1].set_color('red')
lines[1].set_linestyle('-')
ax[0].legend(lines, [line.get_label() for line in lines])

plt.show()


# In[14]:


lines[0].get_label()


# In[15]:


# TODO: G1.4 Sumační zesilovač
fields = list(df_g14)

u1a = np.array(df_g14[fields[0]])
u1b = np.array(df_g14[fields[1]])
suma = np.array(df_g14[fields[2]])

print(suma)

# vykreslení
ax = plt.axes(projection='3d')

ax.scatter(u1a, u1b, suma)

ax.set_xlabel(r'U1a (V)')
ax.set_ylabel(r'U1b (V)')
ax.set_zlabel(r'suma (V)')

plt.show()


# In[16]:


# G1.5 Převodník proudu na napětí
fields = list(df_g15)

# teoreticke vypocty
ivst = np.array(df_g15[fields[0]])
uvyst_t = -ivst

plt.figure()
plot_results(df_g15, x=fields[0], y=fields[1], y_teor=uvyst_t, title=r'Převodník proudu na napětí')


# In[17]:


# TODO: G2.1 Rozdílový zesilovač


# In[18]:


# G2.2 Integrační zesilovač
fields = list(df_g22)

# převod na datetime
df_g22[fields[0]] = pd.to_datetime(df_g22[fields[0]],format='%H:%M:%S')

# teoreticke vypocty
R = 100000  # ohm
C = 14.1*10**-6  # F
u1 = 0.2  # V
u2_0 = 0.001 # V

t = np.array(df_g22[fields[0]].dt.minute*60 + df_g22[fields[0]].dt.second) # cas trvani pokusu v sekundach
u2_t = -u2_0 - 1/R/C*u1*t  # V

# vykreslení
plt.figure()
plot_results(df_g22, x=fields[0], y=fields[1], y_teor=u2_t, title=r'Integrační zesilovač')

plt.show()


# In[19]:


# G2.3 Komparátor bez hystereze
# teoreticky vypocet
U2max = 15  # V
U2min = -15  # V
UR = 5  # V
R1 = 1000  # ohm
RR = 1000  # ohm

u1 = np.linspace(4,5.2,50)
u2_t = np.array([U2max if u1[i] < UR else U2min for i in range(len(u1))])

# vykreslení
plt.figure()
fig, ax = plot_results(df_g23, title=r'Komparátor bez hystereze', styles=['bo-'])

ax[0].plot(u1, u2_t, '-g', label='U2 (V) teor')
lines = ax[0].get_lines()
ax[0].legend(lines, [line.get_label() for line in lines])

plt.show()


# In[20]:


# G2.4 Komparátor s hysterezí
def komp_s_hysterezi(R1,RZ,u1,U2min,U2max):
    
    # inicializace
    u2_t = np.zeros_like(u1)
    
    # hystereze
    UH = R1/(R1+RZ)*(U2max - U2min)
    
    # vypocet u2
    for i in range(len(u1)):
        if u1[i] <= (UR - UH):
            u2_t[i] = U2max
        elif u1[i] >= (UR + UH):
            u2_t[i] = U2min
        else:
            u2_t[i] = u2_t[i-1]
            
    return u2_t


# In[21]:


fields_rz100k = list(df_g24_rz100k)
fields_rz10k = list(df_g24_rz10k)

# teoreticke vypocty
# A (RZ = 100kohm)
U2max = 15  # V
U2min = -15  # V
UR = 5  # V
R1 = 1000  # ohm
RR = 1000  # ohm
RZ = 100000  # ohm

# vstupni napeti
U1min = min(df_g24_rz100k[fields_rz100k[0]])
U1max = max(df_g24_rz100k[fields_rz100k[0]])
u1 = np.hstack((np.linspace(U1min,U1max,25),np.linspace(U1max,U1min,25)))

# vystupni napeti
u2_t = komp_s_hysterezi(R1,RZ,u1,U2min,U2max)

# vykreslení
plt.figure()
fig, ax = plot_results(df_g24_rz100k, title=r'Komparátor s hysterezí ($R_Z$ = 100 k$\Omega$)', styles=['bo-'])

ax[0].plot(u1, u2_t, '-g', label='U2 (V) teor')
lines = ax[0].get_lines()
ax[0].legend(lines, [line.get_label() for line in lines])

# B (RZ = 10kohm)
RZ = 10000

# vstupni napeti
U1min = min(df_g24_rz10k[fields_rz10k[0]]) - 2
U1max = max(df_g24_rz10k[fields_rz10k[0]]) + 2.5
u1 = np.hstack((np.linspace(U1min,U1max,25),np.linspace(U1max,U1min,25)))

# vystupni napeti
u2_t = komp_s_hysterezi(R1,RZ,u1,U2min,U2max)

plt.figure()
fig, ax = plot_results(df_g24_rz10k, title=r'Komparátor s hysterezí ($R_Z$ = 10 k$\Omega$)', styles=['bo-'])

ax[0].plot(u1, u2_t, '-g', label='U2 (V) teor')
lines = ax[0].get_lines()
ax[0].legend(lines, [line.get_label() for line in lines])

plt.show()


# In[22]:


(UR + UH)


# In[ ]:



    


# In[ ]:


ax = [None]*2

fig, ax[0] = plt.subplots()
ax[0].plot(df_g12['U1 (V)'], df_g12['U2 (V)'])
plt.draw()

ax[1] = ax[0].twinx()
ax[1].plot(df_g12['U1 (V)'], df_g12['Z ~ 11'])
    
a1 = ax[0].get_lines() + ax[1].get_lines()
lines = []
lines.extend(axi.get_lines() for axi in ax if axi)

print(a1)
print(lines)


# In[ ]:


isinstance(u2_z10_t, np.ndarray)


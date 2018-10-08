# -- coding: cp1250 --
import math
import pandas as pd
from matplotlib import pyplot as plt

def load_data(filename, path='./', delimiter='\t', usecols=None):
    """ load the data from filename in specified path"""

    df = pd.read_csv(path + filename, delimiter=delimiter, header=0, usecols=usecols, encoding='cp1250')
    df['Time'] = pd.to_datetime(df['Time'], format='%M:%S.%f')

    return df

def identify_first_order(time, values):
    """get the gain and time constant of a first order system from a series of values"""

    # find extremes of temperature in data
    t_min, t_min_index = (min(values), values.idxmin())
    t_max, t_max_index = (max(values), values.idxmax())

    # find the equivalent of 63.2% value change
    t_632 = t_min + (t_max - t_min)*0.632

    # find the closest value to the t_632 and its index
    t_closest = values.iloc[(values - t_632).abs().argsort()[2:3]]

    # find the index of first value change (beginning of change)
    start_index = find_first_change(values)

    # compute the time constant and gain
    gain = t_max - t_min
    time_const = time[t_closest.index] - time[start_index]

    return gain, float(time_const.dt.total_seconds())

def find_first_change(series):
    """find the index of first value change in the input series"""

    s_min = min(series)

    for index, value in enumerate(series):
        if value > s_min:
            return index

def plot_first_order(r0, T, tspan, t0=0, y0=0, down=False):

    if t0:
        tspan0 = [t-t0 for t in tspan]
    else:
        tspan0 = tspan

    if down:
        values = [y0 + r0*(math.exp(-t/T)-1) for t in tspan0]
    else:
        values = [y0 + r0*(1-math.exp(-t/T)) for t in tspan0]

    plt.plot(tspan, values, '-.r', alpha=0.6, linewidth=2)

def plot_results(dframe, r0, T, handle=1):

    # time span of the measurements in seconds
    tspan_seconds = dframe['Time'].dt.minute * 60 + dframe['Time'].dt.second + dframe['Time'].dt.microsecond / 1e6

    # important indices
    start_index = find_first_change(dframe['Temp'])  # index of the first change in value
    max_index = dframe['Temp'].idxmax()              # index of the maximum value

    # slices for significant parts of the measurements
    rising_part = slice(start_index, max_index)
    declining_part = slice(max_index, None)

    plt.figure(handle)
    plt.plot(tspan_seconds, dframe['Temp'], alpha=0.6, linewidth=2)         # plot the measured data
    plot_first_order(r0, T, tspan_seconds[rising_part],
                     t0=tspan_seconds[start_index],
                     y0=dframe['Temp'][0])                     # plot the identified series rising part
    plot_first_order(r0, T, tspan_seconds[declining_part],
                     t0=tspan_seconds[max_index],
                     y0=dframe['Temp'][max_index], down=True)  # plot the identified series rising part

    plt.title('Porovnání naměřených hodnot s identifikovanou soustavou')
    plt.xlabel('čas (s)')
    plt.ylabel('teplota (°C)')
    plt.legend(['naměřené hodnoty', 'identifikovaná soustava'])
    plt.grid()
    plt.show()


if __name__ == '__main__':
    dframe = load_data('pyro_dynamika.txt')

    gain, time_constant = identify_first_order(dframe['Time'], dframe['Temp'])

    print('r0 = {:.1f} \nT = {:.1f} s'.format(gain, time_constant))

    plot_results(dframe, gain, time_constant)

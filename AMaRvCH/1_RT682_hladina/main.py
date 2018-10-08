# -- coding: cp1250 --
import pandas as pd
import os

from matplotlib import pyplot as plt
from matplotlib import dates as mdates
from datetime import datetime

def load_data(filename, path='./', delimiter='\t', usecols=None):
    """ load the data from filename in specified path"""

    df = pd.read_csv(path + filename, delimiter=delimiter, header=0, usecols=usecols, encoding='cp1250')
    df['Time Index'] = pd.to_datetime(df['Time Index'], format='%H:%M:%S')
#    df['Time Index'] = df['Time Index'].apply(lambda x: x.strftime('%M:%S.%f'))
#    df['Time Index'] = df['Time Index'].dt.strftime('%M:%S.%f')
    df = df.rename(index=str, columns={'Time Index': 'čas (m:s.ms)',
                                           'X1 in mm': 'aktuální výška hladiny (mm)',
                                           'W1 in mm': 'požadovaná výška hladiny (mm)',
                                           'Y1 in %': 'aktuální příkon čerpadla (%)',
                                           'F1 in l/h': 'průtok soustavou (l/h)'},
                   )

    return df

def plot_data(ax, df, x, y, y2, y2_secondary):

    df.plot(kind='line', x=x, y=y, alpha=0.8, ax=ax[0], linewidth=1.5)
    df.plot(kind='line', x=x, y=y2, alpha=0.8, ax=ax[1], linewidth=1.5)
    ax2 = df.plot(kind='line', x=x, y=y2_secondary, alpha=0.8, ax=ax[1], secondary_y=True, linewidth=1.5)

    format_axes(ax[0], 'Hladina vody ve výměníku', 'čas (min)', 'w, y (mm)')
    format_axes(ax[1], 'Příkon čerpadla / Průtok soustavou', 'čas (min)', 'u (%)', ax2=ax2, ax2_ylabel='z (l/h)')


def format_axes(ax, title, xlabel, ylabel, time_format='%M', ax2=None, ax2_ylabel=None):

    ax.set_title(title)
    ax.set_xlabel(xlabel)
    ax.set_ylabel(ylabel)
    ax.grid(color='k', linestyle=':', alpha=0.3)
    ax.autoscale(enable=True, axis='x', tight=True)
    ax.xaxis.set_major_locator(mdates.MinuteLocator())
    ax.xaxis.set_major_formatter(mdates.DateFormatter(time_format))
    plt.setp(ax.xaxis.get_majorticklabels(), rotation=45)

    if ax2:
        ax2.set_ylabel('z (l/h)')


if __name__ == '__main__':
    folder = './data/'

    for (index, filename) in enumerate(os.listdir(folder)):
        dataframe = load_data(filename, folder)
        if index == 1:
            dataframe = dataframe[100:]
        fig, ax = plt.subplots(nrows=2, ncols=1, tight_layout=True)
        plot_data(ax, dataframe, 0, [1, 2], [3], [7])
        plt.draw()
    plt.show()
#    date_dt = [datetime.strptime(x, '%M:%S.%f') for x in dataframe['cas (m:s.ms)'].values]

#    print(date_dt)

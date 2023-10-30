import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import scipy.signal as sig

def signal_generate():
    f1 = 5.0
    f2 = 10.0 #信号频率
    t = np.arange(0, 1.0, 0.001)
    y1 = np.sin(2*np.pi*f1*t)
    y2 = np.cos(2*np.pi*f2*t) #最高频率 fc=10, 2fc=20
    y = y1 + y2
    plt.plot(t, y, 'r') #拟合函数图像
    plt.xlabel('$t$')
    plt.ylabel('$f(t)$')
    plt.title('analog signal')
    plt.grid()
    plt.show()
    return t, y

time, signal = signal_generate()

def sampling(fs):
    sampling_point = np.arange(0, 1.0, 1.0/fs)
    sampling_signal = signal[0:1000:int(1000/fs)]
    # plt.scatter(sampling_point, sampling_signal, color='r', zorder=2)
    # plt.plot(sampling_point, sampling_signal, color='b', zorder=1)
    plt.stem(sampling_point, sampling_signal, linefmt='grey', markerfmt="C0.")
    plt.xlabel('$t$')
    plt.ylabel('$f(t)$')
    plt.title('samplied signal')
    plt.grid()
    plt.show()
    return sampling_point, sampling_signal

sampling_point, sampling_signal = sampling(100)

def sampling_cmp():
    plt.subplot(1, 2, 1)
    plt.plot(time, signal, 'r')
    plt.scatter(sampling_point, sampling_signal, s=10)
    plt.xlabel('$t$')
    plt.ylabel('$f(t)$')
    plt.grid()
    plt.title('sampling process')

    plt.subplot(1, 2, 2)
    plt.plot(sampling_point, sampling_signal)
    plt.xlabel('$t$')
    plt.ylabel('$f(t)$')
    # plt.ylim(0, 2)
    plt.grid()
    plt.title('sampling result')
    plt.tight_layout()
    plt.show()

# sampling_cmp()

def restoring(fs): # fs 应大于 2fc
    fc = 10
    sampling_y = [signal[i] if i % int(1000/fs) == 0 else 0 for i in range(0, 1000)]
    b, a = sig.iirdesign(0.08, 2*fc/fs, 1, 40)
    x = np.arange(0, 1.0, 0.001)
    y = (1000 / fs) * sig.filtfilt(b, a, sampling_y)
    plt.plot(x, signal, 'r')
    plt.plot(x, y, 'b--')
    plt.ylim(-2.5, 2.5)
    plt.xlabel('$t$')
    plt.ylabel('$f(t)$')
    plt.title('restored signal')
    plt.grid()
    plt.show()
    return y

recsig = restoring(40)
#计算FFT和IFFT
import numpy as np
import matplotlib.pyplot as plt

def fft(x):  #基2FFT算法
    x = np.asarray(x, dtype=complex)
    N = x.shape[0]
    if N % 2 > 0:
        raise ValueError("must be a power of 2") # 不符合要求报错
    elif N <= 2:   # 这种情况下直接返回DFT
        n = np.arange(N)
        k = n.reshape((N, 1))
        M = np.exp(-2j * np.pi * n *k/ N)
        return np.dot(M, x)
    else:
        X_even = fft(x[::2])  # 偶数组
        X_odd = fft(x[1::2])  # 奇数组
        terms = np.exp(-2j * np.pi * np.arange(N) / N)
        return np.concatenate([X_even + terms[:int(N/2)] * X_odd,
                               X_even + terms[int(N/2):] * X_odd])

def ifft(x): #直接使用FFT子程序运算ifft
    g = fft(np.conj(x))
    x = np.asarray(x, dtype=complex)
    N = x.shape[0]
    return np.conj(g) / N

k = np.arange(0, 16, 1)
x = k

X = fft(x)
xi = np.fft.ifft(X)  #ifft序列
for i in range(8):
    if np.imag(xi[i]) < 0.001:
        xi = np.real(xi)

#绘制幅频相频图像
plt.figure(figsize=(8, 6), dpi=80)
plt.subplot(121)
plt.stem(k, np.abs(X), use_line_collection=True)
plt.grid()
plt.xlabel('$k$')
plt.ylabel('$|X(K)|$')
plt.title('FFT Amplitude')

plt.subplot(122)
plt.stem(k, np.angle(X), use_line_collection=True)
plt.grid()
plt.xlabel('$k$')
plt.ylabel('$\mathrm{arg}[X(k)]$')
plt.title('FFT phase')
plt.tight_layout()
plt.show()

plt.figure(figsize=(8, 6), dpi=80)
plt.subplot(121)
plt.stem(k, np.abs(xi), use_line_collection=True)
plt.grid()
plt.xlabel('$n$')
plt.ylabel('$|x(n)|$')
plt.title('IFFT Amplitude')

plt.subplot(122)
plt.stem(k, np.angle(xi), use_line_collection=True)
plt.grid()
plt.xlabel('$n$')
plt.ylabel('$\mathrm{arg}[x(n)]$')
plt.title('IFFT phase')
plt.tight_layout()
plt.show()
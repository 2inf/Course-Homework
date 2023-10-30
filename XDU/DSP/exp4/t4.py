import numpy as np
import matplotlib.pyplot as plt

def FFT_Vec(x):
	x = np.asarray(x, dtype=float)
	N = x.shape[0]
	if np.log2(N) % 1 > 0:
		raise ValueError("must be a power of 2")
	N_base = min(N, 2)
	n = np.arange(N_base)
	k = n[:, None]
	X = np.dot(np.exp(-2j * np.pi * n * k / N_base), x.reshape((N_base, -1)))
	while X.shape[0] < N:
		X_even = X[:, :X.shape[1] // 2]
		X_odd = X[:, X.shape[1] // 2:]
		factor = np.exp(-1j * np.pi * np.arange(X.shape[0]) / X.shape[0])[:, None]
		X = np.vstack([X_even + factor * X_odd, X_even - factor * X_odd])
	return X.ravel()

def func(t):
	return 2 * np.cos(t) + np.sin(2 * t)

t = np.linspace(0, 4 * np.pi, 1000)
nt = np.arange(0, 4 * np.pi, np.pi / 8)

plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False

plt.figure(figsize=(8, 6), dpi=80)
plt.subplot(121)
plt.plot(t, func(t), 'y', linewidth=2.0, label=r'$x_a(t)$')
plt.stem(nt, func(nt), linefmt='b', basefmt='k-', markerfmt='C0o')
plt.legend(loc='upper right')
plt.grid()
plt.xlabel('$t$')
plt.ylabel('$x_a(t)$')
plt.title('采样过程')

plt.subplot(122)
n = np.arange(0, 32)
xn = func(np.pi * n / 8)
plt.stem(n, xn, linefmt='r', basefmt='k-', markerfmt='C0o', label=r'$x(n)$')
plt.legend(loc='upper right')
plt.grid()
plt.xlabel('$n$')
plt.ylabel('$x(n)$')
plt.title('采样得到的序列')
plt.tight_layout()
plt.show()

n = np.mat(n)
omega = np.arange(0, 2*np.pi , 2*np.pi /1000)
X = xn * np.exp(-1j*n.T*omega)
X = X.T

plt.figure(figsize=(8, 6), dpi=80)
plt.subplot(121)
plt.plot(omega , np.abs(X), 'g', linewidth =1.0)
plt.grid()
plt.xlabel('$\omega$ ')
plt.ylabel('$|X(e^{j\omega })|$')
plt.title('DTFT Amplitude ')

plt.subplot(122)
plt.plot(omega , np.angle(X), 'b', linewidth =1.0)
plt.grid()
plt.xlabel('$\omega$ ')
plt.ylabel('$\mathrm{arg}[X(e^{j\omega })]$')
plt.title('DTFT Phase')
plt.tight_layout()
plt.show()

n = np.arange(0, 32)
X = FFT_Vec(xn)

plt.figure(figsize=(8, 6), dpi=80)
plt.subplot(121)
plt.stem(n, np.abs(X), linefmt='r', basefmt='k-', markerfmt='C0o')
plt.grid()
plt.xlabel('$k$')
plt.ylabel('$|X(K)|$')
plt.title('FFT Amplitude')

plt.subplot(122)
plt.stem(n, np.angle(X), linefmt='r', basefmt='k-', markerfmt='C0o')
plt.grid()
plt.xlabel('$k$')
plt.ylabel('$\mathrm{arg}[X(k)]$')
plt.title('FFT Phase')
plt.tight_layout()
plt.show()
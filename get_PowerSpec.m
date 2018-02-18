function power_spec = get_PowerSpec(vec)

Y = fft(vec);
Pyy = Y.* conj(Y) / length(vec);
power_spec = Pyy ;
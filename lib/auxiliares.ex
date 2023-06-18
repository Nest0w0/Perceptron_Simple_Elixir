defmodule Auxiliares do

  def producto([head1 | tail1],[head2 | tail2]) do
    [head1 * head2 | producto(tail1, tail2)]
  end

  def producto([], []) do
    []
  end

  def generarPesos(n) when n > 0 do
    import :rand, only: [uniform: 0]
    [uniform()] ++ generarPesos(n-1)
  end

  def generarPesos(n) when n <= 0 do
    []
  end

  def generarListaNeuronas(num_neuronas) when num_neuronas > 0 do
    nueva_neurona = Perceptron.nuevo(0, 3)
    [nueva_neurona | generarListaNeuronas(num_neuronas - 1)]
  end

  def generarListaNeuronas(num_neuronas) when num_neuronas <= 0 do
    []
  end


end

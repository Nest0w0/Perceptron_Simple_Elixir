defmodule Capa do

  @enforce_keys [:num_neuronas, :razon_aprendizaje]
  defstruct [
    :num_neuronas,
    :neuronas,
    :razon_aprendizaje
  ]

  def nuevo(n, r) do
    neuronas = for _ <- 1..n, do: Perceptron.nuevo(0,5)
    %Capa{num_neuronas: n, neuronas: neuronas, razon_aprendizaje: r}
  end

  def nuevo(n, r, lista_pesos) do
    neuronas = for i <- 0..(n - 1), do: Perceptron.nuevo(0, Enum.at(lista_pesos, i))
    %Capa{num_neuronas: n, neuronas: neuronas, razon_aprendizaje: r}
  end

  def procesar(entrada, capa) do
    for i <- 0..(capa.num_neuronas - 1), do: Perceptron.salida(entrada, Enum.at(capa.neuronas, i))
  end

  def maximoResultado(entrada, capa) do
    procesar(entrada, capa) |> Enum.max()
  end

  def salida(entrada, capa) do
    pos = procesar(entrada, capa) |> Enum.find_index(fn x -> maximoResultado(entrada, capa) == x  end)
    n = capa.num_neuronas - 1
    for x <- 0..n, do: (if (x == pos) do 1 else 0 end)
  end


  def entrenar(capa, [erh|ert]) do
    capa_actualizada = actualizarNeuronas(capa, erh)
    entrenar(capa_actualizada, ert)
  end

  def entrenar(capa, []) do
    capa
  end

  def actualizarNeuronas(capa, er) do
    entrada = er.entrada
    esperado = er.esperado
    obtenido = salida(entrada, capa)
    nuevas_neuronas = for i <- 0..(capa.num_neuronas - 1), do: Enum.at(capa.neuronas, i) |> Perceptron.actualizarPesos(entrada, Enum.at(esperado, i), Enum.at(obtenido, i), capa.razon_aprendizaje)
    %{capa | neuronas: nuevas_neuronas}
  end

end

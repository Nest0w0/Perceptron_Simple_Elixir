defmodule Perceptron do

  @enforce_keys [:umbral, :pesos]
  defstruct [:umbral , :pesos]

  def nuevo(umbral, n) when is_integer(n) do
    import :rand, only: [uniform: 0]
    pesos = for _ <- 1..n, do: uniform()*2 - 1
    %Perceptron{umbral: umbral, pesos: pesos}
  end

  def nuevo(umbral, pesos) do
    %Perceptron{umbral: umbral, pesos: pesos}
  end

  def dispersion(entrada, perceptron) do
    longitud = length(entrada)
    ponderacion = for i <- 0..(longitud-1), do: Enum.at(entrada, i)*Enum.at(perceptron.pesos,i)
    Enum.sum(ponderacion)
  end

  def sigmoide(sumatoria) do
    import :math, only: [exp: 1]
    1/(1 + exp(-sumatoria))
  end

  def salida(entrada, perceptron) do
    dispersion(entrada, perceptron) |> sigmoide()
  end

  def actualizarPesos(perceptron, entrada, v_esperado, v_obtenido, razon_aprendizaje) do
    n = length(perceptron.pesos) - 1
    nuevos_pesos = for i <- 0..n, do: Enum.at(entrada, i)*razon_aprendizaje*(v_esperado - v_obtenido) + Enum.at(perceptron.pesos, i)
    %{perceptron | pesos: nuevos_pesos}
  end

end

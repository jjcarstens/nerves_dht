# nerves_dht

<!-- DOCS -->

Read DHT sensor (Digital Humidity and Temparature)

Example usage:

```elixir
iex> defmodule MyGenServer do
        use NervesDht
      end
:ok
iex> {:ok, dht} = MyGenServer.start_link({2, 22})
:ok
iex> {:ok, humidity, temperature} = MyGenServer.info(dht)
{:ok, 41.3, 27.22}
```

You can use `listen` too listen event of sensor too.
For example:

```
iex> defmodule MyGenServer do
        use NervesDht
        def listen({:ok, p, s, h, t}) do
          IO.puts("Listen event on MyGenServer")
          IO.puts("Pin: #{p}, Sensor: #{s}\n")
          IO.puts("Temperature: #{t}, Humidity: #{h})\n")
        end
      end
:ok
iex> {:ok, dht} = MyGenServer.start_link({2, 22})
:ok
Listen event on MyGenServer
Pin: 2, Sensor: 22
(Temperature: 41.3, Humidity: 27.20)
Listen event on MyGenServer
Pin: 2, Sensor: 22
(Temperature: 41.2, Humidity: 27.25)
```

<!-- DOCS -->

# Driver
Driver used is [https://github.com/adafruit/Adafruit_Python_DHT](https://github.com/adafruit/Adafruit_Python_DHT)

# Variable Environment

# Sample
[https://github.com/esdrasedu/nerves_dht_sample](https://github.com/esdrasedu/nerves_dht_sample)

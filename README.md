
# Gem Bom Tempo

If you need information about the weather in a specific city? This gem Offers a weather forecast for the next 5 days of a city.


## Author

- [@welitonjjose](https://github.com/welitonjjose/)


## Installation


```bash
  gem install bomtempo
```

Obs:
credential is required in https://openweathermap.org/

```ruby
  Bomtempo.config do |c|
    c.access_token = "OPEN_WEATHER_MAP_TOKEN"
  end
```

    
## How use

```ruby
    Bomtempo.weather_in({
        city: "São Paulo",
        state: "SP",
        country: "BR
    })
```


## Licence

[MIT](https://choosealicense.com/licenses/mit/)


# Load the prophet library
library(prophet)

# Load the data
data <- read.csv("C:\\Users\\GG671LB\\OneDrive - EY\\Progetti\\AI\\TimeSeries-Days.csv", sep = ";", header = TRUE)

# Convert the "Time" column to Date format in the desired format ("%d/%m/%Y" to "%Y-%m-%d")
data$Time <- as.Date(data$Time, format = "%d/%m/%Y")

# Remove non-numeric characters from the "ClosingPrice" column
data$ClosingPrice <- as.numeric(gsub("[^0-9.]", "", data$ClosingPrice))

# Remove rows with NAs in the "Time" or "ClosingPrice" columns
data <- data[complete.cases(data), ]

# Prepara i dati nel formato richiesto da Prophet
data <- data.frame(ds = as.character(data$Time), y = data$ClosingPrice)

# Crea un nuovo oggetto Prophet
model <- prophet(data)

# Genera un periodo futuro di previsione
future <- make_future_dataframe(model, periods = 7)

# Effettua la previsione
forecast <- predict(model, future)

# Visualizza il risultato del forecast
tail(forecast[c("ds", "yhat", "yhat_lower", "yhat_upper")])

# Visualizzazione del risultato del forecast
plot(model, forecast)

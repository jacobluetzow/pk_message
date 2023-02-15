# Pk Message

## About
This application "processes" messages received in order by printing message text to the terminal. Each queue that receives a message will "process" one message a second, no matter how quickly the message are submitted to the `GET /receive_message/:queue/:message`. Messages received on different queues will "process" simultaneously, and any following messages in those queues will then be "processed" every second.

When this project's running, it will also start a GenServer process called ProcessingServer to keep the message queue state, executing code asynchronously. 



To start Pk Message server:

#### INSTALL DEPENDENCIES
```
mix deps.get
```

#### RUN TESTS
```
mix test
```

#### START PROJECT
```
mix phx.server
```


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.



To send message
[`localhost:4000/api/receive_message/:queue/:message`](http://localhost:4000/api/receive-message/queue1/This%20is%20a%20%20message!)

#### Example
```
curl http://localhost:4000/api/receive-message/queue1/This%20is%20a%20%20message!
```
Output
```
Queue: queue1, Message: This is a  message!
```




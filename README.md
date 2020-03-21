# DIY task
As a part of this interview stage we would like to give you a coding task which solution will be the main topic on our next conversation.

Tips:
* Write tests for each application (we will expect to see some)
* Do not overengineer
* Prepare to reason about design decisions

## Step 1: The "consoleapp"
Implement a console application which takes one argument `-n` (sequence length) and prints a Fibonacci sequence multiplication table in the `STDOUT`.

### What is?
* [Fibonacci sequence](https://www.mathsisfun.com/numbers/fibonacci-sequence.html)
* [Multiplication table](https://www.mathsisfun.com/tables.html)

### Technology
Your choice.

### Example
```bash
$> consoleapp -n 4

  0 1 1 2
0 0 0 0 0
1 0 1 1 2
1 0 1 1 2
2 0 2 2 4

$> consoleapp -n 5

  0 1 1 2 3
0 0 0 0 0 0
1 0 1 1 2 3
1 0 1 1 2 3
2 0 2 2 4 6
3 0 3 3 6 9
```

## Step 2: The "backapp"
Wrap the "consoleapp" in a web application and expose it as a REST API. This application should also have a database in which the generated Fibonacci sequences could be cached if requested (check Step 3).

### Technology
#### Web
Your choice. It will be nice if you can use the "consoleapp" as a library, so using the same programming language for both might be a good idea.

#### Database
Your choice.

### Expected result
A web application with two API endpoints:

#### Generate Fibonacci
This endpoint should check if we have a cached version of the sequence in the database which satisfies the request and:
* if found - Return a JSON representation of the cached result.
* if not found - Generate a new Fibonacci sequence using the "consoleapp" and return a JSON representation of it.

##### Request
```
GET http://localhost:3000/fibonacci?n=4
```

##### Response
```json
# HTTP 200
# Content-Type: application/json

[
  [null, 0, 1, 1, 2],
  [   0, 0, 0, 0, 0],
  [   1, 0, 1, 1, 2],
  [   1, 0, 1, 1, 2],
  [   2, 0, 2, 2, 4]
]
```

#### Generate & Cache Fibonacci
This endpoint should use the "consoleapp" to generate a Fibonacci sequence, cache it in the database and return a JSON representation of it.

##### Request
```
POST http://localhost:3000/fibonacci
(Content-Disposition: form-data; n="4")
```

##### Response
```json
# HTTP 200
# Content-Type: application/json

[
  [null, 0, 1, 1, 2],
  [   0, 0, 0, 0, 0],
  [   1, 0, 1, 1, 2],
  [   1, 0, 1, 1, 2],
  [   2, 0, 2, 2, 4]
]
```

## Step 3: The "frontapp"
Write a Sinatra Ruby application which will consume the "backapp" API and will serve it as HTML.

### Technology
[Ruby](https://www.ruby-lang.org/) + [Sinatra](http://sinatrarb.com/)

You can find a starting point for your Sinatra application [here](https://github.com/dobrinov/interviewing/tree/master/questions/webapp/frontapp).

#### Request
```
GET http://localhost:4567/fibonacci
```

#### Response
![GET http://localhost:4567/fibonacci](initial.png)

#### Request
```
GET http://localhost:4567/fibonacci?n=4
```

#### Response
![GET http://localhost:4567/fibonacci?n=4](generated.png)

#### Request
```
POST http://localhost:4567/fibonacci
(Content-Disposition: form-data; n="4")
```

#### Response
![POST http://localhost:4567/fibonacci (form-data n=4)](saved.png)

## Step 4: Version control
Push the code to a public git reposotory (Github, Gitlab, Bitbucket, etc.) and share a link with us prior the interview. It will be nice if you have a good commit history (do not put everything in a single commit).

# Interview task
We will look at your implementation, discuss it and modify it a bit.

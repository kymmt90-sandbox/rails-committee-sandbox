User.destroy_all

User.create(
  [
    { email: 'foo@example.com', name: 'foo', age: 20 },
    { email: 'bar@example.com', name: 'bar', age: 43 },
    { email: 'fizz@example.jp', name: 'fizz', age: 9 },
    { email: 'buzz@example.shop', name: 'buzz', age: 78 }
  ]
)

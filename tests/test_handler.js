const { handler } = require('../lambda/handler');

test('returns 200', async () => {
  const res = await handler({});
  expect(res.statusCode).toBe(200);
});


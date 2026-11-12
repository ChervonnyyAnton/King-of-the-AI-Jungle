/** @type {import('@playwright/test').PlaywrightTestConfig} */
module.exports = {
  testDir: './tests',
  timeout: 15000,
  expect: {
    timeout: 5000
  },
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  reportSlowTests: { max: 5, threshold: 10000 },
  projects: [
    { name: 'setup', testMatch: /.*\.setup\.ts/ },
    { name: 'playwright-test', testMatch: /.*\.spec\.ts/, dependencies: ['setup'] },
  ],
};

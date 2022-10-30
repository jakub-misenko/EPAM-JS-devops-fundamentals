/*
 * For a detailed explanation regarding each configuration property and type check, visit:
 * https://jestjs.io/docs/en/configuration.html
 */

export default {
  // Automatically clear mock calls and instances between every test
  preset: 'jest-preset-angular',
  setupFilesAfterEnv: ['<rootDir>/setup-jest.ts'],
  globalSetup: 'jest-preset-angular/global-setup',

  clearMocks: true,

  coveragePathIgnorePatterns: [
    '.husky',
    '.github',
    'e2e',
    'node_modules',
    'scripts',
  ],
  collectCoverage: true,
  coverageThreshold: {
    coverageThreshold: {
      global: {
        branches: 20,
        functions: 20,
        lines: 20,
        statements: 20,
      },
    },
  },
  coverageDirectory: 'coverage',

  // The test environment that will be used for testing
  testEnvironment: 'jsdom',

  // The glob patterns Jest uses to detect test files
  testMatch: ['**/__tests__/**/*.[jt]s?(x)', '**/?(*.)+(spec|test).[tj]s?(x)'],

  // An array of regexp pattern strings that are matched against all test paths, matched tests are skipped
  testPathIgnorePatterns: ['node_modules'],
};

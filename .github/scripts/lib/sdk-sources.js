// Per-SDK configuration for the SDK docs sync (see .github/scripts/sdk-sync.js).
//
// The hiero-ledger SDK repos are the source of truth. For each SDK this file
// describes:
//  - classFile:  which source files hold one public Transaction/Query class each
//  - methods():  how to pull public method names out of one of those files
//  - identity(): how to read the canonical package name from the upstream manifest
//  - pins:       explicit install pins in the docs that track the latest release.
//                Only install snippets belong here. "Available in vX.Y.Z+"
//                feature minimums must never be auto-bumped.
//  - legacy:     retired package/repo identifiers that should no longer appear in docs

'use strict';

const VERSION = String.raw`\d+\.\d+\.\d+`;

// Deprecation markers across the SDK languages: JSDoc/Javadoc tags and annotations,
// Go "Deprecated:" comments, Rust #[deprecated], C++ [[deprecated]], Swift @available.
const DEPRECATED = /@deprecated|@Deprecated|\bDeprecated:|#\[deprecated|\[\[deprecated|@available\([^)]*deprecated/;

// Whether the doc comment / attributes directly above a definition mark it deprecated.
// Looks back to the end of the previous member (a line that is only "}").
function isDeprecatedAt(source, offset) {
  const lines = source.slice(0, offset).split('\n');
  lines.pop(); // the definition line itself
  for (let i = lines.length - 1, seen = 0; i >= 0 && seen < 40; i--, seen++) {
    if (/^\s*}\s*$/.test(lines[i])) break;
    if (DEPRECATED.test(lines[i])) return true;
  }
  return false;
}

// Collect capture group 1 of every match, skipping private (underscore) names.
// Deprecated names are left out of the result and listed in result.deprecated; an
// overloaded name counts as current if any overload is not deprecated.
function collect(source, regex, skip = new Set()) {
  const names = new Set();
  const deprecated = new Set();
  for (const match of source.matchAll(regex)) {
    const name = match[1];
    if (name.startsWith('_') || skip.has(name)) continue;
    if (isDeprecatedAt(source, match.index + match[0].length)) deprecated.add(name);
    else names.add(name);
  }
  names.deprecated = new Set([...deprecated].filter(name => !names.has(name)));
  return names;
}

const JS_NON_METHODS = new Set(['constructor', 'if', 'for', 'while', 'switch', 'catch', 'return', 'function']);

function snakeToPascal(name) {
  return name.replace(/(^|_)([a-z0-9])/g, (m, sep, c) => c.toUpperCase());
}

module.exports = {
  js: {
    name: 'JavaScript SDK',
    repo: 'hiero-ledger/hiero-sdk-js',
    classFile: /^src\/(?:.+\/)?([A-Z]\w*(?:Transaction|Query))\.js$/,
    methods: src => collect(src, /^ {4}(?:static\s+)?(?:async\s+)?([A-Za-z]\w*)\s*\(/gm, JS_NON_METHODS),
    identity: {
      file: 'package.json',
      parse: text => JSON.parse(text).name,
    },
    pins: [
      { file: /\.mdx$/, regex: new RegExp(String.raw`(@hiero-ledger/sdk@)(${VERSION})`, 'g') },
      { file: /\.mdx$/, regex: new RegExp(String.raw`("@hiero-ledger/sdk"\s*:\s*"[~^]?)(${VERSION})`, 'g') },
    ],
    legacy: [
      { find: '@hashgraph/sdk', use: '@hiero-ledger/sdk' },
      { find: 'hashgraph/hedera-sdk-js', use: 'hiero-ledger/hiero-sdk-js' },
    ],
  },

  java: {
    name: 'Java SDK',
    repo: 'hiero-ledger/hiero-sdk-java',
    classFile: /^sdk\/src\/main\/java\/com\/hedera\/hashgraph\/sdk\/([A-Z]\w*(?:Transaction|Query))\.java$/,
    // Class-level (4-space indent) public methods; constructors have no return type and do not match.
    methods: src =>
      collect(src, /^ {4}public\s+(?:(?:static|final|synchronized|abstract)\s+)*(?:<[^>]+>\s+)?[\w.<>\[\],? ]+?\s+(\w+)\s*\(/gm),
    identity: {
      file: 'settings.gradle.kts',
      parse: text => {
        const group = text.match(/module\("sdk"\)\s*\{\s*group\s*=\s*"([^"]+)"/);
        return group ? `${group[1]}:sdk` : null;
      },
    },
    pins: [
      { file: /\.(mdx|sh)$/, regex: new RegExp(String.raw`(com\.hedera\.hashgraph:sdk:)(${VERSION})`, 'g') },
      {
        file: /\.mdx$/,
        regex: new RegExp(
          String.raw`(<groupId>com\.hedera\.hashgraph</groupId>\s*<artifactId>sdk</artifactId>\s*<version>)(${VERSION})`,
          'g'
        ),
      },
    ],
    legacy: [{ find: 'hashgraph/hedera-sdk-java', use: 'hiero-ledger/hiero-sdk-java' }],
  },

  go: {
    name: 'Go SDK',
    repo: 'hiero-ledger/hiero-sdk-go',
    classFile: /^sdk\/([a-z0-9_]+_(?:transaction|query))\.go$/,
    className: snakeToPascal,
    // Exported methods on the class's own receiver type (matched case-insensitively,
    // since the struct name is derived from the snake_case file name).
    methods: (src, className) => {
      const names = new Set();
      const deprecated = new Set();
      for (const match of src.matchAll(/^func \(\w+ \*?(\w+)\) ([A-Z]\w*)\(/gm)) {
        const [, receiver, name] = match;
        if (receiver.toLowerCase() !== className.toLowerCase()) continue;
        if (isDeprecatedAt(src, match.index + match[0].length)) deprecated.add(name);
        else names.add(name);
      }
      names.deprecated = new Set([...deprecated].filter(name => !names.has(name)));
      return names;
    },
    identity: {
      file: 'go.mod',
      parse: text => (text.match(/^module\s+(\S+)/m) || [])[1],
    },
    pins: [{ file: /\.mdx$/, regex: new RegExp(String.raw`(hiero-sdk-go/v2(?:@|\s+)v)(${VERSION})`, 'g') }],
    legacy: [{ find: 'hashgraph/hedera-sdk-go', use: 'hiero-ledger/hiero-sdk-go/v2' }],
  },

  python: {
    name: 'Python SDK',
    repo: 'hiero-ledger/hiero-sdk-python',
    classFile: /^src\/hiero_sdk_python\/(?:.+\/)?([a-z0-9_]+_(?:transaction|query))\.py$/,
    className: snakeToPascal,
    methods: src => collect(src, /^ {4}def ([a-z]\w*)\(/gm),
    identity: {
      file: 'pyproject.toml',
      parse: text => (text.match(/^name\s*=\s*"([^"]+)"/m) || [])[1],
    },
    pins: [{ file: /\.mdx$/, regex: new RegExp(String.raw`(hiero[-_]sdk[-_]python==)(${VERSION})`, 'g') }],
    legacy: [{ find: 'hashgraph/hedera-sdk-python', use: 'hiero-ledger/hiero-sdk-python' }],
  },

  swift: {
    name: 'Swift SDK',
    repo: 'hiero-ledger/hiero-sdk-swift',
    classFile: /^Sources\/Hiero\/(?:.+\/)?([A-Z]\w*(?:Transaction|Query))\.swift$/,
    // Builder-style API: a public property plus a same-named chaining func.
    methods: src => collect(src, /^ {4}public\s+(?:(?:override|final|static)\s+)*(?:func|var)\s+(\w+)/gm),
    identity: {
      file: 'Package.swift',
      parse: text => (text.match(/\.library\(\s*name:\s*"([^"]+)"/) || [])[1],
    },
    pins: [
      {
        file: /\.mdx$/,
        regex: new RegExp(String.raw`(hiero-sdk-swift(?:\.git)?"\s*,\s*(?:from|exact)\s*:\s*")(${VERSION})`, 'g'),
      },
    ],
    legacy: [{ find: 'hashgraph/hedera-sdk-swift', use: 'hiero-ledger/hiero-sdk-swift' }],
  },

  rust: {
    name: 'Rust SDK',
    repo: 'hiero-ledger/hiero-sdk-rust',
    classFile: /^src\/(?:.+\/)?([a-z0-9_]+_(?:transaction|query))\.rs$/,
    className: snakeToPascal,
    methods: src => collect(src, /^ {4}pub fn (\w+)/gm),
    identity: {
      file: 'Cargo.toml',
      parse: text => (text.match(/^\[package\][^[]*?^name\s*=\s*"([^"]+)"/ms) || [])[1],
    },
    pins: [{ file: /\.mdx$/, regex: new RegExp(String.raw`(hiero-sdk\s*=\s*"[~^=]?)(${VERSION})`, 'g') }],
    legacy: [
      { find: 'cargo add hedera', use: 'cargo add hiero-sdk' },
      { find: 'hedera = "', use: 'hiero-sdk = "' },
      { find: 'hashgraph/hedera-sdk-rust', use: 'hiero-ledger/hiero-sdk-rust' },
    ],
  },

  cpp: {
    name: 'C++ SDK',
    repo: 'hiero-ledger/hiero-sdk-cpp',
    classFile: /^src\/sdk\/main\/include\/([A-Z]\w*(?:Transaction|Query))\.h$/,
    // Public section of the header only: stop at the first private/protected label.
    methods: src => {
      const publicPart = src.split(/^\s*(?:private|protected)\s*:/m)[0];
      return collect(
        publicPart,
        /^ {2}(?:\[\[nodiscard\]\]\s+)?(?:(?:inline|virtual|static|explicit)\s+)*[\w:<>,*& ]+?[\s*&]([a-z]\w*)\s*\(/gm,
        new Set(['operator'])
      );
    },
    identity: {
      file: 'vcpkg.json',
      parse: text => JSON.parse(text).name,
    },
    pins: [],
    legacy: [{ find: 'hashgraph/hedera-sdk-cpp', use: 'hiero-ledger/hiero-sdk-cpp' }],
  },
};

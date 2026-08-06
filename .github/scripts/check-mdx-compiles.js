#!/usr/bin/env node
// Compile one or more .mdx files with the MDX compiler to catch parse/JSX
// errors before an automated PR ships a page that 404s.
//
// Why this exists: the release-notes automation inserts upstream GitHub
// changelog text verbatim. Mintlify compiles each page as JSX, so a stray
// "<Word...>" token (e.g. "<maxRetries>") is read as an unclosed JSX tag and
// fails the WHOLE page build — the route is dropped (404) and the sidebar label
// falls back to the raw slug. This gate fails the workflow instead.
//
// Usage: node check-mdx-compiles.js <file.mdx> [more.mdx ...]
//
// Note: this validates MDX *syntax* (balanced tags, valid expressions). It does
// not resolve components, so Mintlify components like <Accordion>...</Accordion>
// pass as long as they are well-formed, while "<maxRetries>" (no close) fails.

'use strict';

const fs = require('fs');

async function main() {
  const files = process.argv.slice(2);

  if (files.length === 0) {
    console.error('Usage: node check-mdx-compiles.js <file.mdx> [more.mdx ...]');
    process.exit(2);
  }

  let compile;
  try {
    ({ compile } = await import('@mdx-js/mdx'));
  } catch (error) {
    console.error(
      'ERROR: could not load "@mdx-js/mdx". Install it before running this check ' +
        '(e.g. `npm install --no-save @mdx-js/mdx`).'
    );
    console.error(error.message);
    process.exit(2);
  }

  const failures = [];

  for (const file of files) {
    let source;
    try {
      source = fs.readFileSync(file, 'utf8');
    } catch (error) {
      failures.push({ file, message: `could not read file: ${error.message}` });
      continue;
    }

    try {
      // Strip YAML frontmatter — the bare MDX compiler treats it as a thematic
      // break + content, not metadata. Mintlify parses it separately.
      const body = source.replace(/^---\r?\n[\s\S]*?\r?\n---\r?\n/, '');
      await compile(body);
      console.log(`OK: ${file}`);
    } catch (error) {
      const place = error.line ? ` (line ${error.line}, column ${error.column})` : '';
      failures.push({ file, message: `${error.reason || error.message}${place}` });
    }
  }

  if (failures.length > 0) {
    console.error('\nMDX compile check FAILED:');
    for (const failure of failures) {
      console.error(`  ✗ ${failure.file}: ${failure.message}`);
    }
    console.error(
      '\nThis usually means upstream release text contains a "<...>" or "{...}" token ' +
        'that MDX parses as JSX. The generator should escape it; see ' +
        '.github/scripts/consensus-node-release-entry.js (escapeMdx).'
    );
    process.exit(1);
  }

  console.log(`\nAll ${files.length} file(s) compiled cleanly.`);
}

main();

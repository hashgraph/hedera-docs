'use strict';

// Escape MDX-significant characters in upstream release text so it renders
// literally. Docs pages compile as JSX, so a bare "<" (e.g. "<maxRetries>") is
// parsed as an unclosed JSX tag and fails the WHOLE page build (404), and "{"
// opens a JS expression that is equally fatal. Backslash is escaped first so an
// input like "\<" cannot un-escape a following "<" and re-open the tag. Inline
// `code` spans already treat these as literal, so they are left untouched to
// avoid inserting visible backslashes inside code.
//
// Shared by the consensus- and mirror-node release-notes generators so the two
// stay in sync (see .github/scripts/*-release-entry.js).
function escapeMdx(text) {
  return text
    .split(/(`[^`]*`)/g)
    .map(part =>
      part.startsWith('`')
        ? part
        : part.replace(/\\/g, '\\\\').replace(/[<{]/g, '\\$&')
    )
    .join('');
}

module.exports = { escapeMdx };

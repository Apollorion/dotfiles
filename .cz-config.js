const execSync = require('child_process').execSync;

let gitDiff = execSync('git diff --name-only --cached', {
    encoding: 'utf-8'
});
gitDiff = gitDiff.split("\n");

// Remove last element if its an empty string
const index = gitDiff.indexOf(gitDiff.length - 1);
if (index > -1 && gitDiff[index] == "") {
  gitDiff.splice(index, 1);
}

module.exports = {
    types: [
        {
            value: 'feat',
            name: 'feat:     A new feature'
        },
        {
            value: 'fix',
            name: 'fix:      A bug fix'
        },
        {
            value: 'chore',
            name: 'chore:    Changes to the build process or auxiliary tools\n            and libraries such as documentation generation',
        },
        {
            value: 'docs',
            name: 'docs:     Documentation only changes'
        },
        {
            value: 'style',
            name: 'style:    Changes that do not affect the meaning of the code\n            (white-space, formatting, missing semi-colons, etc)',
        },
        {
            value: 'refactor',
            name: 'refactor: A code change that neither fixes a bug nor adds a feature',
        },
        {
            value: 'perf',
            name: 'perf:     A code change that improves performance',
        },
        {
            value: 'test',
            name: 'test:     Adding missing tests'
        },
        {
            value: 'revert',
            name: 'revert:   Revert to a commit'
        },
        {
            value: 'WIP',
            name: 'WIP:      Work in progress'
        },
    ],
    skipQuestions: ["body", "breaking", "footer"],
    scopes: gitDiff,
    allowTicketNumber: false,
    allowCustomScopes: true,

};
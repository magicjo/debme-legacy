(function (TEMPLATE_GIT_GRAPH, GitGraph) {
    'use strict';

    var bugGraph = new GitGraph({
        template: TEMPLATE_GIT_GRAPH,
        elementId: 'bug',
        mode: 'extended'
    });

    var master = bugGraph.branch('master');

    master.commit('The release branch');

    var bug = master.branch('bug/refs123/css');

    bug.commit('A bug branch, format: `bug/refs{issueId}/{bugName}`');

    bug.commit('commit for bug #123');

    bug.merge(master, {message: 'bug done, merge branch `bug/refs123/css` into `master` (pull request)'});

})(window.TEMPLATE_GIT_GRAPH, GitGraph);

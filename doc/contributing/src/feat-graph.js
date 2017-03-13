(function (TEMPLATE_GIT_GRAPH, GitGraph) {
    'use strict';

    var featGraph = new GitGraph({
        template: TEMPLATE_GIT_GRAPH,
        elementId: 'feat',
        mode: 'extended'
    });

    var master = featGraph.branch('master');

    master.commit('The release branch');

    var us3 = master.branch('us-3/develop');

    us3.commit('A milestone branch, format: `{milestoneId}/develop`');

    var feat12 = us3.branch('us-3/refs12/log');

    feat12.commit('A feature branch, format: `{milestoneId}/refs{issueId}/{featureName}`');

    var feat19 = us3.branch('us-3/refs19/doc');

    feat19.commit('Another one feature branch, format: `{milestoneId}/refs{issueId}/{featureName}`');

    feat19.commit('commit for feature #19');

    feat12.commit('commit for feature #12');

    feat19.merge(us3, {message: '#19 done, merge branch `us-3/refs19/doc` into `us-3/develop` (pull request)'});

    feat12.merge(us3, {message: '#12  done, merge branch `us-3/refs12/log` into `us-3/develop` (pull request)'});

    us3.merge(master, {message: 'us-3 features done, merge branch `us-3/develop` into `master` (pull request)'});

})(window.TEMPLATE_GIT_GRAPH, GitGraph);

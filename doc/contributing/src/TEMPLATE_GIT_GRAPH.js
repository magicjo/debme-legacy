(function (GitGraph, window) {
    'use strict';

    var TEMPLATE = {
        colors: [
            '#979797',
            '#008fb5',
            '#f1c109',
            '#d994f1',
            '#55cef1'
        ],
        branch: {
            lineWidth: 10,
            spacingX: 50,
            labelRotation: 0
        },
        commit: {
            spacingY: -80,
            dot: {
                size: 14
            },
            message: {
                displayAuthor: false,
                displayBranch: true,
                displayHash: false,
                font: 'normal 14pt Arial'
            }
        }
    };

    window.TEMPLATE_GIT_GRAPH = new GitGraph.Template(TEMPLATE);

})(window.GitGraph, window);

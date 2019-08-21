/**
 * @namespace WORKAREA.sortableTables
 */
WORKAREA.registerModule('sortableTables', (function () {
    'use strict';

    var // UI Updates

        updateState = function ($header, direction) {
            if (direction === 'ASC') {
                $header.data('sortableTableHeader', 'DSC');
            } else {
                $header.data('sortableTableHeader', 'ASC');
            }
        },

        addArrow = function ($header, direction) {
            var $arrow = $('<span>').data('sortableTableArrow', true);

            if (direction === 'ASC') {
                $arrow.text('↓');
            } else {
                $arrow.text('↑');
            }

            $header.append($arrow);
        },

        removeArrows = function ($header) {
            $header.siblings().addBack($header)
                .find('> span').filter(function (index, span) {
                    return $(span).data('sortableTableArrow');
                })
                .remove();
        },

        updateUI = function ($header, direction) {
            removeArrows($header);
            addArrow($header, direction);
            updateState($header, direction);
        },

        // Sorting & Reordering DOM

        reorderRows = function ($cells) {
            $cells.each(function (index, cell) {
                $(cell).closest('tr').appendTo($(cell).closest('tbody'));
            });
        },

        sortCells = function ($cells, direction) {
            var result = _.sortBy($cells.get(), [function (cell) {
                return $(cell).text().trim();
            }]);

            return direction === 'ASC' ? $(result) : $(_.reverse(result));
        },

        getCells = function ($table, $header) {
            var columnIndex = $header.index();

            return $table.find('tbody tr').map(function (index, row) {
                return $(row).find('td').eq(columnIndex);
            });
        },

        sort = function (event) {
            var $table = $(event.delegateTarget),
                $header = $(event.currentTarget),
                direction = $header.data('sortableTableHeader') || 'ASC',
                $cells = getCells($table, $header),
                $sortedCells = sortCells($cells, direction);

            reorderRows($sortedCells);
            updateUI($header, direction);
        },

        // Setup

        bindHeaderLinks = function (table) {
            $(table).on('click', '[data-sortable-table-header]', sort);
        },

        convertHeadersToLinks = function (table) {
            $(table)
                .find('[data-sortable-table-header]')
                .addClass('link');
        },

        setup = function (index, table) {
            convertHeadersToLinks(table);
            bindHeaderLinks(table);
        },

        /**
         * @method
         * @name init
         * @memberof WORKAREA.sortableTables
         */
        init = function ($scope) {
            $('[data-sortable-table]', $scope).each(setup);
        };

    return {
        init: init
    };
}()));

function getLanguageFromURL() {
    const regex = new RegExp('[\\?&]lang=([^&#]*)');
    const results = regex.exec(location.search);

    return results === null ? null : decodeURIComponent(results[1].replace(/\+/g, ' '));
}

TradingView.onready(function() {
    var theme = "Light";
    if ( window.location.href.includes('advance-trading') ) {
        theme = "Dark";
    }

    // Change theme to dark
    theme = "Dark";

    var widget = window.tvWidget = new TradingView.widget({
        symbol: gon.market.id,
        // BEWARE: no trailing slash is expected in feed URL
        // tslint:disable-next-line:no-any
        datafeed: new window.Datafeeds.UDFCompatibleDatafeed(`https://${location.host}/api/v2/tradingview`, 60000),
        interval: '15',
        container_id: 'tradingview_35f2bc',
        library_path: '/charting_library/',

        locale: getLanguageFromURL() || 'en',
        disabled_features: ['use_localstorage_for_settings', 'header_symbol_search', 'symbol_search_hot_key', 'header_compare', 'compare_symbol', 'volume_force_overlay'],
        enabled_features: ['study_templates'],
        charts_storage_url: 'https://saveload.tradingview.com',
        charts_storage_api_version: '1.1',
        client_id: 'tradingview.com',
        user_id: 'public_user_id',
        fullscreen: false,
        autosize: true,
        studies_overrides: {},
        debug: true,
        theme: theme
    });

    // widget.onChartReady(() => {
    //     const button = widget.createButton()
    //         .attr('title', 'Click to show a notification popup')
    //         .addClass('apply-common-tooltip')
    //         .on('click', () => widget.showNoticeDialog({
    //             title: 'Notification',
    //             body: 'TradingView Charting Library API works correctly',
    //             callback: () => {
    //                 console.log('Noticed!');
    //             },
    //         }));
    //
    //     button[0].innerHTML = 'Check API';
    // });
});
import consumer from "./consumer"

if (window.location.href.match(/admin/)) {
    consumer.subscriptions.create("OrdersChannel", {
        connected() {
            this.perform('follow')
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received(data) {
            $('.orders-table').prepend(data)
        }
    });
}
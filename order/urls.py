from django.urls import include, path

from order.api.views import cart_view, checkout_view

app_name = 'order'
urlpatterns = [
    path('/cart', include([
        path('/list', cart_view.CartView.as_view({
            'post': 'list'
        }), name='cart-list'),
        path('/add', cart_view.CartView.as_view({
            'post': 'add'
        }), name='cart-add')
    ])),
    path('/checkout', include([
        path('/add', checkout_view.CheckOutView.as_view({
            'post': 'add'
        }), name='checkout-add')
    ]))
]


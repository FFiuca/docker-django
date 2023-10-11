from django.db import models
from safedelete.models import SafeDeleteModel, SOFT_DELETE
from user import models as uModel
from store import models as sModel
from master import models as mModel
from order import model_managers

class Cart(SafeDeleteModel):
    _safedelete_policy = SOFT_DELETE

    customer = models.ForeignKey(uModel.Customer, related_name='cart_customer', on_delete=models.CASCADE)
    item = models.ForeignKey(sModel.UserItem, related_name='cart_item', on_delete=models.CASCADE)
    qty = models.IntegerField(blank=False, default=1)
    status = models.ForeignKey(mModel.Status,
                               related_name='cart_status',
                               on_delete=models.CASCADE,
                               default=mModel.Status.objects.filter(status_int=1, module_name='order.cart').first().pk
                               )
    created_at = models.DateTimeField(blank=False, auto_now_add=True)
    updated_at = models.DateTimeField(blank=True, auto_now=True)

    # for scoping like laravel
    objects = model_managers.CartManager()

    class Meta:
        ordering = ['created_at']

class Checkout(SafeDeleteModel):
    _safedelete_policy = SOFT_DELETE

    checkout_code = models.CharField(blank=False, max_length=100, unique=True)
    customer = models.ForeignKey(uModel.Customer, related_name='checkout_customer', on_delete=models.CASCADE)
    user_store = models.ForeignKey(sModel.UserStore, related_name='checkout_user_store', on_delete=models.CASCADE)
    status = models.ForeignKey(mModel.Status, related_name='checkout_status', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(blank=True, auto_now=True)

    class Meta:
        ordering = ['created_at']
        db_tablespace = 'order_checkout'
        indexes = [
            models.Index(fields=['customer', 'user_store_id'])
        ]

class CheckoutDetail(SafeDeleteModel):
    pass



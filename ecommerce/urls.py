from django.contrib import admin
from django.urls import path, include

from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    # system
    path('admin/', admin.site.urls),
    path('account/', include('django.contrib.auth.urls')),

    # app
    path('user', include('user.urls')),
    path('store', include('store.urls')),
    path('order', include('order.urls')),

    # third
    path("__debug__/", include("debug_toolbar.urls")),
    path('api-auth/', include('rest_framework.urls')),
    path('silk/', include('silk.urls', namespace='silk')),
] + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT) # to add media urls, when use daphne asgi must configured because staticfiles not covered

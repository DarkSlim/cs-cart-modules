{* перезаписали отображение с помощью модуля ms_uni_delivery *}

{script src="js/addons/rus_geolocation/geolocation.js"}

<input type="hidden" id="geo_product_id" value="{$product.product_id}" />
<input type="hidden" name="url_geo_shipping" value="{$config.current_url}">

<div class="cm-ajax" id="geolocation_shipping_methods">
{if $smarty.session.geocity && $show_data}
    <input type="hidden" id="result_ids" value="geolocation_shipping_methods" />

    {if $addons.rus_geolocation.geolocation_shippings == "Y"}
    <div class="ty-geo-shipping__wrapper ms_uni_delivery" id="shipping_methods">

        {if $shipping_methods}

            <div>
                <ul class="shipping_list">
                {foreach from=$shipping_methods item="shipping_method" name="geolocation_shipping_methods"}                    

                    <li class="shipping" id={$shipping_method.shipping_id}>
                        <span class="name">{$shipping_method.shipping}</span>
                        {if $shipping_method.rate != "0"}<span class="price"> - от {include file="common/price.tpl" value=$shipping_method.rate class="ty-geo_shipping_price"}</span>{/if}
                        {if $shipping_method.delivery_time}<span class="delivery_time"> - {$shipping_method.delivery_time}</span>{/if}
                    </li>
                {/foreach}
                </ul>

                {if __("addon.rus_geolocation.title_calculate_shippings")}<p class="shipping_description">{__("addon.rus_geolocation.title_calculate_shippings")}</p>{/if}

            </div>
        {else}
            <span class="ty-geo_title">{__("addon.rus_geolocation.title_not_shippings", ["[city]" => $smarty.session.geocity])}</span>
        {/if}
    </div>
    {/if}
{/if}
<!--geolocation_shipping_methods--></div>

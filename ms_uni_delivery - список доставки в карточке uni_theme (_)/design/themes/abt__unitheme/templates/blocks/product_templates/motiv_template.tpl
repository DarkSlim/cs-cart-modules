{* карточка товара, скопированная с помощью модуля ms_uni_delivery *}

{script src="js/tygh/exceptions.js"}

<div class="ty-product-block ty-product-detail">
    
    <div class="row-fluid  ty-product-block__wrapper clearfix">
        {hook name="products:view_main_info"}
        {if $product}

            {if !$hide_title}
                <h1 class="ty-product-block-title" {live_edit name="product:product:{$product.product_id}"}>{$product.product nofilter}</h1>
            {/if}
            {include file="common/breadcrumbs.tpl"}

            {assign var="obj_id" value=$product.product_id}
            {include file="common/product_data.tpl" product=$product but_role="big" but_text=__("add_to_cart")}
            <div class="span7 ty-product-block__img-wrapper">
                {hook name="products:image_wrap"}
                {if !$no_images}
                    <div class="ty-product-block__img cm-reload-{$product.product_id}"
                         id="product_images_{$product.product_id}_update">

                        {assign var="discount_label" value="discount_label_`$obj_prefix``$obj_id`"}
                        {if $product.image_pairs}
                            <div class="{if count($product.image_pairs) > 5}active-gallery {if $settings.Appearance.thumbnails_gallery == "N"}two-col{/if}{else}active-gallery {if $settings.Appearance.thumbnails_gallery == "N"}one-col{/if}{/if}">
                                {$smarty.capture.$discount_label nofilter}
                            </div>
                        {else}
                            {$smarty.capture.$discount_label nofilter}
                        {/if}

                        <div class="{if count($product.image_pairs) > 5 && $settings.Appearance.thumbnails_gallery == "N"}two-col{else}{if $settings.Appearance.thumbnails_gallery == "N"}one-col{/if}{/if}">{include file="views/products/components/product_images.tpl" product=$product show_detailed_link="Y" image_width=$settings.Thumbnails.product_details_thumbnail_width image_height=$settings.Thumbnails.product_details_thumbnail_height}</div>
                        <!--product_images_{$product.product_id}_update--></div>
                {/if}
                {/hook}
            </div>
            <div class="span9 ty-product-block__left">

                {assign var="form_open" value="form_open_`$obj_id`"}
                {$smarty.capture.$form_open nofilter}

                {assign var="old_price" value="old_price_`$obj_id`"}
                {assign var="price" value="price_`$obj_id`"}
                {assign var="clean_price" value="clean_price_`$obj_id`"}
                {assign var="list_discount" value="list_discount_`$obj_id`"}
                {assign var="discount_label" value="discount_label_`$obj_id`"}

                {*hook name="products:main_info_title"}{/hook*}

                {if $product.discussion_type && $product.discussion_type != 'D'}
                    <div class="advanced-layer-01">
                        <div class="ty-product-block__rating">
                            {assign var="rating" value="rating_`$obj_id`"}
                            {if $product.discussion.search.total_items > 0}
                                <div class="ty-discussion__rating-wrapper" id="average_rating_product">
                                    {$smarty.capture.$rating nofilter}<a
                                            class="ty-discussion__review-a cm-external-click"
                                            data-ca-scroll="content_discussion"
                                            data-ca-external-click-id="discussion">{$product.discussion.search.total_items} {__("reviews", [$product.discussion.search.total_items])}</a><a
                                            class="ty-discussion__review-write cm-dialog-opener cm-dialog-auto-size"
                                            data-ca-target-id="new_post_dialog_{$obj_id}"
                                            rel="nofollow">{__("write_review")}</a>
                                </div>
                            {else}
                                <div class="ty-discussion__rating-wrapper">
                                    <span class="ty-nowrap no-rating"><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i></span>
                                    <a class="ty-discussion__review-write cm-dialog-opener cm-dialog-auto-size" data-ca-target-id="new_post_dialog_{$obj_id}" rel="nofollow">{__("write_review")}</a>
                                </div>
                            {/if}
                        </div>

                        {if $settings.abt__unitheme.show_block_in_product.value > 0}
                            <div class="ty-product-block__sku">
                                {assign var="sku" value="sku_`$obj_id`"}
                                {$smarty.capture.$sku nofilter}
                            </div>
                        {/if}

                    </div>
                {/if}

                <div class="show_info_block_in_product">{hook name="products:ab__deal_of_the_day_product_view"}{/hook}</div>

                <div class="row-fluid">
                    <div class="span8 ty-product-options-grid">

                        <div class="{if $smarty.capture.$old_price|trim || $smarty.capture.$clean_price|trim || $smarty.capture.$list_discount|trim}prices-container {/if}price-wrap">
                            {if $smarty.capture.$old_price|trim || $smarty.capture.$clean_price|trim || $smarty.capture.$list_discount|trim}
                            <div class="ty-product-prices">
                                {if $smarty.capture.$old_price|trim}{$smarty.capture.$old_price nofilter}{/if}
                                {/if}

                                {if $smarty.capture.$price|trim}
                                    <div class="ty-product-block__price-actual">
                                        {$smarty.capture.$price nofilter}
                                    </div>
                                {/if}

                                {if $smarty.capture.$old_price|trim || $smarty.capture.$clean_price|trim || $smarty.capture.$list_discount|trim}
                                {$smarty.capture.$clean_price nofilter}
                                {$smarty.capture.$list_discount nofilter}
                            </div>
                            {/if}
                        </div>
                        {assign var="product_amount" value="product_amount_`$obj_id`"}
                        {$smarty.capture.$product_amount nofilter}

                        {if $capture_options_vs_qty}{capture name="product_options"}{$smarty.capture.product_options nofilter}{/if}
                        <div class="ty-product-block__option">
                            {assign var="product_options" value="product_options_`$obj_id`"}
                            {$smarty.capture.$product_options nofilter}
                        </div>
                        {if $capture_options_vs_qty}{/capture}{/if}

                        <div class="ty-product-block__advanced-option clearfix">
                            {if $capture_options_vs_qty}{capture name="product_options"}{$smarty.capture.product_options nofilter}{/if}
                            {assign var="advanced_options" value="advanced_options_`$obj_id`"}
                            {$smarty.capture.$advanced_options nofilter}
                            {if $capture_options_vs_qty}{/capture}{/if}
                        </div>

                        

                        {if $capture_options_vs_qty}{capture name="product_options"}{$smarty.capture.product_options nofilter}{/if}
                        <div class="ty-product-block__field-group">
                            {assign var="qty" value="qty_`$obj_id`"}
                            {if $smarty.capture.$qty && !$product.prices}
                                <div class="block-qty-grid">{$smarty.capture.$qty nofilter}</div>{else}
                                <div class="block-qty-grid">{$smarty.capture.$qty nofilter}</div>{/if}

                            {assign var="min_qty" value="min_qty_`$obj_id`"}
                            {$smarty.capture.$min_qty nofilter}
                        </div>
                        {if $capture_options_vs_qty}{/capture}{/if}

                        {if $capture_buttons}{capture name="buttons"}{/if}
                        <div class="ty-product-block__button">
                            {if $show_details_button}
                                {include file="buttons/button.tpl" but_href="products.view?product_id=`$product.product_id`" but_text=__("view_details") but_role="submit"}
                            {/if}

                            {assign var="add_to_cart" value="add_to_cart_`$obj_id`"}
                            {$smarty.capture.$add_to_cart nofilter}

                            {assign var="list_buttons" value="list_buttons_`$obj_id`"}
                            {$smarty.capture.$list_buttons nofilter}
                        </div>
                        {if $capture_buttons}{/capture}{/if}

                        {if $settings.abt__unitheme.show_block_in_product.value > 0}
                            {if $show_features && $settings.abt__unitheme.show_features_in_product.value == 'Y'}
                                <div class="ty-product-list__feature" style="margin-top: 20px">
                                    <div class="cm-reload-{$obj_prefix}{$obj_id}" id="dt_product_features_update_{$obj_prefix}{$obj_id}">
                                        <input type="hidden" name="appearance[show_features]" value="{$show_features}" />
                                        {include file="views/products/components/product_features_short_list.tpl" features=$product.header_features no_container=true}
                                        <!--dt_product_features_update_{$obj_prefix}{$obj_id}--></div>
                                </div>
                            {/if}
                        {/if}
                    </div>

                    <div class="span8 advanced-layer-02">

                        {hook name="products:change_product_ft_ds"}

                        {if $settings.abt__unitheme.show_block_in_product.value == ''}
                            <div class="ty-product-block__sku">
                                {assign var="sku" value="sku_`$obj_id`"}
                                {$smarty.capture.$sku nofilter}
                            </div>
                        {/if}


                        {if $settings.abt__unitheme.show_block_in_product.value == ''}
                            {if $show_features && $settings.abt__unitheme.show_features_in_product.value == 'Y'}
                                <div class="ty-product-list__feature" style="margin-top: 20px">
                                    <div class="cm-reload-{$obj_prefix}{$obj_id}" id="dt_product_features_update_{$obj_prefix}{$obj_id}">
                                        <input type="hidden" name="appearance[show_features]" value="{$show_features}" />
                                        {include file="views/products/components/product_features_short_list.tpl" features=$product.header_features no_container=true}
                                        <!--dt_product_features_update_{$obj_prefix}{$obj_id}--></div>
                                </div>
                            {/if}
                        {/if}
                        {if $show_descr && $settings.abt__unitheme.show_short_desc_in_product.value == 'Y'}
                            <noindex>
                                {assign var="prod_descr" value="prod_descr_`$obj_id`"}
                                <div class="ty-product-block__description">{$smarty.capture.$prod_descr nofilter}</div>
                            </noindex>
                        {/if}

                        {/hook}                        

                        <div class="ty-product-infoblock-dropdown ms_uni_delivery">                                

                                <div id="sw_elm_delivery" class="pib-title cm-combination">
                                    <i class="uni-icon uni-delivery-truck"></i><em>Доставим {if $smarty.session.geocity}в город {$smarty.session.geocity}{/if}</em>
                                </div>                                

                                <div id="elm_delivery" class="pib-content cm-popup-box" {if $addons.ms_uni_delivery.show_delivery != "Y"} style="display: none;" {/if}>
                                    <ul>
                                        {* подключение шаблона для отображения доставки через /design/themes/responsive/templates/addons/rus_geolocation/views/geolocation/product_shipping_list.tpl*}
                                        {assign var="product_edp" value="product_edp_`$obj_id`"}
                                        {$smarty.capture.$product_edp nofilter}                                    
                                    </ul>
                                </div>

                                {* продолжение отображения мотивационного блока. берем содержимое любого блока по его id *}
                                {if $settings.abt__unitheme.show_block_in_product.value > 0}
                                    {render_block block_id=$settings.abt__unitheme.show_block_in_product.value dispatch="products.view"  use_cache=false parse_js=false}
                                {/if}
                        </div>

                        {hook name="products:promo_text"}
                        {if $product.promo_text}
                            <div class="ty-product-block__note">
                                {$product.promo_text nofilter}
                            </div>
                        {/if}
                        {/hook}

                        {* {hook name="products:brand"}{/hook} *}
                    </div>
                </div>

                <!-- List/Advanced buttons -->
                <div class="advanced-buttons">

                    {if $addons.wishlist.status == "A" && !$hide_wishlist_button}
                        {include file="addons/wishlist/views/wishlist/components/add_to_wishlist.tpl" but_id="button_wishlist_`$obj_prefix``$product.product_id`" but_name="dispatch[wishlist.add..`$product.product_id`]" but_role="text"}
                    {/if}
                    {if $settings.General.enable_compare_products == "Y" && !$hide_compare_list_button || $product.feature_comparison == "Y"}
                        {include file="buttons/add_to_compare_list.tpl" product_id=$product.product_id}
                    {/if}

                    {hook name="products:share_view_links"}
                    {if $provider_settings}
                        <a class="ty-btn share-link" onclick="$(this).next().toggleClass('hidden');"><i class="uni-share"></i>{__("share")}</a>
                    {/if}
                        <div class="sb-block hidden">{hook name="products:product_detail_bottom"}{/hook}</div>
                    {/hook}

                </div>
                <!-- END List/Advanced buttons -->

                {assign var="form_close" value="form_close_`$obj_id`"}
                {$smarty.capture.$form_close nofilter}

                {if $show_product_tabs}
                    {include file="views/tabs/components/product_popup_tabs.tpl"}
                    {$smarty.capture.popupsbox_content nofilter}
                {/if}
            </div>
        {/if}

        {/hook}
    </div>

    {if $smarty.capture.hide_form_changed == "Y"}
        {assign var="hide_form" value=$smarty.capture.orig_val_hide_form}
    {/if}

    {if $show_product_tabs}
        {hook name="products:product_tabs"}
            {include file="views/tabs/components/product_tabs.tpl"}

        {if $blocks.$tabs_block_id.properties.wrapper}
            {include file=$blocks.$tabs_block_id.properties.wrapper content=$smarty.capture.tabsbox_content title=$blocks.$tabs_block_id.description}
        {else}
            {$smarty.capture.tabsbox_content nofilter}
        {/if}
        {/hook}
    {/if}
</div>

<div class="product-details">
</div>

{capture name="mainbox_title"}{assign var="details_page" value=true}{/capture}
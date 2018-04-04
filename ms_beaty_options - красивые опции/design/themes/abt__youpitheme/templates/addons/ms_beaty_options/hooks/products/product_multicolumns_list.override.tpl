{if $settings.abt__yt.product_list.show_sku == 'Y' or  $settings.abt__yt.product_list.show_amount == 'Y'}
                                    <div class="stock-block">
                                        {assign var="sku" value="sku_$obj_id"}
                                        {$smarty.capture.$sku nofilter}

                                        {if $settings.abt__yt.product_list.show_brand == 'none'}
                                            {assign var="product_amount" value="product_amount_`$obj_id`"}
                                            {$smarty.capture.$product_amount nofilter}
                                        {/if}
                                    </div>
                                {/if}
                                    <div class="ty-grid-list__image">
                                        {include file="views/products/components/product_icon.tpl" product=$product show_gallery=true}

                                        {assign var="discount_label" value="discount_label_`$obj_prefix``$obj_id`"}
                                        {$smarty.capture.$discount_label nofilter}
                                    </div>
                                    <div class="block-top">
                                        {assign var="rating" value="rating_$obj_id"}
                                        {if $smarty.capture.$rating|strlen > 40}
                                            <div class="grid-list__rating">
                                                {if ($ab_dotd_product_ids && $product.product_id|in_array:$ab_dotd_product_ids) or ($product.promotions)}
                                                    <div class="ab_dotd_product_label">{__('ab_dotd_product_label')}</div>
                                                {/if}
                                                {$smarty.capture.$rating nofilter}{if $product.discussion_amount_posts > 0}
                                                    <span class="cn-comments">({$product.discussion_amount_posts})</span>
                                                {/if}
                                            </div>
                                        {else}
                                            <div class="grid-list__rating no-rating">
                                                {if ($ab_dotd_product_ids && $product.product_id|in_array:$ab_dotd_product_ids) or ($product.promotions)}
                                                    <div class="ab_dotd_product_label">{__('ab_dotd_product_label')}</div>
                                                {/if}
                                                {if $addons.discussion.status == "A"}
                                                    <i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i>
                                                {elseif $product.discussion_amount_posts > 0}
                                                    <span class="cn-comments">({$product.discussion_amount_posts})</span>
                                                {/if}
                                            </div>
                                        {/if}                         
                                        
                                      {hook name="products:ypi_product_list_block_top"}{/hook}
                                    </div>
                                    {if $settings.abt__yt.product_list.show_brand == 'as_text' and $settings.abt__yt.general.brand_feature_id > 0}
                                        {$b_feature=$product.abt__yt_features[$settings.abt__yt.general.brand_feature_id]}
                                        <div class="ypi-brand">{$b_feature.variant}</div>
                                    {elseif $settings.abt__yt.product_list.show_brand == 'as_logo' and $settings.abt__yt.general.brand_feature_id > 0}
                                        {$b_feature=$product.abt__yt_features[$settings.abt__yt.general.brand_feature_id]}
                                        <div class="ypi-brand-img">
                                            <a href="{"categories.view?category_id=`$product.main_category`&features_hash=`$b_feature.features_hash`"|fn_url}">
                                                {include file="common/image.tpl" image_height=20 images=$b_feature.variants[$b_feature.variant_id].image_pairs no_ids=true}
                                            </a>
                                        </div>
                                    {/if}
                                    <div class="ty-grid-list__item-name">
                                        {if $item_number == "Y"}
                                            <span class="item-number">{$cur_number}.&nbsp;</span>
                                            {math equation="num + 1" num=$cur_number assign="cur_number"}
                                        {/if}

                                        {assign var="name" value="name_$obj_id"}
                                        <bdi>{$smarty.capture.$name nofilter}</bdi>
                                    </div>

<!--  module ms_beaty_options  -->
{if !$details_page}
<div class="clear-both"></div>

{* берем настройки из модуля *}
{$display_options_in_category =  $addons.ms_beaty_options.display_options_in_category}
{$color_name = $addons.ms_beaty_options.input_color}
{$size_name = $addons.ms_beaty_options.input_size}

{$show_options_without_amount = $addons.ms_beaty_options.show_options_in_categories_without_amount}

{* как показывать опции при наведении? или как обычно? *}
{$hover = $addons.ms_beaty_options.show_options_in_categories}

{if $hover == "hover"} 
	<style type="text/css">
		{literal}
			.ty-grid-list__item form:hover ul.color, .ty-grid-list__item form:hover ul.size {
			    display: block !important; 
			}
			ul.color, ul.size {
			    display: none;
			}
		{/literal}
	</style>
{/if}


	{foreach name="product_options" from=$product.product_options item="po"}   
		{if ($po.option_type == "S" or $po.option_type == "R") and $po.variants} {*Selectbox or Radiogroup*}
			{if $display_options_in_category == 'Y' && ($runtime.controller == 'categories' || $runtime.controller == 'ab__auto_loading_products')}

		        {$variant_amount = array()}
		        
		        {if $po.variants}
		            {foreach from=$po.variants item="vr" name=vars}
		                
		                {* подсчет кол-ва товара. данные берутся из аякс запроса *}
		                {$variant_product = $product}
		                {if $variant_product.selected_options[$po.option_id] != $vr.variant_id}
		                    {$variant_product.selected_options[$po.option_id] = $vr.variant_id}
		                    {$variant_product.product_options[$po.option_id] = null}
		                    {$variant_product.changed_option = $po.option_id}
		                    {$variant_product = fn_apply_options_rules($variant_product)}          
		                    {$variant_amount[$vr.variant_id] = $variant_product.inventory_amount|default:$variant_product.amount}
		                    
		                {else}
		                    {$variant_amount[$vr.variant_id] = $product_amount}
		                {/if}
		                
		            {/foreach}
		        {/if}

				{* если это цвет *}
				{if $po.option_name==$color_name }


				<ul class="color">
					<li class="boxes-list"><span>{$po.option_name}:</span></li>
					{foreach from=$po.variants item="vr" name=vars}

						{$hex_code = fn_settings_variants_addons_ms_beaty_options_search_hex_code($vr.variant_name)}

						{if $hex_code == "mixed"}						        
							<li style="padding: 0px 0px !important; background: linear-gradient(to right, #ff0,#008000,#4b0082,#ee82ee); {if $show_options_without_amount =="N" && $variant_amount[$vr.variant_id] == "0"} display:none; {/if}" value="{$vr.variant_id}" class="boxes-li" title="{$vr.variant_name}" id="li_{$obj_prefix}{$id}_{$po.option_id}" data-amount="{$variant_amount[$vr.variant_id]}">
								<a href="{"products.view&product_id=`$product.product_id`"|fn_url}"><span class="cm-tooltip"></span></a>
							</li>
						{else}  
							{if strpos($vr.variant_name, '/') !== false}
                                {$result = explode("/", $vr.variant_name)}
								{$hex_code1 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[0])}
                                {$hex_code2 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[1])}
                                {$hex_code3 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[2])}

                                <li style="padding: 0px 0px !important; {if $show_options_without_amount =="N" && $variant_amount[$vr.variant_id] == "0"} display:none; {/if}" value="{$vr.variant_id}" class="boxes-li" title="{$vr.variant_name}" id="li_{$obj_prefix}{$id}_{$po.option_id}" data-amount="{$variant_amount[$vr.variant_id]}"><div style="border-top: 16px solid {$hex_code1}; border-right: {if !empty($result[2])}8px{else}16px{/if} solid {$hex_code2}; {if !empty($result[2])}border-left: 8px solid {$hex_code3}; {/if}"></div><a href="{"products.view&product_id=`$product.product_id`"|fn_url}"><span class="cm-tooltip"></span></a></li>

                            {else}     
         
							<li style="padding: 0px 0px !important; background: {$hex_code}; {if $show_options_without_amount == "N" and $variant_amount[$vr.variant_id] == "0"} display:none; {/if}" title="{$vr.variant_name}" value="{$vr.variant_id}" class="boxes-li" id="li_{$obj_prefix}{$id}_{$po.option_id}" data-amount="{$variant_amount[$vr.variant_id]}">
								<a href="{"products.view&product_id=`$product.product_id`"|fn_url}"><span class="cm-tooltip"></span></a>
							</li>
							{/if}
						{/if}							

					{/foreach}
				</ul>
				{/if}
				{* end of color *}

				{* если это размер *}
				{if $po.option_name==$size_name}
				<ul class="size" >
					<li class="boxes-list"><span>{$po.option_name}:</span></li>
					{foreach from=$po.variants item="vr" name=vars}
						<li value="{$vr.variant_id}" class="boxes-li" id="li_{$obj_prefix}{$id}_{$po.option_id}" data-amount="{$variant_amount[$vr.variant_id]}" 
						style="{if $show_options_without_amount =="N" && $variant_amount[$vr.variant_id] == "0"} display:none; {/if}"
							<a href="{"products.view&product_id=`$product.product_id`"|fn_url}"><span class="cm-tooltip">{$vr.variant_name}</span></a>
						</li>
					{/foreach}
				</ul>
				{/if}
				{* end of size *}

			{/if}
			{* end of display_options_in_category *}
		{/if}
		{* end of variants *}

	{/foreach}
	{* end of product_options *}
{/if} 
{* end of !details_page *}  

                                    <div class="block-middle">
                                        {if $settings.abt__yt.product_list.grid_list_descr == 'description'}
                                            <div class="product-description">
                                                {assign var="prod_descr" value="prod_descr_`$obj_id`"}
                                                {$smarty.capture.$prod_descr nofilter}
                                            </div>
                                        {else}
                                          {*  <div class="product-feature">
                                                {assign var="product_features" value="product_features_`$obj_id`"}
                                                {$smarty.capture.$product_features nofilter}test
                                            </div>*}
                                        {/if}
                                    </div>
                                    <div class="block-bottom {if $product.taxed_price}taxed-price{/if}">
                                        <div class="v-align-bottom">

                                            {if !$smarty.capture.capt_options_vs_qty}
                                                <div class="ypi-product__option">
                                                    {assign var="product_options" value="product_options_`$obj_id`"}
                                                    {$smarty.capture.$product_options nofilter}
                                                </div>
                                                <div class="ypi-product__qty">
                                                    {assign var="qty" value="qty_`$obj_id`"}
                                                    {$smarty.capture.$qty nofilter}
                                                </div>
                                            {/if}

                                            <div class="ty-grid-list__price {if $show_qty}qty-wrap{/if} {if $product.price == 0}ty-grid-list__no-price{/if}">
                                                {assign var="old_price" value="old_price_`$obj_id`"}
                                                {if $smarty.capture.$old_price|trim}{$smarty.capture.$old_price nofilter}{/if}

                                                {assign var="price" value="price_`$obj_id`"}
                                                {$smarty.capture.$price nofilter}
                                                
                                                {if $product.ab__is_qty_discount}
                                                    <div class="qty_discounts_grid">
                                                        <a class="ab__show_qty_discounts ajax-link cm-tooltip" data-ca-product-id="{$product.product_id}" data-ca-target-id="qty_discounts_{$obj_id}" title="{__("qty_discounts")}"><i class="material-icons">&#xE88F;</i></a>
                                                        <div id="qty_discounts_{$obj_id}" class="qty_discounts_popup hidden">
                                                        <!--qty_discounts_{$obj_id}--></div>
                                                    </div>
                                                {/if}

                                                {assign var="clean_price" value="clean_price_`$obj_id`"}
                                                {$smarty.capture.$clean_price nofilter}

                                                {assign var="list_discount" value="list_discount_`$obj_id`"}
                                                {$smarty.capture.$list_discount nofilter}
                                                
                                                
                                            </div>

                                            {if $settings.abt__yt.product_list.show_buttons == 'Y'}
                                                <div class="ty-grid-list__control {if $show_list_buttons}show-list-buttons{/if}">
                                                    {if $show_add_to_cart}
                                                        <div class="button-container {if $addons.call_requests.buy_now_with_one_click == "Y"}call-requests__show{/if}">
                                                            {assign var="add_to_cart" value="add_to_cart_`$obj_id`"}
                                                            {$smarty.capture.$add_to_cart nofilter}
                                                        </div>
                                                    {/if}
                                                </div>
                                            {/if}

                                        </div>
                                    </div>

                                    <div class="ty-grid-body">
                                        <div class="ty-grid-list__image">
                                            {include file="views/products/components/product_icon.tpl" product=$product show_gallery=false}

                                            {assign var="discount_label" value="discount_label_`$obj_prefix``$obj_id`"}
                                            {$smarty.capture.$discount_label nofilter}

                                            <div class="grid-list-buttons">
                                                {if !$quick_view && $settings.Appearance.enable_quick_view == 'Y'}
                                                    {include file="views/products/components/quick_view_link.tpl" quick_nav_ids=$quick_nav_ids}
                                                {/if}
                                                {if $addons.wishlist.status == "A" && !$hide_wishlist_button}
                                                    {include file="addons/wishlist/views/wishlist/components/add_to_wishlist.tpl" but_id="button_wishlist_`$obj_prefix``$product.product_id`" but_name="dispatch[wishlist.add..`$product.product_id`]" but_role="text"}
                                                {/if}
                                                {if $settings.General.enable_compare_products == "Y" && !$hide_compare_list_button || $product.feature_comparison == "Y"}
                                                    {include file="buttons/add_to_compare_list.tpl" product_id=$product.product_id}
                                                {/if}
                                            </div>
                                        </div>

                                        {assign var="rating" value="rating_$obj_id"}
                                        {if $smarty.capture.$rating|strlen > 40}
                                            <div class="grid-list__rating">
                                                {if ($ab_dotd_product_ids && $product.product_id|in_array:$ab_dotd_product_ids) or ($addons.ab__deal_of_the_day.status == 'A' && $product.promotions)}
                                                    <div class="ab_dotd_product_label">{__('ab_dotd_product_label')}</div>
                                                {/if}
                                                {$smarty.capture.$rating nofilter}{if $product.discussion_amount_posts > 0}<span class="cn-comments">({$product.discussion_amount_posts})</span>{/if}
                                            </div>
                                        {else}
                                            <div class="grid-list__rating no-rating">
                                                {if ($ab_dotd_product_ids && $product.product_id|in_array:$ab_dotd_product_ids) or ($addons.ab__deal_of_the_day.status == 'A' && $product.promotions)}
                                                    <div class="ab_dotd_product_label">{__('ab_dotd_product_label')}</div>
                                                {/if}
                                                <i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i><i class="ty-icon-star-empty"></i>{if $product.discussion_amount_posts > 0}<span class="cn-comments">({$product.discussion_amount_posts})</span>{/if}
                                            </div>
                                        {/if}
                                        
{if !$details_page}
<!--  module ms_beaty_options  -->

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

                                <li style="padding: 0px 0px !important; {if $show_options_without_amount =="N" && $variant_amount[$vr.variant_id] == "0"} display:none; {/if}" value="{$vr.variant_id}" class="boxes-li" title="{$vr.variant_name}" id="li_{$obj_prefix}{$id}_{$po.option_id}" data-amount="{$variant_amount[$vr.variant_id]}"><div style="border-top: 20px solid {$hex_code1}; border-right: {if !empty($result[2])}10px{else}20px{/if} solid {$hex_code2}; {if !empty($result[2])}border-left: 10px solid {$hex_code3}; {/if}"></div><a href="{"products.view&product_id=`$product.product_id`"|fn_url}"><span class="cm-tooltip"></span></a></li>

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

<div class="ty-grid-list__item-name">
                                            {if $item_number == "Y"}
                                                <span class="item-number">{$cur_number}.&nbsp;</span>
                                                {math equation="num + 1" num=$cur_number assign="cur_number"}
                                            {/if}

                                            {assign var="name" value="name_$obj_id"}
                                            {$smarty.capture.$name nofilter}
                                        </div>

                                        <div class="ty-grid-list__price {if $product.price == 0}ty-grid-list__no-price{/if}">
                                            {assign var="price" value="price_`$obj_id`"}
                                            {$smarty.capture.$price nofilter}

                                            {assign var="old_price" value="old_price_`$obj_id`"}
                                            {if $smarty.capture.$old_price|trim}{$smarty.capture.$old_price nofilter}{/if}

                                            {assign var="clean_price" value="clean_price_`$obj_id`"}
                                            {$smarty.capture.$clean_price nofilter}

                                            {assign var="list_discount" value="list_discount_`$obj_id`"}
                                            {$smarty.capture.$list_discount nofilter}
                                        </div>
										
										{* для модуля ms_feature_catalog. выводим хар-ки *} 
											<div class="ty-product-list__feature ms_feature_catalog">
											{assign var="product_features" value="product_features_`$obj_id`"}
											 {$smarty.capture.$product_features nofilter}
											</div>

										{* для модуля ms_feature_catalog. выводим кол-во на складе *}
											{hook name="products:ms_feature_catalog_amount"}
											 {/hook}


                                        {if $capture_options_vs_qty}{capture name="product_options"}{$smarty.capture.product_options nofilter}{/if}
                                        <div class="stock-grid ty-product-block__field-group">
                                            {assign var="product_amount" value="product_amount_`$obj_id`"}
                                            {$smarty.capture.$product_amount nofilter}
                                        </div>
                                        {if $capture_options_vs_qty}{/capture}{/if}

                                        <div class="ty-grid-list__control">
                                            {if $show_add_to_cart}
                                                <div class="button-container">
                                                    {assign var="add_to_cart" value="add_to_cart_`$obj_id`"}
                                                    {$smarty.capture.$add_to_cart nofilter}
                                                </div>
                                            {/if}
                                        </div>

                                        {if $show_descr}
                                            <div class="ty-grid-list__ab-description">
                                                {assign var="prod_descr" value="prod_descr_`$obj_id`"}
                                                {$smarty.capture.$prod_descr nofilter}
                                            </div>
                                        {/if}

                                    </div>


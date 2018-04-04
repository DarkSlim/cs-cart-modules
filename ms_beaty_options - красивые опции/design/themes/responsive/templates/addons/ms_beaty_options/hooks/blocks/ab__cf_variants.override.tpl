<!-- This template was override by ms_beaty_options with seo -->
{* перезаписываем файл, с помощью модуля ms_beaty_options *}
{$color_name = $addons.ms_beaty_options.input_color}

<ul class="ty-product-filters {if $collapse}hidden{/if}" id="content_{$filter_uid}">

	{* Selected variants *}
	{foreach from=$filter.selected_variants key="variant_id" item="variant"}
	
		{if $addons.ms_beaty_options && $addons.ms_beaty_options.use_colors_filters == "Y" && $variant.name_feature == $color_name}
		
			{$hex_code = fn_settings_variants_addons_ms_beaty_options_search_hex_code($variant.variant)}
		                      
			<li class="colors_filter">
				<input class="hidden cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" checked="checked" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" {if $variant.disabled}disabled="disabled"{/if}>
				{if $hex_code == "mixed"}
                        	<label class="boxes-li" style="background: linear-gradient(to right, #ff0,#008000,#4b0082,#ee82ee);" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
                                      
                        {else}
                        	{if strpos($variant.variant, '/') !== false}
                                {$result = explode("/", $variant.variant)}
                                
                                {$hex_code1 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[0])}
                                {$hex_code2 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[1])}
                                {$hex_code3 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[2])}
                                
								<label class="boxes-li" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"><div style="border-top: 24px solid {$hex_code1}; border-right: {if !empty($result[2])}12px{else}24px{/if} solid {$hex_code2}; {if !empty($result[2])}border-left: 12px solid {$hex_code3}; {/if}"></div></label>
                                                                
                            {else}     
                                <label class="boxes-li" style="background: {$hex_code};" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
                            {/if}
                        {/if}

			</li> 
			
		{else}            
			
			<li class="cm-product-filters-checkbox-container ty-product-filters__group">
				<input class="cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" checked="checked">
				<label class="ms_beaty" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}">
					{$filter.prefix}{$variant.variant|fn_text_placeholders}{$filter.suffix}
				</label>
			</li>
		
		{/if}       
		     
	{/foreach}
	
	{* невыбранные фильтры *}
	{if $filter.variants}
	
		{if $addons.ms_beaty_options && $addons.ms_beaty_options.use_colors_filters == "Y" && $filter.filter == $color_name}   
			
			<li class="ty-product-filters__item-more">
				<ul id="ranges_{$filter_uid}" {if $filter.display_count}style="max-height: {$filter.display_count * 2}em;"{/if} class="colors ty-product-filters__variants cm-filter-table" data-ca-input-id="elm_search_{$filter_uid}" data-ca-clear-id="elm_search_clear_{$filter_uid}" data-ca-empty-id="elm_search_empty_{$filter_uid}">
				
					{foreach from=$filter.variants item="variant"} 
					
						{$hex_code = fn_settings_variants_addons_ms_beaty_options_search_hex_code($variant.variant)}
						                  
						<li class="colors_filter">
							<input class="hidden cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" {if $variant.disabled}disabled="disabled"{/if}>
							{if $hex_code == "mixed"}
                        	<label class="boxes-li" style="background: linear-gradient(to right, #ff0,#008000,#4b0082,#ee82ee);" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
                                      
                        {else}
                        	{if strpos($variant.variant, '/') !== false}
                                {$result = explode("/", $variant.variant)}
                                
                                {$hex_code1 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[0])}
                                {$hex_code2 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[1])}
                                {$hex_code3 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[2])}
                                
								<label class="boxes-li" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"><div style="border-top: 24px solid {$hex_code1}; border-right: {if !empty($result[2])}12px{else}24px{/if} solid {$hex_code2}; {if !empty($result[2])}border-left: 12px solid {$hex_code3}; {/if}"></div></label>
                                                                
                            {else}     
                                <label class="boxes-li" style="background: {$hex_code};" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
                            {/if}
                        {/if}
						</li> 
					
					{/foreach}
				
				</ul>
				<p id="elm_search_empty_{$filter_uid}" class="ty-product-filters__no-items-found hidden">{__("no_items_found")}</p>
				{if $filter.variants|@count > 30}
            <a class="ty-btn ypi-more-btn" onclick="$(this).prev().toggleClass('none-overflow'); $(this).toggleClass('open');">{__('more')} <i class="material-icons">&#xE313;</i></a>
    {/if}
			</li>
			
		{else}            
		        
			<li class="ty-product-filters__item-more">
				<ul id="ranges_{$filter_uid}" {if $filter.display_count}style="max-height: {$filter.display_count * 2}em;"{/if} class="ty-product-filters__variants cm-filter-table" data-ca-input-id="elm_search_{$filter_uid}" data-ca-clear-id="elm_search_clear_{$filter_uid}" data-ca-empty-id="elm_search_empty_{$filter_uid}">
				
					{foreach from=$filter.variants item="variant"}
						<li class="cm-product-filters-checkbox-container ty-product-filters__group">
						                    
							<label {if $variant.disabled}class="disabled"{/if}>
								{if $addons.ab__seo_filters.status == 'A'}
									{assign var="href" value="`$filter.filter_id`-`$variant.variant_id`"|fn_ab__seo_filters_prepare_filter_url}
									{if !$variant.disabled and $href|strpos:"features_hash" === false and !empty($href)}
									<a class="cm-ajax cm-ajax-full-render cm-history" data-ca-target-id="product_filters_*,products_search_*,category_products_*,product_features_*,breadcrumbs_*,currencies_*,languages_*,selected_filters_*" href="{$href}">
									{/if}
								{/if}
								
								<input class="cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" {if $variant.disabled}disabled="disabled"{/if}><label class="ms_beaty" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}">{$filter.prefix}{$variant.variant|fn_text_placeholders}{$filter.suffix}</label>
							</label>
							{if $addons.ab__seo_filters.status == 'A'}
								{if !$variant.disabled and $href|strpos:"features_hash" === false and !empty($href)}</a>
								{/if}
							{/if}
						</li>
					{/foreach}
				</ul>
				<p id="elm_search_empty_{$filter_uid}" class="ty-product-filters__no-items-found hidden">{__("no_items_found")}</p>
			</li>
		{/if}
		
	{/if}
</ul>

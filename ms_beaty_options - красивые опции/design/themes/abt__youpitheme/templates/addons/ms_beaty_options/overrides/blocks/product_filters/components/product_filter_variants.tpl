{* перезаписываем файл, с помощью модуля ms_beaty_options *}
{$color_name = $addons.ms_beaty_options.input_color}

<ul class="ty-product-filters {if $collapse}hidden{/if}" id="content_{$filter_uid}">

    {if $filter.display_count && $filter.variants|count > $filter.display_count}
    <li>
        {script src="js/tygh/filter_table.js"}

        {*<div class="ty-product-filters__search">
        <input type="text" placeholder="{__("search")}" class="cm-autocomplete-off ty-input-text-medium" name="q" id="elm_search_{$filter_uid}" value="" />
        <i class="ty-product-filters__search-icon ty-icon-cancel-circle hidden" id="elm_search_clear_{$filter_uid}" title="{__("clear")}"></i>
        </div>*}
    </li>
    {/if}


    {* Selected variants *}
    {foreach from=$filter.selected_variants key="variant_id" item="variant"}
    
	    {if $addons.ms_beaty_options && $addons.ms_beaty_options.use_colors_filters == "Y" && $variant.name_feature == $color_name}
			
				{$hex_code = fn_settings_variants_addons_ms_beaty_options_search_hex_code($variant.variant)}
				<li class="colors_filter">
				<input class="cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" checked="checked">
				{if $hex_code == "mixed"}
	                <label class="boxes-li" style="box-shadow: 0 0 0px 2px #ff5319; background: linear-gradient(to right, #ff0,#008000,#4b0082,#ee82ee);" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
	                                      
	            {else}
	                {if strpos($variant.variant, '/') !== false}
		                {$result = explode("/", $variant.variant)}
		                                
						{$hex_code1 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[0])}
		                {$hex_code2 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[1])}
		                {$hex_code3 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[2])}
		                                
						<label style="box-shadow: 0 0 0px 2px #ff5319;" class="boxes-li" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"><div style="border-top: 20px solid {$hex_code1}; border-right: {if !empty($result[2])}10px{else}20px{/if} solid {$hex_code2}; {if !empty($result[2])}border-left: 10px solid {$hex_code3}; {/if}"></div></label>                                                                
	                {else}     
	                	<label class="boxes-li" style="box-shadow: 0 0 0px 2px #ff5319; background: {$hex_code};" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
	                {/if}
                {/if}

				</li>
		{else}
	        <li class="cm-product-filters-checkbox-container ty-product-filters__group">
	            <input class="cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" checked="checked">
	            <label for="elm_checkbox_{$filter_uid}_{$variant.variant_id}">{$filter.prefix}{$variant.variant|fn_text_placeholders}{$filter.suffix}</label>
	        </li>
	    {/if}
    {/foreach}

{* Unselected variants *}
	{if $filter.variants}
	{if $addons.ms_beaty_options.status == "A" && $addons.ms_beaty_options.use_colors_filters == "Y" && $filter.filter == $color_name}

	<li class="ty-product-filters__item-more">
	<ul id="ranges_{$filter_uid}" {if $filter.display_count}style="max-height: {$filter.display_count * 24}px;"{/if} class="ty-product-filters__variants {if $filter.variants|@count > $filter.display_count}items-more {/if}cm-filter-table" data-ca-input-id="elm_search_{$filter_uid}" data-ca-clear-id="elm_search_clear_{$filter_uid}" data-ca-empty-id="elm_search_empty_{$filter_uid}">
	
	{foreach from=$filter.variants item="variant"}
	{$hex_code = fn_settings_variants_addons_ms_beaty_options_search_hex_code($variant.variant)}
	 <li class="colors_filter">
                       <input class="boxes-li cm-product-filters-checkbox hidden" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" {if $variant.disabled}disabled="disabled"{/if} />
                        {if $hex_code == "mixed"}
                        	<label class="boxes-li" style="background: linear-gradient(to right, #ff0,#008000,#4b0082,#ee82ee);" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
                                      
                        {else}
                        	{if strpos($variant.variant, '/') !== false}
                                {$result = explode("/", $variant.variant)}
                                
                                {$hex_code1 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[0])}
                                {$hex_code2 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[1])}
                                {$hex_code3 = fn_settings_variants_addons_ms_beaty_options_search_hex_code($result[2])}
                                
								<label class="boxes-li" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"><div style="border-top: 20px solid {$hex_code1}; border-right: {if !empty($result[2])}10px{else}20px{/if} solid {$hex_code2}; {if !empty($result[2])}border-left: 10px solid {$hex_code3}; {/if}"></div></label>
                                                                
                            {else}     
                                <label class="boxes-li" style="background: {$hex_code};" for="elm_checkbox_{$filter_uid}_{$variant.variant_id}"  title="{$variant.variant}"></label>
                            {/if}
                        {/if}
                        
                    </li> 

	{/foreach}
	</ul>
	{if $filter.variants|@count > 30}
            <a class="ty-btn ypi-more-btn" onclick="$(this).prev().toggleClass('none-overflow'); $(this).toggleClass('open');">{__('more')} <i class="material-icons">&#xE313;</i></a>
    {/if}
	</li>
	
	{else}
        <li class="ty-product-filters__item-more">
            <ul id="ranges_{$filter_uid}" {if $filter.display_count}style="max-height: {$filter.display_count * 24}px;"{/if} class="ty-product-filters__variants {if $filter.variants|@count > $filter.display_count}items-more {/if}cm-filter-table" data-ca-input-id="elm_search_{$filter_uid}" data-ca-clear-id="elm_search_clear_{$filter_uid}" data-ca-empty-id="elm_search_empty_{$filter_uid}">

                {foreach from=$filter.variants item="variant"}
                
                                
				
				
                <li class="cm-product-filters-checkbox-container ty-product-filters__group">
                    <input class="cm-product-filters-checkbox" type="checkbox" name="product_filters[{$filter.filter_id}]" data-ca-filter-id="{$filter.filter_id}" value="{$variant.variant_id}" id="elm_checkbox_{$filter_uid}_{$variant.variant_id}" {if $variant.disabled}disabled="disabled"{/if}><label {if $variant.disabled}class="disabled"{/if} for="elm_checkbox_{$filter_uid}_{$variant.variant_id}">{$filter.prefix}{$variant.variant|fn_text_placeholders}{$filter.suffix}</label>
                </li>
                
                {/foreach}
            </ul>
            {if $filter.variants|@count > $filter.display_count}
            <a class="ty-btn ypi-more-btn" onclick="$(this).prev().toggleClass('none-overflow'); $(this).toggleClass('open');">{__('more')} <i class="material-icons">&#xE313;</i></a>
            {/if}
            <p id="elm_search_empty_{$filter_uid}" class="ty-product-filters__no-items-found hidden">{__("no_items_found")}</p>
        </li>
    {/if}
    {/if}
</ul>

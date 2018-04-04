<style>
	.show_info_block_in_product {
		font-weight: 600; 
	}
	.show_info_block_in_product p {
		margin: 2px;
		padding: 14px 0 1px;
		}
	.span8.advanced-layer-02 {
		padding-top: 0px;
		margin-top: 0px;
	}
	.span8.ty-product-options-grid {
		margin-top:2px;
		padding-top: 2px; 
	} 
</style>

{if $addons.ms_wholesale_price.input_text}

{if $auth.usergroup_ids[2] == $addons.ms_wholesale_price.input_text}
<br>
<p class = "ms_wholesale_price" style="font-size: 15px; font-weight: bolg;">{__("ms_wholesale_price.wholesale")}</p>
{else}
<br>
<p class =  "ms_wholesale_price" style="font-size: 15px; font-weight: bolg;">{__("ms_wholesale_price.retail")}</p>
{/if}
 
{else}

{if $auth.usergroup_ids[2] == 3}
<br>
<p class = "ms_wholesale_price" style="font-size: 15px; font-weight: bolg;">{__("ms_wholesale_price.wholesale")}</p>
{else}
<br>
<p class =  "ms_wholesale_price" style="font-size: 15px; font-weight: bolg;">{__("ms_wholesale_price.retail")}</p>
{/if}

{/if}
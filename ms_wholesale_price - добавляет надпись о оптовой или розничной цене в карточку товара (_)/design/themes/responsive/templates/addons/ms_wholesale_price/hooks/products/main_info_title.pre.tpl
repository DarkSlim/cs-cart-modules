<style>
	.show_info_block_in_product {
		width: 250px;
		font-weight: 600; 
	} 
	.show_info_block_in_product p {
		margin: 2px;
		padding: 14px 0 1px;
		}
</style>
{if $addons.ms_wholesale_price.input_text}

{if $auth.usergroup_ids[2] == $addons.ms_wholesale_price.input_text}
<p class = "ms_wholesale_price" style="font-size: 15px;">{__("ms_wholesale_price.wholesale")}</p>
{else}
<p class =  "ms_wholesale_price" style="font-size: 15px;">{__("ms_wholesale_price.retail")}</p>
{/if}
 
{else}

{if $auth.usergroup_ids[2] == 3}
<p class = "ms_wholesale_price" style="font-size: 15px;">{__("ms_wholesale_price.wholesale")}</p>
{else}
<p class =  "ms_wholesale_price" style="font-size: 15px;">{__("ms_wholesale_price.retail")}</p>
{/if}

{/if}
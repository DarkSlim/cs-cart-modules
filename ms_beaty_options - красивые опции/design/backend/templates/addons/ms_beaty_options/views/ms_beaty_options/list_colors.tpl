{capture name="mainbox"}


<form action="{""|fn_url}" method="post" name="manage_variants_form" id="manage_variants_form">
	<input type="hidden" name="category_id" value="{$search.cid}" />

	{include file="common/pagination.tpl" save_current_page=true save_current_url=true div_id=$smarty.request.content_id}

	{include file="buttons/update_for_all.tpl" display=$show_update_for_all object_id="price_`$product.product_id`" name="update_all_vendors[price][`$product.product_id`]"}

	<p>{__("ms_beaty_options.double_colors")}</p>
	
	<p>{__("ms_beaty_options.all_colors_search")}</p>	

	<p>{__("ms_beaty_options.automatic_colors")}</p>

	<a class="cm-comet btn btn-primary" href="{$smarty.server.SCRIPT_NAME}?dispatch=ms_beaty_options.set_awesome_code_color" title={__("ms_beaty_options.copy")}>{__("ms_beaty_options.carry_out")}</a>

	{* выводим только цвета *}
	
	<table style="width:30%;" class="table table-middle">
		<thead>
			<tr>
				<td width="20%">{__("ms_beaty_options.name")}</td>
				<td width="10%">{__("ms_beaty_options.code")}</td>				
			</tr>
		</thead>	
		<tbody>	

			{foreach name="list_colors" from=$list_colors key="key" item="variant"}

			<tr>
				{* Название *}
				<td width="30%">
					{if strpos($variant.color_name, '/') !== false}
						{foreach name="name" from=$variant key="q" item="w"}
							{if $q !== 'color_name'}
								<input type="text" name="colors_data[{$variant.$q.color_name}][color_name]" size="10" value="{$variant.$q.color_name}" class="input">
							{/if}
						{/foreach}
					{else}
						<input type="text" name="colors_data[{$variant.color_name}][color_name]" size="10" value="{$variant.color_name}" class="input">
					{/if}
				</td>

				{* Выбор цвета *}
				<td width="10%">
	
					<div class="input-prepend">

						{if $variant.color_hex == "mixed"}					

							<span style="width: 49px;height: 25px;display: inline-block;background:linear-gradient(to right, #ff0,#008000,#4b0082,#ee82ee);" ></span>

						{else}
						
							{if strpos($variant.color_name, '/') !== false }

								{foreach name="double" from=$variant key="k" item="i"}
									{if $k !== 'color_name'}
										<div class="colorpicker">
											<input type="text" maxlength="7" name="colors_data[{$variant.$k.color_name}][color_hex]" id="storage_elm_te_links" value="{$variant.$k.color_hex}" data-ca-storage="theme_editor" class="cm-colorpicker cm-te-value-changer" style="display: none;" data-ca-view="palette">
										</div>
									{/if}
								{/foreach}
							
							{else}
								<div class="colorpicker">
									<input type="text" maxlength="7" name="colors_data[{$variant.color_name}][color_hex]" id="storage_elm_te_links" value="{$variant.color_hex}" data-ca-storage="theme_editor" class="cm-colorpicker cm-te-value-changer" style="display: none;" data-ca-view="palette">
								</div>
							{/if}
						{/if}

					</div>
				</td>	

			</tr>
			{/foreach}

		</tbody>
	</table>

	<button type="submit" data-ca-dispatch="dispatch[ms_beaty_options.update_color]" data-ca-target-form="manage_variants_form" class="btn btn-primary cm-submit" form="manage_variants_form" name="dispatch[ms_beaty_options.update_color]">{__("ms_beaty_options.save")}</button>

	<div class="clearfix">
		{include file="common/pagination.tpl" div_id=$smarty.request.content_id}
	</div>

</form>




{/capture}

{include file="common/mainbox.tpl" 
title=__("options") 
content=$smarty.capture.mainbox title_extra=$smarty.capture.title_extra select_languages=true buttons=$smarty.capture.buttons sidebar=$smarty.capture.sidebar content_id="list_colors"}
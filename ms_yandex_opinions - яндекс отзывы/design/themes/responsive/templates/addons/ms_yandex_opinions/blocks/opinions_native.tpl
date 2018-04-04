{** block-description:opinions_native **}

{assign var="data" value=fn_ms_yandex_opinions_get_shop_opinions($block.properties.count, 'filter_'|str_replace:'':$block.properties.grade, $block.properties.how, $block.properties.max_comments, $block.properties.sort)}

{*$data|var_export:true|highlight_string:true nofilter*}

{include file="addons/ms_yandex_opinions/views/opinions/components/opinions.tpl"}

{if isset($data.opinion)}
<div class="ty-mtb-s ty-left ty-uppercase">
	<a href="{"opinions.list"|fn_url}">{__("view_all")}</a>
</div>
{/if}

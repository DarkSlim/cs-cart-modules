{if $data}
<div class="opinions-block" id="{if $container_id}{$container_id}{else}content_opinions{/if}">
	{if $wrap == true}
		{capture name="content"}
		{include file="common/subheader.tpl" title=$title}
	{/if}

	{if $subheader}
		<h4>{$subheader}</h4>
	{/if}

	<div id="opinions_list">
	{if $data.opinion}
		{include file="common/pagination.tpl" id="pagination_contents_opinions" search=$search}
		
		{include file="addons/ms_yandex_opinions/views/opinions/components/opinions.tpl"}

		{include file="common/pagination.tpl" id="pagination_contents_opinions" search=$search}
	{else}
		<p class="ty-no-items">{__("no_opinions_found")}</p>
	{/if}
	<!--/opinions_list-->
	</div>

	{if $wrap == true}
		{/capture}
		{$smarty.capture.content nofilter}
	{else}
		{capture name="mainbox_title"}{$title}{/capture}
	{/if}
</div>
{/if}
{** block-description:opinions_discussion **}

{assign var="data" value=fn_ms_yandex_opinions_get_shop_opinions($block.properties.count, 'filter_'|str_replace:'':$block.properties.grade, $block.properties.how, $block.properties.max_comments, $block.properties.sort)}

{*$data|var_export:true|highlight_string:true nofilter*}

{if isset($data.opinion)}
<div id="ms_yandex_opinions_{$block.snapping_id}" class="ms-yandex-opinions">
	{foreach from=$data.opinion item="opinion" key="key"}
	
	<div class="ty-discussion-post__content">
		
		{hook name="ms_yandex_opinions_discussion:items_list_row"}
		
		<span class="ty-discussion-post__author">
			{if $opinion.anonymous or $opinion.visibility eq 'ANONYMOUS'}
				{__("msyo_anonymous")}
			{else}
				{$opinion.author}
			{/if}
		</span>
		
		<span class="ty-discussion-post__date">
			{($opinion.date/1000)|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}
		</span>
		
		<div class="ty-discussion-post {cycle values=", ty-discussion-post_even"}" id="post_{$opinion.id}">
			<span class="ty-caret"> <span class="ty-caret-outer"></span> <span class="ty-caret-inner"></span></span>

			<div class="clearfix ty-discussion-post__rating">
				{include file="addons/ms_yandex_opinions/views/opinions/components/stars.tpl" stars=($opinion.grade+3)|fn_get_discussion_rating}
			</div>
			
			<div class="ty-discussion-post__message">
				{if $opinion.text}
				<div>
					{$opinion.text|escape|nl2br nofilter}
				</div>
				{/if}
				
				{if $opinion.pro}
				<div>
					<b>{__("msyo_prons")}:</b>
					{$opinion.pro|escape|nl2br nofilter}
				</div>
				{/if}
				
				{if $opinion.contra}
				<div>
					<b>{__("msyo_cons")}:</b>
					{$opinion.contra|escape|nl2br nofilter}
				</div>
				{/if}
			</div>
			
		</div>
		
		{/hook}
		
	</div>
	{/foreach}
</div>

<div class="ty-mtb-s ty-left ty-uppercase">
	<a href="{"opinions.list"|fn_url}">{__("view_all")}</a>
</div>
{/if}

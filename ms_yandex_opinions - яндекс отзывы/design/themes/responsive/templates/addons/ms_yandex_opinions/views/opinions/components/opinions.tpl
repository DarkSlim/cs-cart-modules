{if isset($data.opinion)}
<div id="ms_yandex_opinions_{$block.snapping_id}" class="ms-yandex-opinions">
	{foreach from=$data.opinion item="opinion" key="key"}
	<div class="ty-ms-yandex-opinions-native-post">
		{hook name="ms_yandex_opinions_native:items_list_row"}
		
		<div class="ty-ms-yandex-opinions-native-post-header">
			{if isset($opinion.authorInfo.avatarUrl)}
			<div class="ty-ms-yandex-opinions-native-post-header-photo">
				<img src="{$opinion.authorInfo.avatarUrl}">
			</div>
			{/if}
			<div class="ty-ms-yandex-opinions-native-post-header-name{if !isset($opinion.authorInfo.avatarUrl)} no-avatar{/if}">
				{if $opinion.anonymous or $opinion.visibility eq 'ANONYMOUS'}
					{__("msyo_anonymous")}
				{else}
					{$opinion.author}
				{/if}
			</div>
			<div class="ty-clear-both"></div>
		</div>
		
		<div class="ty-ms-yandex-opinions-native-post-body">
			<div class="ty-ms-yandex-opinions-native-img"></div>
			<div class="ty-ms-yandex-opinions-native-post-body-a">
				<div>
					{if isset($opinion.shopOrderId)}
					<div class="ty-ms-yandex-opinions-native-number">{__("msyo_order_no")} {$opinion.shopOrderId|ltrim:'#'}</div>
					{/if}
					<div class="ty-ms-yandex-opinions-native-attrs">
						{if $opinion.delivery eq 'DELIVERY'}{__("msyo_delivery")}
						{elseif $opinion.delivery eq 'INSTORE'}{__("msyo_bought_in_shop")}
						{elseif $opinion.delivery eq 'PICKUP'}{__("msyo_local_pickup")}
						{/if}
						
						{if isset($opinion.region)}
						{$opinion.region|fn_ms_yandex_opinions_get_region_name}
						{/if}
						
						{($opinion.date/1000)|date_format:"`$settings.Appearance.date_format`, `$settings.Appearance.time_format`"}
					</div>
					<div class="ty-clear-both"></div>
				</div>
				<div>
					<div class="ty-ms-yandex-opinions-native-rate">
						{include file="addons/ms_yandex_opinions/views/opinions/components/stars.tpl" stars=($opinion.grade+3)|fn_get_ms_yandex_opinions_rating}
					</div>
				</div>
				<div>
					<div class="ty-ms-yandex-opinions-native-text">
						
						{if $opinion.pro}
						<p><b>{__("msyo_prons")}:</b> {$opinion.pro|escape|nl2br nofilter}</p>
						{/if}
						
						{if $opinion.contra}
						<p><b>{__("msyo_cons")}:</b> {$opinion.contra|escape|nl2br nofilter}</p>
						{/if}
						
						{if $opinion.text}
						<p><b>{__("msyo_comment")}:</b><br>{$opinion.text|escape|nl2br nofilter}</p>
						{/if}
						
					</div>
				</div>

				{foreach from=$opinion.comments item="comment"}
				<div class="ty-ms-yandex-opinions-native-answer">
					<span>
					{if $comment.user.id}
						{$comment.user.name}
					{else}
						{__("msyo_shop")} {$runtime.company_data.company}
					{/if}
					</span><br>
					{$comment.body}
				</div>
				{/foreach}
				
			</div>
		</div>
		{/hook}
		
	</div>
	{/foreach}
</div>
{/if}
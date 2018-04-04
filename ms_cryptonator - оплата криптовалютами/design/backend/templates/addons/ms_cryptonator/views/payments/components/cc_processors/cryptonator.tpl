{assign var="callback_url" value="payment_notification.callback?payment=cryptonator"|fn_url:'C':'https'}
{assign var="fail_url" value="payment_notification.error?payment=cryptonator"|fn_url:'C':'https'}
{assign var="success_url" value="payment_notification.ok?payment=cryptonator"|fn_url:'C':'https'}

{include file="common/subheader.tpl" title=__("information") target="#cryptonator_payment_instruction_`$smarty.request.payment_id`"}
<div id="cryptonator_payment_instruction_{$smarty.request.payment_id}" class="in collapse">
{hook name="cryptonator:cryptonator_payment_instructions"}
{__("text_cryptonator_tech_urls", ["[callback_url]" => $callback_url, "[fail_url]" => $fail_url, "[success_url]" => $success_url])}
{/hook}

{hook name="cryptonator:cryptonator_processor_https_text"}
{assign var="check_https" value="HTTPS"|defined}

{if !$check_https}
{__("text_cryptonator_https")}
{/if}
{/hook}
</div>


{include file="common/subheader.tpl" title=__("settings") target="#cryptonator_settings_`$smarty.request.payment_id`"}
<div id="cryptonator_payment_settings_{$smarty.request.payment_id}" class="in collapse">

<div class="control-group">
    <label class="control-label" for="merchant_id">{__("cryptonator.merchant_id")}:</label>
    <div class="controls">
        <input type="text" name="payment_data[processor_params][merchant_id]" id="shop_id" value="{$processor_params.merchant_id}" class="input-text-large"  size="60" />
    </div>
</div>
<div class="control-group">
    <label class="control-label" for="scid">{__("cryptonator.secret")}:</label>
    <div class="controls">
        <input type="text" name="payment_data[processor_params][secret]" id="secret" value="{$processor_params.secret}" class="input-text-large"  size="60" />
    </div>
</div>


<div class="control-group">
    <label class="control-label" for="logging">{__("addons.cryptonator.logging")}:</label>
    <div class="controls">
        <input type="checkbox" name="payment_data[processor_params][logging]" id="logging" value="Y" {if $processor_params.logging == 'Y'} checked="checked"{/if} class="input-text-large"  size="60" />
    </div>
</div>
{*
{include file="common/subheader.tpl" title=__("cryptonator_payment_types") target="#cryptonator_payment_types_`$smarty.request.payment_id`"}
<div id="cryptonator_payment_types_{$smarty.request.payment_id}" class="in collapse">

    <fieldset>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_bitcoin">{__("cryptonator_payment_bitcoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][bitcoin]" id="cryptonator_payment_bitcoin" class="cm-cryptonator-payment-type" value="bitcoin"{if $processor_params.payments && $processor_params.payments.bitcoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_bitcoincash">{__("cryptonator_payment_bitcoincash")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][bitcoincash]" id="cryptonator_payment_bitcoincash" class="cm-cryptonator-payment-type" value="bitcoincash"{if $processor_params.payments && $processor_params.payments.bitcoincash} checked="checked"{/if}>
        </div>
    </div>
    
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_blackcoin">{__("cryptonator_payment_blackcoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][blackcoin]" id="cryptonator_payment_blackcoin" class="cm-cryptonator-payment-type" value="blackcoin"{if $processor_params.payments && $processor_params.payments.blackcoin} checked="checked"{/if}>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_bytecoin">{__("cryptonator_payment_bytecoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][bytecoin]" id="cryptonator_payment_bytecoin" class="cm-cryptonator-payment-type" value="bytecoin"{if $processor_params.payments && $processor_params.payments.bytecoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_dash">{__("cryptonator_payment_dash")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][dash]" id="cryptonator_payment_dash" class="cm-cryptonator-payment-type" value="dash"{if $processor_params.payments && $processor_params.payments.dash} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_dogecoin">{__("cryptonator_payment_dogecoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][dogecoin]" id="cryptonator_payment_dogecoin" class="cm-cryptonator-payment-type" value="dogecoin"{if $processor_params.payments && $processor_params.payments.dogecoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_emercoin">{__("cryptonator_payment_emercoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][emercoin]" id="cryptonator_payment_emercoin" class="cm-cryptonator-payment-type" value="emercoin"{if $processor_params.payments && $processor_params.payments.emercoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_ethereum">{__("cryptonator_payment_ethereum")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][ethereum]" id="cryptonator_payment_ethereum" class="cm-cryptonator-payment-type" value="ethereum"{if $processor_params.payments && $processor_params.payments.ethereum} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_litecoin">{__("cryptonator_payment_litecoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][litecoin]" id="cryptonator_payment_litecoin" class="cm-cryptonator-payment-type" value="litecoin"{if $processor_params.payments && $processor_params.payments.litecoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_peercoin">{__("cryptonator_payment_peercoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][peercoin]" id="cryptonator_payment_peercoin" class="cm-cryptonator-payment-type" value="peercoin"{if $processor_params.payments && $processor_params.payments.peercoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_primecoin">{__("cryptonator_payment_primecoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][primecoin]" id="cryptonator_payment_primecoin" class="cm-cryptonator-payment-type" value="primecoin"{if $processor_params.payments && $processor_params.payments.primecoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_reddcoin">{__("cryptonator_payment_reddcoin")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][reddcoin]" id="cryptonator_payment_reddcoin" class="cm-cryptonator-payment-type" value="reddcoin"{if $processor_params.payments && $processor_params.payments.reddcoin} checked="checked"{/if}>
        </div>
    </div>
        
    <div class="control-group">
        <label class="control-label" for="cryptonator_payment_zcash">{__("cryptonator_payment_zcash")}:</label>
        <div class="controls">
            <input type="checkbox" name="payment_data[processor_params][payments][zcash]" id="cryptonator_payment_zcash" class="cm-cryptonator-payment-type" value="zcash"{if $processor_params.payments && $processor_params.payments.zcash} checked="checked"{/if}>
        </div>
    </div>
        
    
    </fieldset>
</div>
*}
<div class="control-group">
    <label class="control-label" for="currency_{$payment_id}">{__("currency")}:</label>
    <div class="controls">
        <select name="payment_data[processor_params][currency]" id="currency_{$payment_id}">
            <option value="RUB"{if $processor_params.currency == "RUB"} selected="selected"{/if}>{__("currency_code_rur")}</option>
            <option value="USD"{if $processor_params.currency == "USD"} selected="selected"{/if}>{__("currency_code_usd")}</option>
            <option value="EUR"{if $processor_params.currency == "EUR"} selected="selected"{/if}>{__("currency_code_eur")}</option>
        </select>
    </div>
</div>

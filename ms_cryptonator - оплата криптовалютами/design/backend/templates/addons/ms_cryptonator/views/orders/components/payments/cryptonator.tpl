{assign var="cryptonator_payments" value=$payment_method.processor_params.payments}

{if $cryptonator_payments|count > 1}
    {*
    <div class="control-group">
        <label for="cryptonator_payment_type">{__("select_cryptonator_payment")}</label>
        <select name="payment_info[yandex_payment_type]" id="cryptonator_payment_type">
            {if $payment_method.processor_params.payments.bitcoin}
                <option value="bitcoin"> {__('cryptonator_payment_bitcoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.bitcoincash}
                <option value="bitcoincash"> {__('cryptonator_payment_bitcoincash')}</option>
            {/if}
            {if $payment_method.processor_params.payments.blackcoin}
                <option value="blackcoin"> {__('cryptonator_payment_blackcoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.bytecoin}
                <option value="bytecoin"> {__('cryptonator_payment_bytecoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.dash}
                <option value="dash"> {__('cryptonator_payment_dash')}</option>
            {/if}
            {if $payment_method.processor_params.payments.dogecoin}
                <option value="dogecoin"> {__('cryptonator_payment_dogecoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.emercoin}
                <option value="emercoin"> {__('cryptonator_payment_emercoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.ethereum}
                <option value="ethereum"> {__('cryptonator_payment_ethereum')}</option>
            {/if}
            {if $payment_method.processor_params.payments.litecoin}
                <option value="litecoin"> {__('cryptonator_payment_litecoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.peercoin}
                <option value="peercoin"> {__('cryptonator_payment_peercoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.primecoin}
                <option value="primecoin"> {__('cryptonator_payment_primecoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.reddcoin}
                <option value="reddcoin"> {__('cryptonator_payment_reddcoin')}</option>
            {/if}
            {if $payment_method.processor_params.payments.zcash}
                <option value="zcash"> {__('cryptonator_payment_zcash')}</option>
            {/if}
        </select>
    </div>
    *}
{elseif is_array($cryptonator_payments)}
    <input type="hidden" name="payment_info[cryptonator_payment_type]" value="{$cryptonator_payments|key}">
{else}
    <input type="hidden" name="payment_info[cryptonator_payment_type]" value="">
{/if}

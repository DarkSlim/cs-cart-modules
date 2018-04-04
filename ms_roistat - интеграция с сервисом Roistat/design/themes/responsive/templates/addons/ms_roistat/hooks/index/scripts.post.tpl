{* модуль ms_roistat *}

{if $addons.ms_roistat}

    {$client_id = $addons.ms_roistat.roistat_client_id}

    {if $client_id != "ID"}

        <script data-no-defer>
            (function ms_roistat1(w, d, s, h, id) {       
                w.roistatProjectId = id; w.roistatHost = h;
                var p = d.location.protocol == "https:" ? "https://" : "http://";
                var u = /^.*roistat_visit=[^;]+(.*)?$/.test(d.cookie) ? "/dist/module.js" : "/api/site/1.0/"+id+"/init";
                var js = d.createElement(s); 
                js.charset="UTF-8"; 
                js.async = 1; 
                js.src = p+h+u; 
                var js2 = d.getElementsByTagName(s)[0]; 
                js2.parentNode.insertBefore(js, js2);
            })
            (window, document, 'script', 'cloud.roistat.com', '{$client_id}');              

        </script>

    {/if}

{/if}
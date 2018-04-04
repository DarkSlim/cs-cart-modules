<span class="ty-nowrap ty-stars">

    {section name="full_star" loop=$stars.full}
        <i class="ty-stars__icon ty-icon-star"></i>
    {/section}

    {if $stars.part}
        <i class="ty-stars__icon ty-icon-star-half"></i>
    {/if}

    {section name="full_star" loop=$stars.empty}
        <i class="ty-stars__icon ty-icon-star-empty"></i>
    {/section}

</span>
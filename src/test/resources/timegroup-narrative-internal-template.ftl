Total Worked Time: ${getTotalDuration(getTimeRows())?string.@duration}
<#if getTotalDuration(getTimeRows()) == getTotalDurationSecs() && getUser().getExperienceWeightingPercent() != 100>
 Total Chargeable Time: ${(getTotalDurationSecsPerTag() * getUser().getExperienceWeightingPercent() / 100)?round?string.@duration}
 ${'\r\n'}The chargeable time has been weighed based on an experience factor of ${getUser().getExperienceWeightingPercent()}%.
<#else>
 Total Chargeable Time: ${getTotalDurationSecsPerTag()?string.@duration}
</#if>
<#if getDurationSplitStrategy() == "DIVIDE_BETWEEN_TAGS" && (getTags()?size > 1)>
 ${'\r\n'}The above times have been split across ${getTags()?size} items and are thus greater than the chargeable time in this item
</#if>

<#function getTotalDurationSecsPerTag>
 <#local totalDurationSecs = getTotalDurationSecs()>
 <#if getDurationSplitStrategy() == "DIVIDE_BETWEEN_TAGS" && (getTags()?size > 1)>
  <#local totalDurationSecs /= getTags()?size>
 </#if>
 <#return totalDurationSecs />
</#function>

<#function getTotalDuration timeRows>
 <#local rowTotalDuration = 0?number>
 <#list timeRows as timeRow>
  <#local rowTotalDuration += timeRow.getDurationSecs()>
 </#list>
 <#return rowTotalDuration />
</#function>


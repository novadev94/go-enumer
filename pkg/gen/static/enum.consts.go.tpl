{{- /* Declaration of enum's base constants */ -}}
{{- with $ts := .Type -}}
const (
	_{{ $ts.Name }}String      = "{{ $ts.AggregatedValueStrings }}"
{{- if $ts.SupportIgnoreCase }}
	_{{ $ts.Name }}LowerString = "{{ lower $ts.AggregatedValueStrings }}"
{{- end }}
)

{{ end -}}

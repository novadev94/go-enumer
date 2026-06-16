
{{- /* Declare lookup functions of enum type */ -}}
{{- with $ts := .Type -}}
{{- if not $ts.UseSwitchLookup }}
var (
	_{{ $ts.Name }}StringToValueMap = map[string]{{ $ts.Name }}{
{{- range $v := $ts.Values }}
		_{{ $ts.Name }}String[{{ $v.Position }}:{{ add $v.Position $v.Length }}]: {{ if $ts.IsFromCsvSource }}{{ $v.Value }}{{ else }}{{ $v.ConstName }}{{ end }},
{{- end }}
	}
{{- if $ts.SupportIgnoreCase }}
	_{{ $ts.Name }}LowerStringToValueMap = map[string]{{ $ts.Name }}{
{{- range $v := $ts.Values }}
		_{{ $ts.Name }}LowerString[{{ $v.Position }}:{{ add $v.Position $v.Length }}]: {{ if $ts.IsFromCsvSource }}{{ $v.Value }}{{ else }}{{ $v.ConstName }}{{ end }},
{{- end }}
	}
{{- end }}
)
{{- end }}

// {{ $ts.Name }}FromString determines the enum value with an exact case match.
func {{ $ts.Name }}FromString(raw string) ({{ $ts.Name }}, bool) {
{{- if $ts.SupportUndefined }}
	if len(raw) == 0 {
		return {{ $ts.Name }}(0), true
	}
{{- end }}
{{- if $ts.UseSwitchLookup }}
	switch raw {
{{- range $v := $ts.Values }}
	case _{{ $ts.Name }}String[{{ $v.Position }}:{{ add $v.Position $v.Length }}]:
		return {{ if $ts.IsFromCsvSource }}{{ $v.Value }}{{ else }}{{ $v.ConstName }}{{ end }}, true
{{- end }}
	default:
		return {{ $ts.Name }}(0), false
	}
{{- else }}
	v, ok := _{{ $ts.Name }}StringToValueMap[raw]
	if !ok {
		return {{ $ts.Name }}(0), false
	}
	return v, true
{{- end }}
}

{{- if $ts.SupportIgnoreCase }}
// {{ $ts.Name }}FromStringIgnoreCase determines the enum value with a case-insensitive match.
func {{ $ts.Name }}FromStringIgnoreCase(raw string) ({{ $ts.Name }}, bool) {
{{- if $ts.SupportUndefined }}
	if len(raw) == 0 {
		return {{ $ts.Name }}(0), true
	}
{{- end }}
	v, ok := {{ $ts.Name }}FromString(raw)
	if ok {
		return v, ok
	}
{{- if $ts.UseSwitchLookup }}
	switch raw {
{{- range $v := $ts.Values }}
	case _{{ $ts.Name }}LowerString[{{ $v.Position }}:{{ add $v.Position $v.Length }}]:
		return {{ if $ts.IsFromCsvSource }}{{ $v.Value }}{{ else }}{{ $v.ConstName }}{{ end }}, true
{{- end }}
	default:
		return {{ $ts.Name }}(0), false
	}
{{- else }}
	v, ok = _{{ $ts.Name }}LowerStringToValueMap[raw]
	if !ok {
		return {{ $ts.Name }}(0), false
	}
	return v, true
{{- end }}
}
{{- end }}

{{ end -}}

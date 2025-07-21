{{- define "cluster.name" -}}
    {{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "openstackmachinetemplate.controlplane.name" -}}
    {{- include "cluster.name" . }}-cp-mt-{{ .Values.controlPlane.image | toString | sha256sum | trunc 8 }}
{{- end }}

{{- define "openstackmachinetemplate.worker.name" -}}
    {{- include "cluster.name" . }}-worker-mt-{{ .Values.worker.image | toString | sha256sum | trunc 8 }}
{{- end }}

{{- define "openstackmachinetemplate.ingress.name" -}}
    {{- include "cluster.name" . }}-ingress-mt-{{ .Values.ingress.image | toString | sha256sum | trunc 8 }}
{{- end }}

{{- define "openstackmachinetemplate.gpu.name" -}}
    {{- $gpuType := .gpuType }}
    {{- include "cluster.name" .root }}-{{ $gpuType }}-mt-{{ .root.Values.gpu.image | toString | sha256sum | trunc 8 }}
{{- end }}

{{- define "k0scontrolplane.name" -}}
    {{- include "cluster.name" . }}-cp
{{- end }}

{{- define "k0sworkerconfigtemplate.name" -}}
    {{- include "cluster.name" . }}-machine-config
{{- end }}

{{- define "machinedeployment.worker.name" -}}
    {{- include "cluster.name" . }}-worker-md
{{- end }}

{{- define "machinedeployment.ingress.name" -}}
    {{- include "cluster.name" . }}-ingress-md
{{- end }}

{{- define "machinedeployment.gpu.name" -}}
    {{- $gpuType := .gpuType }}
    {{- include "cluster.name" .root }}-{{ $gpuType }}-md
{{- end }}

{{- define "gpu.enabled" -}}
    {{- $gpuType := .gpuType }}
    {{- $gpuConfig := index .root.Values.gpuTypes $gpuType }}
    {{- if and $gpuConfig (gt ($gpuConfig.replicas | int) 0) -}}
        {{- true -}}
    {{- else -}}
        {{- false -}}
    {{- end -}}
{{- end }}


{{/*
Expand the name of the chart.
*/}}
{{- define "core-api.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "core-api.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "core-api.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "core-api.labels" -}}
helm.sh/chart: {{ include "core-api.chart" . }}
{{ include "core-api.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "core-api.selectorLabels" -}}
app.kubernetes.io/name: {{ include "core-api.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "core-api.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "core-api.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{- define "core-api.tplvalue" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Primary prod host for ingress
*/}}
{{- define "core-api.primaryProdIngressHost" -}}
  {{- printf "%s.%s.%s" .Values.deploymentLabels.subEnvironment .Values.deploymentLabels.location .Values.deploymentLabels.baseDomain -}}
{{- end -}}

{{/*
Secondary host for ingress
*/}}
{{- define "core-api.ingressHost" -}}
  {{- printf "%s.%s.%s" .Values.deploymentLabels.subEnvironment .Values.deploymentLabels.location .Values.deploymentLabels.baseDomain -}}
{{- end -}}

{{/*
Pod immutable labels
*/}}
{{- define "core-api.pod-immutable-labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
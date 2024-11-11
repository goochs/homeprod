package kube

#secret & {
	apiVersion: "v1"
	kind:       "Secret"
	metadata: name: "onepass-connect-secret"
	stringData: {
		token:                        "ENC[AES256_GCM,data:tH66KP1GBNbSmPXstr7sgp4VRBDA9rR7Ge5qpmX+zPSrb5wnmTu9/GlfEXegfGSxuPCDmS1LC/rQJyS83ZVpYKzg8vX3VGMNHrCy6yt20xXiuZyUAC2rYaJ0o+lrzbMBWxwKTqGk2SLy4gYlpFWkI87XtzpL6KLtcUsQwNRZoxmRHy8n/D9NdTlHAm62OXRaXErJf97ucN18BRpLwmU9ZM6JHmMiX44r8cqy1UyKvM88fmk1GMfjEbyDMsUiWfhFCtgiS9ZFxCvRmNwQ1plsMQF5Rqw0K2dHinNdT+tHjvW3W7OZfMbk1vw2KY4VJFOW9AbbZbve+WFdstp+73wUZUr6A5ZveDeNzlQZlnsDqKdGlXI5KwaxmxK3fAnR32pfsi2Yai7O5GaWkLp3YT9lOgx4lesqCg4v/w12x02zci1EHALeTyt5e7yHqBn2QuIDvR/3YK39Z3hWMOfKAkzbO02MrJiWJMd3xJLTAopLKDd16Z1l2iHklBYY8KPZ5o3aFSP+jmtsEPjFoER6X50vzHBnVQe40IwFpdzTdiAMCTEdkM7uXT/t7Yj9Pgnz78r7cGFcqPoR8IlvstSMAaQUsTknVo8h5CxxixJD4g6r4AaPqr9trhN5U1VKHONmfhTbBqFDqX9AnUgg+JTpIAK/6CZ7x4NF/zmDPQ0YbLYrSQGGaQhMHEQ99E8DqvxxG7xipx9LnnKjQg2XufiRzAoP/9OhpLauhTLtbq0ktDSCmptKGd2MSie91qdA2cQUmk9goNM1yRiEE8VWzB3vnmSiPqlGb8Ms/oQptv72HLU32mbiBRajEsaNylpIEPrm0VDjuJDvOPGjQ6HsjWMX375yd3Vk,iv:W+U7PRdODTF6fSjRG5fLXHxSRZf1Cs9pnAJvbfIHh58=,tag:Ktq+Eq6TORIaMSALWl6fIA==,type:str]"
		"1password-credentials.json": "ENC[AES256_GCM,data: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,iv:lGvcFHbGzAYG0mYrv6Y/SLKkEa0YqhsfbwAvshCnd+0=,tag:d+ThGg9T9prW5ORO9YkApw==,type:str]"
	}
	sops: {
		kms: []
		gcp_kms: []
		azure_kv: []
		hc_vault: []
		age: [{
			recipient: "age17yhdxmw884lyl8m022pfqlh5c8j4e5ljcr7k7qugy63xnptkmvysdm345w"
			enc: """
				-----BEGIN AGE ENCRYPTED FILE-----
				YWdlLWVuY3J5cHRpb24ub3JnL3YxCi0+IFgyNTUxOSAvSGZwcTVnRmdQZnJOYWhC
				aWF3ekVoL1dxQW1HOURGTmZBbENWR0tTOVRjClFucmpHbEptS0NpQ1FOZ3NoR082
				RVRDUTlsK0ZOQVhTcVp2Y1NwU2xoWHcKLS0tIHZyaldRSXNxZ3JZcFZxZDFPRmpT
				cGZUU1BzRkZLYjRNdkxIWW5CNFNSVVEKTphhL/u1fbmtLslLIe/8P0uWZ5a/+MjC
				Ocif3VMxZn/Z8Avbp6h9oKxf2H4RLKlYwcCHMvb5foJuajUflajJIA==
				-----END AGE ENCRYPTED FILE-----

				"""
		}]
		lastmodified: "2024-11-11T22:42:58Z"
		mac:          "ENC[AES256_GCM,data:OQpFqKdcN58xZDH2VpsDSmt6SD3h7h73GNyTxW413czukzGFvmVAIKg0CoFecQPkkBYXhPiqmNIEzRFRpV6egdxthtNuRiJUNBhtk7dqvYFtcoDw7ILhZlFEVNZy5Ye92f35/53UYZCJrBLgR0sL/MR+IRLis0hyWJN/xkEVLig=,iv:imXd2oiS15ohzONig6t33zSpFabf2UwxzCfhNqzgIR4=,tag:MUbRpoG+2sIbvSPVteegDg==,type:str]"
		pgp: []
		encrypted_regex: "^(data|stringData)$"
		version:         "3.8.1"
	}
}

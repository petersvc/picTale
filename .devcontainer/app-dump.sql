--
-- PostgreSQL database dump
--

-- Dumped from database version 12.22
-- Dumped by pg_dump version 12.22

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: api; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA api;


ALTER SCHEMA api OWNER TO postgres;

--
-- Name: tvlar; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA tvlar;


ALTER SCHEMA tvlar OWNER TO postgres;

--
-- Name: SCHEMA tvlar; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA tvlar IS 'standard public schema';


--
-- Name: atualizar_cdc_ajuste(); Type: FUNCTION; Schema: tvlar; Owner: postgres
--

CREATE FUNCTION tvlar.atualizar_cdc_ajuste() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
v_tipo_ajuste CHAR(1);
BEGIN
-- Obtém o tipo de ajuste da tabela t_tipo_lancamento_ajuste
SELECT t.tipo_ajuste INTO v_tipo_ajuste
FROM t_tipo_lancamento_ajuste t
WHERE t.id_tipo_lancamento_ajuste = NEW.id_tipo_lancamento_ajuste;

-- Verifica o tipo de ajuste e atualiza t_cdc conforme necessário
IF v_tipo_ajuste = 'C' THEN
UPDATE t_cdc
SET ajuste_credito = (
    SELECT COALESCE(SUM(l.valor), 0)
    FROM t_lancamento_ajuste l
             JOIN t_tipo_lancamento_ajuste t ON l.id_tipo_lancamento_ajuste = t.id_tipo_lancamento_ajuste
    WHERE t.tipo_ajuste = 'C' AND l.id_cdc = NEW.id_cdc
)
WHERE id_cdc = NEW.id_cdc;
ELSIF v_tipo_ajuste = 'D' THEN
UPDATE t_cdc
SET ajuste_debito = (
    SELECT COALESCE(SUM(l.valor), 0)
    FROM t_lancamento_ajuste l
             JOIN t_tipo_lancamento_ajuste t ON l.id_tipo_lancamento_ajuste = t.id_tipo_lancamento_ajuste
    WHERE t.tipo_ajuste = 'D' AND l.id_cdc = NEW.id_cdc
)
WHERE id_cdc = NEW.id_cdc;
END IF;

RETURN NEW;
END;
$$;


ALTER FUNCTION tvlar.atualizar_cdc_ajuste() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: t_tenant; Type: TABLE; Schema: api; Owner: postgres
--

CREATE TABLE api.t_tenant (
    emissor text NOT NULL,
    tenant text NOT NULL
);


ALTER TABLE api.t_tenant OWNER TO postgres;

--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.hibernate_sequence OWNER TO postgres;

--
-- Name: revinfo; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.revinfo (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    id_user bigint,
    ip character varying(255)
);


ALTER TABLE tvlar.revinfo OWNER TO postgres;

--
-- Name: s_acordo; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_acordo
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_acordo OWNER TO postgres;

--
-- Name: s_acordo_abatimento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_acordo_abatimento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_acordo_abatimento OWNER TO postgres;

--
-- Name: s_acordo_origem; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_acordo_origem
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_acordo_origem OWNER TO postgres;

--
-- Name: s_acordo_pagamento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_acordo_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_acordo_pagamento OWNER TO postgres;

--
-- Name: s_acordo_parcela; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_acordo_parcela
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_acordo_parcela OWNER TO postgres;

--
-- Name: s_administradora; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_administradora
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_administradora OWNER TO postgres;

--
-- Name: s_administradora_rede; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_administradora_rede
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_administradora_rede OWNER TO postgres;

--
-- Name: s_antecipacao; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_antecipacao
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_antecipacao OWNER TO postgres;

--
-- Name: s_antecipacao_item; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_antecipacao_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_antecipacao_item OWNER TO postgres;

--
-- Name: s_boleto; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_boleto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_boleto OWNER TO postgres;

--
-- Name: s_boleto_formato; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_boleto_formato
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_boleto_formato OWNER TO postgres;

--
-- Name: s_broker_sms; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_broker_sms
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_broker_sms OWNER TO postgres;

--
-- Name: s_cartao; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cartao
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cartao OWNER TO postgres;

--
-- Name: s_cartao_bin; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cartao_bin
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cartao_bin OWNER TO postgres;

--
-- Name: s_cartao_historico; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cartao_historico
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cartao_historico OWNER TO postgres;

--
-- Name: s_cartao_tipo_bloqueio; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cartao_tipo_bloqueio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cartao_tipo_bloqueio OWNER TO postgres;

--
-- Name: s_cdc; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cdc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cdc OWNER TO postgres;

--
-- Name: s_cdc_abatimento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cdc_abatimento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cdc_abatimento OWNER TO postgres;

--
-- Name: s_cdc_historico; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cdc_historico
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cdc_historico OWNER TO postgres;

--
-- Name: s_classificacao_reversao_pagamento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_classificacao_reversao_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_classificacao_reversao_pagamento OWNER TO postgres;

--
-- Name: s_cobransaas; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_cobransaas
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_cobransaas OWNER TO postgres;

--
-- Name: s_consumidor; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_consumidor
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_consumidor OWNER TO postgres;

--
-- Name: s_consumidor_conjuge; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_consumidor_conjuge
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_consumidor_conjuge OWNER TO postgres;

--
-- Name: s_consumidor_dependente; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_consumidor_dependente
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_consumidor_dependente OWNER TO postgres;

--
-- Name: s_consumidor_referencia; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_consumidor_referencia
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_consumidor_referencia OWNER TO postgres;

--
-- Name: s_consumidor_socio; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_consumidor_socio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_consumidor_socio OWNER TO postgres;

--
-- Name: s_consumidor_telefone; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_consumidor_telefone
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_consumidor_telefone OWNER TO postgres;

--
-- Name: s_contato; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_contato
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_contato OWNER TO postgres;

--
-- Name: s_contrato; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_contrato
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_contrato OWNER TO postgres;

--
-- Name: s_endereco; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_endereco OWNER TO postgres;

--
-- Name: s_estabelecimento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_estabelecimento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_estabelecimento OWNER TO postgres;

--
-- Name: s_estorno; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_estorno
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_estorno OWNER TO postgres;

--
-- Name: s_execucao_job_agenda_repasse; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_execucao_job_agenda_repasse
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_execucao_job_agenda_repasse OWNER TO postgres;

--
-- Name: s_feriado; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_feriado
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_feriado OWNER TO postgres;

--
-- Name: s_funcionario; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_funcionario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_funcionario OWNER TO postgres;

--
-- Name: s_horizon; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_horizon
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_horizon OWNER TO postgres;

--
-- Name: s_horizon_servico; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_horizon_servico
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_horizon_servico OWNER TO postgres;

--
-- Name: s_informacao_banco; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_informacao_banco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_informacao_banco OWNER TO postgres;

--
-- Name: s_integracao; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_integracao
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_integracao OWNER TO postgres;

--
-- Name: s_integracao_header; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_integracao_header
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_integracao_header OWNER TO postgres;

--
-- Name: s_lancamento_ajuste; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_lancamento_ajuste
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_lancamento_ajuste OWNER TO postgres;

--
-- Name: s_pagamento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_pagamento OWNER TO postgres;

--
-- Name: s_pagamento_item; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_pagamento_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_pagamento_item OWNER TO postgres;

--
-- Name: s_plano_pagamento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_plano_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_plano_pagamento OWNER TO postgres;

--
-- Name: s_produto; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_produto OWNER TO postgres;

--
-- Name: s_profile; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_profile
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_profile OWNER TO postgres;

--
-- Name: s_proposta; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_proposta
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_proposta OWNER TO postgres;

--
-- Name: s_remessa; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_remessa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_remessa OWNER TO postgres;

--
-- Name: s_remessa_contrato; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_remessa_contrato
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_remessa_contrato OWNER TO postgres;

--
-- Name: s_remessa_contrato_parcela; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_remessa_contrato_parcela
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_remessa_contrato_parcela OWNER TO postgres;

--
-- Name: s_remessa_contrato_parcela_historico; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_remessa_contrato_parcela_historico
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_remessa_contrato_parcela_historico OWNER TO postgres;

--
-- Name: s_retorno_cnab; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_retorno_cnab
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_retorno_cnab OWNER TO postgres;

--
-- Name: s_retorno_parcela; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_retorno_parcela
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_retorno_parcela OWNER TO postgres;

--
-- Name: s_reversao_pagamento; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_reversao_pagamento
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_reversao_pagamento OWNER TO postgres;

--
-- Name: s_reversao_pagamento_item; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_reversao_pagamento_item
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_reversao_pagamento_item OWNER TO postgres;

--
-- Name: s_role; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_role
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_role OWNER TO postgres;

--
-- Name: s_senior; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_senior
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_senior OWNER TO postgres;

--
-- Name: s_senior_log; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_senior_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_senior_log OWNER TO postgres;

--
-- Name: s_sms; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_sms
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_sms OWNER TO postgres;

--
-- Name: s_tipo_lancamento_ajuste; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_tipo_lancamento_ajuste
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_tipo_lancamento_ajuste OWNER TO postgres;

--
-- Name: s_tipo_transacao; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_tipo_transacao
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_tipo_transacao OWNER TO postgres;

--
-- Name: s_tivea_log; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_tivea_log
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_tivea_log OWNER TO postgres;

--
-- Name: s_token_acesso; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_token_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_token_acesso OWNER TO postgres;

--
-- Name: s_transacao; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_transacao
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_transacao OWNER TO postgres;

--
-- Name: s_user; Type: SEQUENCE; Schema: tvlar; Owner: postgres
--

CREATE SEQUENCE tvlar.s_user
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE tvlar.s_user OWNER TO postgres;

--
-- Name: t_acordo; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_acordo (
    id_acordo bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    codigo_barra character varying(255),
    data_emissao date,
    data_operacao date,
    data_vencimento date,
    id_cobransaas bigint,
    meio_pagamento character varying(255),
    nsu character varying(255),
    numero_acordo bigint NOT NULL,
    numero_parcelas integer NOT NULL,
    percentual_taxa_operacao numeric(19,2),
    status character varying(255),
    tipo character varying(255),
    valor_juros numeric(19,2),
    valor_principal numeric(19,2),
    valor_tarifa numeric(19,2),
    valor_total numeric(19,2),
    id_consumidor bigint,
    id_contrato bigint,
    ativado boolean DEFAULT false
);


ALTER TABLE tvlar.t_acordo OWNER TO postgres;

--
-- Name: t_acordo_abatimento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_acordo_abatimento (
    id_acordo_abatimento bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cobransaas_id bigint,
    cobransaas_origem bigint,
    data_hora_integracao timestamp without time zone,
    integracao character varying(255),
    mensagem_integracao character varying(255),
    percentual numeric(19,2),
    tipo character varying(255),
    valor_adicionado numeric(19,2),
    valor_atual numeric(19,2),
    valor_desconto numeric(19,2),
    valor_juros numeric(19,2),
    valor_mora numeric(19,2),
    valor_multa numeric(19,2),
    valor_outros numeric(19,2),
    valor_permanencia numeric(19,2),
    valor_principal numeric(19,2),
    valor_tarifa numeric(19,2),
    valor_total numeric(19,2),
    valor_tributo numeric(19,2),
    id_acordo_pagamento bigint,
    id_cdc bigint
);


ALTER TABLE tvlar.t_acordo_abatimento OWNER TO postgres;

--
-- Name: t_acordo_origem; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_acordo_origem (
    id_acordo_origem bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cobransaas_contrato_id bigint,
    cobransaas_id bigint,
    cobransaas_parcela_id bigint,
    contrato character varying(255),
    data_vencimento date,
    desconto_juros numeric(19,2),
    desconto_mora numeric(19,2),
    desconto_multa numeric(19,2),
    desconto_outros numeric(19,2),
    desconto_permanencia numeric(19,2),
    desconto_principal numeric(19,2),
    desconto_total numeric(19,2),
    dias_atraso integer NOT NULL,
    numero_contrato character varying(255),
    numero_parcela integer NOT NULL,
    parcela character varying(255),
    saldo_adicionado numeric(19,2),
    saldo_atual numeric(19,2),
    saldo_desconto numeric(19,2),
    saldo_juros numeric(19,2),
    saldo_mora numeric(19,2),
    saldo_multa numeric(19,2),
    saldo_outros numeric(19,2),
    saldo_permanencia numeric(19,2),
    saldo_principal numeric(19,2),
    saldo_tarifa numeric(19,2),
    saldo_total numeric(19,2),
    situacao character varying(255),
    valor_adicionado numeric(19,2),
    valor_atual numeric(19,2),
    valor_desconto numeric(19,2),
    valor_juros numeric(19,2),
    valor_mora numeric(19,2),
    valor_multa numeric(19,2),
    valor_outros numeric(19,2),
    valor_permanencia numeric(19,2),
    valor_principal numeric(19,2),
    valor_tarifa numeric(19,2),
    valor_total numeric(19,2),
    id_acordo bigint,
    id_cdc bigint
);


ALTER TABLE tvlar.t_acordo_origem OWNER TO postgres;

--
-- Name: t_acordo_pagamento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_acordo_pagamento (
    id_acordo_pagamento bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cobransaas_id bigint,
    data_hora_inclusao timestamp without time zone,
    data_liquidacao date,
    data_operacao date,
    data_processamento date,
    forma_liquidacao character varying(255),
    integracao character varying(255),
    situacao character varying(255),
    valor_desconto numeric(19,2),
    valor_distorcao numeric(19,2),
    valor_encargos numeric(19,2),
    valor_recebido numeric(19,2),
    valor_sobra numeric(19,2),
    id_acordo bigint
);


ALTER TABLE tvlar.t_acordo_pagamento OWNER TO postgres;

--
-- Name: t_acordo_parcela; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_acordo_parcela (
    id_acordo_parcela bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data_vencimento date,
    numero_parcela integer NOT NULL,
    saldo_atual numeric(19,2),
    saldo_principal numeric(19,2),
    saldo_total numeric(19,2),
    situacao character varying(255),
    valor_adicionado numeric(19,2),
    valor_base_tributo numeric(19,2),
    valor_juros numeric(19,2),
    valor_mora numeric(19,2),
    valor_multa numeric(19,2),
    valor_permanencia numeric(19,2),
    valor_principal numeric(19,2),
    valor_tarifa numeric(19,2),
    valor_total numeric(19,2),
    valor_tributo numeric(19,2),
    id_acordo bigint,
    id_cdc bigint
);


ALTER TABLE tvlar.t_acordo_parcela OWNER TO postgres;

--
-- Name: t_acordo_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_acordo_transacao (
    id_acordo bigint NOT NULL,
    id_transacao bigint NOT NULL
);


ALTER TABLE tvlar.t_acordo_transacao OWNER TO postgres;

--
-- Name: t_administradora; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_administradora (
    id_administradora bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cnpj character varying(255),
    codigo_carteira_boleto_simples bigint,
    nome_fantasia character varying(255),
    observacao text,
    razao_social character varying(255),
    status character varying(255),
    id_endereco bigint
);


ALTER TABLE tvlar.t_administradora OWNER TO postgres;

--
-- Name: t_administradora_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_administradora_aud (
    id_administradora bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    cnpj character varying(255),
    codigo_carteira_boleto_simples bigint,
    nome_fantasia character varying(255),
    observacao text,
    razao_social character varying(255),
    status character varying(255)
);


ALTER TABLE tvlar.t_administradora_aud OWNER TO postgres;

--
-- Name: t_administradora_contato; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_administradora_contato (
    id_administradora bigint NOT NULL,
    id_contato bigint NOT NULL
);


ALTER TABLE tvlar.t_administradora_contato OWNER TO postgres;

--
-- Name: t_administradora_contato_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_administradora_contato_aud (
    rev integer NOT NULL,
    id_administradora bigint NOT NULL,
    id_contato bigint NOT NULL,
    revtype smallint
);


ALTER TABLE tvlar.t_administradora_contato_aud OWNER TO postgres;

--
-- Name: t_administradora_rede; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_administradora_rede (
    id_administradora_rede bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    nome character varying(255),
    status character varying(255),
    id_administradora bigint
);


ALTER TABLE tvlar.t_administradora_rede OWNER TO postgres;

--
-- Name: t_administradora_rede_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_administradora_rede_aud (
    id_administradora_rede bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    nome character varying(255),
    status character varying(255),
    id_administradora bigint
);


ALTER TABLE tvlar.t_administradora_rede_aud OWNER TO postgres;

--
-- Name: t_antecipacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_antecipacao (
    id_antecipacao bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    codigo_barra character varying(255),
    valor numeric(16,2) NOT NULL,
    valor_antecipacao numeric(16,2) NOT NULL,
    desconto numeric(16,2),
    data_operacao date NOT NULL,
    data_vencimento date NOT NULL,
    status character varying(50) NOT NULL,
    id_consumidor bigint NOT NULL,
    id_contrato bigint NOT NULL,
    id_contrato_origem bigint NOT NULL
);


ALTER TABLE tvlar.t_antecipacao OWNER TO postgres;

--
-- Name: t_antecipacao_item; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_antecipacao_item (
    id_antecipacao_item bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data_emissao date NOT NULL,
    data_vencimento date NOT NULL,
    numero_parcela integer NOT NULL,
    codigo_barra character varying(255),
    valor numeric(16,2) NOT NULL,
    valor_antecipacao numeric(16,2) NOT NULL,
    valor_taxa_operacao numeric(16,2),
    desconto numeric(16,2) NOT NULL,
    id_antecipacao bigint NOT NULL,
    id_cdc bigint NOT NULL
);


ALTER TABLE tvlar.t_antecipacao_item OWNER TO postgres;

--
-- Name: t_boleto; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_boleto (
    id_boleto bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    aceite character varying(255),
    agencia_digito character varying(255),
    agencia_numero character varying(255),
    anotacoes character varying(255),
    beneficiario_codigo character varying(255),
    beneficiario_cpf_cnpj character varying(255),
    beneficiario_endereco character varying(255),
    beneficiario_nome character varying(255),
    carteira_chave character varying(255),
    codigo_externo bigint,
    conta_codigo bigint,
    conta_digito character varying(255),
    conta_numero character varying(255),
    data_documento date,
    data_hora_atualizacao timestamp without time zone,
    data_hora_criacao timestamp without time zone,
    data_hora_registro timestamp without time zone,
    data_pagamento date,
    data_vencimento date,
    descricao character varying(255),
    dias_para_baixa integer,
    dias_para_desconto integer,
    dias_para_juros integer,
    dias_para_multa integer,
    dias_para_segundo_desconto integer,
    dias_para_terceiro_desconto integer,
    instrucoes character varying(255),
    linha_digitavel character varying(255),
    meta character varying(255),
    nosso_numero bigint,
    nosso_numerodv character varying(255),
    nosso_numerodvformatado character varying(255),
    numero_documento character varying(255),
    percentual_desconto numeric(19,2),
    percentual_juros numeric(19,2),
    percentual_multa numeric(19,2),
    percentual_segundo_desconto numeric(19,2),
    percentual_terceiro_desconto numeric(19,2),
    status character varying(255),
    tipo_desconto character varying(255),
    tipo_documento character varying(255),
    tipo_juros character varying(255),
    tipo_multa character varying(255),
    valor numeric(19,2),
    valor_desconto numeric(19,2),
    valor_juros numeric(19,2),
    valor_multa numeric(19,2),
    valor_segundo_desconto numeric(19,2),
    valor_terceiro_desconto numeric(19,2),
    id_boleto_formato bigint,
    id_consumidor bigint
);


ALTER TABLE tvlar.t_boleto OWNER TO postgres;

--
-- Name: t_boleto_formato; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_boleto_formato (
    id_boleto_formato bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    barcode character varying(255),
    boleto_hibrido character varying(255),
    boleto_pix character varying(255),
    envelope character varying(255),
    letter character varying(255),
    line character varying(255),
    padrao character varying(255),
    pdf character varying(255),
    png character varying(255),
    recibo character varying(255),
    id_boleto bigint
);


ALTER TABLE tvlar.t_boleto_formato OWNER TO postgres;

--
-- Name: t_boleto_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_boleto_transacao (
    id_boleto bigint NOT NULL,
    id_transacao bigint NOT NULL
);


ALTER TABLE tvlar.t_boleto_transacao OWNER TO postgres;

--
-- Name: t_broker_sms; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_broker_sms (
    id_broker_sms bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    ambiente character varying(255),
    authorization_header_token character varying(255),
    content_type_header character varying(255),
    content_type_header_token character varying(255),
    grant_type_header_token character varying(255),
    password_token character varying(255),
    token character varying(255),
    url character varying(255),
    url_token character varying(255),
    username_token character varying(255)
);


ALTER TABLE tvlar.t_broker_sms OWNER TO postgres;

--
-- Name: t_cartao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cartao (
    id_cartao bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    numero_cartao character varying(255) NOT NULL,
    nome_titular character varying(27) NOT NULL,
    data_validade character varying(255) NOT NULL,
    tipo_cartao character varying(20),
    numero_truncado character varying(16) NOT NULL,
    id_consumidor bigint,
    status character varying(20),
    CONSTRAINT t_cartao_nome_titular_tamanho CHECK ((char_length((nome_titular)::text) <= 27)),
    CONSTRAINT t_cartao_numero_truncado_valido CHECK (((numero_truncado)::text ~ '^\d{4}X{8}\d{4}$'::text))
);


ALTER TABLE tvlar.t_cartao OWNER TO postgres;

--
-- Name: t_cartao_bin; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cartao_bin (
    id_cartao_bin bigint NOT NULL,
    version bigint,
    insert_date timestamp with time zone,
    update_date timestamp with time zone,
    numero_bin character varying(8) NOT NULL,
    descricao character varying(100) NOT NULL
);


ALTER TABLE tvlar.t_cartao_bin OWNER TO postgres;

--
-- Name: t_cartao_historico; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cartao_historico (
    id_cartao_historico bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    id_cartao bigint,
    status character varying(20),
    id_user bigint,
    id_cartao_tipo_bloqueio bigint,
    descricao character varying(100) NOT NULL
);


ALTER TABLE tvlar.t_cartao_historico OWNER TO postgres;

--
-- Name: t_cartao_tipo_bloqueio; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cartao_tipo_bloqueio (
    id_cartao_tipo_bloqueio bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    descricao character varying(100) NOT NULL,
    cancela_cartao boolean NOT NULL,
    permite_desbloqueio boolean NOT NULL,
    CONSTRAINT t_cartao_tipo_bloqueio_descricao_tamanho CHECK (((char_length((descricao)::text) >= 1) AND (char_length((descricao)::text) <= 100)))
);


ALTER TABLE tvlar.t_cartao_tipo_bloqueio OWNER TO postgres;

--
-- Name: t_cartao_tipo_bloqueio_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cartao_tipo_bloqueio_aud (
    id_cartao_tipo_bloqueio bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    descricao character varying(100),
    cancela_cartao boolean,
    permite_desbloqueio boolean
);


ALTER TABLE tvlar.t_cartao_tipo_bloqueio_aud OWNER TO postgres;

--
-- Name: t_cdc; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cdc (
    id_cdc bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cobranca boolean NOT NULL,
    codigo_barra character varying(255),
    data_emissao timestamp without time zone,
    data_perdido date,
    data_vencimento date,
    dias_entre_pagamentos integer NOT NULL,
    iof_adicional_atraso numeric(16,2),
    iof_diario_atraso numeric(16,2),
    mora numeric(16,2),
    multa numeric(16,2),
    numero_parcela integer NOT NULL,
    renegociado boolean NOT NULL,
    status character varying(255),
    total_parcelas integer NOT NULL,
    tp_amortizacaoiof numeric(16,2),
    tp_amortizacao_principal numeric(16,2),
    tp_jurosiof numeric(16,2),
    tp_juros_principal numeric(16,2),
    tp_saldo_devedoriof numeric(16,2),
    tp_saldo_devedor_principal numeric(16,2),
    tp_valor_prestacao numeric(16,2),
    valor numeric(16,2),
    valor_taxa_operacao numeric(16,2),
    id_contrato bigint,
    ajuste_credito numeric(16,2) DEFAULT 0 NOT NULL,
    ajuste_debito numeric(16,2) DEFAULT 0 NOT NULL,
    fator_desconto numeric(16,2),
    iof_dia numeric(16,4),
    iof_adicional numeric(16,4),
    iof_total numeric(16,2)
);


ALTER TABLE tvlar.t_cdc OWNER TO postgres;

--
-- Name: t_cdc_abatimento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cdc_abatimento (
    id_cdc_abatimento bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    mora numeric(16,2),
    multa numeric(16,2),
    percentual numeric(16,2),
    status character varying(255),
    valor numeric(16,2),
    valor_taxa_operacao numeric(16,2),
    valor_total numeric(16,2),
    id_cdc bigint,
    id_pagamento_item bigint,
    ajuste_credito numeric(16,2) DEFAULT 0,
    ajuste_debito numeric(16,2) DEFAULT 0,
    desconto_pagamento_antecipado numeric(10,2) DEFAULT 0
);


ALTER TABLE tvlar.t_cdc_abatimento OWNER TO postgres;

--
-- Name: t_cdc_boleto; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cdc_boleto (
    id_cdc bigint NOT NULL,
    id_boleto bigint NOT NULL
);


ALTER TABLE tvlar.t_cdc_boleto OWNER TO postgres;

--
-- Name: t_cdc_historico; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cdc_historico (
    id_cdc_historico bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    data_vencimento date,
    iof_adicional_atraso numeric(10,2),
    iof_diario_atraso numeric(10,2),
    mora numeric(10,2),
    multa numeric(10,2),
    operacao character varying(255),
    status character varying(255),
    valor numeric(10,2),
    id_cdc bigint,
    id_transacao bigint
);


ALTER TABLE tvlar.t_cdc_historico OWNER TO postgres;

--
-- Name: t_classificacao_reversao_pagamento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_classificacao_reversao_pagamento (
    id_classificacao bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    codigo_contabil character varying(255) NOT NULL,
    descricao character varying(255) NOT NULL
);


ALTER TABLE tvlar.t_classificacao_reversao_pagamento OWNER TO postgres;

--
-- Name: t_classificador; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_classificador (
    id_classificador bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    descricao character varying(255) NOT NULL
);


ALTER TABLE tvlar.t_classificador OWNER TO postgres;

--
-- Name: t_classificador_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_classificador_aud (
    id_classificador bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    descricao character varying(255)
);


ALTER TABLE tvlar.t_classificador_aud OWNER TO postgres;

--
-- Name: t_cobransaas; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_cobransaas (
    id_cobransaas bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    agrupador character varying(255),
    ambiente character varying(255),
    auth character varying(255),
    produto character varying(255),
    token character varying(255),
    url_acordo_confirmar_abatimento character varying(255),
    url_acordo_pagamento character varying(255),
    url_acordo_vincular_contrato character varying(255),
    url_consumidor_cadastrar character varying(255),
    url_consumidor_visualizar character varying(255),
    url_contrato_cadastrar character varying(255),
    url_contrato_excluir character varying(255),
    url_contrato_visualizar character varying(255),
    url_contrato_visualizar_parcelas character varying(255),
    url_login character varying(255)
);


ALTER TABLE tvlar.t_cobransaas OWNER TO postgres;

--
-- Name: t_consumidor; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor (
    id_consumidor bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    atividade_primaria character varying(255),
    cargo_solicitante character varying(255),
    cidade_natal character varying(255),
    cpf_cnpj character varying(255),
    data_emissao_rg date,
    data_nascimento date,
    email character varying(255),
    escolaridade character varying(255),
    estado_civil character varying(255),
    estado_natal character varying(255),
    faturamento_data date,
    faturamento_valor numeric(19,2),
    inscricao_estadual character varying(255),
    nacionalidade character varying(255),
    nome character varying(255),
    nome_mae character varying(255),
    nome_pai character varying(255),
    observacao text,
    ocupacao character varying(255),
    orgao_emissorrg character varying(255),
    profissao character varying(255),
    razao_social character varying(255),
    renda numeric(19,2),
    responsavel_financeiro character varying(255),
    rg character varying(255),
    sexo character varying(255),
    status character varying(255),
    tipo character varying(255),
    tributacao_tipo character varying(255),
    tributacao_valor numeric(19,2),
    vinculo_empregaticio boolean,
    id_classificador bigint,
    id_endereco_residencial bigint,
    id_user bigint
);


ALTER TABLE tvlar.t_consumidor OWNER TO postgres;

--
-- Name: t_consumidor_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_aud (
    id_consumidor bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    atividade_primaria character varying(255),
    cargo_solicitante character varying(255),
    cidade_natal character varying(255),
    cpf_cnpj character varying(255),
    data_emissao_rg date,
    data_nascimento date,
    email character varying(255),
    escolaridade character varying(255),
    estado_civil character varying(255),
    estado_natal character varying(255),
    faturamento_data date,
    faturamento_valor numeric(19,2),
    inscricao_estadual character varying(255),
    nacionalidade character varying(255),
    nome character varying(255),
    nome_mae character varying(255),
    nome_pai character varying(255),
    ocupacao character varying(255),
    orgao_emissorrg character varying(255),
    profissao character varying(255),
    razao_social character varying(255),
    renda numeric(19,2),
    responsavel_financeiro character varying(255),
    rg character varying(255),
    sexo character varying(255),
    status character varying(255),
    tipo character varying(255),
    tributacao_tipo character varying(255),
    tributacao_valor numeric(19,2),
    vinculo_empregaticio boolean
);


ALTER TABLE tvlar.t_consumidor_aud OWNER TO postgres;

--
-- Name: t_consumidor_conjuge; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_conjuge (
    id_consumidor_conjuge bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cpf character varying(255),
    data_emissao_rg date,
    data_nascimento date,
    nome character varying(255),
    orgao_emissor character varying(255),
    rg character varying(255),
    sexo character varying(255),
    id_consumidor bigint
);


ALTER TABLE tvlar.t_consumidor_conjuge OWNER TO postgres;

--
-- Name: t_consumidor_conjuge_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_conjuge_aud (
    id_consumidor_conjuge bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    cpf character varying(255),
    data_emissao_rg date,
    data_nascimento date,
    nome character varying(255),
    orgao_emissor character varying(255),
    rg character varying(255),
    sexo character varying(255)
);


ALTER TABLE tvlar.t_consumidor_conjuge_aud OWNER TO postgres;

--
-- Name: t_consumidor_dependente; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_dependente (
    id_consumidor_dependente bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    area character varying(255),
    cpf character varying(255),
    nome character varying(255),
    status character varying(255),
    telefone character varying(255),
    id_consumidor bigint
);


ALTER TABLE tvlar.t_consumidor_dependente OWNER TO postgres;

--
-- Name: t_consumidor_dependente_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_dependente_aud (
    id_consumidor_dependente bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    area character varying(255),
    cpf character varying(255),
    nome character varying(255),
    status character varying(255),
    telefone character varying(255)
);


ALTER TABLE tvlar.t_consumidor_dependente_aud OWNER TO postgres;

--
-- Name: t_consumidor_referencia; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_referencia (
    id_consumidor_referencia bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    grau_parentesco character varying(255),
    nome character varying(255),
    id_consumidor bigint
);


ALTER TABLE tvlar.t_consumidor_referencia OWNER TO postgres;

--
-- Name: t_consumidor_referencia_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_referencia_aud (
    id_consumidor_referencia bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    grau_parentesco character varying(255),
    nome character varying(255)
);


ALTER TABLE tvlar.t_consumidor_referencia_aud OWNER TO postgres;

--
-- Name: t_consumidor_socio; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_socio (
    id_consumidor_socio bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cargo character varying(255),
    cidade_natal character varying(255),
    cpf character varying(255),
    data_nascimento date,
    estado_civil character varying(255),
    nacionalidade character varying(255),
    nome character varying(255),
    orgao_emissorrg character varying(255),
    rg character varying(255),
    sexo character varying(255),
    uf character varying(255),
    id_consumidor bigint
);


ALTER TABLE tvlar.t_consumidor_socio OWNER TO postgres;

--
-- Name: t_consumidor_socio_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_socio_aud (
    id_consumidor_socio bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    cargo character varying(255),
    cidade_natal character varying(255),
    cpf character varying(255),
    data_nascimento date,
    estado_civil character varying(255),
    nacionalidade character varying(255),
    nome character varying(255),
    orgao_emissorrg character varying(255),
    rg character varying(255),
    sexo character varying(255),
    uf character varying(255)
);


ALTER TABLE tvlar.t_consumidor_socio_aud OWNER TO postgres;

--
-- Name: t_consumidor_telefone; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_telefone (
    id_consumidor_telefone bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    area character varying(255),
    ramal character varying(255),
    sms boolean NOT NULL,
    telefone character varying(255),
    tipo character varying(255),
    id_consumidor bigint,
    id_conjuge bigint,
    id_consumidor_referencia bigint,
    id_consumidor_socio bigint
);


ALTER TABLE tvlar.t_consumidor_telefone OWNER TO postgres;

--
-- Name: t_consumidor_telefone_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_consumidor_telefone_aud (
    id_consumidor_telefone bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    area character varying(255),
    ramal character varying(255),
    sms boolean,
    telefone character varying(255),
    tipo character varying(255),
    id_consumidor bigint,
    id_conjuge bigint,
    id_consumidor_referencia bigint,
    id_consumidor_socio bigint
);


ALTER TABLE tvlar.t_consumidor_telefone_aud OWNER TO postgres;

--
-- Name: t_contato; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_contato (
    idcontato bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    tipo_contato character varying(255),
    valor character varying(255)
);


ALTER TABLE tvlar.t_contato OWNER TO postgres;

--
-- Name: t_contato_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_contato_aud (
    idcontato bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    tipo_contato character varying(255),
    valor character varying(255)
);


ALTER TABLE tvlar.t_contato_aud OWNER TO postgres;

--
-- Name: t_contrato; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_contrato (
    id_contrato bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    adicional_financeiro numeric(10,4),
    ajuste_deiof numeric(10,4),
    aliquota numeric(10,4),
    cobranca boolean NOT NULL,
    codigo_barra character varying(255),
    coeficiente_financeiro numeric(10,4),
    data timestamp without time zone,
    dias_de_ajuste numeric(10,4),
    elegivel_vendor boolean NOT NULL,
    iof_do_salto numeric(10,4),
    nsu character varying(255),
    pgto numeric(10,4),
    pgtoiof numeric(10,4),
    pgto_principal numeric(10,4),
    potencia numeric(10,4),
    quantidade_de_parcelas integer NOT NULL,
    quociente numeric(10,4),
    serie numeric(10,4),
    status character varying(255),
    tipo character varying(255),
    valor numeric(10,2),
    valor_com_adicional_financeiro numeric(10,4),
    valoriofadicional numeric(10,4),
    valoriofdiario numeric(10,4),
    valor_parcela numeric(10,2),
    valor_taxa_operacao numeric(10,2),
    valor_total numeric(12,2),
    valor_total_comiof numeric(10,4),
    id_acordo bigint,
    id_consumidor bigint,
    id_estabelecimento bigint,
    id_estorno bigint,
    id_plano_pagamento bigint,
    id_user_conclusao bigint,
    id_user_solicitacao bigint,
    cet_total numeric(16,2),
    cet_mensal numeric(16,2),
    cet_anual numeric(16,2),
    taxa_juros_parcela numeric(16,2),
    dias_carencia bigint,
    ajuste_credito numeric(16,2) DEFAULT 0,
    ajuste_debito numeric(16,2) DEFAULT 0
);


ALTER TABLE tvlar.t_contrato OWNER TO postgres;

--
-- Name: t_contrato_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_contrato_transacao (
    id_contrato bigint NOT NULL,
    id_transacao bigint NOT NULL
);


ALTER TABLE tvlar.t_contrato_transacao OWNER TO postgres;

--
-- Name: t_endereco; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_endereco (
    id_endereco bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    bairro character varying(255),
    cep character varying(255),
    cidade character varying(255),
    codigo_ibge character varying(255),
    complemento character varying(255),
    estado character varying(255),
    numero character varying(255),
    rua character varying(255)
);


ALTER TABLE tvlar.t_endereco OWNER TO postgres;

--
-- Name: t_endereco_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_endereco_aud (
    id_endereco bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    bairro character varying(255),
    cep character varying(255),
    cidade character varying(255),
    codigo_ibge character varying(255),
    complemento character varying(255),
    estado character varying(255),
    numero character varying(255),
    rua character varying(255)
);


ALTER TABLE tvlar.t_endereco_aud OWNER TO postgres;

--
-- Name: t_estabelecimento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_estabelecimento (
    id_estabelecimento bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cnpj character varying(255),
    codigo_externo bigint,
    nome_fantasia character varying(255),
    razao_social character varying(255),
    status character varying(255),
    id_administradora_rede bigint,
    id_endereco bigint
);


ALTER TABLE tvlar.t_estabelecimento OWNER TO postgres;

--
-- Name: t_estabelecimento_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_estabelecimento_aud (
    id_estabelecimento bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    cnpj character varying(255),
    codigo_externo bigint,
    nome_fantasia character varying(255),
    razao_social character varying(255),
    status character varying(255),
    id_administradora_rede bigint,
    id_endereco bigint
);


ALTER TABLE tvlar.t_estabelecimento_aud OWNER TO postgres;

--
-- Name: t_estabelecimento_contato; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_estabelecimento_contato (
    id_estabelecimento bigint NOT NULL,
    id_contato bigint NOT NULL
);


ALTER TABLE tvlar.t_estabelecimento_contato OWNER TO postgres;

--
-- Name: t_estabelecimento_contato_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_estabelecimento_contato_aud (
    rev integer NOT NULL,
    id_estabelecimento bigint NOT NULL,
    id_contato bigint NOT NULL,
    revtype smallint
);


ALTER TABLE tvlar.t_estabelecimento_contato_aud OWNER TO postgres;

--
-- Name: t_estorno; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_estorno (
    id_estorno bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    nsu character varying(255),
    observacao character varying(255),
    origem character varying(255),
    status character varying(255),
    valor numeric(10,4),
    id_contrato bigint,
    id_pagamento bigint,
    id_user_conclusao bigint,
    id_user_solicitacao bigint
);


ALTER TABLE tvlar.t_estorno OWNER TO postgres;

--
-- Name: t_estorno_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_estorno_transacao (
    id_estorno bigint NOT NULL,
    id_transacao bigint NOT NULL
);


ALTER TABLE tvlar.t_estorno_transacao OWNER TO postgres;

--
-- Name: t_execucao_job_agenda_repasse; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_execucao_job_agenda_repasse (
    id_execucao_job_agenda_repasse bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data_referencia date,
    url_s3_arquivo_recebiveis_lojas character varying(255)
);


ALTER TABLE tvlar.t_execucao_job_agenda_repasse OWNER TO postgres;

--
-- Name: t_feriado; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_feriado (
    id_feriado bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data date,
    descricao character varying(255),
    status character varying(255)
);


ALTER TABLE tvlar.t_feriado OWNER TO postgres;

--
-- Name: t_feriado_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_feriado_aud (
    id_feriado bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    data date,
    descricao character varying(255),
    status character varying(255)
);


ALTER TABLE tvlar.t_feriado_aud OWNER TO postgres;

--
-- Name: t_funcionario; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_funcionario (
    id_funcionario bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    cpf character varying(255),
    email character varying(255),
    nome character varying(255),
    status character varying(255),
    id_estabelecimento bigint,
    id_user bigint
);


ALTER TABLE tvlar.t_funcionario OWNER TO postgres;

--
-- Name: t_funcionario_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_funcionario_aud (
    id_funcionario bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    cpf character varying(255),
    email character varying(255),
    nome character varying(255),
    status character varying(255)
);


ALTER TABLE tvlar.t_funcionario_aud OWNER TO postgres;

--
-- Name: t_funcionario_contato; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_funcionario_contato (
    id_funcionario bigint NOT NULL,
    id_contato bigint NOT NULL
);


ALTER TABLE tvlar.t_funcionario_contato OWNER TO postgres;

--
-- Name: t_funcionario_contato_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_funcionario_contato_aud (
    rev integer NOT NULL,
    id_funcionario bigint NOT NULL,
    id_contato bigint NOT NULL,
    revtype smallint
);


ALTER TABLE tvlar.t_funcionario_contato_aud OWNER TO postgres;

--
-- Name: t_horizon; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_horizon (
    id_horizon bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    ambiente character varying(255),
    authorization_token character varying(255),
    client character varying(255),
    content_type character varying(255),
    grant_type character varying(255),
    password character varying(255),
    path_token character varying(255),
    token character varying(255),
    url character varying(255),
    username character varying(255)
);


ALTER TABLE tvlar.t_horizon OWNER TO postgres;

--
-- Name: t_horizon_servico; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_horizon_servico (
    id_horizon_servico bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    content_type character varying(255),
    path_servico character varying(255),
    servico character varying(255),
    id_horizon bigint
);


ALTER TABLE tvlar.t_horizon_servico OWNER TO postgres;

--
-- Name: t_informacao_banco; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_informacao_banco (
    id_informacao_banco bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    agencia bigint,
    banco character varying(255),
    cnpj character varying(255),
    conta bigint,
    digito_agencia bigint,
    razao character varying(255),
    status character varying(255)
);


ALTER TABLE tvlar.t_informacao_banco OWNER TO postgres;

--
-- Name: t_integracao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_integracao (
    id_integracao bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    ambiente character varying(255),
    key_webhook character varying(255),
    servico character varying(255),
    url_base character varying(255)
);


ALTER TABLE tvlar.t_integracao OWNER TO postgres;

--
-- Name: t_integracao_header; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_integracao_header (
    id_integracao_header bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    header character varying(255),
    valor character varying(255),
    id_integracao bigint
);


ALTER TABLE tvlar.t_integracao_header OWNER TO postgres;

--
-- Name: t_lancamento_ajuste; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_lancamento_ajuste (
    id_lancamento_ajuste bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    valor numeric(16,2) NOT NULL,
    id_tipo_lancamento_ajuste bigint NOT NULL,
    id_cdc bigint NOT NULL,
    id_consumidor bigint NOT NULL,
    id_user bigint,
    id_estabelecimento bigint NOT NULL,
    data_lancamento date NOT NULL
);


ALTER TABLE tvlar.t_lancamento_ajuste OWNER TO postgres;

--
-- Name: t_pagamento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_pagamento (
    id_pagamento bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    iof_adicional_atraso numeric(10,2),
    iof_diario_atraso numeric(10,2),
    mora numeric(10,2),
    multa numeric(10,2),
    nsu character varying(255),
    status character varying(255),
    tipo character varying(255),
    valor numeric(10,2),
    valor_taxa_operacao numeric(10,2),
    valor_total numeric(10,2),
    id_boleto bigint,
    id_consumidor bigint,
    id_estabelecimento bigint,
    id_estorno bigint,
    id_user_conclusao bigint,
    id_user_solicitacao bigint,
    ajuste_credito numeric(16,2) DEFAULT 0,
    ajuste_debito numeric(16,2) DEFAULT 0,
    desconto_pagamento_antecipado numeric(10,2) DEFAULT 0
);


ALTER TABLE tvlar.t_pagamento OWNER TO postgres;

--
-- Name: t_pagamento_item; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_pagamento_item (
    id_pagamento_item bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    iof_adicional_atraso numeric(10,2),
    iof_diario_atraso numeric(10,2),
    mora numeric(10,2),
    multa numeric(10,2),
    status character varying(255),
    valor numeric(10,2),
    valor_taxa_operacao numeric(10,2),
    valor_total numeric(10,2),
    id_cdc bigint,
    id_pagamento bigint,
    ajuste_credito numeric(16,2) DEFAULT 0,
    ajuste_debito numeric(16,2) DEFAULT 0,
    desconto_pagamento_antecipado numeric(10,2) DEFAULT 0
);


ALTER TABLE tvlar.t_pagamento_item OWNER TO postgres;

--
-- Name: t_pagamento_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_pagamento_transacao (
    id_pagamento bigint NOT NULL,
    id_transacao bigint NOT NULL
);


ALTER TABLE tvlar.t_pagamento_transacao OWNER TO postgres;

--
-- Name: t_parametro; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_parametro (
    id bigint NOT NULL,
    descricao character varying(255),
    tipo character varying(255),
    valor character varying(255),
    visivel boolean DEFAULT true NOT NULL
);


ALTER TABLE tvlar.t_parametro OWNER TO postgres;

--
-- Name: t_parametro_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_parametro_aud (
    id bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    descricao character varying(255),
    tipo character varying(255),
    valor character varying(255)
);


ALTER TABLE tvlar.t_parametro_aud OWNER TO postgres;

--
-- Name: t_plano_pagamento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_plano_pagamento (
    id_plano_pagamento bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    carencia boolean NOT NULL,
    juros_parcela numeric(19,2),
    limite_maximo_dias_carencia integer,
    parcela_final integer NOT NULL,
    parcela_inicial integer NOT NULL,
    quantidade_dias_entre_parcelas integer NOT NULL,
    quantidade_dias_primeira_parcela integer NOT NULL,
    score_consumidor character varying(255),
    status character varying(255),
    tipo_taxa_operacao character varying(255),
    valor_taxa_operacao numeric(19,2),
    valor_taxa_repasse numeric(19,2),
    id_administradora_rede bigint,
    id_classificador bigint,
    id_produto bigint
);


ALTER TABLE tvlar.t_plano_pagamento OWNER TO postgres;

--
-- Name: t_plano_pagamento_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_plano_pagamento_aud (
    id_plano_pagamento bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    carencia boolean,
    juros_parcela numeric(19,2),
    limite_maximo_dias_carencia integer,
    parcela_final integer,
    parcela_inicial integer,
    quantidade_dias_entre_parcelas integer,
    quantidade_dias_primeira_parcela integer,
    score_consumidor character varying(255),
    status character varying(255),
    tipo_taxa_operacao character varying(255),
    valor_taxa_operacao numeric(19,2),
    valor_taxa_repasse numeric(19,2),
    id_administradora_rede bigint,
    id_classificador bigint,
    id_produto bigint
);


ALTER TABLE tvlar.t_plano_pagamento_aud OWNER TO postgres;

--
-- Name: t_produto; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_produto (
    id_produto bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    codigo_externo character varying(20) NOT NULL,
    descricao character varying(255) NOT NULL,
    id_classificador bigint,
    id_cartao_bin bigint
);


ALTER TABLE tvlar.t_produto OWNER TO postgres;

--
-- Name: t_produto_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_produto_aud (
    id_produto bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    descricao character varying(255),
    id_cartao_bin bigint
);


ALTER TABLE tvlar.t_produto_aud OWNER TO postgres;

--
-- Name: t_profile; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_profile (
    id_profile bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    name character varying(255)
);


ALTER TABLE tvlar.t_profile OWNER TO postgres;

--
-- Name: t_profile_role; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_profile_role (
    id_profile bigint NOT NULL,
    id_role bigint NOT NULL
);


ALTER TABLE tvlar.t_profile_role OWNER TO postgres;

--
-- Name: t_proposta; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_proposta (
    id_proposta bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    data_validade_proposta timestamp without time zone,
    limite numeric(19,2),
    limite_parcelas numeric(19,2),
    score_consumidor character varying(255),
    status character varying(255),
    id_consumidor bigint,
    id_estabelecimento bigint,
    id_produto bigint,
    id_user bigint
);


ALTER TABLE tvlar.t_proposta OWNER TO postgres;

--
-- Name: t_proposta_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_proposta_aud (
    id_proposta bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    data timestamp without time zone,
    data_validade_proposta timestamp without time zone,
    limite numeric(19,2),
    limite_parcelas numeric(19,2),
    score_consumidor character varying(255),
    status character varying(255)
);


ALTER TABLE tvlar.t_proposta_aud OWNER TO postgres;

--
-- Name: t_remessa; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_remessa (
    id_remessa bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data_envio timestamp without time zone,
    status character varying(255),
    taxa_vendor numeric(12,2),
    id_informacao_banco bigint
);


ALTER TABLE tvlar.t_remessa OWNER TO postgres;

--
-- Name: t_remessa_contrato; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_remessa_contrato (
    id_remessa_contrato bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    id_contrato bigint,
    status character varying(255),
    id_remessa bigint
);


ALTER TABLE tvlar.t_remessa_contrato OWNER TO postgres;

--
-- Name: t_remessa_contrato_parcela; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_remessa_contrato_parcela (
    id_remessa_contrato_parcela bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    codigo_ocorrencia_retorno character varying(255),
    id_cdc bigint,
    id_contrato bigint,
    id_estabelecimento bigint,
    numero_parcela integer NOT NULL,
    status character varying(255),
    valor numeric(16,2),
    valor_entregue numeric(16,2),
    valor_total numeric(16,2),
    id_remessa_contrato bigint
);


ALTER TABLE tvlar.t_remessa_contrato_parcela OWNER TO postgres;

--
-- Name: t_remessa_contrato_parcela_historico; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_remessa_contrato_parcela_historico (
    id_remessa_contrato_parcela_historico bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    operacao character varying(255),
    status character varying(255),
    id_remessa_contrato_parcela bigint
);


ALTER TABLE tvlar.t_remessa_contrato_parcela_historico OWNER TO postgres;

--
-- Name: t_retorno_cnab; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_retorno_cnab (
    id_retorno_cnab bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    banco character varying(255),
    data_gravacao date,
    data_upload timestamp without time zone,
    nome character varying(255),
    qtd_total_registros integer,
    valor_total_financiado numeric(19,2)
);


ALTER TABLE tvlar.t_retorno_cnab OWNER TO postgres;

--
-- Name: t_retorno_parcela; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_retorno_parcela (
    id_retorno_parcela bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    codigo_ocorrencia character varying(255),
    status character varying(255),
    uso_da_empresa character varying(255),
    valor numeric(16,2),
    valor_entregue numeric(16,2),
    valor_financiado numeric(16,2),
    id_remessa_contrato_parcela bigint,
    id_retorno_cnab bigint
);


ALTER TABLE tvlar.t_retorno_parcela OWNER TO postgres;

--
-- Name: t_reversao_pagamento; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_reversao_pagamento (
    id_reversao_pagamento bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    iof_adicional_atraso numeric(10,2),
    iof_diario_atraso numeric(10,2),
    mora numeric(10,2),
    multa numeric(10,2),
    nsu character varying(255),
    observacao character varying(255),
    status character varying(255),
    valor numeric(10,2),
    valor_taxa_operacao numeric(10,2),
    valor_total numeric(10,2),
    id_classificacao bigint,
    id_consumidor bigint,
    id_estabelecimento bigint,
    id_user_autorizacao bigint,
    id_user_criacao bigint
);


ALTER TABLE tvlar.t_reversao_pagamento OWNER TO postgres;

--
-- Name: t_reversao_pagamento_item; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_reversao_pagamento_item (
    id_reversao_pagamento_item bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    codigo_barra character varying(255),
    data timestamp without time zone,
    data_vencimento date,
    id_contrato bigint,
    iof_adicional_atraso numeric(10,2),
    iof_diario_atraso numeric(10,2),
    mora numeric(10,2),
    multa numeric(10,2),
    numero_parcela integer NOT NULL,
    status character varying(255),
    valor numeric(10,2),
    valor_taxa_operacao numeric(10,2),
    valor_total numeric(10,2),
    id_cdc bigint,
    id_reversao_pagamento bigint
);


ALTER TABLE tvlar.t_reversao_pagamento_item OWNER TO postgres;

--
-- Name: t_reversao_pagamento_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_reversao_pagamento_transacao (
    id_reversao_pagamento bigint NOT NULL,
    id_transacao bigint NOT NULL
);


ALTER TABLE tvlar.t_reversao_pagamento_transacao OWNER TO postgres;

--
-- Name: t_role; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_role (
    id_role bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    alteravel_backoffice boolean DEFAULT false,
    descricao character varying(255),
    module character varying(255),
    name character varying(255)
);


ALTER TABLE tvlar.t_role OWNER TO postgres;

--
-- Name: t_senior; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_senior (
    id_senior bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    encryption integer,
    end_point character varying(255),
    login character varying(255),
    password character varying(255)
);


ALTER TABLE tvlar.t_senior OWNER TO postgres;

--
-- Name: t_senior_log; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_senior_log (
    id_senior_log bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    evento character varying(255),
    http_method character varying(255),
    request_body text,
    request_timestamp timestamp without time zone,
    response_body text,
    response_timestamp timestamp without time zone,
    result_log character varying(255),
    url character varying(255),
    id_transacao bigint
);


ALTER TABLE tvlar.t_senior_log OWNER TO postgres;

--
-- Name: t_sms; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_sms (
    id_sms bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    area character varying(255),
    codigo character varying(255),
    data_envio timestamp without time zone,
    descricao character varying(255),
    id_destinatario bigint NOT NULL,
    id_mensagem character varying(255),
    situacao character varying(255),
    telefone character varying(255),
    tipo_destinatario character varying(255)
);


ALTER TABLE tvlar.t_sms OWNER TO postgres;

--
-- Name: t_tipo_lancamento_ajuste; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_tipo_lancamento_ajuste (
    id_tipo_lancamento_ajuste bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    descricao character varying(100) NOT NULL,
    tipo_ajuste character varying(1) NOT NULL,
    tipo_usuario character varying(1) NOT NULL,
    status character varying(255)
);


ALTER TABLE tvlar.t_tipo_lancamento_ajuste OWNER TO postgres;

--
-- Name: COLUMN t_tipo_lancamento_ajuste.status; Type: COMMENT; Schema: tvlar; Owner: postgres
--

COMMENT ON COLUMN tvlar.t_tipo_lancamento_ajuste.status IS 'Status: ATIVO, CANCELADO';


--
-- Name: t_tipo_lancamento_ajuste_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_tipo_lancamento_ajuste_aud (
    id_tipo_lancamento_ajuste bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    descricao character varying(100),
    tipo_ajuste character varying(1),
    tipo_usuario character varying(1),
    status character varying(255)
);


ALTER TABLE tvlar.t_tipo_lancamento_ajuste_aud OWNER TO postgres;

--
-- Name: t_tipo_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_tipo_transacao (
    id_tipo_transacao bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    descricao character varying(100) NOT NULL,
    letra character varying(1) NOT NULL
);


ALTER TABLE tvlar.t_tipo_transacao OWNER TO postgres;

--
-- Name: t_tivea_log; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_tivea_log (
    id_tivea_log bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    evento character varying(255),
    http_method character varying(255),
    http_status integer NOT NULL,
    id_transacao bigint,
    request_body text,
    request_timestamp timestamp without time zone,
    response_body text,
    response_timestamp timestamp without time zone,
    url character varying(255)
);


ALTER TABLE tvlar.t_tivea_log OWNER TO postgres;

--
-- Name: t_token_acesso; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_token_acesso (
    id_token_acesso bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    status character varying(255),
    telefone character varying(255),
    token character varying(255),
    id_consumidor bigint
);


ALTER TABLE tvlar.t_token_acesso OWNER TO postgres;

--
-- Name: t_token_acesso_aud; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_token_acesso_aud (
    id_token_acesso bigint NOT NULL,
    rev integer NOT NULL,
    revtype smallint,
    status character varying(255),
    telefone character varying(255),
    token character varying(255)
);


ALTER TABLE tvlar.t_token_acesso_aud OWNER TO postgres;

--
-- Name: t_transacao; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_transacao (
    id_transacao bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    data timestamp without time zone,
    identificador character varying(255),
    ip character varying(255),
    nsu character varying(255),
    operacao character varying(255),
    origem character varying(255),
    terminal_origem character varying(255),
    valor_transacao numeric(10,2),
    id_consumidor bigint,
    id_estabelecimento bigint,
    id_user bigint
);


ALTER TABLE tvlar.t_transacao OWNER TO postgres;

--
-- Name: t_user; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_user (
    id_user bigint NOT NULL,
    insert_date timestamp without time zone,
    update_date timestamp without time zone,
    version bigint,
    access_attempt_count integer NOT NULL,
    access_attempt_date date,
    data_validade_senha date,
    email character varying(255),
    login character varying(255),
    name character varying(255),
    password character varying(255),
    status character varying(255),
    tag character varying(255),
    token_version integer NOT NULL,
    update_password boolean NOT NULL
);


ALTER TABLE tvlar.t_user OWNER TO postgres;

--
-- Name: t_user_profile; Type: TABLE; Schema: tvlar; Owner: postgres
--

CREATE TABLE tvlar.t_user_profile (
    id_user bigint NOT NULL,
    id_profile bigint NOT NULL
);


ALTER TABLE tvlar.t_user_profile OWNER TO postgres;

--
-- Data for Name: t_tenant; Type: TABLE DATA; Schema: api; Owner: postgres
--

COPY api.t_tenant (emissor, tenant) FROM stdin;
muffato	muffato
condor	condor
tvlar	tvlar
dma	dma
muffato	muffato
condor	condor
tvlar	tvlar
dma	dma
muffato	muffato
condor	condor
tvlar	tvlar
dma	dma
muffato	muffato
condor	condor
tvlar	tvlar
dma	dma
\.


--
-- Data for Name: revinfo; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.revinfo (id, "timestamp", id_user, ip) FROM stdin;
1	1718771990052	-99	0:0:0:0:0:0:0:1
2	1718772045071	-99	0:0:0:0:0:0:0:1
3	1718772865658	-99	0:0:0:0:0:0:0:1
4	1718773117847	-99	0:0:0:0:0:0:0:1
5	1718800066016	-99	0:0:0:0:0:0:0:1
6	1718819079886	-99	0:0:0:0:0:0:0:1
7	1718820104018	-99	0:0:0:0:0:0:0:1
8	1718820148697	-99	0:0:0:0:0:0:0:1
9	1718904508208	-99	0:0:0:0:0:0:0:1
10	1718904867348	-99	0:0:0:0:0:0:0:1
11	1719325960187	-99	0:0:0:0:0:0:0:1
12	1719423382389	-99	0:0:0:0:0:0:0:1
13	1719596839785	-99	0:0:0:0:0:0:0:1
14	1719596964301	-99	0:0:0:0:0:0:0:1
15	1719926628462	-99	0:0:0:0:0:0:0:1
16	1719927851525	-99	0:0:0:0:0:0:0:1
17	1719928053702	-99	0:0:0:0:0:0:0:1
18	1719928139155	-99	0:0:0:0:0:0:0:1
19	1719928171878	-99	0:0:0:0:0:0:0:1
20	1719945344364	-99	0:0:0:0:0:0:0:1
21	1719945377445	-99	0:0:0:0:0:0:0:1
22	1719945494824	-99	0:0:0:0:0:0:0:1
23	1719945510282	-99	0:0:0:0:0:0:0:1
24	1719964409442	-99	0:0:0:0:0:0:0:1
25	1719968193446	-99	0:0:0:0:0:0:0:1
26	1719968233034	-99	0:0:0:0:0:0:0:1
27	1719968497282	-99	0:0:0:0:0:0:0:1
28	1719968701253	-99	0:0:0:0:0:0:0:1
29	1719971527460	-99	0:0:0:0:0:0:0:1
30	1719976114528	-99	0:0:0:0:0:0:0:1
31	1719976381062	-99	0:0:0:0:0:0:0:1
32	1719976412562	-99	0:0:0:0:0:0:0:1
33	1719976448504	-99	0:0:0:0:0:0:0:1
34	1719976468517	-99	0:0:0:0:0:0:0:1
35	1719976765579	-99	0:0:0:0:0:0:0:1
36	1719976782303	-99	0:0:0:0:0:0:0:1
37	1719977475400	-99	0:0:0:0:0:0:0:1
38	1719977491594	-99	0:0:0:0:0:0:0:1
39	1719977653067	-99	0:0:0:0:0:0:0:1
40	1719977664687	-99	0:0:0:0:0:0:0:1
41	1719977674750	-99	0:0:0:0:0:0:0:1
42	1719977688001	-99	0:0:0:0:0:0:0:1
43	1719978293211	-99	0:0:0:0:0:0:0:1
44	1719978321450	-99	0:0:0:0:0:0:0:1
45	1719978333117	-99	0:0:0:0:0:0:0:1
46	1719978342792	-99	0:0:0:0:0:0:0:1
47	1719978352049	-99	0:0:0:0:0:0:0:1
48	1719979331424	-99	0:0:0:0:0:0:0:1
49	1719982267740	-99	0:0:0:0:0:0:0:1
50	1719983220920	-99	0:0:0:0:0:0:0:1
51	1719983702307	-99	0:0:0:0:0:0:0:1
52	1719984085466	-99	0:0:0:0:0:0:0:1
53	1720008103322	-99	0:0:0:0:0:0:0:1
54	1720008721705	-99	0:0:0:0:0:0:0:1
55	1720009688105	-99	0:0:0:0:0:0:0:1
56	1720104605156	-99	0:0:0:0:0:0:0:1
57	1720104660510	-99	0:0:0:0:0:0:0:1
58	1720104687907	-99	0:0:0:0:0:0:0:1
59	1720104702776	-99	0:0:0:0:0:0:0:1
60	1720104720894	-99	0:0:0:0:0:0:0:1
61	1720104738303	-99	0:0:0:0:0:0:0:1
62	1720104758206	-99	0:0:0:0:0:0:0:1
63	1720104955569	-99	0:0:0:0:0:0:0:1
64	1720104967438	-99	0:0:0:0:0:0:0:1
65	1720104975375	-99	0:0:0:0:0:0:0:1
66	1720105007422	-99	0:0:0:0:0:0:0:1
67	1720107496133	-99	0:0:0:0:0:0:0:1
68	1720108761996	-99	0:0:0:0:0:0:0:1
69	1720108792559	-99	0:0:0:0:0:0:0:1
70	1720108806984	-99	0:0:0:0:0:0:0:1
71	1720108888628	-99	0:0:0:0:0:0:0:1
72	1720108972255	-99	0:0:0:0:0:0:0:1
73	1720111480801	-99	0:0:0:0:0:0:0:1
74	1720112306825	-99	0:0:0:0:0:0:0:1
75	1720112453875	-99	0:0:0:0:0:0:0:1
76	1720114205641	-99	0:0:0:0:0:0:0:1
77	1720114884402	-99	0:0:0:0:0:0:0:1
78	1720118645298	-99	0:0:0:0:0:0:0:1
79	1720118803097	-99	0:0:0:0:0:0:0:1
80	1720118814584	-99	0:0:0:0:0:0:0:1
81	1720118917266	-99	0:0:0:0:0:0:0:1
82	1720118946742	-99	0:0:0:0:0:0:0:1
83	1720119003219	-99	0:0:0:0:0:0:0:1
84	1720200365398	-99	0:0:0:0:0:0:0:1
85	1720200391198	-99	0:0:0:0:0:0:0:1
86	1720201749890	-99	0:0:0:0:0:0:0:1
87	1720201966687	-99	0:0:0:0:0:0:0:1
88	1720202075295	-99	0:0:0:0:0:0:0:1
89	1720202218404	-99	0:0:0:0:0:0:0:1
90	1720202252219	-99	0:0:0:0:0:0:0:1
98	1720678479687	-99	0:0:0:0:0:0:0:1
99	1721741138531	-99	0:0:0:0:0:0:0:1
100	1721741342752	-99	0:0:0:0:0:0:0:1
101	1721742159999	-99	0:0:0:0:0:0:0:1
102	1721743157566	-99	0:0:0:0:0:0:0:1
103	1721743175682	-99	0:0:0:0:0:0:0:1
104	1721743795665	-99	0:0:0:0:0:0:0:1
105	1721744123447	-99	0:0:0:0:0:0:0:1
106	1721744367290	-99	0:0:0:0:0:0:0:1
107	1721824076497	-99	0:0:0:0:0:0:0:1
108	1721824090045	-99	0:0:0:0:0:0:0:1
109	1721824103869	-99	0:0:0:0:0:0:0:1
110	1721843217898	-99	0:0:0:0:0:0:0:1
111	1721843235962	-99	0:0:0:0:0:0:0:1
112	1721843347985	-99	0:0:0:0:0:0:0:1
113	1721843358024	-99	0:0:0:0:0:0:0:1
114	1723747317285	-99	127.0.0.1
115	1723782144392	-99	0:0:0:0:0:0:0:1
116	1723788281657	-99	127.0.0.1
117	1723788326446	-99	127.0.0.1
118	1723788342847	-99	127.0.0.1
119	1723788371667	-99	127.0.0.1
120	1723788389169	-99	127.0.0.1
121	1723788431409	-99	127.0.0.1
122	1723788458197	-99	127.0.0.1
123	1723788467263	-99	127.0.0.1
124	1723788710695	-99	127.0.0.1
125	1723788727265	-99	127.0.0.1
126	1723788734938	-99	127.0.0.1
127	1723788742950	-99	127.0.0.1
128	1723788906533	-99	127.0.0.1
129	1723788946084	-99	127.0.0.1
130	1723789013863	-99	127.0.0.1
131	1723789074882	-99	127.0.0.1
132	1723789096174	-99	127.0.0.1
133	1723789108130	-99	127.0.0.1
134	1723789125171	-99	127.0.0.1
135	1723789143570	-99	127.0.0.1
136	1723789156812	-99	127.0.0.1
137	1723789246031	-99	127.0.0.1
138	1723789255082	-99	127.0.0.1
139	1723789262694	-99	127.0.0.1
140	1723789271581	-99	127.0.0.1
141	1723789278654	-99	127.0.0.1
142	1723789286002	-99	127.0.0.1
143	1723789583189	-99	127.0.0.1
144	1723789846348	-99	127.0.0.1
145	1723789852013	-99	127.0.0.1
146	1723792140419	-99	127.0.0.1
147	1723792181629	-99	127.0.0.1
148	1723792195935	-99	127.0.0.1
149	1723792205495	-99	127.0.0.1
150	1723792217945	-99	127.0.0.1
151	1723831067328	-99	0:0:0:0:0:0:0:1
152	1723831104127	-99	0:0:0:0:0:0:0:1
153	1723831133866	-99	0:0:0:0:0:0:0:1
154	1723831133892	-99	0:0:0:0:0:0:0:1
155	1723831183876	-99	0:0:0:0:0:0:0:1
156	1723832627705	-99	0:0:0:0:0:0:0:1
157	1724029369935	-99	127.0.0.1
158	1724035636921	-99	127.0.0.1
159	1724035678555	-99	127.0.0.1
160	1724035707449	-99	127.0.0.1
161	1724036188467	-99	127.0.0.1
162	1724042292637	-99	127.0.0.1
163	1724042348628	-99	127.0.0.1
164	1724042364663	-99	127.0.0.1
165	1724063710477	-99	127.0.0.1
166	1724065605924	-99	127.0.0.1
167	1724065662415	-99	127.0.0.1
168	1724070390975	-99	127.0.0.1
169	1724095148541	-99	0:0:0:0:0:0:0:1
170	1724095382808	-99	0:0:0:0:0:0:0:1
171	1724095445881	-99	0:0:0:0:0:0:0:1
172	1724095544995	-99	0:0:0:0:0:0:0:1
173	1724095659454	-99	0:0:0:0:0:0:0:1
174	1724095951214	-99	0:0:0:0:0:0:0:1
175	1724097134581	-99	0:0:0:0:0:0:0:1
176	1724097425432	-99	0:0:0:0:0:0:0:1
177	1724097520898	-99	0:0:0:0:0:0:0:1
178	1724097561253	-99	0:0:0:0:0:0:0:1
179	1724097866894	-99	0:0:0:0:0:0:0:1
180	1724097896002	-99	0:0:0:0:0:0:0:1
181	1724098553356	-99	0:0:0:0:0:0:0:1
182	1724098565843	-99	0:0:0:0:0:0:0:1
183	1724098575435	-99	0:0:0:0:0:0:0:1
184	1724098624817	-99	0:0:0:0:0:0:0:1
185	1724098637926	-99	0:0:0:0:0:0:0:1
186	1724098645750	-99	0:0:0:0:0:0:0:1
187	1724098645771	-99	0:0:0:0:0:0:0:1
188	1724098675096	-99	0:0:0:0:0:0:0:1
189	1724100059927	-99	0:0:0:0:0:0:0:1
190	1724100063278	-99	0:0:0:0:0:0:0:1
191	1724100097099	-99	0:0:0:0:0:0:0:1
192	1724100100063	-99	0:0:0:0:0:0:0:1
193	1724102228139	-99	0:0:0:0:0:0:0:1
194	1724102281189	-99	0:0:0:0:0:0:0:1
195	1724118716290	-99	0:0:0:0:0:0:0:1
196	1724120954863	-99	0:0:0:0:0:0:0:1
197	1724125970828	-99	0:0:0:0:0:0:0:1
198	1724126121426	-99	0:0:0:0:0:0:0:1
199	1724126199635	-99	0:0:0:0:0:0:0:1
200	1724159994038	-99	0:0:0:0:0:0:0:1
201	1724213395777	-99	0:0:0:0:0:0:0:1
202	1724213411460	-99	0:0:0:0:0:0:0:1
203	1724213528713	-99	0:0:0:0:0:0:0:1
204	1724213540392	-99	0:0:0:0:0:0:0:1
205	1724213595939	-99	0:0:0:0:0:0:0:1
206	1724283456169	-99	0:0:0:0:0:0:0:1
207	1724283579200	-99	0:0:0:0:0:0:0:1
208	1724305875050	-99	0:0:0:0:0:0:0:1
209	1724305906887	-99	0:0:0:0:0:0:0:1
210	1724306047353	-99	0:0:0:0:0:0:0:1
211	1724690108878	-99	0:0:0:0:0:0:0:1
212	1724690266956	-99	0:0:0:0:0:0:0:1
213	1724690285063	-99	0:0:0:0:0:0:0:1
214	1724690785997	-99	0:0:0:0:0:0:0:1
215	1724690963962	-99	0:0:0:0:0:0:0:1
216	1724691020746	-99	0:0:0:0:0:0:0:1
217	1724691180175	-99	0:0:0:0:0:0:0:1
218	1724691189304	-99	0:0:0:0:0:0:0:1
219	1724691338890	-99	0:0:0:0:0:0:0:1
220	1724692299879	-99	0:0:0:0:0:0:0:1
221	1724692315167	-99	0:0:0:0:0:0:0:1
222	1724692344615	-99	0:0:0:0:0:0:0:1
223	1724692434080	-99	0:0:0:0:0:0:0:1
224	1724692444996	-99	0:0:0:0:0:0:0:1
225	1724692452269	-99	0:0:0:0:0:0:0:1
226	1724692485340	-99	0:0:0:0:0:0:0:1
227	1724692532028	-99	0:0:0:0:0:0:0:1
228	1724693983175	-99	0:0:0:0:0:0:0:1
229	1724694005849	-99	0:0:0:0:0:0:0:1
230	1724702208917	4	0:0:0:0:0:0:0:1
231	1724702317698	4	0:0:0:0:0:0:0:1
232	1724702816033	4	0:0:0:0:0:0:0:1
233	1724703191115	4	0:0:0:0:0:0:0:1
234	1724703408023	4	0:0:0:0:0:0:0:1
235	1724703415915	4	0:0:0:0:0:0:0:1
236	1724791716634	-99	0:0:0:0:0:0:0:1
237	1724792387340	-99	0:0:0:0:0:0:0:1
238	1724792401734	-99	0:0:0:0:0:0:0:1
239	1724792432914	-99	0:0:0:0:0:0:0:1
240	1725304798747	-99	0:0:0:0:0:0:0:1
241	1725308048123	-99	0:0:0:0:0:0:0:1
242	1725308167967	-99	0:0:0:0:0:0:0:1
243	1725308181607	-99	0:0:0:0:0:0:0:1
244	1725373961965	-99	0:0:0:0:0:0:0:1
245	1725373972151	-99	0:0:0:0:0:0:0:1
246	1725379260495	-99	0:0:0:0:0:0:0:1
247	1725379291413	-99	0:0:0:0:0:0:0:1
248	1725379433516	-99	0:0:0:0:0:0:0:1
249	1725379507850	-99	0:0:0:0:0:0:0:1
250	1725379529495	-99	0:0:0:0:0:0:0:1
251	1725379601195	-99	0:0:0:0:0:0:0:1
252	1725379638042	-99	0:0:0:0:0:0:0:1
253	1725379725020	-99	0:0:0:0:0:0:0:1
254	1725386953607	-99	0:0:0:0:0:0:0:1
255	1725386963525	-99	0:0:0:0:0:0:0:1
256	1725387124006	-99	0:0:0:0:0:0:0:1
257	1725387142714	-99	0:0:0:0:0:0:0:1
258	1725501210201	-99	0:0:0:0:0:0:0:1
259	1725501210246	-99	0:0:0:0:0:0:0:1
260	1725546311595	-99	0:0:0:0:0:0:0:1
261	1725888765126	-99	0:0:0:0:0:0:0:1
262	1725888768657	-99	0:0:0:0:0:0:0:1
263	1725888777582	-99	0:0:0:0:0:0:0:1
264	1725888777606	-99	0:0:0:0:0:0:0:1
265	1725888780839	-99	0:0:0:0:0:0:0:1
266	1725888792909	-99	0:0:0:0:0:0:0:1
267	1725888796268	-99	0:0:0:0:0:0:0:1
268	1726681340590	-99	0:0:0:0:0:0:0:1
269	1726681940014	-99	0:0:0:0:0:0:0:1
270	1726683290043	-99	0:0:0:0:0:0:0:1
271	1726687643174	-99	0:0:0:0:0:0:0:1
272	1726687664813	-99	0:0:0:0:0:0:0:1
273	1726688323028	-99	0:0:0:0:0:0:0:1
274	1726688362228	-99	0:0:0:0:0:0:0:1
275	1726689182330	-99	0:0:0:0:0:0:0:1
276	1726690022225	-99	0:0:0:0:0:0:0:1
277	1726690029999	-99	0:0:0:0:0:0:0:1
278	1726690170261	-99	0:0:0:0:0:0:0:1
279	1726692078407	-99	0:0:0:0:0:0:0:1
280	1726692748727	-99	0:0:0:0:0:0:0:1
281	1726693485858	-99	0:0:0:0:0:0:0:1
282	1726694131870	-99	0:0:0:0:0:0:0:1
283	1726695691512	-99	0:0:0:0:0:0:0:1
284	1726695873021	-99	0:0:0:0:0:0:0:1
285	1726754698367	-99	0:0:0:0:0:0:0:1
286	1726754883920	-99	0:0:0:0:0:0:0:1
287	1726754931291	-99	0:0:0:0:0:0:0:1
288	1726754972047	-99	0:0:0:0:0:0:0:1
289	1726755017269	-99	0:0:0:0:0:0:0:1
290	1726755305920	-99	0:0:0:0:0:0:0:1
291	1726755662575	-99	0:0:0:0:0:0:0:1
292	1726756310228	-99	0:0:0:0:0:0:0:1
293	1726756330606	-99	0:0:0:0:0:0:0:1
294	1726756410507	-99	0:0:0:0:0:0:0:1
295	1726756421806	-99	0:0:0:0:0:0:0:1
296	1726772479760	-99	0:0:0:0:0:0:0:1
297	1726852399585	-99	0:0:0:0:0:0:0:1
298	1726852470850	-99	0:0:0:0:0:0:0:1
299	1726853151290	-99	0:0:0:0:0:0:0:1
300	1726853203755	-99	0:0:0:0:0:0:0:1
301	1726853243672	-99	0:0:0:0:0:0:0:1
302	1726853250942	-99	0:0:0:0:0:0:0:1
303	1726853336555	-99	0:0:0:0:0:0:0:1
304	1726853348975	-99	0:0:0:0:0:0:0:1
305	1726853445361	-99	0:0:0:0:0:0:0:1
306	1726857073724	-99	0:0:0:0:0:0:0:1
307	1726857168461	-99	0:0:0:0:0:0:0:1
308	1726857248196	-99	0:0:0:0:0:0:0:1
309	1726857281669	-99	0:0:0:0:0:0:0:1
310	1726857296249	-99	0:0:0:0:0:0:0:1
311	1726857304216	-99	0:0:0:0:0:0:0:1
312	1726857312850	-99	0:0:0:0:0:0:0:1
313	1726860590855	-99	0:0:0:0:0:0:0:1
314	1726860885289	-99	0:0:0:0:0:0:0:1
315	1726860933130	-99	0:0:0:0:0:0:0:1
316	1726860957166	-99	0:0:0:0:0:0:0:1
317	1726861030086	-99	0:0:0:0:0:0:0:1
318	1726861040715	-99	0:0:0:0:0:0:0:1
319	1726861048818	-99	0:0:0:0:0:0:0:1
320	1726861070637	-99	0:0:0:0:0:0:0:1
321	1726862972672	-99	0:0:0:0:0:0:0:1
322	1726863702821	-99	0:0:0:0:0:0:0:1
323	1726863721321	-99	0:0:0:0:0:0:0:1
324	1726863738337	-99	0:0:0:0:0:0:0:1
325	1726864849262	4	0:0:0:0:0:0:0:1
326	1726864858321	4	0:0:0:0:0:0:0:1
327	1726865010513	4	0:0:0:0:0:0:0:1
328	1727097328943	-99	0:0:0:0:0:0:0:1
329	1727097433664	-99	0:0:0:0:0:0:0:1
330	1727097455355	-99	0:0:0:0:0:0:0:1
331	1727097468961	-99	0:0:0:0:0:0:0:1
332	1727097483721	-99	0:0:0:0:0:0:0:1
333	1727097511335	-99	0:0:0:0:0:0:0:1
334	1727097531355	-99	0:0:0:0:0:0:0:1
335	1727097586354	-99	0:0:0:0:0:0:0:1
336	1727097601777	-99	0:0:0:0:0:0:0:1
337	1727204393480	-99	0:0:0:0:0:0:0:1
338	1727204415361	-99	0:0:0:0:0:0:0:1
339	1727204467685	-99	0:0:0:0:0:0:0:1
340	1727204477240	-99	0:0:0:0:0:0:0:1
341	1727204526718	-99	0:0:0:0:0:0:0:1
342	1727204559264	-99	0:0:0:0:0:0:0:1
343	1727204694524	-99	0:0:0:0:0:0:0:1
344	1727271359536	-99	0:0:0:0:0:0:0:1
345	1727787524514	-99	0:0:0:0:0:0:0:1
346	1727787991323	-99	0:0:0:0:0:0:0:1
347	1727788003355	-99	0:0:0:0:0:0:0:1
348	1727919272549	-99	0:0:0:0:0:0:0:1
349	1728078023356	-99	0:0:0:0:0:0:0:1
350	1728305240528	-99	0:0:0:0:0:0:0:1
351	1728310324092	-99	0:0:0:0:0:0:0:1
352	1728310725241	-99	0:0:0:0:0:0:0:1
353	1728310753228	-99	0:0:0:0:0:0:0:1
354	1728312720073	-99	0:0:0:0:0:0:0:1
355	1728312771270	-99	0:0:0:0:0:0:0:1
356	1728497088843	-99	0:0:0:0:0:0:0:1
357	1728497161007	-99	0:0:0:0:0:0:0:1
358	1728562774065	-99	0:0:0:0:0:0:0:1
359	1728572861432	-99	0:0:0:0:0:0:0:1
360	1728621870679	4	0:0:0:0:0:0:0:1
361	1728621903433	4	0:0:0:0:0:0:0:1
362	1728621980821	4	0:0:0:0:0:0:0:1
363	1728622165728	4	0:0:0:0:0:0:0:1
364	1728677136512	4	0:0:0:0:0:0:0:1
365	1728677152266	4	0:0:0:0:0:0:0:1
366	1728875540552	-99	0:0:0:0:0:0:0:1
367	1728878480727	-99	0:0:0:0:0:0:0:1
368	1728878831988	-99	0:0:0:0:0:0:0:1
369	1728878877914	-99	0:0:0:0:0:0:0:1
371	1728880154897	-99	0:0:0:0:0:0:0:1
372	1728880280189	-99	0:0:0:0:0:0:0:1
373	1728881126941	4	0:0:0:0:0:0:0:1
374	1728881140046	4	0:0:0:0:0:0:0:1
375	1730388338606	-99	127.0.0.1
376	1730788877945	-99	172.19.0.1
377	1730788985083	-99	172.19.0.1
378	1730789034738	-99	172.19.0.1
379	1730789050943	-99	172.19.0.1
380	1730789278434	-99	172.19.0.1
381	1730997361354	-99	172.19.0.1
382	1730997392102	-99	172.19.0.1
383	1730997606217	-99	172.19.0.1
384	1730997624971	-99	172.19.0.1
385	1731012644389	-99	127.0.0.1
386	1731016319008	-99	127.0.0.1
387	1731032416061	-99	127.0.0.1
388	1731032451077	-99	127.0.0.1
389	1731074285659	-99	127.0.0.1
390	1731074416534	-99	127.0.0.1
391	1731093484342	-99	127.0.0.1
392	1731094006935	-99	127.0.0.1
395	1731192731777	-99	172.19.0.1
396	1731206596098	-99	172.19.0.1
397	1731206622762	-99	172.19.0.1
398	1731206656280	-99	172.19.0.1
399	1731227748788	-99	172.19.0.1
400	1731227812923	-99	172.19.0.1
401	1731227861134	-99	172.19.0.1
402	1731227873674	-99	172.19.0.1
403	1731227905425	-99	172.19.0.1
404	1731227946702	-99	172.19.0.1
405	1731227973110	-99	172.19.0.1
406	1731302742148	-99	172.19.0.1
407	1731302754353	-99	172.19.0.1
408	1731302760389	-99	172.19.0.1
409	1731302766874	-99	172.19.0.1
410	1731336081267	-99	172.19.0.1
411	1731336288903	-99	172.19.0.1
412	1731336336496	-99	172.19.0.1
413	1731344607383	-99	172.19.0.1
414	1731519344048	-99	127.0.0.1
415	1731947045645	-99	127.0.0.1
416	1732238019575	-99	172.19.0.1
417	1732238426370	-99	172.19.0.1
418	1732278220478	-99	127.0.0.1
419	1732278348958	-99	127.0.0.1
420	1732279264220	-99	172.19.0.1
421	1732298605284	-99	172.19.0.1
422	1732298739945	-99	172.19.0.1
423	1732298777098	-99	172.19.0.1
425	1734384771996	-99	172.19.0.1
426	1734525428874	-99	172.19.0.1
427	1734525497744	-99	172.19.0.1
\.


--
-- Data for Name: t_acordo; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_acordo (id_acordo, insert_date, update_date, version, codigo_barra, data_emissao, data_operacao, data_vencimento, id_cobransaas, meio_pagamento, nsu, numero_acordo, numero_parcelas, percentual_taxa_operacao, status, tipo, valor_juros, valor_principal, valor_tarifa, valor_total, id_consumidor, id_contrato, ativado) FROM stdin;
1	2024-07-29 16:35:55.135143	2024-07-29 16:35:55.135222	0	1722281722075	2022-06-06	2022-06-06	2022-06-09	1	DINHEIRO	\N	14	3	10.00	PENDENTE	RENEGOCIACAO	17.03	57.03	0.00	57.03	1	9	f
\.


--
-- Data for Name: t_acordo_abatimento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_acordo_abatimento (id_acordo_abatimento, insert_date, update_date, version, cobransaas_id, cobransaas_origem, data_hora_integracao, integracao, mensagem_integracao, percentual, tipo, valor_adicionado, valor_atual, valor_desconto, valor_juros, valor_mora, valor_multa, valor_outros, valor_permanencia, valor_principal, valor_tarifa, valor_total, valor_tributo, id_acordo_pagamento, id_cdc) FROM stdin;
\.


--
-- Data for Name: t_acordo_origem; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_acordo_origem (id_acordo_origem, insert_date, update_date, version, cobransaas_contrato_id, cobransaas_id, cobransaas_parcela_id, contrato, data_vencimento, desconto_juros, desconto_mora, desconto_multa, desconto_outros, desconto_permanencia, desconto_principal, desconto_total, dias_atraso, numero_contrato, numero_parcela, parcela, saldo_adicionado, saldo_atual, saldo_desconto, saldo_juros, saldo_mora, saldo_multa, saldo_outros, saldo_permanencia, saldo_principal, saldo_tarifa, saldo_total, situacao, valor_adicionado, valor_atual, valor_desconto, valor_juros, valor_mora, valor_multa, valor_outros, valor_permanencia, valor_principal, valor_tarifa, valor_total, id_acordo, id_cdc) FROM stdin;
1	2024-07-29 16:35:55.19015	2024-07-29 16:35:55.190221	0	7	7	64	Contrato	2022-03-03	0.00	0.00	0.00	0.00	0.00	0.00	0.00	95	7	1	64	0.00	57.03	0.00	0.00	16.23	0.80	0.00	57.03	57.03	0.00	57.03	\N	0.00	57.03	0.00	0.00	16.23	0.80	0.00	0.00	40.00	10.00	57.03	1	64
\.


--
-- Data for Name: t_acordo_pagamento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_acordo_pagamento (id_acordo_pagamento, insert_date, update_date, version, cobransaas_id, data_hora_inclusao, data_liquidacao, data_operacao, data_processamento, forma_liquidacao, integracao, situacao, valor_desconto, valor_distorcao, valor_encargos, valor_recebido, valor_sobra, id_acordo) FROM stdin;
\.


--
-- Data for Name: t_acordo_parcela; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_acordo_parcela (id_acordo_parcela, insert_date, update_date, version, data_vencimento, numero_parcela, saldo_atual, saldo_principal, saldo_total, situacao, valor_adicionado, valor_base_tributo, valor_juros, valor_mora, valor_multa, valor_permanencia, valor_principal, valor_tarifa, valor_total, valor_tributo, id_acordo, id_cdc) FROM stdin;
1	2024-07-29 16:35:55.243391	2024-07-29 16:35:55.243467	0	2022-06-09	0	57.03	57.03	57.03	\N	0.00	0.00	17.03	16.23	0.80	0.00	57.03	0.00	57.03	0.00	1	\N
\.


--
-- Data for Name: t_acordo_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_acordo_transacao (id_acordo, id_transacao) FROM stdin;
1	19
\.


--
-- Data for Name: t_administradora; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_administradora (id_administradora, insert_date, update_date, version, cnpj, codigo_carteira_boleto_simples, nome_fantasia, observacao, razao_social, status, id_endereco) FROM stdin;
1	2024-06-19 01:38:11.680713	2024-06-19 01:38:11.680713	0	004561957000168	5822	IMPORTADORA TV LAR LTDA - MATRZ		MATRZ	ATIVO	1
\.


--
-- Data for Name: t_administradora_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_administradora_aud (id_administradora, rev, revtype, cnpj, codigo_carteira_boleto_simples, nome_fantasia, observacao, razao_social, status) FROM stdin;
\.


--
-- Data for Name: t_administradora_contato; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_administradora_contato (id_administradora, id_contato) FROM stdin;
\.


--
-- Data for Name: t_administradora_contato_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_administradora_contato_aud (rev, id_administradora, id_contato, revtype) FROM stdin;
\.


--
-- Data for Name: t_administradora_rede; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_administradora_rede (id_administradora_rede, insert_date, update_date, version, nome, status, id_administradora) FROM stdin;
1	2024-06-19 01:38:11.680713	2024-06-19 01:38:11.680713	0	Perfil Padrão	ATIVO	1
2	2024-08-26 17:06:56.027975	2024-08-26 17:06:56.027993	0	REDE TESTE	ATIVO	1
\.


--
-- Data for Name: t_administradora_rede_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_administradora_rede_aud (id_administradora_rede, rev, revtype, nome, status, id_administradora) FROM stdin;
2	232	0	REDE TESTE	ATIVO	1
\.


--
-- Data for Name: t_antecipacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_antecipacao (id_antecipacao, insert_date, update_date, version, codigo_barra, valor, valor_antecipacao, desconto, data_operacao, data_vencimento, status, id_consumidor, id_contrato, id_contrato_origem) FROM stdin;
1	2024-10-30 09:24:08.505526	2024-10-30 09:24:08.505542	0	1730291051535	236.86	216.19	20.67	2024-10-30	2024-10-30	PENDENTE_ANTECIPACAO	1	47	46
\.


--
-- Data for Name: t_antecipacao_item; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_antecipacao_item (id_antecipacao_item, insert_date, update_date, version, data_emissao, data_vencimento, numero_parcela, codigo_barra, valor, valor_antecipacao, valor_taxa_operacao, desconto, id_antecipacao, id_cdc) FROM stdin;
1	2024-10-30 09:24:08.508748	2024-10-30 09:24:08.508761	0	2024-10-30	2024-11-16	1	1729209292303-1	110.43	101.93	8.00	8.50	1	228
2	2024-10-30 09:24:08.511021	2024-10-30 09:24:08.511031	0	2024-10-30	2024-12-16	2	1729209292303-2	110.43	98.26	8.00	12.17	1	229
\.


--
-- Data for Name: t_boleto; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_boleto (id_boleto, insert_date, update_date, version, aceite, agencia_digito, agencia_numero, anotacoes, beneficiario_codigo, beneficiario_cpf_cnpj, beneficiario_endereco, beneficiario_nome, carteira_chave, codigo_externo, conta_codigo, conta_digito, conta_numero, data_documento, data_hora_atualizacao, data_hora_criacao, data_hora_registro, data_pagamento, data_vencimento, descricao, dias_para_baixa, dias_para_desconto, dias_para_juros, dias_para_multa, dias_para_segundo_desconto, dias_para_terceiro_desconto, instrucoes, linha_digitavel, meta, nosso_numero, nosso_numerodv, nosso_numerodvformatado, numero_documento, percentual_desconto, percentual_juros, percentual_multa, percentual_segundo_desconto, percentual_terceiro_desconto, status, tipo_desconto, tipo_documento, tipo_juros, tipo_multa, valor, valor_desconto, valor_juros, valor_multa, valor_segundo_desconto, valor_terceiro_desconto, id_boleto_formato, id_consumidor) FROM stdin;
1	2024-07-16 23:54:07.888685	2024-07-25 13:41:26.026257	3	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	657277	4615	2	9909880	\N	2024-07-16 23:54:07	2024-07-16 23:54:07	\N	\N	2024-07-23	Boleto para quitacao do carnê 1720658487704-1	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 40000.000204 6 97860000008205	\N	140	02000000001403	02/00000000140-3	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	82.05	\N	\N	\N	\N	\N	1	1
2	2024-07-25 13:47:04.695335	2024-07-26 15:26:20.778325	1	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	658001	4615	2	9909880	\N	2024-07-25 13:47:04	2024-07-25 13:47:04	\N	\N	2024-08-01	Boleto para quitacao do carnê 1720658487704-1	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 41000.000202 2 97950000016400	\N	141	02000000001411	02/00000000141-1	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	164.00	\N	\N	\N	\N	\N	2	1
3	2024-08-03 02:22:53.453466	2024-08-03 02:46:26.505969	1	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	659580	4615	2	9909880	\N	2024-08-03 02:22:53	2024-08-03 02:22:53	\N	\N	2024-08-12	Boleto para quitacao do carnê 1720658487704-8	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 44000.000206 6 98060000008205	\N	144	02000000001446	02/00000000144-6	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	82.05	\N	\N	\N	\N	\N	3	1
4	2024-08-03 02:49:42.482982	2024-08-03 03:03:04.800559	1	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	659581	4615	2	9909880	\N	2024-08-03 02:49:42	2024-08-03 02:49:42	\N	\N	2024-08-12	Boleto para quitacao do carnê 1720658487704-8	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 45000.000203 1 98060000010205	\N	145	02000000001454	02/00000000145-4	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	102.05	\N	\N	\N	\N	\N	4	1
5	2024-08-03 03:04:12.315001	2024-08-03 03:04:12.315006	0	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	659582	4615	2	9909880	\N	2024-08-03 03:04:12	2024-08-03 03:04:12	\N	\N	2024-08-05	Boleto para quitacao do carnê 1720658487704-8	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 46000.000201 9 97990000012466	\N	146	02000000001462	02/00000000146-2	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	124.66	\N	\N	\N	\N	\N	5	1
6	2024-08-06 12:59:31.819084	2024-08-06 13:24:24.927343	1	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	659852	4615	2	9909880	\N	2024-08-06 12:59:31	2024-08-06 12:59:31	\N	\N	2024-08-06	Boleto para quitacao do carnê 1720658487704-8	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 59000.000204 1 98000000012571	\N	159	02000000001594	02/00000000159-4	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	125.71	\N	\N	\N	\N	\N	6	1
7	2024-08-06 13:27:22.099984	2024-08-09 17:35:37.150089	1	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	659855	4615	2	9909880	\N	2024-08-06 13:27:21	2024-08-06 13:27:21	\N	\N	2024-08-06	Boleto para quitacao do carnê 1720658487704-8	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 60000.000202 1 98000000013071	\N	160	02000000001608	02/00000000160-8	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	130.71	\N	\N	\N	\N	\N	7	1
8	2024-08-25 04:34:39.658079	2024-08-25 21:30:17.815218	1	N	2	7887	\N	0001-2 / 0000002-2	06.148.054/0001-85	Avenida Senador Ruy Carneiro, 1300, Centro, JOÃO PESSOA, PB, 58032100	São João Ltda	bradesco-bs-02	661172	4615	2	9909880	\N	2024-08-25 04:34:39	2024-08-25 04:34:39	\N	\N	2024-08-26	Boleto para quitacao do carnê 1720658487704-8	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000016 65000.000201 1 98200000011037	\N	165	02000000001659	02/00000000165-9	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	110.37	\N	\N	\N	\N	\N	8	1
9	2024-12-16 18:33:05.669239	2024-12-16 18:34:15.578895	1	N	1	9000	\N	0001-1 / 0000002-3	76.549.708/0001-68	LEON NICOLAS, 67, TERREO, PINHEIRINHO, CURITIBA, PR, 81150050	ZONTA ADMINISTRADORA DE CARTOES LTDA	bradesco-bs-02	678754	5822	3	9889933	\N	2024-12-16 18:33:05	2024-12-16 18:33:05	\N	\N	2024-12-16	Boleto para quitacao do carnê 1734377109680-1	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000008 35000.000204 6 99320000018649	\N	35	02000000000350	02/00000000035-0	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	186.49	\N	\N	\N	\N	\N	9	1
10	2024-12-17 09:28:12.260796	2024-12-17 09:37:36.744344	1	N	1	9000	\N	0001-1 / 0000002-3	76.549.708/0001-68	LEON NICOLAS, 67, TERREO, PINHEIRINHO, CURITIBA, PR, 81150050	ZONTA ADMINISTRADORA DE CARTOES LTDA	bradesco-bs-02	678784	5822	3	9889933	\N	2024-12-17 09:28:12	2024-12-17 09:28:12	\N	\N	2024-12-17	Boleto para quitacao do carnê 1734438235797-1	1	\N	\N	\N	\N	\N	SR(a) CAIXA: NÃO RECEBER APÓS O VENCIMENTO.	23790.00108 20000.000008 36000.000202 8 99330000006462	\N	36	02000000000369	02/00000000036-9	\N	\N	\N	\N	\N	\N	CANCELADO	INEXISTENTE	02	INEXISTENTE	INEXISTENTE	64.62	\N	\N	\N	\N	\N	10	1
\.


--
-- Data for Name: t_boleto_formato; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_boleto_formato (id_boleto_formato, insert_date, update_date, version, barcode, boleto_hibrido, boleto_pix, envelope, letter, line, padrao, pdf, png, recibo, id_boleto) FROM stdin;
1	2024-07-16 23:54:07.874478	2024-07-16 23:54:07.90854	1	https://sandbox.bole.to/3/rjnydm/barcode	https://sandbox.bole.to/3/rjnydm/boleto_hibrido	https://sandbox.bole.to/3/rjnydm/boleto_pix	https://sandbox.bole.to/3/rjnydm/envelope	https://sandbox.bole.to/3/rjnydm/letter	https://sandbox.bole.to/3/rjnydm/line	https://sandbox.bole.to/3/rjnydm	https://sandbox.bole.to/3/rjnydm.pdf	https://sandbox.bole.to/3/rjnydm.png	https://sandbox.bole.to/3/rjnydm/recibo	1
2	2024-07-25 13:47:04.692733	2024-07-25 13:47:04.705621	1	https://sandbox.bole.to/3/onxozg/barcode	https://sandbox.bole.to/3/onxozg/boleto_hibrido	https://sandbox.bole.to/3/onxozg/boleto_pix	https://sandbox.bole.to/3/onxozg/envelope	https://sandbox.bole.to/3/onxozg/letter	https://sandbox.bole.to/3/onxozg/line	https://sandbox.bole.to/3/onxozg	https://sandbox.bole.to/3/onxozg.pdf	https://sandbox.bole.to/3/onxozg.png	https://sandbox.bole.to/3/onxozg/recibo	2
3	2024-08-03 02:22:53.447957	2024-08-03 02:22:53.459356	1	https://sandbox.bole.to/3/lxjkke/barcode	https://sandbox.bole.to/3/lxjkke/boleto_hibrido	https://sandbox.bole.to/3/lxjkke/boleto_pix	https://sandbox.bole.to/3/lxjkke/envelope	https://sandbox.bole.to/3/lxjkke/letter	https://sandbox.bole.to/3/lxjkke/line	https://sandbox.bole.to/3/lxjkke	https://sandbox.bole.to/3/lxjkke.pdf	https://sandbox.bole.to/3/lxjkke.png	https://sandbox.bole.to/3/lxjkke/recibo	3
4	2024-08-03 02:49:42.481701	2024-08-03 02:49:42.4879	1	https://sandbox.bole.to/3/joyzzy/barcode	https://sandbox.bole.to/3/joyzzy/boleto_hibrido	https://sandbox.bole.to/3/joyzzy/boleto_pix	https://sandbox.bole.to/3/joyzzy/envelope	https://sandbox.bole.to/3/joyzzy/letter	https://sandbox.bole.to/3/joyzzy/line	https://sandbox.bole.to/3/joyzzy	https://sandbox.bole.to/3/joyzzy.pdf	https://sandbox.bole.to/3/joyzzy.png	https://sandbox.bole.to/3/joyzzy/recibo	4
5	2024-08-03 03:04:12.314116	2024-08-03 03:04:12.319816	1	https://sandbox.bole.to/3/gbzqqg/barcode	https://sandbox.bole.to/3/gbzqqg/boleto_hibrido	https://sandbox.bole.to/3/gbzqqg/boleto_pix	https://sandbox.bole.to/3/gbzqqg/envelope	https://sandbox.bole.to/3/gbzqqg/letter	https://sandbox.bole.to/3/gbzqqg/line	https://sandbox.bole.to/3/gbzqqg	https://sandbox.bole.to/3/gbzqqg.pdf	https://sandbox.bole.to/3/gbzqqg.png	https://sandbox.bole.to/3/gbzqqg/recibo	5
6	2024-08-06 12:59:31.811802	2024-08-06 12:59:31.832826	1	https://sandbox.bole.to/3/onowbx/barcode	https://sandbox.bole.to/3/onowbx/boleto_hibrido	https://sandbox.bole.to/3/onowbx/boleto_pix	https://sandbox.bole.to/3/onowbx/envelope	https://sandbox.bole.to/3/onowbx/letter	https://sandbox.bole.to/3/onowbx/line	https://sandbox.bole.to/3/onowbx	https://sandbox.bole.to/3/onowbx.pdf	https://sandbox.bole.to/3/onowbx.png	https://sandbox.bole.to/3/onowbx/recibo	6
7	2024-08-06 13:27:22.095965	2024-08-06 13:27:22.112949	1	https://sandbox.bole.to/3/wzrqkj/barcode	https://sandbox.bole.to/3/wzrqkj/boleto_hibrido	https://sandbox.bole.to/3/wzrqkj/boleto_pix	https://sandbox.bole.to/3/wzrqkj/envelope	https://sandbox.bole.to/3/wzrqkj/letter	https://sandbox.bole.to/3/wzrqkj/line	https://sandbox.bole.to/3/wzrqkj	https://sandbox.bole.to/3/wzrqkj.pdf	https://sandbox.bole.to/3/wzrqkj.png	https://sandbox.bole.to/3/wzrqkj/recibo	7
8	2024-08-25 04:34:39.6334	2024-08-25 04:34:39.712285	1	https://sandbox.bole.to/3/wzrvxe/barcode	https://sandbox.bole.to/3/wzrvxe/boleto_hibrido	https://sandbox.bole.to/3/wzrvxe/boleto_pix	https://sandbox.bole.to/3/wzrvxe/envelope	https://sandbox.bole.to/3/wzrvxe/letter	https://sandbox.bole.to/3/wzrvxe/line	https://sandbox.bole.to/3/wzrvxe	https://sandbox.bole.to/3/wzrvxe.pdf	https://sandbox.bole.to/3/wzrvxe.png	https://sandbox.bole.to/3/wzrvxe/recibo	8
9	2024-12-16 18:33:05.667154	2024-12-16 18:33:05.67649	1	https://sandbox.bole.to/3/xobbgn/barcode	https://sandbox.bole.to/3/xobbgn/boleto_hibrido	https://sandbox.bole.to/3/xobbgn/boleto_pix	https://sandbox.bole.to/3/xobbgn/envelope	https://sandbox.bole.to/3/xobbgn/letter	https://sandbox.bole.to/3/xobbgn/line	https://sandbox.bole.to/3/xobbgn	https://sandbox.bole.to/3/xobbgn.pdf	https://sandbox.bole.to/3/xobbgn.png	https://sandbox.bole.to/3/xobbgn/recibo	9
10	2024-12-17 09:28:12.259617	2024-12-17 09:28:12.269867	1	https://sandbox.bole.to/3/kgoobg/barcode	https://sandbox.bole.to/3/kgoobg/boleto_hibrido	https://sandbox.bole.to/3/kgoobg/boleto_pix	https://sandbox.bole.to/3/kgoobg/envelope	https://sandbox.bole.to/3/kgoobg/letter	https://sandbox.bole.to/3/kgoobg/line	https://sandbox.bole.to/3/kgoobg	https://sandbox.bole.to/3/kgoobg.pdf	https://sandbox.bole.to/3/kgoobg.png	https://sandbox.bole.to/3/kgoobg/recibo	10
\.


--
-- Data for Name: t_boleto_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_boleto_transacao (id_boleto, id_transacao) FROM stdin;
1	13
1	14
1	15
1	16
2	17
2	18
3	20
3	21
4	22
4	23
5	24
6	27
6	30
7	31
7	33
8	34
8	38
9	219
9	222
10	225
10	228
\.


--
-- Data for Name: t_broker_sms; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_broker_sms (id_broker_sms, insert_date, update_date, version, ambiente, authorization_header_token, content_type_header, content_type_header_token, grant_type_header_token, password_token, token, url, url_token, username_token) FROM stdin;
\.


--
-- Data for Name: t_cartao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cartao (id_cartao, insert_date, update_date, version, numero_cartao, nome_titular, data_validade, tipo_cartao, numero_truncado, id_consumidor, status) FROM stdin;
57	2024-10-14 01:01:20.724829	2024-10-14 01:01:20.724843	0	5378909106087195	BRENNO A F D MECO	2029-10-31	VIRTUAL	5378XXXXXXXX7195	2	CANCELADO
58	2024-10-14 01:07:11.985936	2024-10-14 01:07:11.98596	0	5378909084070700	BRENNO A F D MECO	2029-10-31	VIRTUAL	5378XXXXXXXX0700	2	CANCELADO
59	2024-10-14 01:07:57.913378	2024-10-14 01:07:57.913387	0	5378901215399629	BRENNO A F D MECO	2027-10-31	VIRTUAL	5378XXXXXXXX9629	2	CANCELADO
56	2024-10-14 00:12:20.541151	2024-10-14 00:12:20.54117	0	3749281587095106	PETER S V D COSTA	2029-10-31	VIRTUAL	3749XXXXXXXX5106	1	CANCELADO
62	2024-10-14 01:31:20.187722	2024-10-14 01:31:20.187746	0	3749281548514302	PETER S V D COSTA	2027-10-31	VIRTUAL	3749XXXXXXXX4302	1	CANCELADO
63	2024-10-31 12:25:38.597362	2024-10-31 12:25:38.597378	0	3749281514111091	PETER S V D COSTA	2027-10-31	VIRTUAL	3749XXXXXXXX1091	1	CANCELADO
64	2024-11-07 17:50:44.372527	2024-11-07 17:50:44.372554	0	3749281573092463	APOLLO B P MIDAS	2027-11-30	VIRTUAL	3749XXXXXXXX2463	1	CANCELADO
65	2024-11-07 18:51:58.997503	2024-11-07 18:51:58.997529	0	3749281550809590	APOLLO B P MIDAS	2027-11-30	VIRTUAL	3749XXXXXXXX9590	1	CANCELADO
66	2024-11-07 23:20:16.04631	2024-11-07 23:20:16.046336	0	3749281542397019	APOLLO B P MIDAS	2027-11-30	VIRTUAL	3749XXXXXXXX7019	1	CANCELADO
68	2024-11-08 10:58:05.64415	2024-11-08 10:58:05.644177	0	3749281515332381	MIDAS B P APOLLO	2027-11-30	VIRTUAL	3749XXXXXXXX2381	3	CANCELADO
69	2024-11-08 11:00:16.533605	2024-11-08 11:00:16.533614	0	3749281503979755	MIDAS B P APOLLO	2027-11-30	VIRTUAL	3749XXXXXXXX9755	3	CANCELADO
70	2024-11-08 16:18:04.329323	2024-11-08 16:18:04.329351	0	3749281510858042	MIDAS B P APOLLO	2027-11-30	VIRTUAL	3749XXXXXXXX8042	3	CANCELADO
71	2024-11-08 16:26:46.920926	2024-11-08 16:26:46.920962	0	3749281518985953	MIDAS B P APOLLO	2027-11-30	VIRTUAL	3749XXXXXXXX5953	3	CANCELADO
61	2024-10-14 01:29:14.888328	2024-11-26 12:00:47.426719	5	5378909278480061	BRENNO A F D M II	2027-10-31	VIRTUAL	5378XXXXXXXX0061	2	BLOQUEADO
72	2024-11-18 13:24:05.638004	2024-11-26 14:50:27.928059	9	3749281504820941	MIDAS B P APOLLO	2029-11-30	VIRTUAL	3749XXXXXXXX0941	3	CANCELADO
67	2024-11-07 23:20:51.074959	2024-12-13 09:59:15.747589	1	3749281516260763	APOLLO B P MIDAS	2027-11-30	VIRTUAL	3749XXXXXXXX0763	1	CANCELADO
73	2024-12-13 09:59:15.825013	2024-12-13 09:59:15.825024	0	VbypY5Bqs6EvNIvQRUmlJdzzbJ2vjusfkNFOHWLX1iPqZKibVBuCcdJ5W3U=	APOLLO B P MIDAS	C17bhAVmwzLNDzFneGg5mjmJviRmySJzwdXRY6DpzED/irpDB7w=	VIRTUAL	3749XXXXXXXX1643	1	ATIVO
\.


--
-- Data for Name: t_cartao_bin; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cartao_bin (id_cartao_bin, version, insert_date, update_date, numero_bin, descricao) FROM stdin;
1	0	2024-09-27 06:18:46.000851+00	2024-09-27 06:18:46.000896+00	462892	Bin Padrão
2	0	2024-09-27 06:26:06.36076+00	2024-09-27 06:26:06.360765+00	5273946	Bin Padrão 2
3	0	2024-09-27 06:39:20.126028+00	2024-09-27 06:39:20.12604+00	37492815	Bin Padrão 3
\.


--
-- Data for Name: t_cartao_historico; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cartao_historico (id_cartao_historico, insert_date, update_date, version, data, id_cartao, status, id_user, id_cartao_tipo_bloqueio, descricao) FROM stdin;
1	2024-11-22 15:03:25.25465	2024-11-22 15:03:25.254668	0	2024-11-22 15:03:25.239991	72	CANCELADO	-99	\N	Descrição padrão
2	2024-11-22 15:05:39.942127	2024-11-22 15:05:39.94214	0	2024-11-22 15:05:39.941004	61	BLOQUEADO	-99	\N	Descrição padrão
3	2024-11-22 15:06:17.094354	2024-11-22 15:06:17.09436	0	2024-11-22 15:06:17.093202	61	CANCELADO	-99	\N	Descrição padrão
5	2024-11-22 16:10:46.354342	2024-11-22 16:10:46.354383	0	2024-11-22 16:10:46.331851	61	BLOQUEADO	-99	\N	Descrição padrão
6	2024-11-22 17:07:54.718815	2024-11-22 17:07:54.718877	0	2024-11-22 17:07:54.693744	61	BLOQUEADO	-99	\N	Descrição padrão
7	2024-11-22 17:10:48.807038	2024-11-22 17:10:48.807059	0	2024-11-22 17:10:48.793391	61	BLOQUEADO	-99	\N	Descrição padrão
8	2024-11-26 12:00:47.41118	2024-11-26 12:00:47.411198	0	2024-11-26 12:00:47.391668	61	CANCELADO	-99	\N	Descrição padrão
9	2024-11-26 12:02:21.565251	2024-11-26 12:02:21.565262	0	2024-11-26 12:02:21.550404	72	BLOQUEADO	-99	\N	Descrição padrão
10	2024-11-26 12:03:49.276608	2024-11-26 12:03:49.276649	0	2024-11-26 12:03:49.274882	72	CANCELADO	-99	\N	Descrição padrão
11	2024-11-26 14:50:27.913749	2024-11-26 14:50:27.913764	0	2024-11-26 14:50:27.896698	72	CANCELADO	-99	\N	Descrição padrão
12	2024-12-13 09:59:15.729474	2024-12-13 09:59:15.729502	0	2024-12-13 09:59:15.684904	67	CANCELADO	-99	-1	Solicitação de troca
13	2024-12-13 09:59:15.82283	2024-12-13 09:59:15.827073	1	2024-12-13 09:59:15.818881	73	ATIVO	-99	\N	Cartão cadastrado
\.


--
-- Data for Name: t_cartao_tipo_bloqueio; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cartao_tipo_bloqueio (id_cartao_tipo_bloqueio, insert_date, update_date, version, descricao, cancela_cartao, permite_desbloqueio) FROM stdin;
20	2024-09-20 15:31:13.722913	2024-09-20 15:31:13.722922	0	Teste front 1	t	f
21	2024-09-20 15:32:48.460451	2024-09-20 15:32:48.460457	0	Teste front 2	f	t
22	2024-09-20 15:34:08.194397	2024-09-20 15:34:08.194415	0	Teste front 3	f	f
19	2024-09-19 16:01:19.742873	2024-09-20 15:34:41.66809	1	Teste 7	t	f
17	2024-09-19 11:15:05.919231	2024-09-20 15:35:12.848087	3	Teste 5	t	f
23	2024-09-20 16:29:50.85329	2024-09-20 16:29:50.853304	0	Teste front 4	f	f
16	2024-09-19 11:10:17.268688	2024-09-20 16:35:57.164588	5	Teste 4	t	f
14	2024-09-19 11:08:03.919418	2024-09-20 16:37:28.816197	4	Teste 2	f	f
15	2024-09-19 11:09:32.045705	2024-09-20 16:37:50.63595	1	Teste 3	f	t
18	2024-09-19 11:21:02.561396	2024-09-20 17:09:32.670951	4	Teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 test	f	t
24	2024-09-20 17:43:30.51061	2024-09-20 17:43:30.51063	0	Teste front 5	f	t
13	2024-09-19 11:04:58.354116	2024-09-23 10:18:51.354609	19	Teste 1	f	t
26	2024-09-23 10:19:46.354107	2024-09-23 10:19:46.354114	0	Teste front 7	f	f
28	2024-09-24 15:59:53.469402	2024-09-24 15:59:53.469445	0	Teste qa	t	f
27	2024-09-23 10:20:01.775148	2024-09-24 16:01:17.23903	3	Teste qa2	f	t
25	2024-09-23 10:15:28.925244	2024-09-24 16:04:54.523448	3	Teste qa2 Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2	t	f
29	2024-10-01 09:58:44.501312	2024-10-01 09:58:44.501356	0	teste qa2	t	f
30	2024-10-01 10:06:31.309216	2024-10-01 10:06:43.35351	1	Teste qa2 2	f	f
-1	2024-12-13 12:50:50.707851	2024-12-13 12:50:50.707851	1	Solicitação de troca	t	f
\.


--
-- Data for Name: t_cartao_tipo_bloqueio_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cartao_tipo_bloqueio_aud (id_cartao_tipo_bloqueio, rev, revtype, descricao, cancela_cartao, permite_desbloqueio) FROM stdin;
13	285	0	teste 1	f	t
14	286	0	teste 2	f	t
13	287	1	teste 1	f	f
15	288	0	teste 3	f	f
16	289	0	teste 4	t	f
17	290	0	teste 5	t	f
18	291	0	teste 7 teste 1  teste 1 teste 1 teste 1  teste 1 teste 1 teste 1  teste 1 teste 1 teste 1  teste 1 	f	t
13	292	1	teste 2.1	f	f
13	293	1	teste 1	f	f
13	294	1	teste 1	f	t
13	295	1	teste 1.1	f	f
19	296	0	teste 8	t	f
13	297	1	teste 1.1	f	t
13	298	1	teste 1	f	f
16	299	1	teste 4.1	t	f
16	300	1	teste 4	t	f
14	301	1	teste 2	f	f
14	302	1	teste 2	f	t
18	303	1	teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6	f	t
18	304	1	teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6	f	t
18	305	1	teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 test	f	t
20	306	0	Teste front 1	t	f
21	307	0	Teste front 2	f	t
22	308	0	Teste front 3	f	f
19	309	1	Teste 7	t	f
17	310	1	Teste 6	t	f
17	311	1	Teste 4	t	f
17	312	1	Teste 5	t	f
23	313	0	Teste front 4	f	f
16	314	1	teste 4.1	t	f
16	315	1	Teste 4.1	t	f
16	316	1	Teste 4	t	f
14	317	1	Teste 2	f	t
13	318	1	Teste 1	f	t
14	319	1	Teste 2	f	f
15	320	1	Teste 3	f	t
18	321	1	Teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 test	f	t
13	322	1	Teste 1.1	f	t
13	323	1	Teste 1	f	f
13	324	1	Teste 1	f	t
13	325	1	Teste 1.	f	t
13	326	1	Teste 1	f	t
24	327	0	Teste front 5	f	t
25	328	0	Teste front 6	t	f
13	329	1	Teste 1	f	f
13	330	1	Teste 1.1	f	t
13	331	1	Teste 1	f	f
13	332	1	1	f	t
13	333	1	1Teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 teste 6 tes	f	t
13	334	1	Teste 1	f	t
26	335	0	Teste front 7	f	f
27	336	0	Teste front 8	f	t
28	337	0	Teste qa	t	f
27	338	1	teste 4	f	t
27	339	1	Teste qa2	f	f
27	340	1	Teste qa2	f	t
25	341	1	Teste qa 3	t	f
25	342	1	Teste qa 2	t	f
25	343	1	Teste qa2 Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2Teste qa2	t	f
29	345	0	teste qa2	t	f
30	346	0	Teste qa2 2	f	t
30	347	1	Teste qa2 2	f	f
\.


--
-- Data for Name: t_cdc; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cdc (id_cdc, insert_date, update_date, version, cobranca, codigo_barra, data_emissao, data_perdido, data_vencimento, dias_entre_pagamentos, iof_adicional_atraso, iof_diario_atraso, mora, multa, numero_parcela, renegociado, status, total_parcelas, tp_amortizacaoiof, tp_amortizacao_principal, tp_jurosiof, tp_juros_principal, tp_saldo_devedoriof, tp_saldo_devedor_principal, tp_valor_prestacao, valor, valor_taxa_operacao, id_contrato, ajuste_credito, ajuste_debito, fator_desconto, iof_dia, iof_adicional, iof_total) FROM stdin;
185	2024-09-10 17:49:00.953407	2024-09-12 15:47:52.323848	4	f	1726001343788-1	2024-09-10 17:49:00.925545	\N	2024-09-05	30	0.02	0.00	0.00	0.00	1	f	REVERSAO_PAGAMENTO	1	1.26	200.00	0.04	5.99	0.00	0.00	207.29	207.29	8.00	23	64.75	43.56	97.09	0.4920	0.7600	1.25
217	2024-10-11 16:47:11.20868	2024-10-11 16:47:17.58614	1	f	1728676032361-1	2024-10-11 16:47:11.166597	\N	2024-11-10	30	0.00	0.00	0.00	0.00	1	f	CANCELADO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	43	0.00	0.00	97.09	0.2460	0.3800	0.63
209	2024-09-27 14:52:56.206278	2024-09-27 15:42:44.304761	7	f	1727459578710-4	2024-09-27 14:52:56.176068	\N	2024-08-25	30	0.00	0.00	6.87	0.98	4	f	PAGO	4	0.40	39.16	0.01	1.20	0.00	0.00	40.76	40.76	8.00	38	0.00	0.00	88.84	0.3853	0.1488	0.53
187	2024-09-11 02:16:04.400674	2024-09-11 15:46:31.650342	4	f	1726031765134-1	2024-09-11 02:16:04.386878	\N	2024-09-06	30	0.01	0.00	0.00	0.00	1	f	REVERSAO_PAGAMENTO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	25	9.77	82.43	97.09	0.2460	0.3800	0.63
206	2024-09-27 14:52:56.19292	2024-09-27 15:56:59.58721	3	f	1727459578710-1	2024-09-27 14:52:56.175818	\N	2024-10-27	30	0.00	0.00	0.00	0.00	1	f	PAGO	4	0.36	35.86	0.05	4.50	1.16	114.14	40.76	40.76	8.00	38	0.00	0.00	97.09	0.0882	0.1363	0.22
207	2024-09-27 14:52:56.196936	2024-09-27 15:56:59.598438	3	f	1727459578710-2	2024-09-27 14:52:56.175922	\N	2024-11-26	30	0.00	0.00	0.00	0.00	2	f	PAGO	4	0.37	36.94	0.03	3.42	0.78	77.20	40.76	40.76	8.00	38	0.00	0.00	94.26	0.1817	0.1404	0.32
208	2024-09-27 14:52:56.201614	2024-09-27 15:56:59.6003	3	f	1727459578710-3	2024-09-27 14:52:56.175996	\N	2024-12-26	30	0.00	0.00	0.00	0.00	3	f	PAGO	4	0.39	38.04	0.02	2.32	0.40	39.16	40.76	40.76	8.00	38	0.00	0.00	91.51	0.2807	0.1446	0.43
193	2024-09-11 03:41:38.899471	2024-10-10 14:34:22.036116	4	f	1726036901966-1	2024-09-11 03:41:38.84707	\N	2024-10-25	30	0.00	0.00	0.00	0.00	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	31	0.00	0.00	97.09	0.2460	0.3800	0.63
173	2024-09-10 16:42:04.88444	2024-10-10 14:34:22.047152	3	f	1725997326299-2	2024-09-10 16:42:04.861031	\N	2024-11-09	30	0.00	0.00	0.00	0.00	2	f	PAGO	12	1.53	72.58	0.59	27.89	18.06	856.95	102.59	102.59	8.00	21	0.00	0.00	94.26	0.3571	0.2758	0.63
172	2024-09-10 16:42:04.879519	2024-10-10 14:34:22.051499	5	f	1725997326299-1	2024-09-10 16:42:04.860959	\N	2024-10-10	30	0.00	0.00	0.00	0.00	1	f	PAGO	12	1.49	70.47	0.63	30.00	19.59	929.53	102.59	102.59	8.00	21	41.00	41.00	97.09	0.1734	0.2678	0.44
174	2024-09-10 16:42:04.888576	2024-10-10 14:34:22.052881	3	f	1725997326299-3	2024-09-10 16:42:04.86109	\N	2024-12-09	30	0.00	0.00	0.00	0.00	3	f	PAGO	12	1.58	74.76	0.54	25.71	16.49	782.19	102.59	102.59	8.00	21	0.00	0.00	91.51	0.5517	0.2841	0.84
175	2024-09-10 16:42:04.893125	2024-10-10 14:34:22.054299	3	f	1725997326299-4	2024-09-10 16:42:04.861147	\N	2025-01-08	30	0.00	0.00	0.00	0.00	4	f	PAGO	12	1.62	77.00	0.49	23.47	14.87	705.19	102.59	102.59	8.00	21	0.00	0.00	88.84	0.7577	0.2926	1.05
194	2024-09-11 03:44:18.32286	2024-10-10 14:34:22.070688	4	f	1726037058741-1	2024-09-11 03:44:18.308309	\N	2024-11-22	30	0.00	0.00	0.00	0.00	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	32	0.00	0.00	97.09	0.2460	0.3800	0.63
213	2024-09-27 15:59:20.445107	2024-10-10 14:34:22.077993	3	f	1727463561030-4	2024-09-27 15:59:20.415935	\N	2025-01-25	30	0.00	0.00	0.00	0.00	4	f	PAGO	4	0.40	39.16	0.01	1.20	0.00	0.00	40.76	40.76	8.00	39	0.00	0.00	88.84	0.3853	0.1488	0.53
196	2024-09-11 13:29:04.990334	2024-10-10 14:34:22.078784	12	f	1726072148333-1	2024-09-11 13:29:04.956092	\N	2024-11-27	30	0.00	0.00	0.00	0.00	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	34	4.93	0.00	97.09	0.2460	0.3800	0.63
191	2024-09-11 03:11:59.791525	2024-10-10 14:34:22.080777	4	f	1726035124236-1	2024-09-11 03:11:59.763249	\N	2024-12-06	30	0.00	0.00	0.00	0.00	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	29	0.00	0.00	97.09	0.2460	0.3800	0.63
189	2024-09-11 02:50:31.762159	2024-10-10 14:34:22.085688	5	f	1726033835985-1	2024-09-11 02:50:31.727733	\N	2024-10-06	30	0.00	0.00	-0.09	-0.11	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	27	117.00	0.00	97.09	0.2460	0.3800	0.63
195	2024-09-11 03:51:17.933786	2024-10-10 14:34:22.090237	4	f	1726037478995-1	2024-09-11 03:51:17.91829	\N	2024-12-20	30	0.00	0.00	0.00	0.00	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	33	0.00	0.00	97.09	0.2460	0.3800	0.63
215	2024-10-10 16:54:30.487846	2024-10-10 17:28:06.542813	1	f	1728590071569-1	2024-10-10 16:54:30.446392	\N	2024-11-09	30	0.00	0.00	0.00	0.00	1	f	CANCELADO	1	0.94	150.00	0.03	4.50	0.00	0.00	155.47	155.47	8.00	41	0.00	0.00	97.09	0.3690	0.5700	0.94
71	2024-07-10 21:41:23.652145	2024-09-02 03:50:34.12843	10	f	1720658487704-8	2024-07-10 21:41:23.359369	\N	2024-09-07	30	0.00	0.00	27.68	1.64	8	f	PENDENTE_PAGAMENTO	12	1.45	69.33	0.23	11.04	6.25	298.74	82.05	82.05	10.00	7	0.00	0.00	\N	\N	\N	\N
243	2024-12-16 16:25:06.046908	2024-12-16 18:34:15.570238	3	f	1734377109680-1	2024-12-16 16:25:06.039662	\N	2024-12-16	30	0.00	0.00	0.00	0.00	1	f	ESTORNADO	3	1.43	161.93	0.13	15.00	2.99	338.07	178.49	178.49	8.00	50	0.00	0.00	97.00	0.4000	0.6200	1.02
244	2024-12-16 16:25:06.048644	2024-12-16 18:34:15.572504	3	f	1734377109680-2	2024-12-16 16:25:06.039718	\N	2025-02-14	30	0.00	0.00	0.00	0.00	2	f	ESTORNADO	3	1.47	166.79	0.09	10.14	1.52	171.28	178.49	178.49	8.00	50	0.00	0.00	94.17	0.8200	0.6300	1.45
245	2024-12-16 16:25:06.050024	2024-12-16 18:34:15.574826	3	f	1734377109680-3	2024-12-16 16:25:06.039742	\N	2025-03-16	30	0.00	0.00	0.00	0.00	3	f	ESTORNADO	3	1.51	171.28	0.05	5.65	0.01	0.00	178.49	178.49	8.00	50	0.00	0.00	91.43	1.2600	0.6500	1.91
64	2024-07-10 21:41:23.483827	2024-12-16 16:24:08.544862	6	f	1720658487704-1	2024-07-10 21:41:23.35886	\N	2024-11-15	30	0.00	0.00	10.86	1.64	1	f	PAGO	12	1.18	56.37	0.50	24.00	15.57	743.63	82.05	82.05	0.00	7	0.00	0.00	\N	\N	\N	\N
184	2024-09-10 17:48:19.260231	2024-09-11 15:30:29.482409	6	f	1726001303630-1	2024-09-10 17:48:19.24151	\N	2024-09-06	30	0.00	0.00	2.21	2.07	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	22	190.20	83.27	97.09	0.2460	0.3800	0.63
210	2024-09-27 15:59:20.437593	2024-09-30 09:25:25.709241	6	f	1727463561030-1	2024-09-27 15:59:20.41509	\N	2024-08-25	30	0.00	0.00	7.50	0.98	1	f	PAGO	4	0.36	35.86	0.05	4.50	1.16	114.14	40.76	40.76	8.00	39	62.24	5.00	97.09	0.0882	0.1363	0.22
228	2024-10-17 20:54:47.586471	2024-10-30 09:24:08.513609	2	f	1729209292303-1	2024-10-17 20:54:47.568	\N	2024-11-16	30	0.00	0.00	0.00	0.00	1	f	PENDENTE	5	1.08	94.18	0.17	15.00	4.65	405.82	110.43	110.43	8.00	46	0.00	0.00	97.09	0.2317	0.3579	0.59
229	2024-10-17 20:54:47.593048	2024-10-30 09:24:08.517383	2	f	1729209292303-2	2024-10-17 20:54:47.568086	\N	2024-12-16	30	0.00	0.00	0.00	0.00	2	f	PENDENTE	5	1.11	97.01	0.14	12.17	3.54	308.81	110.43	110.43	8.00	46	0.00	0.00	94.26	0.4773	0.3686	0.85
188	2024-09-11 02:28:13.211558	2024-09-13 14:41:25.081574	4	f	1726032497583-1	2024-09-11 02:28:13.185819	\N	2024-09-06	30	0.00	0.00	0.95	0.63	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	26	136.43	56.43	97.09	0.2460	0.3800	0.63
186	2024-09-10 17:57:50.839117	2024-09-25 11:06:15.908851	3	f	1726001873850-1	2024-09-10 17:57:50.818154	\N	2024-09-05	30	0.00	0.00	0.00	0.00	1	f	ESTORNADO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	24	58.00	63.44	97.09	0.2460	0.3800	0.63
197	2024-09-12 11:26:36.385329	2024-10-10 14:34:22.017331	3	f	1726151199349-1	2024-09-12 11:26:36.335142	\N	2024-10-12	30	0.00	0.00	0.00	0.00	1	f	PAGO	2	0.37	49.26	0.02	3.00	0.38	50.74	52.66	52.66	8.00	35	0.00	0.00	97.09	0.1212	0.1872	0.31
198	2024-09-12 11:26:36.393993	2024-10-10 14:34:22.025318	3	f	1726151199349-2	2024-09-12 11:26:36.335216	\N	2024-11-11	30	0.00	0.00	0.00	0.00	2	f	PAGO	2	0.38	50.74	0.01	1.52	0.00	0.00	52.66	52.66	8.00	35	0.00	0.00	94.26	0.2496	0.1928	0.44
199	2024-09-25 18:55:23.180593	2024-10-10 14:34:22.027642	4	f	1727301325783-1	2024-09-25 18:55:23.158275	\N	2024-10-25	30	0.00	0.00	0.00	0.00	1	f	PAGO	3	0.86	97.06	0.08	9.00	1.80	202.94	107.00	107.00	8.00	36	5.00	0.00	97.09	0.2388	0.3688	0.61
200	2024-09-25 18:55:23.190228	2024-10-10 14:34:22.033232	8	f	1727301325783-2	2024-09-25 18:55:23.158342	\N	2025-01-14	30	0.00	0.00	0.00	0.00	2	f	PAGO	3	0.88	99.97	0.05	6.09	0.91	102.97	107.00	107.00	8.00	36	0.00	0.00	94.26	0.4919	0.3799	0.87
201	2024-09-25 18:55:23.195444	2024-10-10 14:34:22.034447	3	f	1727301325783-3	2024-09-25 18:55:23.158381	\N	2024-12-24	30	0.00	0.00	0.00	0.00	3	f	PAGO	3	0.91	102.97	0.03	3.09	0.00	0.00	107.00	107.00	8.00	36	0.00	0.00	91.51	0.7599	0.3913	1.15
190	2024-09-11 02:56:16.573034	2024-10-10 14:34:22.040931	5	f	1726034178422-1	2024-09-11 02:56:16.50311	\N	2024-11-06	30	0.01	0.00	0.00	0.00	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	28	0.00	0.00	97.09	0.2460	0.3800	0.63
176	2024-09-10 16:42:04.897401	2024-10-10 14:34:22.055618	3	f	1725997326299-5	2024-09-10 16:42:04.861203	\N	2025-02-07	30	0.00	0.00	0.00	0.00	5	f	PAGO	12	1.67	79.31	0.45	21.16	13.19	625.88	102.59	102.59	8.00	21	0.00	0.00	86.25	0.9755	0.3014	1.28
177	2024-09-10 16:42:04.902024	2024-10-10 14:34:22.05698	3	f	1725997326299-6	2024-09-10 16:42:04.861259	\N	2025-03-09	30	0.00	0.00	0.00	0.00	6	f	PAGO	12	1.72	81.69	0.40	18.78	11.47	544.19	102.59	102.59	8.00	21	0.00	0.00	83.74	1.2057	0.3104	1.52
192	2024-09-11 03:22:50.346172	2024-10-10 14:34:22.066843	4	f	1726035774187-1	2024-09-11 03:22:50.30005	\N	2024-11-14	30	0.00	0.00	0.00	0.00	1	f	PAGO	1	0.63	100.00	0.02	3.00	0.00	0.00	103.65	103.65	8.00	30	0.00	0.00	97.09	0.2460	0.3800	0.63
211	2024-09-27 15:59:20.440714	2024-10-10 14:34:22.07477	3	f	1727463561030-2	2024-09-27 15:59:20.415814	\N	2024-11-26	30	0.00	0.00	0.00	0.00	2	f	PAGO	4	0.37	36.94	0.03	3.42	0.78	77.20	40.76	40.76	8.00	39	0.00	0.00	94.26	0.1817	0.1404	0.32
212	2024-09-27 15:59:20.443123	2024-10-10 14:34:22.077214	3	f	1727463561030-3	2024-09-27 15:59:20.41588	\N	2024-12-26	30	0.00	0.00	0.00	0.00	3	f	PAGO	4	0.39	38.04	0.02	2.32	0.40	39.16	40.76	40.76	8.00	39	0.00	0.00	91.51	0.2807	0.1446	0.43
202	2024-09-27 14:06:50.378285	2024-09-27 14:45:41.347146	7	f	1727456810800-1	2024-09-27 14:06:50.340619	\N	2024-08-27	30	0.00	0.00	6.45	0.98	1	f	PAGO	4	0.36	35.86	0.05	4.50	1.16	114.14	40.76	40.76	8.00	37	0.00	0.00	97.09	0.0882	0.1363	0.22
203	2024-09-27 14:06:50.389322	2024-09-27 14:45:41.355733	3	f	1727456810800-2	2024-09-27 14:06:50.340739	\N	2024-11-26	30	0.00	0.00	0.00	0.00	2	f	PAGO	4	0.37	36.94	0.03	3.42	0.78	77.20	40.76	40.76	8.00	37	0.00	0.00	94.26	0.1817	0.1404	0.32
204	2024-09-27 14:06:50.398325	2024-09-27 14:45:41.35814	3	f	1727456810800-3	2024-09-27 14:06:50.340833	\N	2024-12-26	30	0.00	0.00	0.00	0.00	3	f	PAGO	4	0.39	38.04	0.02	2.32	0.40	39.16	40.76	40.76	8.00	37	0.00	0.00	91.51	0.2807	0.1446	0.43
205	2024-09-27 14:06:50.404832	2024-09-27 14:45:41.360286	3	f	1727456810800-4	2024-09-27 14:06:50.34092	\N	2025-01-25	30	0.00	0.00	0.00	0.00	4	f	PAGO	4	0.40	39.16	0.01	1.20	0.00	0.00	40.76	40.76	8.00	37	0.00	0.00	88.84	0.3853	0.1488	0.53
216	2024-10-10 17:27:44.963682	2024-10-10 17:28:03.577245	1	f	1728592069067-1	2024-10-10 17:27:44.931201	\N	2024-11-09	30	0.00	0.00	0.00	0.00	1	f	CANCELADO	1	3.15	500.00	0.09	14.99	0.00	0.00	518.23	518.23	8.00	42	0.00	0.00	97.09	1.2300	1.9000	3.13
178	2024-09-10 16:42:04.90663	2024-10-10 14:34:22.058309	3	f	1725997326299-7	2024-09-10 16:42:04.861318	\N	2025-04-08	30	0.00	0.00	0.00	0.00	7	f	PAGO	12	1.77	84.14	0.34	16.33	9.70	460.05	102.59	102.59	8.00	21	0.00	0.00	81.30	1.4489	0.3197	1.77
179	2024-09-10 16:42:04.910237	2024-10-10 14:34:22.059572	3	f	1725997326299-8	2024-09-10 16:42:04.861374	\N	2025-05-08	30	0.00	0.00	0.00	0.00	8	f	PAGO	12	1.83	86.67	0.29	13.80	7.87	373.38	102.59	102.59	8.00	21	0.00	0.00	78.93	1.7057	0.3293	2.04
180	2024-09-10 16:42:04.913109	2024-10-10 14:34:22.061037	3	f	1725997326299-9	2024-09-10 16:42:04.861438	\N	2025-06-07	30	0.00	0.00	0.00	0.00	9	f	PAGO	12	1.88	89.27	0.24	11.20	5.99	284.11	102.59	102.59	8.00	21	0.00	0.00	76.63	1.9764	0.3392	2.32
181	2024-09-10 16:42:04.915784	2024-10-10 14:34:22.062311	3	f	1725997326299-10	2024-09-10 16:42:04.861495	\N	2025-07-07	30	0.00	0.00	0.00	0.00	10	f	PAGO	12	1.94	91.95	0.18	8.52	4.05	192.16	102.59	102.59	8.00	21	0.00	0.00	74.40	2.2620	0.3494	2.61
182	2024-09-10 16:42:04.918219	2024-10-10 14:34:22.0635	3	f	1725997326299-11	2024-09-10 16:42:04.86155	\N	2025-08-06	30	0.00	0.00	0.00	0.00	11	f	PAGO	12	2.00	94.71	0.12	5.76	2.05	97.45	102.59	102.59	8.00	21	0.00	0.00	72.23	2.5629	0.3599	2.92
183	2024-09-10 16:42:04.921482	2024-10-10 14:34:22.064703	3	f	1725997326299-12	2024-09-10 16:42:04.861607	\N	2025-09-05	30	0.00	0.00	0.00	0.00	12	f	PAGO	12	2.06	97.45	0.06	3.02	0.00	0.00	102.59	102.59	8.00	21	0.00	0.00	70.13	2.8767	0.3703	3.25
246	2024-12-16 17:08:00.630729	2024-12-16 17:08:08.682504	1	f	1734379681752-1	2024-12-16 17:08:00.611028	\N	2025-01-15	30	0.00	0.00	0.00	0.00	1	f	ATIVO	4	1.21	119.64	0.15	15.00	3.85	380.36	136.00	136.00	9.00	51	0.00	0.00	97.00	0.2900	0.4500	0.74
247	2024-12-16 17:08:00.632597	2024-12-16 17:08:08.684935	1	f	1734379681752-2	2024-12-16 17:08:00.611048	\N	2025-02-14	30	0.00	0.00	0.00	0.00	2	f	ATIVO	4	1.24	123.23	0.12	11.41	2.61	257.13	136.00	136.00	9.00	51	0.00	0.00	94.17	0.6100	0.4700	1.08
248	2024-12-16 17:08:00.635206	2024-12-16 17:08:08.687008	1	f	1734379681752-3	2024-12-16 17:08:00.611053	\N	2025-03-16	30	0.00	0.00	0.00	0.00	3	f	ATIVO	4	1.28	126.93	0.08	7.71	1.33	130.20	136.00	136.00	9.00	51	0.00	0.00	91.43	0.9400	0.4800	1.42
249	2024-12-16 17:08:00.637055	2024-12-16 17:08:08.689208	1	f	1734379681752-4	2024-12-16 17:08:00.611058	\N	2025-04-15	30	0.00	0.00	0.00	0.00	4	f	ATIVO	4	1.32	130.20	0.04	4.44	0.01	0.00	136.00	136.00	9.00	51	0.00	0.00	88.77	1.2800	0.4900	1.77
253	2024-12-17 14:41:46.749526	2024-12-17 14:53:46.044179	3	f	1734457307954-1	2024-12-17 14:41:46.673891	\N	2025-01-16	30	0.00	0.00	0.00	0.00	1	f	ESTORNADO	4	0.36	35.89	0.05	4.50	1.16	114.11	40.80	40.80	8.00	53	0.00	0.00	97.00	0.0900	0.1400	0.23
254	2024-12-17 14:41:46.760603	2024-12-17 14:53:46.046203	3	f	1734457307954-2	2024-12-17 14:41:46.673978	\N	2025-02-15	30	0.00	0.00	0.00	0.00	2	f	ESTORNADO	4	0.38	36.97	0.03	3.42	0.78	77.14	40.80	40.80	8.00	53	0.00	0.00	94.17	0.1800	0.1400	0.32
255	2024-12-17 14:41:46.767636	2024-12-17 14:53:46.048089	3	f	1734457307954-3	2024-12-17 14:41:46.674023	\N	2025-03-17	30	0.00	0.00	0.00	0.00	3	f	ESTORNADO	4	0.39	38.08	0.02	2.31	0.38	39.06	40.80	40.80	8.00	53	0.00	0.00	91.43	0.2800	0.1400	0.42
256	2024-12-17 14:41:46.774156	2024-12-17 14:53:46.050038	3	f	1734457307954-4	2024-12-17 14:41:46.674064	\N	2025-04-16	30	0.00	0.00	0.00	0.00	4	f	ESTORNADO	4	0.40	39.06	0.01	1.33	0.00	0.00	40.80	40.80	8.00	53	0.00	0.00	88.77	0.3800	0.1500	0.53
214	2024-10-10 15:05:11.354639	2024-12-16 16:06:27.378979	3	f	1728583512523-1	2024-10-10 15:05:11.329004	\N	2024-11-09	30	0.00	0.00	15.01	1.90	1	f	PAGO	1	0.94	150.00	0.03	4.50	0.00	0.00	155.47	155.47	8.00	40	168.48	100.00	97.09	0.3690	0.5700	0.94
222	2024-10-17 20:54:10.782753	2024-12-16 16:06:27.384292	3	f	1729209254072-1	2024-10-17 20:54:10.761423	\N	2024-11-16	30	0.00	0.00	4.62	0.72	1	f	PAGO	6	0.30	23.19	0.06	4.50	1.62	126.81	28.05	28.05	8.00	45	0.00	0.00	97.09	0.0570	0.0881	0.15
223	2024-10-17 20:54:10.790572	2024-12-16 16:06:27.390535	3	f	1729209254072-2	2024-10-17 20:54:10.761504	\N	2024-12-16	30	0.00	0.00	0.00	0.00	2	f	PAGO	6	0.31	23.89	0.05	3.80	1.32	102.92	28.05	28.05	8.00	45	0.00	0.00	94.26	0.1175	0.0908	0.21
218	2024-10-17 20:39:34.690561	2024-12-16 16:06:27.392451	3	f	1729208379464-1	2024-10-17 20:39:34.617932	\N	2024-11-16	30	0.00	0.00	6.25	0.98	1	f	PAGO	4	0.36	35.86	0.05	4.50	1.16	114.14	40.76	40.76	8.00	44	0.00	0.00	97.09	0.0882	0.1363	0.22
219	2024-10-17 20:39:34.698297	2024-12-16 16:06:27.397997	3	f	1729208379464-2	2024-10-17 20:39:34.618015	\N	2024-12-16	30	0.00	0.00	0.00	0.00	2	f	PAGO	4	0.37	36.94	0.03	3.42	0.78	77.20	40.76	40.76	8.00	44	0.00	0.00	94.26	0.1817	0.1404	0.32
234	2024-11-25 11:32:03.031355	2024-12-16 16:06:27.489683	3	f	1732545124230-1	2024-11-25 11:32:02.965086	\N	2024-12-25	30	0.00	0.00	0.00	0.00	1	f	PAGO	6	0.99	77.30	0.19	15.00	5.40	422.70	93.48	93.48	8.00	48	45.67	0.00	97.09	0.1902	0.2937	0.48
230	2024-10-17 20:54:47.598055	2024-12-16 16:06:27.530375	3	f	1729209292303-3	2024-10-17 20:54:47.568152	\N	2025-01-15	30	0.00	0.00	0.00	0.00	3	f	PAGO	5	1.14	99.92	0.11	9.26	2.39	208.89	110.43	110.43	8.00	46	118.43	0.00	91.51	0.7374	0.3797	1.12
224	2024-10-17 20:54:10.794611	2024-12-16 16:06:27.550544	3	f	1729209254072-3	2024-10-17 20:54:10.761559	\N	2025-01-15	30	0.00	0.00	0.00	0.00	3	f	PAGO	6	0.31	24.60	0.04	3.09	1.00	78.32	28.05	28.05	8.00	45	36.05	0.00	91.51	0.1815	0.0935	0.28
220	2024-10-17 20:39:34.702803	2024-12-16 16:06:27.571184	3	f	1729208379464-3	2024-10-17 20:39:34.618064	\N	2025-01-15	30	0.00	0.00	0.00	0.00	3	f	PAGO	4	0.39	38.04	0.02	2.32	0.40	39.16	40.76	40.76	8.00	44	48.76	0.00	91.51	0.2807	0.1446	0.43
235	2024-11-25 11:32:03.043024	2024-12-16 16:06:27.592121	3	f	1732545124230-2	2024-11-25 11:32:02.965144	\N	2025-01-24	30	0.00	0.00	0.00	0.00	2	f	PAGO	6	1.02	79.62	0.16	12.68	4.38	343.08	93.48	93.48	8.00	48	101.48	0.00	94.26	0.3917	0.3026	0.69
231	2024-10-17 20:54:47.601946	2024-12-16 16:06:27.608079	3	f	1729209292303-4	2024-10-17 20:54:47.568212	\N	2025-02-14	30	0.00	0.00	0.00	0.00	4	f	PAGO	5	1.18	102.91	0.07	6.27	1.21	105.98	110.43	110.43	8.00	46	118.43	0.00	88.84	1.0126	0.3911	1.40
225	2024-10-17 20:54:10.79933	2024-12-16 16:06:27.630957	3	f	1729209254072-4	2024-10-17 20:54:10.761613	\N	2025-02-14	30	0.00	0.00	0.00	0.00	4	f	PAGO	6	0.32	25.34	0.03	2.35	0.68	52.98	28.05	28.05	8.00	45	36.05	0.00	88.84	0.2493	0.0963	0.35
221	2024-10-17 20:39:34.706325	2024-12-16 16:06:27.658357	3	f	1729208379464-4	2024-10-17 20:39:34.618112	\N	2025-02-14	30	0.00	0.00	0.00	0.00	4	f	PAGO	4	0.40	39.16	0.01	1.20	0.00	0.00	40.76	40.76	8.00	44	48.76	0.00	88.84	0.3853	0.1488	0.53
236	2024-11-25 11:32:03.051798	2024-12-16 16:06:27.6769	3	f	1732545124230-3	2024-11-25 11:32:02.96523	\N	2025-02-23	30	0.00	0.00	0.00	0.00	3	f	PAGO	6	1.05	82.01	0.13	10.29	3.34	261.07	93.48	93.48	8.00	48	101.48	0.00	91.51	0.6052	0.3116	0.92
232	2024-10-17 20:54:47.6053	2024-12-16 16:06:27.693448	3	f	1729209292303-5	2024-10-17 20:54:47.568292	\N	2025-03-16	30	0.00	0.00	0.00	0.00	5	f	PAGO	5	1.21	105.98	0.04	3.20	0.00	0.00	110.43	110.43	8.00	46	118.43	0.00	86.25	1.3036	0.4027	1.71
226	2024-10-17 20:54:10.806152	2024-12-16 16:06:27.716457	3	f	1729209254072-5	2024-10-17 20:54:10.761668	\N	2025-03-16	30	0.00	0.00	0.00	0.00	5	f	PAGO	6	0.33	26.10	0.02	1.59	0.34	26.88	28.05	28.05	8.00	45	36.05	0.00	86.25	0.3210	0.0992	0.42
237	2024-11-25 11:32:03.060921	2024-12-16 16:06:27.734896	3	f	1732545124230-4	2024-11-25 11:32:02.965271	\N	2025-03-25	30	0.00	0.00	0.00	0.00	4	f	PAGO	6	1.08	84.47	0.10	7.83	2.26	176.60	93.48	93.48	8.00	48	101.48	0.00	88.84	0.8312	0.3210	1.15
227	2024-10-17 20:54:10.813056	2024-12-16 16:06:27.762248	3	f	1729209254072-6	2024-10-17 20:54:10.76172	\N	2025-04-15	30	0.00	0.00	0.00	0.00	6	f	PAGO	6	0.34	26.88	0.01	0.81	0.00	0.00	28.05	28.05	8.00	45	36.05	0.00	83.74	0.3967	0.1021	0.50
238	2024-11-25 11:32:03.06866	2024-12-16 16:06:27.778933	3	f	1732545124230-5	2024-11-25 11:32:02.96532	\N	2025-04-24	30	0.00	0.00	0.00	0.00	5	f	PAGO	6	1.11	87.00	0.07	5.30	1.14	89.60	93.48	93.48	8.00	48	101.48	0.00	86.25	1.0701	0.3306	1.40
239	2024-11-25 11:32:03.076639	2024-12-16 16:06:27.793329	3	f	1732545124230-6	2024-11-25 11:32:02.965381	\N	2025-05-24	30	0.00	0.00	0.00	0.00	6	f	PAGO	6	1.15	89.60	0.03	2.70	0.00	0.00	93.48	93.48	8.00	48	101.48	0.00	83.74	1.3225	0.3405	1.66
250	2024-12-17 09:23:51.550255	2024-12-17 09:37:36.737845	4	f	1734438235797-1	2024-12-17 09:23:51.515737	\N	2024-12-10	30	0.00	0.00	1.84	1.23	1	f	ESTORNADO	3	0.43	48.58	0.04	4.50	0.90	101.42	53.55	53.55	8.00	52	0.00	0.00	97.00	0.1200	0.1800	0.30
251	2024-12-17 09:23:51.554202	2024-12-17 09:37:36.740179	3	f	1734438235797-2	2024-12-17 09:23:51.515793	\N	2025-02-15	30	0.00	0.00	0.00	0.00	2	f	ESTORNADO	3	0.44	50.04	0.03	3.04	0.46	51.38	53.55	53.55	8.00	52	0.00	0.00	94.17	0.2500	0.1900	0.44
252	2024-12-17 09:23:51.556048	2024-12-17 09:37:36.741668	3	f	1734438235797-3	2024-12-17 09:23:51.51583	\N	2025-03-17	30	0.00	0.00	0.00	0.00	3	f	ESTORNADO	3	0.46	51.38	0.01	1.70	0.00	0.00	53.55	53.55	8.00	52	0.00	0.00	91.43	0.3800	0.2000	0.58
240	2024-12-16 16:13:13.176464	2024-12-16 16:15:44.579198	3	f	1734376393373-1	2024-12-16 16:13:13.167979	\N	2025-01-15	30	0.00	0.00	0.00	0.00	1	f	ESTORNADO	3	1.57	178.12	0.15	16.50	3.30	371.88	196.34	196.34	8.00	49	0.00	0.00	97.00	0.4400	0.6800	1.12
241	2024-12-16 16:13:13.178688	2024-12-16 16:15:44.581356	3	f	1734376393373-2	2024-12-16 16:13:13.168017	\N	2025-02-14	30	0.00	0.00	0.00	0.00	2	f	ESTORNADO	3	1.62	183.46	0.10	11.16	1.68	188.42	196.34	196.34	8.00	49	0.00	0.00	94.17	0.9000	0.7000	1.60
242	2024-12-16 16:13:13.180495	2024-12-16 16:15:44.583768	3	f	1734376393373-3	2024-12-16 16:13:13.168037	\N	2025-03-16	30	0.00	0.00	0.00	0.00	3	f	ESTORNADO	3	1.67	188.42	0.05	6.20	0.01	0.00	196.34	196.34	8.00	49	0.00	0.00	91.43	1.3900	0.7200	2.11
258	2024-12-24 10:11:33.444358	2024-12-24 10:11:42.225757	1	f	1735045895333-2	2024-12-24 10:11:33.401219	\N	2025-02-22	30	0.00	0.00	0.00	0.00	2	f	ATIVO	4	1.37	135.55	0.13	12.55	2.88	282.85	149.60	149.60	8.00	54	0.00	0.00	94.17	0.6700	0.5200	1.19
259	2024-12-24 10:11:33.453142	2024-12-24 10:11:42.227099	1	f	1735045895333-3	2024-12-24 10:11:33.401273	\N	2025-03-24	30	0.00	0.00	0.00	0.00	3	f	ATIVO	4	1.41	139.61	0.09	8.49	1.47	143.24	149.60	149.60	8.00	54	0.00	0.00	91.43	1.0300	0.5300	1.56
260	2024-12-24 10:11:33.461646	2024-12-24 10:11:42.228345	1	f	1735045895333-4	2024-12-24 10:11:33.401314	\N	2025-04-23	30	0.00	0.00	0.00	0.00	4	f	ATIVO	4	1.46	143.24	0.04	4.86	0.01	0.00	149.60	149.60	8.00	54	0.00	0.00	88.77	1.4100	0.5400	1.95
257	2024-12-24 10:11:33.434567	2024-12-24 10:11:42.224119	1	f	1735045895333-1	2024-12-24 10:11:33.401155	\N	2025-01-23	30	0.00	0.00	0.00	0.00	1	f	PENDENTE_ACORDO	4	1.33	131.60	0.17	16.50	4.25	418.40	149.60	149.60	8.00	54	0.00	0.00	97.00	0.3200	0.5000	0.82
\.


--
-- Data for Name: t_cdc_abatimento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cdc_abatimento (id_cdc_abatimento, insert_date, update_date, version, data, mora, multa, percentual, status, valor, valor_taxa_operacao, valor_total, id_cdc, id_pagamento_item, ajuste_credito, ajuste_debito, desconto_pagamento_antecipado) FROM stdin;
87	2024-10-10 14:33:57.068408	2024-10-10 14:34:22.068199	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	103.65	8.00	111.65	192	85	0.00	0.00	0.00
61	2024-09-11 15:29:41.923318	2024-09-11 15:30:29.484839	1	2024-09-11 15:29:41.901001	2.21	2.07	100.00	ATIVO	103.65	8.00	115.93	184	60	0.00	0.00	0.00
62	2024-09-11 15:30:35.931882	2024-09-11 15:30:35.931899	0	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	0.00	0.00	0.00
63	2024-09-13 14:41:12.620343	2024-09-13 14:41:25.0862	1	2024-09-13 14:41:12.60171	0.95	0.63	100.00	ATIVO	103.65	8.00	33.23	188	61	136.43	56.43	0.00
78	2024-09-30 09:25:25.705591	2024-09-30 09:25:25.705599	0	2024-09-30 09:25:25.670599	7.50	0.98	100.00	ATIVO	40.76	8.00	0.00	210	76	62.24	5.00	0.00
77	2024-09-27 16:12:18.184166	2024-09-30 09:25:55.631415	4	2024-09-27 16:12:18.173017	6.87	0.98	100.00	ESTORNADO	40.76	8.00	56.61	210	76	5.00	5.00	0.00
68	2024-09-27 14:45:31.684665	2024-09-27 14:45:41.34952	1	2024-09-27 14:45:31.656674	6.45	0.98	100.00	ATIVO	40.76	8.00	56.19	202	66	0.00	0.00	0.00
69	2024-09-27 14:45:31.687363	2024-09-27 14:45:41.362191	1	2024-09-27 14:45:31.656674	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	203	67	0.00	0.00	0.00
70	2024-09-27 14:45:31.689778	2024-09-27 14:45:41.363249	1	2024-09-27 14:45:31.656674	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	204	68	0.00	0.00	0.00
71	2024-09-27 14:45:31.692008	2024-09-27 14:45:41.364126	1	2024-09-27 14:45:31.656674	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	205	69	0.00	0.00	0.00
67	2024-09-27 14:28:03.129806	2024-09-27 14:53:10.23087	4	2024-09-27 14:28:03.107773	6.45	0.98	100.00	ESTORNADO	40.76	8.00	56.19	202	66	0.00	0.00	0.00
73	2024-09-27 15:40:23.952013	2024-09-27 15:42:44.307615	1	2024-09-27 15:40:23.941989	6.87	0.98	100.00	ATIVO	40.76	8.00	56.61	209	71	0.00	0.00	0.00
72	2024-09-27 15:26:01.012114	2024-09-27 15:43:22.021719	4	2024-09-27 15:26:00.986626	6.87	0.98	100.00	ESTORNADO	40.76	8.00	56.61	209	71	0.00	0.00	0.00
74	2024-09-27 15:56:48.111003	2024-09-27 15:56:59.589246	1	2024-09-27 15:56:48.046674	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	206	72	0.00	0.00	0.00
75	2024-09-27 15:56:48.115865	2024-09-27 15:56:59.602228	1	2024-09-27 15:56:48.046674	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	207	73	0.00	0.00	0.00
76	2024-09-27 15:56:48.120391	2024-09-27 15:56:59.603524	1	2024-09-27 15:56:48.046674	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	208	74	0.00	0.00	0.00
88	2024-10-10 14:33:57.071265	2024-10-10 14:34:22.072163	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	103.65	8.00	111.65	194	86	0.00	0.00	0.00
81	2024-10-10 14:33:57.013609	2024-10-10 14:34:22.019306	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	52.66	8.00	60.66	197	79	0.00	0.00	0.00
82	2024-10-10 14:33:57.03416	2024-10-10 14:34:22.029742	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	107.00	8.00	110.00	199	80	5.00	0.00	0.00
83	2024-10-10 14:33:57.041324	2024-10-10 14:34:22.03762	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	103.65	8.00	111.65	193	81	0.00	0.00	0.00
84	2024-10-10 14:33:57.049504	2024-10-10 14:34:22.04349	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	103.65	8.00	111.65	190	82	0.00	0.00	0.00
85	2024-10-10 14:33:57.057317	2024-10-10 14:34:22.048579	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	173	83	0.00	0.00	0.00
86	2024-10-10 14:33:57.064075	2024-10-10 14:34:22.065966	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	52.66	8.00	60.66	198	84	0.00	0.00	0.00
89	2024-10-10 14:33:57.073298	2024-10-10 14:34:22.075612	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	211	87	0.00	0.00	0.00
90	2024-10-10 14:33:57.075934	2024-10-10 14:34:22.079475	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	103.65	8.00	106.72	196	88	4.93	0.00	0.00
91	2024-10-10 14:33:57.079973	2024-10-10 14:34:22.08208	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	103.65	8.00	111.65	191	89	0.00	0.00	0.00
92	2024-10-10 14:33:57.082757	2024-10-10 14:34:22.084884	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	174	90	0.00	0.00	0.00
79	2024-10-10 14:33:56.998474	2024-10-10 14:34:22.087016	1	2024-10-10 14:33:56.884055	-0.09	-0.11	100.00	ATIVO	103.65	8.00	-5.55	189	77	117.00	0.00	0.00
59	2024-09-10 16:44:50.138708	2024-10-10 14:35:40.952871	2	2024-09-10 16:44:50.118796	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	172	78	0.00	0.00	0.00
65	2024-09-25 13:28:27.140329	2024-10-10 14:35:40.955111	4	2024-09-25 13:28:27.09255	8.66	2.13	100.00	ESTORNADO	103.65	8.00	117.51	196	88	4.93	0.00	0.00
64	2024-09-25 11:32:12.573838	2024-10-10 14:35:40.95662	7	2024-09-25 11:32:12.538662	8.66	2.13	100.00	ESTORNADO	103.65	8.00	117.51	196	88	4.93	0.00	0.00
66	2024-09-25 19:33:27.385418	2024-10-10 14:35:40.957978	4	2024-09-25 19:33:27.362695	5.40	2.30	100.00	ESTORNADO	107.00	8.00	122.70	200	95	0.00	0.00	0.00
80	2024-10-10 14:33:57.007621	2024-10-10 14:34:22.089454	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	172	78	41.00	41.00	0.00
93	2024-10-10 14:33:57.084962	2024-10-10 14:34:22.091511	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	103.65	8.00	111.65	195	91	0.00	0.00	0.00
94	2024-10-10 14:33:57.087203	2024-10-10 14:34:22.09412	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	107.00	8.00	115.00	201	92	0.00	0.00	0.00
95	2024-10-10 14:33:57.089592	2024-10-10 14:34:22.095043	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	212	93	0.00	0.00	0.00
96	2024-10-10 14:33:57.091659	2024-10-10 14:34:22.09585	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	175	94	0.00	0.00	0.00
97	2024-10-10 14:33:57.093883	2024-10-10 14:34:22.096584	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	107.00	8.00	115.00	200	95	0.00	0.00	0.00
98	2024-10-10 14:33:57.096204	2024-10-10 14:34:22.097291	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	213	96	0.00	0.00	0.00
99	2024-10-10 14:33:57.098563	2024-10-10 14:34:22.098002	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	176	97	0.00	0.00	0.00
100	2024-10-10 14:33:57.100818	2024-10-10 14:34:22.098706	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	177	98	0.00	0.00	0.00
101	2024-10-10 14:33:57.102761	2024-10-10 14:34:22.099392	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	178	99	0.00	0.00	0.00
102	2024-10-10 14:33:57.104555	2024-10-10 14:34:22.100071	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	179	100	0.00	0.00	0.00
103	2024-10-10 14:33:57.106273	2024-10-10 14:34:22.100784	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	180	101	0.00	0.00	0.00
104	2024-10-10 14:33:57.107945	2024-10-10 14:34:22.101458	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	181	102	0.00	0.00	0.00
105	2024-10-10 14:33:57.109836	2024-10-10 14:34:22.102098	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	182	103	0.00	0.00	0.00
106	2024-10-10 14:33:57.111365	2024-10-10 14:34:22.102845	1	2024-10-10 14:33:56.884055	0.00	0.00	100.00	ATIVO	102.59	8.00	110.59	183	104	0.00	0.00	0.00
149	2024-12-16 16:05:41.203248	2024-12-16 16:06:27.380046	1	2024-12-16 16:05:41.159692	15.01	1.90	100.00	ATIVO	155.47	8.00	111.90	214	147	168.48	100.00	0.00
150	2024-12-16 16:05:41.21167	2024-12-16 16:06:27.385933	1	2024-12-16 16:05:41.159692	4.62	0.72	100.00	ATIVO	28.05	8.00	41.39	222	148	0.00	0.00	0.00
151	2024-12-16 16:05:41.216831	2024-12-16 16:06:27.39406	1	2024-12-16 16:05:41.159692	6.25	0.98	100.00	ATIVO	40.76	8.00	55.99	218	149	0.00	0.00	0.00
152	2024-12-16 16:05:41.221361	2024-12-16 16:06:27.400381	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	28.05	8.00	36.05	223	150	0.00	0.00	0.00
153	2024-12-16 16:05:41.224268	2024-12-16 16:06:27.401587	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	40.76	8.00	48.76	219	151	0.00	0.00	0.00
154	2024-12-16 16:05:41.228793	2024-12-16 16:06:27.493349	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	93.48	8.00	55.81	234	152	45.67	0.00	45.67
155	2024-12-16 16:05:41.232644	2024-12-16 16:06:27.532951	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	110.43	8.00	0.00	230	153	118.43	0.00	118.43
156	2024-12-16 16:05:41.23564	2024-12-16 16:06:27.551249	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	28.05	8.00	0.00	224	154	36.05	0.00	36.05
157	2024-12-16 16:05:41.239097	2024-12-16 16:06:27.57283	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	40.76	8.00	0.00	220	155	48.76	0.00	48.76
158	2024-12-16 16:05:41.245355	2024-12-16 16:06:27.592971	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	93.48	8.00	0.00	235	156	101.48	0.00	101.48
159	2024-12-16 16:05:41.250033	2024-12-16 16:06:27.610275	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	110.43	8.00	0.00	231	157	118.43	0.00	118.43
160	2024-12-16 16:05:41.254004	2024-12-16 16:06:27.631667	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	28.05	8.00	0.00	225	158	36.05	0.00	36.05
161	2024-12-16 16:05:41.258016	2024-12-16 16:06:27.659453	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	40.76	8.00	0.00	221	159	48.76	0.00	48.76
162	2024-12-16 16:05:41.261969	2024-12-16 16:06:27.677771	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	93.48	8.00	0.00	236	160	101.48	0.00	101.48
163	2024-12-16 16:05:41.265319	2024-12-16 16:06:27.697018	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	110.43	8.00	0.00	232	161	118.43	0.00	114.43
164	2024-12-16 16:05:41.267969	2024-12-16 16:06:27.717133	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	28.05	8.00	0.00	226	162	36.05	0.00	36.05
165	2024-12-16 16:05:41.270029	2024-12-16 16:06:27.736098	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	93.48	8.00	0.00	237	163	101.48	0.00	101.48
166	2024-12-16 16:05:41.271803	2024-12-16 16:06:27.763009	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	28.05	8.00	0.00	227	164	36.05	0.00	36.05
167	2024-12-16 16:05:41.273617	2024-12-16 16:06:27.77952	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	93.48	8.00	0.00	238	165	101.48	0.00	101.48
168	2024-12-16 16:05:41.275425	2024-12-16 16:06:27.793962	1	2024-12-16 16:05:41.159692	0.00	0.00	100.00	ATIVO	93.48	8.00	0.00	239	166	101.48	0.00	101.48
169	2024-12-16 16:23:51.803503	2024-12-16 16:24:08.547205	1	2024-12-16 16:23:51.789064	10.86	1.64	100.00	ATIVO	82.05	0.00	94.55	64	167	0.00	0.00	0.00
\.


--
-- Data for Name: t_cdc_boleto; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cdc_boleto (id_cdc, id_boleto) FROM stdin;
64	1
64	2
64	1
64	2
71	3
71	4
71	5
71	6
71	7
64	1
64	2
64	1
64	2
71	3
71	4
71	5
71	6
71	7
71	8
243	9
250	10
\.


--
-- Data for Name: t_cdc_historico; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cdc_historico (id_cdc_historico, insert_date, update_date, version, data, data_vencimento, iof_adicional_atraso, iof_diario_atraso, mora, multa, operacao, status, valor, id_cdc, id_transacao) FROM stdin;
801	2024-09-10 16:42:04.882453	2024-09-10 16:42:04.882463	0	2024-09-10 16:42:04.860984	2024-10-10	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	172	60
802	2024-09-10 16:42:04.886879	2024-09-10 16:42:04.886888	0	2024-09-10 16:42:04.861046	2024-11-09	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	173	60
803	2024-09-10 16:42:04.891457	2024-09-10 16:42:04.891488	0	2024-09-10 16:42:04.861104	2024-12-09	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	174	60
804	2024-09-10 16:42:04.895694	2024-09-10 16:42:04.895704	0	2024-09-10 16:42:04.861161	2025-01-08	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	175	60
805	2024-09-10 16:42:04.900115	2024-09-10 16:42:04.900125	0	2024-09-10 16:42:04.861218	2025-02-07	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	176	60
806	2024-09-10 16:42:04.904856	2024-09-10 16:42:04.904866	0	2024-09-10 16:42:04.861273	2025-03-09	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	177	60
807	2024-09-10 16:42:04.909126	2024-09-10 16:42:04.909136	0	2024-09-10 16:42:04.861332	2025-04-08	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	178	60
808	2024-09-10 16:42:04.912066	2024-09-10 16:42:04.912083	0	2024-09-10 16:42:04.861388	2025-05-08	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	179	60
809	2024-09-10 16:42:04.914808	2024-09-10 16:42:04.914814	0	2024-09-10 16:42:04.861452	2025-06-07	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	180	60
810	2024-09-10 16:42:04.917546	2024-09-10 16:42:04.917551	0	2024-09-10 16:42:04.861509	2025-07-07	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	181	60
811	2024-09-10 16:42:04.920241	2024-09-10 16:42:04.920248	0	2024-09-10 16:42:04.861564	2025-08-06	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	182	60
812	2024-09-10 16:42:04.92356	2024-09-10 16:42:04.92357	0	2024-09-10 16:42:04.861627	2025-09-05	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	102.59	183	60
813	2024-09-10 16:42:18.18028	2024-09-10 16:42:18.1803	0	2024-09-10 16:42:18.153349	2024-10-10	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	172	61
814	2024-09-10 16:42:18.183079	2024-09-10 16:42:18.183091	0	2024-09-10 16:42:18.153379	2024-11-09	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	173	61
815	2024-09-10 16:42:18.185427	2024-09-10 16:42:18.185566	0	2024-09-10 16:42:18.153391	2024-12-09	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	174	61
816	2024-09-10 16:42:18.187355	2024-09-10 16:42:18.187364	0	2024-09-10 16:42:18.153401	2025-01-08	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	175	61
817	2024-09-10 16:42:18.190263	2024-09-10 16:42:18.190277	0	2024-09-10 16:42:18.153422	2025-02-07	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	176	61
818	2024-09-10 16:42:18.193073	2024-09-10 16:42:18.193087	0	2024-09-10 16:42:18.153433	2025-03-09	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	177	61
819	2024-09-10 16:42:18.196017	2024-09-10 16:42:18.196033	0	2024-09-10 16:42:18.153443	2025-04-08	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	178	61
820	2024-09-10 16:42:18.198544	2024-09-10 16:42:18.198555	0	2024-09-10 16:42:18.153453	2025-05-08	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	179	61
821	2024-09-10 16:42:18.200231	2024-09-10 16:42:18.20024	0	2024-09-10 16:42:18.153462	2025-06-07	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	180	61
822	2024-09-10 16:42:18.201633	2024-09-10 16:42:18.20164	0	2024-09-10 16:42:18.153472	2025-07-07	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	181	61
823	2024-09-10 16:42:18.203078	2024-09-10 16:42:18.20309	0	2024-09-10 16:42:18.153482	2025-08-06	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	182	61
824	2024-09-10 16:42:18.205445	2024-09-10 16:42:18.20546	0	2024-09-10 16:42:18.153492	2025-09-05	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	102.59	183	61
825	2024-09-10 16:44:50.141188	2024-09-10 16:44:50.141203	0	2024-09-10 16:44:50.119993	2024-10-10	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	172	62
826	2024-09-10 16:45:28.309606	2024-09-10 16:45:28.309622	0	2024-09-10 16:45:28.283997	2024-10-10	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	172	63
827	2024-09-10 17:28:51.016658	2024-09-10 17:28:51.016669	0	2024-09-10 17:28:51.01435	2023-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	102.59	173	\N
828	2024-09-10 17:39:39.526982	2024-09-10 17:39:39.526989	0	2024-09-10 17:39:39.525535	2023-11-09	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	102.59	173	\N
829	2024-09-10 17:46:07.298558	2024-09-10 17:46:07.298566	0	2024-09-10 17:46:07.296924	2023-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	102.59	173	\N
830	2024-09-10 17:48:19.265978	2024-09-10 17:48:19.265999	0	2024-09-10 17:48:19.241542	2024-10-10	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	184	64
831	2024-09-10 17:48:26.86676	2024-09-10 17:48:26.866771	0	2024-09-10 17:48:26.863863	2024-10-10	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	184	65
832	2024-09-10 17:49:00.959264	2024-09-10 17:49:00.959286	0	2024-09-10 17:49:00.92566	2024-10-10	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	207.29	185	66
833	2024-09-10 17:49:06.351356	2024-09-10 17:49:06.351368	0	2024-09-10 17:49:06.34309	2024-10-10	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	207.29	185	67
834	2024-09-10 17:53:17.176821	2024-09-10 17:53:17.176831	0	2024-09-10 17:53:17.175023	2024-09-05	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	184	\N
835	2024-09-10 17:56:16.199347	2024-09-10 17:56:16.199353	0	2024-09-10 17:56:16.198295	2024-09-05	0.02	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	207.29	185	\N
836	2024-09-10 17:57:50.844823	2024-09-10 17:57:50.844847	0	2024-09-10 17:57:50.818204	2024-10-10	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	186	68
837	2024-09-10 17:57:55.153392	2024-09-10 17:57:55.153396	0	2024-09-10 17:57:55.150728	2024-10-10	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	186	69
838	2024-09-10 17:58:50.945875	2024-09-10 17:58:50.945881	0	2024-09-10 17:58:50.944068	2024-08-10	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	186	\N
839	2024-09-11 02:06:20.923676	2024-09-11 02:06:20.923717	0	2024-09-11 02:06:20.91402	2024-09-05	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	184	\N
840	2024-09-11 02:11:23.993641	2024-09-11 02:11:23.993653	0	2024-09-11 02:11:23.990518	2024-09-05	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	184	\N
841	2024-09-11 02:13:41.498406	2024-09-11 02:13:41.498421	0	2024-09-11 02:13:41.495459	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	184	\N
842	2024-09-11 02:16:04.404028	2024-09-11 02:16:04.404058	0	2024-09-11 02:16:04.386912	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	187	70
843	2024-09-11 02:16:41.836804	2024-09-11 02:16:41.83682	0	2024-09-11 02:16:41.828436	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	187	71
844	2024-09-11 02:18:27.071123	2024-09-11 02:18:27.07113	0	2024-09-11 02:18:27.069327	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	187	\N
845	2024-09-11 02:25:08.502381	2024-09-11 02:25:08.50239	0	2024-09-11 02:25:08.500811	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	187	\N
846	2024-09-11 02:28:13.216461	2024-09-11 02:28:13.216484	0	2024-09-11 02:28:13.185891	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	188	72
847	2024-09-11 02:29:19.063403	2024-09-11 02:29:19.063412	0	2024-09-11 02:29:19.058109	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	188	73
848	2024-09-11 02:32:00.223583	2024-09-11 02:32:00.223589	0	2024-09-11 02:32:00.221895	2024-10-11	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	188	\N
849	2024-09-11 02:44:48.589022	2024-09-11 02:44:48.58903	0	2024-09-11 02:44:48.587119	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	188	\N
850	2024-09-11 02:50:31.766918	2024-09-11 02:50:31.766936	0	2024-09-11 02:50:31.727759	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	189	74
851	2024-09-11 02:50:36.095051	2024-09-11 02:50:36.095061	0	2024-09-11 02:50:36.087064	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	189	75
852	2024-09-11 02:52:52.801467	2024-09-11 02:52:52.801492	0	2024-09-11 02:52:52.797903	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	189	\N
853	2024-09-11 02:56:16.580587	2024-09-11 02:56:16.580609	0	2024-09-11 02:56:16.503144	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	190	76
854	2024-09-11 02:56:21.321037	2024-09-11 02:56:21.321048	0	2024-09-11 02:56:21.308244	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	190	77
855	2024-09-11 02:57:16.045747	2024-09-11 02:57:16.045765	0	2024-09-11 02:57:16.042132	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	189	\N
856	2024-09-11 02:58:19.64889	2024-09-11 02:58:19.64891	0	2024-09-11 02:58:19.645573	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	190	\N
857	2024-09-11 03:11:59.795066	2024-09-11 03:11:59.795077	0	2024-09-11 03:11:59.76327	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	191	78
858	2024-09-11 03:12:03.561745	2024-09-11 03:12:03.561751	0	2024-09-11 03:12:03.550086	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	191	79
859	2024-09-11 03:13:59.513091	2024-09-11 03:13:59.513108	0	2024-09-11 03:13:59.507649	2024-09-06	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	191	\N
860	2024-09-11 03:22:50.352382	2024-09-11 03:22:50.352402	0	2024-09-11 03:22:50.300066	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	192	80
861	2024-09-11 03:22:55.913864	2024-09-11 03:22:55.913872	0	2024-09-11 03:22:55.906454	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	192	81
862	2024-09-11 03:24:20.14619	2024-09-11 03:24:20.146202	0	2024-09-11 03:24:20.143291	2024-09-06	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	192	\N
863	2024-09-11 03:41:38.905237	2024-09-11 03:41:38.905254	0	2024-09-11 03:41:38.847088	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	193	82
864	2024-09-11 03:41:49.875593	2024-09-11 03:41:49.875625	0	2024-09-11 03:41:49.861969	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	193	83
865	2024-09-11 03:42:57.665985	2024-09-11 03:42:57.665999	0	2024-09-11 03:42:57.663341	2024-09-06	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	193	\N
866	2024-09-11 03:44:18.327139	2024-09-11 03:44:18.327152	0	2024-09-11 03:44:18.308334	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	194	84
867	2024-09-11 03:44:30.876894	2024-09-11 03:44:30.87691	0	2024-09-11 03:44:30.872801	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	194	85
868	2024-09-11 03:46:33.190056	2024-09-11 03:46:33.190074	0	2024-09-11 03:46:33.187853	2024-09-06	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	194	\N
869	2024-09-11 03:51:17.936925	2024-09-11 03:51:17.936935	0	2024-09-11 03:51:17.918313	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	195	86
870	2024-09-11 03:51:22.956921	2024-09-11 03:51:22.956929	0	2024-09-11 03:51:22.952517	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	195	87
871	2024-09-11 03:55:36.806945	2024-09-11 03:55:36.806954	0	2024-09-11 03:55:36.804118	2024-09-06	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	195	\N
872	2024-09-11 10:27:23.928825	2024-09-11 10:27:23.928832	0	2024-09-11 10:27:23.925184	2024-09-05	0.02	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	207.29	185	\N
873	2024-09-11 13:29:04.995461	2024-09-11 13:29:04.995478	0	2024-09-11 13:29:04.956121	2024-10-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	196	88
874	2024-09-11 13:29:11.774859	2024-09-11 13:29:11.774869	0	2024-09-11 13:29:11.768705	2024-10-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	103.65	196	89
875	2024-09-11 13:32:55.29011	2024-09-11 13:32:55.290125	0	2024-09-11 13:32:55.28542	2024-09-06	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	196	\N
876	2024-09-11 14:43:24.148111	2024-09-11 14:43:24.148125	0	2024-09-11 14:43:24.138156	2024-09-05	0.02	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	207.29	185	\N
877	2024-09-11 14:44:17.626109	2024-09-11 14:44:17.626134	0	2024-09-11 14:44:17.622409	2024-09-05	0.02	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	207.29	185	\N
878	2024-09-11 15:17:40.628097	2024-09-11 15:17:40.62811	0	2024-09-11 15:17:40.62532	2024-09-05	0.02	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	207.29	185	\N
879	2024-09-11 15:18:19.13884	2024-09-11 15:18:19.138856	0	2024-09-11 15:18:19.13653	2024-09-05	0.02	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	207.29	185	\N
880	2024-09-11 15:20:49.183162	2024-09-11 15:20:49.183171	0	2024-09-11 15:20:49.181437	2024-10-10	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	102.59	172	\N
881	2024-09-11 15:21:29.909328	2024-09-11 15:21:29.909352	0	2024-09-11 15:21:29.907286	2024-10-10	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	102.59	172	\N
882	2024-09-11 15:23:22.7395	2024-09-11 15:23:22.739513	0	2024-09-11 15:23:22.737777	2024-09-05	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	186	\N
883	2024-09-11 15:24:58.662769	2024-09-11 15:24:58.662791	0	2024-09-11 15:24:58.660724	2024-09-05	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	103.65	186	\N
884	2024-09-11 15:26:02.9732	2024-09-11 15:26:02.973226	0	2024-09-11 15:26:02.971281	2024-09-06	0.01	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	103.65	184	\N
885	2024-09-11 15:26:44.601397	2024-09-11 15:26:44.60141	0	2024-09-11 15:26:44.599571	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	184	\N
886	2024-09-11 15:28:11.850579	2024-09-11 15:28:11.850589	0	2024-09-11 15:28:11.824842	2024-09-06	0.00	0.00	2.21	2.07	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	184	90
887	2024-09-11 15:29:08.015834	2024-09-11 15:29:08.015842	0	2024-09-11 15:29:08.011916	2024-09-06	0.00	0.00	0.00	0.00	09-PAGAMENTO CADASTRO CANCELADO	ATIVO	103.65	184	91
888	2024-09-11 15:29:41.925912	2024-09-11 15:29:41.925923	0	2024-09-11 15:29:41.901076	2024-09-06	0.00	0.00	2.21	2.07	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	184	92
889	2024-09-11 15:30:29.475771	2024-09-11 15:30:29.475782	0	2024-09-11 15:30:29.45739	2024-09-06	0.00	0.00	2.21	2.07	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	184	93
890	2024-09-11 15:38:17.337483	2024-09-11 15:38:17.337497	0	2024-09-11 15:38:17.333707	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	187	\N
891	2024-09-11 15:38:30.905626	2024-09-11 15:38:30.905634	0	2024-09-11 15:38:30.904551	2024-09-06	0.01	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	103.65	187	\N
892	2024-09-11 15:44:20.901634	2024-09-11 15:44:20.901662	0	2024-09-11 15:44:20.870344	2024-09-06	0.01	0.00	0.00	0.00	29-REVERSAO PAGAMENTO POR FRAUDE CADASTRO	PENDENTE_REVERSAO_PAGAMENTO	103.65	187	94
893	2024-09-11 15:46:31.64475	2024-09-11 15:46:31.64476	0	2024-09-11 15:46:31.640827	2024-09-06	0.01	0.00	0.00	0.00	30-REVERSAO PAGAMENTO POR FRAUDE CADASTRO CONFIRMADO	REVERSAO_PAGAMENTO	103.65	187	95
894	2024-09-12 11:26:36.390073	2024-09-12 11:26:36.39012	0	2024-09-12 11:26:36.335167	2024-10-12	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	52.66	197	96
895	2024-09-12 11:26:36.397048	2024-09-12 11:26:36.397062	0	2024-09-12 11:26:36.335229	2024-11-11	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	52.66	198	96
896	2024-09-12 11:26:43.025063	2024-09-12 11:26:43.02507	0	2024-09-12 11:26:43.017088	2024-10-12	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	52.66	197	97
897	2024-09-12 11:26:43.026187	2024-09-12 11:26:43.026195	0	2024-09-12 11:26:43.017914	2024-11-11	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	52.66	198	97
898	2024-09-12 15:46:56.921742	2024-09-12 15:46:56.921774	0	2024-09-12 15:46:56.89511	2024-09-05	0.02	0.00	0.00	0.00	29-REVERSAO PAGAMENTO POR FRAUDE CADASTRO	PENDENTE_REVERSAO_PAGAMENTO	207.29	185	98
899	2024-09-12 15:47:52.318672	2024-09-12 15:47:52.318679	0	2024-09-12 15:47:52.314862	2024-09-05	0.02	0.00	0.00	0.00	30-REVERSAO PAGAMENTO POR FRAUDE CADASTRO CONFIRMADO	REVERSAO_PAGAMENTO	207.29	185	99
900	2024-09-13 14:39:51.194266	2024-09-13 14:39:51.194291	0	2024-09-13 14:39:51.182555	2024-09-06	0.01	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	56.43	188	100
901	2024-09-13 14:40:12.046299	2024-09-13 14:40:12.046306	0	2024-09-13 14:40:12.042249	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	136.43	188	101
902	2024-09-13 14:41:12.623487	2024-09-13 14:41:12.6235	0	2024-09-13 14:41:12.602769	2024-09-06	0.00	0.00	0.95	0.63	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	188	102
903	2024-09-13 14:41:25.069963	2024-09-13 14:41:25.069998	0	2024-09-13 14:41:25.039396	2024-09-06	0.00	0.00	0.95	0.63	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	188	103
904	2024-09-13 14:45:44.518404	2024-09-13 14:45:44.518413	0	2024-09-13 14:45:44.512778	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	117.00	189	104
905	2024-09-13 15:47:32.520758	2024-09-13 15:47:32.520765	0	2024-09-13 15:47:32.511316	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	117.00	189	105
906	2024-09-13 15:58:40.407425	2024-09-13 15:58:40.407463	0	2024-09-13 15:58:40.396378	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	117.00	189	106
907	2024-09-13 16:02:52.47599	2024-09-13 16:02:52.475998	0	2024-09-13 16:02:52.469619	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	189	\N
908	2024-09-13 16:09:27.495043	2024-09-13 16:09:27.495049	0	2024-09-13 16:09:27.490448	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	103.65	189	\N
909	2024-09-13 17:10:45.405565	2024-09-13 17:10:45.405589	0	2024-09-13 17:10:45.378315	2024-09-06	0.01	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	117.00	189	107
910	2024-09-25 02:18:20.511287	2024-09-25 02:18:20.511294	0	2024-09-25 02:18:20.455613	2024-09-05	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	103.65	186	108
913	2024-09-25 11:06:15.872298	2024-09-25 11:06:15.872318	0	2024-09-25 11:06:15.854792	2024-09-05	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	103.65	186	111
914	2024-09-25 11:32:12.575898	2024-09-25 11:32:12.575902	0	2024-09-25 11:32:12.539682	2024-09-06	0.00	0.00	8.66	2.13	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	196	112
915	2024-09-25 11:35:01.711731	2024-09-25 11:35:01.71174	0	2024-09-25 11:35:01.701456	2024-09-06	0.00	0.00	8.66	2.13	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	196	113
916	2024-09-25 11:39:37.456481	2024-09-25 11:39:37.456489	0	2024-09-25 11:39:37.441822	2024-09-06	0.00	0.00	8.66	2.13	10-PAGAMENTO CADASTRO ESTORNO	PENDENTE_ESTORNO_PAGAMENTO	103.65	196	114
917	2024-09-25 11:40:48.422329	2024-09-25 11:40:48.42234	0	2024-09-25 11:40:48.413004	2024-09-06	0.00	0.00	8.66	2.13	11-PAGAMENTO CADASTRO ESTORNO CONFIRMADO	ATIVO	103.65	196	115
918	2024-09-25 13:28:27.144023	2024-09-25 13:28:27.144039	0	2024-09-25 13:28:27.094623	2024-09-06	0.00	0.00	8.66	2.13	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	196	116
919	2024-09-25 13:28:37.584238	2024-09-25 13:28:37.584249	0	2024-09-25 13:28:37.568387	2024-09-06	0.00	0.00	8.66	2.13	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	196	117
920	2024-09-25 13:29:55.851809	2024-09-25 13:29:55.851819	0	2024-09-25 13:29:55.829575	2024-09-06	0.00	0.00	8.66	2.13	10-PAGAMENTO CADASTRO ESTORNO	PENDENTE_ESTORNO_PAGAMENTO	103.65	196	118
921	2024-09-25 17:57:45.183779	2024-09-25 17:57:45.183789	0	2024-09-25 17:57:45.17081	2024-09-06	0.00	0.00	8.66	2.13	11-PAGAMENTO CADASTRO ESTORNO CONFIRMADO	ATIVO	103.65	196	119
922	2024-09-25 18:55:23.187519	2024-09-25 18:55:23.187531	0	2024-09-25 18:55:23.1583	2024-10-25	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	107.00	199	120
923	2024-09-25 18:55:23.193175	2024-09-25 18:55:23.193189	0	2024-09-25 18:55:23.158352	2024-11-24	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	107.00	200	120
924	2024-09-25 18:55:23.198507	2024-09-25 18:55:23.198519	0	2024-09-25 18:55:23.158442	2024-12-24	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	107.00	201	120
925	2024-09-25 18:55:48.694509	2024-09-25 18:55:48.694519	0	2024-09-25 18:55:48.686855	2024-10-25	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	107.00	199	121
926	2024-09-25 18:55:48.696499	2024-09-25 18:55:48.696508	0	2024-09-25 18:55:48.686873	2024-11-24	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	107.00	200	121
927	2024-09-25 18:55:48.697999	2024-09-25 18:55:48.698006	0	2024-09-25 18:55:48.686879	2024-12-24	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	107.00	201	121
928	2024-09-25 19:19:33.822776	2024-09-25 19:19:33.822787	0	2024-09-25 19:19:33.809518	2024-10-25	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	0.05	199	122
929	2024-09-25 19:21:07.923086	2024-09-25 19:21:07.923095	0	2024-09-25 19:21:07.916256	2024-10-25	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	4.95	199	123
930	2024-09-25 19:33:27.387607	2024-09-25 19:33:27.387615	0	2024-09-25 19:33:27.362789	2024-09-14	0.00	0.00	5.40	2.30	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	107.00	200	124
931	2024-09-25 19:33:48.573767	2024-09-25 19:33:48.573775	0	2024-09-25 19:33:48.564434	2024-09-14	0.00	0.00	5.40	2.30	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	107.00	200	125
932	2024-09-25 19:37:45.238814	2024-09-25 19:37:45.238824	0	2024-09-25 19:37:45.226829	2024-09-14	0.00	0.00	5.40	2.30	10-PAGAMENTO CADASTRO ESTORNO	PENDENTE_ESTORNO_PAGAMENTO	107.00	200	126
933	2024-09-25 19:38:25.858663	2024-09-25 19:38:25.858671	0	2024-09-25 19:38:25.84941	2024-09-14	0.00	0.00	5.40	2.30	11-PAGAMENTO CADASTRO ESTORNO CONFIRMADO	ATIVO	107.00	200	127
934	2024-09-27 14:01:37.100075	2024-09-27 14:01:37.1001	0	2024-09-27 14:01:37.077834	2024-08-25	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	107.00	199	\N
935	2024-09-27 14:02:19.856221	2024-09-27 14:02:19.856236	0	2024-09-27 14:02:19.854079	2024-09-06	0.01	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	189	\N
936	2024-09-27 14:02:33.832541	2024-09-27 14:02:33.832546	0	2024-09-27 14:02:33.831713	2024-09-06	0.01	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	190	\N
937	2024-09-27 14:02:52.613742	2024-09-27 14:02:52.613754	0	2024-09-27 14:02:52.611682	2024-09-06	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	191	\N
938	2024-09-27 14:03:07.358019	2024-09-27 14:03:07.358035	0	2024-09-27 14:03:07.356164	2024-09-06	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	192	\N
939	2024-09-27 14:03:42.962915	2024-09-27 14:03:42.962921	0	2024-09-27 14:03:42.961713	2024-09-06	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	193	\N
940	2024-09-27 14:03:55.007904	2024-09-27 14:03:55.007916	0	2024-09-27 14:03:55.006213	2024-09-06	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	194	\N
941	2024-09-27 14:04:05.666885	2024-09-27 14:04:05.666891	0	2024-09-27 14:04:05.665634	2024-09-06	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	195	\N
942	2024-09-27 14:04:16.758475	2024-09-27 14:04:16.758496	0	2024-09-27 14:04:16.756238	2024-09-06	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	103.65	196	\N
943	2024-09-27 14:04:27.43103	2024-09-27 14:04:27.43104	0	2024-09-27 14:04:27.429683	2024-09-14	0.00	0.00	0.00	0.00	28-ALTERACAO VENCIMENTO	ATIVO	107.00	200	\N
944	2024-09-27 14:06:50.38555	2024-09-27 14:06:50.385574	0	2024-09-27 14:06:50.340657	2024-10-27	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	202	128
945	2024-09-27 14:06:50.394938	2024-09-27 14:06:50.394956	0	2024-09-27 14:06:50.340757	2024-11-26	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	203	128
946	2024-09-27 14:06:50.402603	2024-09-27 14:06:50.402643	0	2024-09-27 14:06:50.34085	2024-12-26	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	204	128
947	2024-09-27 14:06:50.407832	2024-09-27 14:06:50.407844	0	2024-09-27 14:06:50.340936	2025-01-25	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	205	128
948	2024-09-27 14:08:20.969458	2024-09-27 14:08:20.969497	0	2024-09-27 14:08:20.950208	2024-10-27	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	202	129
949	2024-09-27 14:08:20.973779	2024-09-27 14:08:20.973799	0	2024-09-27 14:08:20.950233	2024-11-26	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	203	129
950	2024-09-27 14:08:20.975967	2024-09-27 14:08:20.975984	0	2024-09-27 14:08:20.95024	2024-12-26	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	204	129
951	2024-09-27 14:08:20.978642	2024-09-27 14:08:20.978657	0	2024-09-27 14:08:20.950246	2025-01-25	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	205	129
952	2024-09-27 14:28:03.131882	2024-09-27 14:28:03.131891	0	2024-09-27 14:28:03.1084	2024-08-27	0.00	0.00	6.45	0.98	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	202	130
953	2024-09-27 14:29:26.194961	2024-09-27 14:29:26.194966	0	2024-09-27 14:29:26.187184	2024-08-27	0.00	0.00	6.45	0.98	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	202	131
954	2024-09-27 14:32:45.115094	2024-09-27 14:32:45.115103	0	2024-09-27 14:32:45.097666	2024-08-27	0.00	0.00	6.45	0.98	10-PAGAMENTO CADASTRO ESTORNO	PENDENTE_ESTORNO_PAGAMENTO	40.76	202	132
955	2024-09-27 14:33:38.870614	2024-09-27 14:33:38.870622	0	2024-09-27 14:33:38.862591	2024-08-27	0.00	0.00	6.45	0.98	11-PAGAMENTO CADASTRO ESTORNO CONFIRMADO	ATIVO	40.76	202	133
956	2024-09-27 14:45:31.69503	2024-09-27 14:45:31.695039	0	2024-09-27 14:45:31.656735	2024-08-27	0.00	0.00	6.45	0.98	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	202	134
957	2024-09-27 14:45:31.696144	2024-09-27 14:45:31.69615	0	2024-09-27 14:45:31.656767	2024-11-26	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	203	134
958	2024-09-27 14:45:31.697103	2024-09-27 14:45:31.69711	0	2024-09-27 14:45:31.656793	2024-12-26	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	204	134
959	2024-09-27 14:45:31.697999	2024-09-27 14:45:31.698005	0	2024-09-27 14:45:31.656818	2025-01-25	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	205	134
960	2024-09-27 14:45:41.33167	2024-09-27 14:45:41.33168	0	2024-09-27 14:45:41.317299	2024-08-27	0.00	0.00	6.45	0.98	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	202	135
961	2024-09-27 14:45:41.333679	2024-09-27 14:45:41.33369	0	2024-09-27 14:45:41.320251	2024-11-26	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	203	135
962	2024-09-27 14:45:41.335621	2024-09-27 14:45:41.335632	0	2024-09-27 14:45:41.321064	2024-12-26	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	204	135
963	2024-09-27 14:45:41.337406	2024-09-27 14:45:41.337416	0	2024-09-27 14:45:41.321824	2025-01-25	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	205	135
964	2024-09-27 14:52:56.195139	2024-09-27 14:52:56.195148	0	2024-09-27 14:52:56.17585	2024-10-27	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	206	136
965	2024-09-27 14:52:56.199852	2024-09-27 14:52:56.199863	0	2024-09-27 14:52:56.175939	2024-11-26	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	207	136
966	2024-09-27 14:52:56.204528	2024-09-27 14:52:56.204537	0	2024-09-27 14:52:56.176012	2024-12-26	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	208	136
967	2024-09-27 14:52:56.208933	2024-09-27 14:52:56.208945	0	2024-09-27 14:52:56.176083	2025-01-25	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	209	136
968	2024-09-27 14:53:33.72443	2024-09-27 14:53:33.724437	0	2024-09-27 14:53:33.71529	2024-10-27	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	206	137
969	2024-09-27 14:53:33.726802	2024-09-27 14:53:33.726814	0	2024-09-27 14:53:33.715308	2024-11-26	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	207	137
970	2024-09-27 14:53:33.728608	2024-09-27 14:53:33.728617	0	2024-09-27 14:53:33.715315	2024-12-26	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	208	137
971	2024-09-27 14:53:33.730341	2024-09-27 14:53:33.730351	0	2024-09-27 14:53:33.715321	2025-01-25	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	209	137
972	2024-09-27 15:26:01.013785	2024-09-27 15:26:01.013793	0	2024-09-27 15:26:00.986694	2024-08-25	0.00	0.00	6.87	0.98	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	209	138
973	2024-09-27 15:26:15.581498	2024-09-27 15:26:15.581507	0	2024-09-27 15:26:15.572435	2024-08-25	0.00	0.00	6.87	0.98	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	209	139
974	2024-09-27 15:30:45.873729	2024-09-27 15:30:45.873744	0	2024-09-27 15:30:45.846666	2024-08-25	0.00	0.00	6.87	0.98	10-PAGAMENTO CADASTRO ESTORNO	PENDENTE_ESTORNO_PAGAMENTO	40.76	209	140
975	2024-09-27 15:31:03.222091	2024-09-27 15:31:03.2221	0	2024-09-27 15:31:03.206957	2024-08-25	0.00	0.00	6.87	0.98	11-PAGAMENTO CADASTRO ESTORNO CONFIRMADO	ATIVO	40.76	209	141
976	2024-09-27 15:40:23.953517	2024-09-27 15:40:23.953524	0	2024-09-27 15:40:23.942433	2024-08-25	0.00	0.00	6.87	0.98	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	209	142
977	2024-09-27 15:42:44.298565	2024-09-27 15:42:44.298577	0	2024-09-27 15:42:44.288345	2024-08-25	0.00	0.00	6.87	0.98	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	209	143
978	2024-09-27 15:56:48.124575	2024-09-27 15:56:48.124592	0	2024-09-27 15:56:48.048106	2024-10-27	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	206	144
979	2024-09-27 15:56:48.126643	2024-09-27 15:56:48.126651	0	2024-09-27 15:56:48.04819	2024-11-26	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	207	144
980	2024-09-27 15:56:48.128071	2024-09-27 15:56:48.128078	0	2024-09-27 15:56:48.048218	2024-12-26	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	208	144
981	2024-09-27 15:56:59.577839	2024-09-27 15:56:59.577847	0	2024-09-27 15:56:59.560029	2024-10-27	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	206	145
982	2024-09-27 15:56:59.579331	2024-09-27 15:56:59.579338	0	2024-09-27 15:56:59.5653	2024-11-26	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	207	145
983	2024-09-27 15:56:59.580523	2024-09-27 15:56:59.580529	0	2024-09-27 15:56:59.566462	2024-12-26	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	208	145
984	2024-09-27 15:59:20.439401	2024-09-27 15:59:20.439415	0	2024-09-27 15:59:20.415701	2024-10-27	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	210	146
985	2024-09-27 15:59:20.442097	2024-09-27 15:59:20.442108	0	2024-09-27 15:59:20.415825	2024-11-26	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	211	146
986	2024-09-27 15:59:20.444284	2024-09-27 15:59:20.444294	0	2024-09-27 15:59:20.415888	2024-12-26	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	212	146
987	2024-09-27 15:59:20.447076	2024-09-27 15:59:20.447096	0	2024-09-27 15:59:20.415943	2025-01-25	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	213	146
988	2024-09-27 15:59:27.018009	2024-09-27 15:59:27.018017	0	2024-09-27 15:59:27.002301	2024-10-27	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	210	147
989	2024-09-27 15:59:27.019913	2024-09-27 15:59:27.019921	0	2024-09-27 15:59:27.003127	2024-11-26	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	211	147
990	2024-09-27 15:59:27.021394	2024-09-27 15:59:27.021401	0	2024-09-27 15:59:27.003145	2024-12-26	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	212	147
991	2024-09-27 15:59:27.022556	2024-09-27 15:59:27.022562	0	2024-09-27 15:59:27.003154	2025-01-25	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	213	147
992	2024-09-27 16:05:56.234189	2024-09-27 16:05:56.234205	0	2024-09-27 16:05:56.226575	2024-10-27	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	5.00	210	148
993	2024-09-27 16:06:54.712144	2024-09-27 16:06:54.712155	0	2024-09-27 16:06:54.704071	2024-10-27	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	5.00	210	149
994	2024-09-27 16:12:18.184944	2024-09-27 16:12:18.184948	0	2024-09-27 16:12:18.173514	2024-08-25	0.00	0.00	6.87	0.98	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	210	150
995	2024-09-27 16:12:27.323327	2024-09-27 16:12:27.323334	0	2024-09-27 16:12:27.315906	2024-08-25	0.00	0.00	6.87	0.98	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	210	151
996	2024-09-27 16:18:05.312251	2024-09-27 16:18:05.312262	0	2024-09-27 16:18:05.287824	2024-08-25	0.00	0.00	6.87	0.98	10-PAGAMENTO CADASTRO ESTORNO	PENDENTE_ESTORNO_PAGAMENTO	40.76	210	152
997	2024-09-27 16:18:14.775756	2024-09-27 16:18:14.775766	0	2024-09-27 16:18:14.767043	2024-08-25	0.00	0.00	6.87	0.98	11-PAGAMENTO CADASTRO ESTORNO CONFIRMADO	ATIVO	40.76	210	153
998	2024-09-30 09:25:25.69159	2024-09-30 09:25:25.691718	0	2024-09-30 09:25:25.649794	2024-08-25	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	57.24	210	154
999	2024-09-30 09:25:25.707135	2024-09-30 09:25:25.707145	0	2024-09-30 09:25:25.670755	2024-08-25	0.00	0.00	7.50	0.98	38-PAGAMENTO AJUSTE	PAGO	57.24	210	155
1000	2024-10-10 14:33:57.114581	2024-10-10 14:33:57.11459	0	2024-10-10 14:33:56.885572	2024-10-06	0.00	0.00	-0.09	-0.11	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	189	156
1001	2024-10-10 14:33:57.117124	2024-10-10 14:33:57.117132	0	2024-10-10 14:33:56.885639	2024-10-10	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	172	156
1002	2024-10-10 14:33:57.118189	2024-10-10 14:33:57.118196	0	2024-10-10 14:33:56.885655	2024-10-12	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	52.66	197	156
1003	2024-10-10 14:33:57.119212	2024-10-10 14:33:57.119218	0	2024-10-10 14:33:56.885669	2024-10-25	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	107.00	199	156
1004	2024-10-10 14:33:57.120153	2024-10-10 14:33:57.12016	0	2024-10-10 14:33:56.88568	2024-10-25	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	193	156
1005	2024-10-10 14:33:57.121097	2024-10-10 14:33:57.121102	0	2024-10-10 14:33:56.88569	2024-11-06	0.01	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	190	156
1006	2024-10-10 14:33:57.122132	2024-10-10 14:33:57.122139	0	2024-10-10 14:33:56.885704	2024-11-09	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	173	156
1007	2024-10-10 14:33:57.123246	2024-10-10 14:33:57.123254	0	2024-10-10 14:33:56.885714	2024-11-11	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	52.66	198	156
1008	2024-10-10 14:33:57.124454	2024-10-10 14:33:57.124461	0	2024-10-10 14:33:56.885726	2024-11-14	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	192	156
1009	2024-10-10 14:33:57.12546	2024-10-10 14:33:57.125465	0	2024-10-10 14:33:56.885736	2024-11-22	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	194	156
1010	2024-10-10 14:33:57.126351	2024-10-10 14:33:57.126357	0	2024-10-10 14:33:56.885758	2024-11-26	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	211	156
1011	2024-10-10 14:33:57.127133	2024-10-10 14:33:57.127138	0	2024-10-10 14:33:56.885769	2024-11-27	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	196	156
1012	2024-10-10 14:33:57.127952	2024-10-10 14:33:57.127957	0	2024-10-10 14:33:56.88578	2024-12-06	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	191	156
1013	2024-10-10 14:33:57.128824	2024-10-10 14:33:57.128829	0	2024-10-10 14:33:56.885792	2024-12-09	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	174	156
1014	2024-10-10 14:33:57.129703	2024-10-10 14:33:57.129709	0	2024-10-10 14:33:56.885803	2024-12-20	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	103.65	195	156
1015	2024-10-10 14:33:57.130559	2024-10-10 14:33:57.130565	0	2024-10-10 14:33:56.885816	2024-12-24	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	107.00	201	156
1016	2024-10-10 14:33:57.131356	2024-10-10 14:33:57.131361	0	2024-10-10 14:33:56.885827	2024-12-26	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	212	156
1017	2024-10-10 14:33:57.132296	2024-10-10 14:33:57.132303	0	2024-10-10 14:33:56.885839	2025-01-08	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	175	156
1018	2024-10-10 14:33:57.133058	2024-10-10 14:33:57.133065	0	2024-10-10 14:33:56.885851	2025-01-14	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	107.00	200	156
1019	2024-10-10 14:33:57.133778	2024-10-10 14:33:57.133783	0	2024-10-10 14:33:56.885863	2025-01-25	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	213	156
1020	2024-10-10 14:33:57.13478	2024-10-10 14:33:57.134787	0	2024-10-10 14:33:56.885876	2025-02-07	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	176	156
1021	2024-10-10 14:33:57.135716	2024-10-10 14:33:57.135722	0	2024-10-10 14:33:56.885889	2025-03-09	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	177	156
1022	2024-10-10 14:33:57.136557	2024-10-10 14:33:57.136563	0	2024-10-10 14:33:56.885902	2025-04-08	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	178	156
1023	2024-10-10 14:33:57.137643	2024-10-10 14:33:57.137657	0	2024-10-10 14:33:56.885915	2025-05-08	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	179	156
1024	2024-10-10 14:33:57.138548	2024-10-10 14:33:57.138555	0	2024-10-10 14:33:56.885933	2025-06-07	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	180	156
1025	2024-10-10 14:33:57.139475	2024-10-10 14:33:57.139483	0	2024-10-10 14:33:56.885948	2025-07-07	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	181	156
1026	2024-10-10 14:33:57.140314	2024-10-10 14:33:57.14032	0	2024-10-10 14:33:56.885962	2025-08-06	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	182	156
1027	2024-10-10 14:33:57.141231	2024-10-10 14:33:57.141238	0	2024-10-10 14:33:56.885976	2025-09-05	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	102.59	183	156
1028	2024-10-10 14:34:21.962482	2024-10-10 14:34:21.962487	0	2024-10-10 14:34:21.86521	2024-10-12	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	52.66	197	157
1029	2024-10-10 14:34:21.963418	2024-10-10 14:34:21.963425	0	2024-10-10 14:34:21.915328	2024-11-11	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	52.66	198	157
1030	2024-10-10 14:34:21.964425	2024-10-10 14:34:21.964431	0	2024-10-10 14:34:21.883101	2024-10-25	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	107.00	199	157
1031	2024-10-10 14:34:21.965478	2024-10-10 14:34:21.965483	0	2024-10-10 14:34:21.937206	2025-01-14	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	107.00	200	157
1032	2024-10-10 14:34:21.966415	2024-10-10 14:34:21.966419	0	2024-10-10 14:34:21.935172	2024-12-24	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	107.00	201	157
1033	2024-10-10 14:34:21.967309	2024-10-10 14:34:21.967314	0	2024-10-10 14:34:21.892871	2024-10-25	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	193	157
1034	2024-10-10 14:34:21.968184	2024-10-10 14:34:21.968189	0	2024-10-10 14:34:21.903845	2024-11-06	0.01	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	190	157
1035	2024-10-10 14:34:21.969067	2024-10-10 14:34:21.969072	0	2024-10-10 14:34:21.909831	2024-11-09	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	173	157
1036	2024-10-10 14:34:21.969904	2024-10-10 14:34:21.969909	0	2024-10-10 14:34:21.932148	2024-10-10	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	172	157
1037	2024-10-10 14:34:21.970962	2024-10-10 14:34:21.970969	0	2024-10-10 14:34:21.929329	2024-12-09	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	174	157
1038	2024-10-10 14:34:21.972006	2024-10-10 14:34:21.972011	0	2024-10-10 14:34:21.936662	2025-01-08	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	175	157
1039	2024-10-10 14:34:21.972952	2024-10-10 14:34:21.972959	0	2024-10-10 14:34:21.938229	2025-02-07	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	176	157
1040	2024-10-10 14:34:21.973926	2024-10-10 14:34:21.973947	0	2024-10-10 14:34:21.938714	2025-03-09	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	177	157
1041	2024-10-10 14:34:21.974866	2024-10-10 14:34:21.97487	0	2024-10-10 14:34:21.939172	2025-04-08	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	178	157
1042	2024-10-10 14:34:21.975842	2024-10-10 14:34:21.975846	0	2024-10-10 14:34:21.939607	2025-05-08	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	179	157
1043	2024-10-10 14:34:21.976813	2024-10-10 14:34:21.976818	0	2024-10-10 14:34:21.940083	2025-06-07	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	180	157
1044	2024-10-10 14:34:21.97778	2024-10-10 14:34:21.977785	0	2024-10-10 14:34:21.940755	2025-07-07	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	181	157
1045	2024-10-10 14:34:21.978686	2024-10-10 14:34:21.97869	0	2024-10-10 14:34:21.941266	2025-08-06	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	182	157
1046	2024-10-10 14:34:21.979637	2024-10-10 14:34:21.979642	0	2024-10-10 14:34:21.941845	2025-09-05	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	102.59	183	157
1047	2024-10-10 14:34:21.980588	2024-10-10 14:34:21.980592	0	2024-10-10 14:34:21.916762	2024-11-14	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	192	157
1048	2024-10-10 14:34:21.981588	2024-10-10 14:34:21.981593	0	2024-10-10 14:34:21.919231	2024-11-22	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	194	157
1049	2024-10-10 14:34:21.982594	2024-10-10 14:34:21.982598	0	2024-10-10 14:34:21.92166	2024-11-26	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	211	157
1050	2024-10-10 14:34:21.983707	2024-10-10 14:34:21.983713	0	2024-10-10 14:34:21.936068	2024-12-26	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	212	157
1051	2024-10-10 14:34:21.984772	2024-10-10 14:34:21.984776	0	2024-10-10 14:34:21.93776	2025-01-25	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	213	157
1052	2024-10-10 14:34:21.985814	2024-10-10 14:34:21.985819	0	2024-10-10 14:34:21.924581	2024-11-27	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	196	157
1053	2024-10-10 14:34:21.986674	2024-10-10 14:34:21.986687	0	2024-10-10 14:34:21.927487	2024-12-06	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	191	157
1054	2024-10-10 14:34:21.987574	2024-10-10 14:34:21.987586	0	2024-10-10 14:34:21.930567	2024-10-06	0.00	0.00	-0.09	-0.11	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	189	157
1055	2024-10-10 14:34:21.988562	2024-10-10 14:34:21.988567	0	2024-10-10 14:34:21.933575	2024-12-20	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	103.65	195	157
1056	2024-10-10 15:05:11.360037	2024-10-10 15:05:11.360052	0	2024-10-10 15:05:11.329109	2024-11-09	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	155.47	214	158
1057	2024-10-10 15:05:30.81831	2024-10-10 15:05:30.818316	0	2024-10-10 15:05:30.814309	2024-11-09	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	155.47	214	159
1058	2024-10-10 16:54:30.492147	2024-10-10 16:54:30.492161	0	2024-10-10 16:54:30.44643	2024-11-09	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	155.47	215	160
1059	2024-10-10 17:27:44.967514	2024-10-10 17:27:44.967524	0	2024-10-10 17:27:44.931265	2024-11-09	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	518.23	216	161
1060	2024-10-10 17:28:03.572356	2024-10-10 17:28:03.572365	0	2024-10-10 17:28:03.560168	2024-11-09	0.00	0.00	0.00	0.00	03-VENDA CADASTRO CANCELADO	CANCELADO	518.23	216	162
1061	2024-10-10 17:28:06.529982	2024-10-10 17:28:06.530006	0	2024-10-10 17:28:06.519893	2024-11-09	0.00	0.00	0.00	0.00	03-VENDA CADASTRO CANCELADO	CANCELADO	155.47	215	163
1062	2024-10-11 16:47:11.214755	2024-10-11 16:47:11.214763	0	2024-10-11 16:47:11.166621	2024-11-10	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	103.65	217	164
1063	2024-10-11 16:47:17.575643	2024-10-11 16:47:17.575662	0	2024-10-11 16:47:17.56803	2024-11-10	0.00	0.00	0.00	0.00	03-VENDA CADASTRO CANCELADO	CANCELADO	103.65	217	165
1064	2024-10-16 08:58:32.208581	2024-10-16 08:58:32.208604	0	2024-10-16 08:58:32.190349	2024-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	57.24	214	166
1065	2024-10-16 09:03:50.968267	2024-10-16 09:03:50.968284	0	2024-10-16 09:03:50.961749	2024-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	57.24	214	167
1066	2024-10-16 09:05:03.878007	2024-10-16 09:05:03.878012	0	2024-10-16 09:05:03.874079	2024-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	2.00	214	168
1067	2024-10-16 09:05:25.162781	2024-10-16 09:05:25.162787	0	2024-10-16 09:05:25.158678	2024-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	2.00	214	169
1068	2024-10-16 09:05:35.586743	2024-10-16 09:05:35.586753	0	2024-10-16 09:05:35.58021	2024-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	25.00	214	170
1069	2024-10-16 09:06:29.490299	2024-10-16 09:06:29.490306	0	2024-10-16 09:06:29.487187	2024-11-09	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	25.00	214	171
1070	2024-10-16 09:06:33.94597	2024-10-16 09:06:33.945979	0	2024-10-16 09:06:33.9368	2024-11-09	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	25.00	214	172
1071	2024-10-16 09:06:35.356548	2024-10-16 09:06:35.356557	0	2024-10-16 09:06:35.350013	2024-11-09	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	25.00	214	173
1072	2024-10-16 09:06:36.499628	2024-10-16 09:06:36.499635	0	2024-10-16 09:06:36.495876	2024-11-09	0.00	0.00	0.00	0.00	37-LANCAMENTO AJUSTE DEBITO	ATIVO	25.00	214	174
1073	2024-10-16 09:06:41.944198	2024-10-16 09:06:41.944212	0	2024-10-16 09:06:41.937268	2024-11-09	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	25.00	214	175
1074	2024-10-17 20:39:34.69612	2024-10-17 20:39:34.696132	0	2024-10-17 20:39:34.61796	2024-11-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	218	176
1075	2024-10-17 20:39:34.701099	2024-10-17 20:39:34.701108	0	2024-10-17 20:39:34.618025	2024-12-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	219	176
1076	2024-10-17 20:39:34.704581	2024-10-17 20:39:34.704596	0	2024-10-17 20:39:34.618074	2025-01-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	220	176
1077	2024-10-17 20:39:34.708753	2024-10-17 20:39:34.708762	0	2024-10-17 20:39:34.618122	2025-02-14	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.76	221	176
1078	2024-10-17 20:39:46.312158	2024-10-17 20:39:46.312166	0	2024-10-17 20:39:46.291747	2024-11-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	218	177
1079	2024-10-17 20:39:46.314364	2024-10-17 20:39:46.314372	0	2024-10-17 20:39:46.294078	2024-12-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	219	177
1080	2024-10-17 20:39:46.315705	2024-10-17 20:39:46.315713	0	2024-10-17 20:39:46.294115	2025-01-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	220	177
1081	2024-10-17 20:39:46.316741	2024-10-17 20:39:46.316746	0	2024-10-17 20:39:46.294131	2025-02-14	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.76	221	177
1082	2024-10-17 20:54:10.788288	2024-10-17 20:54:10.788303	0	2024-10-17 20:54:10.761449	2024-11-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	28.05	222	178
1083	2024-10-17 20:54:10.793053	2024-10-17 20:54:10.793065	0	2024-10-17 20:54:10.761516	2024-12-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	28.05	223	178
1084	2024-10-17 20:54:10.796725	2024-10-17 20:54:10.796737	0	2024-10-17 20:54:10.76157	2025-01-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	28.05	224	178
1085	2024-10-17 20:54:10.803612	2024-10-17 20:54:10.803632	0	2024-10-17 20:54:10.761624	2025-02-14	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	28.05	225	178
1086	2024-10-17 20:54:10.810468	2024-10-17 20:54:10.810484	0	2024-10-17 20:54:10.761679	2025-03-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	28.05	226	178
1087	2024-10-17 20:54:10.818334	2024-10-17 20:54:10.818356	0	2024-10-17 20:54:10.761731	2025-04-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	28.05	227	178
1088	2024-10-17 20:54:24.599479	2024-10-17 20:54:24.599486	0	2024-10-17 20:54:24.587346	2024-11-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	28.05	222	179
1089	2024-10-17 20:54:24.600895	2024-10-17 20:54:24.600901	0	2024-10-17 20:54:24.587377	2024-12-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	28.05	223	179
1090	2024-10-17 20:54:24.602135	2024-10-17 20:54:24.602142	0	2024-10-17 20:54:24.587386	2025-01-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	28.05	224	179
1091	2024-10-17 20:54:24.603304	2024-10-17 20:54:24.60331	0	2024-10-17 20:54:24.587394	2025-02-14	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	28.05	225	179
1092	2024-10-17 20:54:24.604385	2024-10-17 20:54:24.604391	0	2024-10-17 20:54:24.587401	2025-03-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	28.05	226	179
1093	2024-10-17 20:54:24.605364	2024-10-17 20:54:24.605369	0	2024-10-17 20:54:24.587408	2025-04-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	28.05	227	179
1099	2024-10-17 20:54:51.206554	2024-10-17 20:54:51.206567	0	2024-10-17 20:54:51.191111	2024-11-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	110.43	228	181
1100	2024-10-17 20:54:51.208443	2024-10-17 20:54:51.208451	0	2024-10-17 20:54:51.191209	2024-12-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	110.43	229	181
1101	2024-10-17 20:54:51.209895	2024-10-17 20:54:51.20991	0	2024-10-17 20:54:51.191214	2025-01-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	110.43	230	181
1102	2024-10-17 20:54:51.211039	2024-10-17 20:54:51.211046	0	2024-10-17 20:54:51.191216	2025-02-14	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	110.43	231	181
1103	2024-10-17 20:54:51.212121	2024-10-17 20:54:51.212128	0	2024-10-17 20:54:51.191218	2025-03-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	110.43	232	181
1094	2024-10-17 20:54:47.590162	2024-10-17 20:54:47.590176	0	2024-10-17 20:54:47.568028	2024-11-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	110.43	228	180
1095	2024-10-17 20:54:47.59619	2024-10-17 20:54:47.5962	0	2024-10-17 20:54:47.568104	2024-12-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	110.43	229	180
1096	2024-10-17 20:54:47.600449	2024-10-17 20:54:47.600458	0	2024-10-17 20:54:47.568164	2025-01-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	110.43	230	180
1097	2024-10-17 20:54:47.604157	2024-10-17 20:54:47.604167	0	2024-10-17 20:54:47.568224	2025-02-14	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	110.43	231	180
1098	2024-10-17 20:54:47.607057	2024-10-17 20:54:47.607066	0	2024-10-17 20:54:47.568306	2025-03-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	110.43	232	180
1105	2024-10-31 12:02:20.903416	2024-10-31 12:02:20.903428	0	2024-10-31 12:02:20.885219	2025-03-16	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	2.00	232	183
1106	2024-10-31 12:24:28.835358	2024-10-31 12:24:28.835384	0	2024-10-31 12:24:28.806226	2025-03-16	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	ATIVO	2.00	232	184
1107	2024-11-25 11:32:03.037318	2024-11-25 11:32:03.037339	0	2024-11-25 11:32:02.965107	2024-12-25	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	93.48	234	185
1108	2024-11-25 11:32:03.048582	2024-11-25 11:32:03.048603	0	2024-11-25 11:32:02.96519	2025-01-24	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	93.48	235	185
1109	2024-11-25 11:32:03.057247	2024-11-25 11:32:03.057278	0	2024-11-25 11:32:02.965241	2025-02-23	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	93.48	236	185
1110	2024-11-25 11:32:03.065265	2024-11-25 11:32:03.06529	0	2024-11-25 11:32:02.965281	2025-03-25	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	93.48	237	185
1111	2024-11-25 11:32:03.073905	2024-11-25 11:32:03.073943	0	2024-11-25 11:32:02.965332	2025-04-24	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	93.48	238	185
1112	2024-11-25 11:32:03.081374	2024-11-25 11:32:03.08139	0	2024-11-25 11:32:02.965393	2025-05-24	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	93.48	239	185
1113	2024-11-25 11:32:42.3473	2024-11-25 11:32:42.347315	0	2024-11-25 11:32:42.323739	2024-12-25	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	93.48	234	186
1114	2024-11-25 11:32:42.349623	2024-11-25 11:32:42.349644	0	2024-11-25 11:32:42.32841	2025-01-24	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	93.48	235	186
1115	2024-11-25 11:32:42.351609	2024-11-25 11:32:42.351617	0	2024-11-25 11:32:42.328439	2025-02-23	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	93.48	236	186
1116	2024-11-25 11:32:42.353164	2024-11-25 11:32:42.353171	0	2024-11-25 11:32:42.328449	2025-03-25	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	93.48	237	186
1117	2024-11-25 11:32:42.355522	2024-11-25 11:32:42.35554	0	2024-11-25 11:32:42.328456	2025-04-24	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	93.48	238	186
1118	2024-11-25 11:32:42.357563	2024-11-25 11:32:42.357574	0	2024-11-25 11:32:42.328464	2025-05-24	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	93.48	239	186
1161	2024-12-16 16:05:41.276486	2024-12-16 16:05:41.276499	0	2024-12-16 16:05:41.16387	2024-11-09	0.00	0.00	15.01	1.90	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	155.47	214	192
1162	2024-12-16 16:05:41.27938	2024-12-16 16:05:41.279388	0	2024-12-16 16:05:41.164729	2024-11-16	0.00	0.00	4.62	0.72	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	28.05	222	192
1163	2024-12-16 16:05:41.280049	2024-12-16 16:05:41.280053	0	2024-12-16 16:05:41.16544	2024-11-16	0.00	0.00	6.25	0.98	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	218	192
1164	2024-12-16 16:05:41.280614	2024-12-16 16:05:41.280617	0	2024-12-16 16:05:41.165483	2024-12-16	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	28.05	223	192
1165	2024-12-16 16:05:41.28112	2024-12-16 16:05:41.281123	0	2024-12-16 16:05:41.165518	2024-12-16	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	219	192
1166	2024-12-16 16:05:41.28169	2024-12-16 16:05:41.281693	0	2024-12-16 16:05:41.166414	2024-12-25	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	93.48	234	192
1167	2024-12-16 16:05:41.282219	2024-12-16 16:05:41.282222	0	2024-12-16 16:05:41.167421	2025-01-15	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	110.43	230	192
1168	2024-12-16 16:05:41.282745	2024-12-16 16:05:41.282749	0	2024-12-16 16:05:41.167542	2025-01-15	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	28.05	224	192
1169	2024-12-16 16:05:41.283274	2024-12-16 16:05:41.283277	0	2024-12-16 16:05:41.167645	2025-01-15	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	220	192
1170	2024-12-16 16:05:41.283804	2024-12-16 16:05:41.283807	0	2024-12-16 16:05:41.167771	2025-01-24	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	93.48	235	192
1171	2024-12-16 16:05:41.284436	2024-12-16 16:05:41.28444	0	2024-12-16 16:05:41.167876	2025-02-14	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	110.43	231	192
1172	2024-12-16 16:05:41.284997	2024-12-16 16:05:41.285002	0	2024-12-16 16:05:41.167983	2025-02-14	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	28.05	225	192
1173	2024-12-16 16:05:41.285623	2024-12-16 16:05:41.285627	0	2024-12-16 16:05:41.168096	2025-02-14	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	40.76	221	192
1174	2024-12-16 16:05:41.286281	2024-12-16 16:05:41.286285	0	2024-12-16 16:05:41.168223	2025-02-23	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	93.48	236	192
1175	2024-12-16 16:05:41.286898	2024-12-16 16:05:41.286903	0	2024-12-16 16:05:41.168333	2025-03-16	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	110.43	232	192
1176	2024-12-16 16:05:41.28751	2024-12-16 16:05:41.287515	0	2024-12-16 16:05:41.16849	2025-03-16	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	28.05	226	192
1177	2024-12-16 16:05:41.288321	2024-12-16 16:05:41.28833	0	2024-12-16 16:05:41.168588	2025-03-25	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	93.48	237	192
1178	2024-12-16 16:05:41.289668	2024-12-16 16:05:41.289676	0	2024-12-16 16:05:41.168699	2025-04-15	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	28.05	227	192
1179	2024-12-16 16:05:41.290865	2024-12-16 16:05:41.290873	0	2024-12-16 16:05:41.168797	2025-04-24	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	93.48	238	192
1180	2024-12-16 16:05:41.292096	2024-12-16 16:05:41.292103	0	2024-12-16 16:05:41.168892	2025-05-24	0.00	0.00	0.00	0.00	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	93.48	239	192
1181	2024-12-16 16:06:27.372127	2024-12-16 16:06:27.372132	0	2024-12-16 16:06:27.327016	2024-11-09	0.00	0.00	15.01	1.90	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	155.47	214	193
1182	2024-12-16 16:06:27.372869	2024-12-16 16:06:27.372874	0	2024-12-16 16:06:27.333283	2024-11-16	0.00	0.00	4.62	0.72	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	28.05	222	193
1183	2024-12-16 16:06:27.373417	2024-12-16 16:06:27.373419	0	2024-12-16 16:06:27.342052	2024-12-16	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	28.05	223	193
1184	2024-12-16 16:06:27.37381	2024-12-16 16:06:27.373813	0	2024-12-16 16:06:27.338244	2024-11-16	0.00	0.00	6.25	0.98	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	218	193
1185	2024-12-16 16:06:27.374189	2024-12-16 16:06:27.374191	0	2024-12-16 16:06:27.343596	2024-12-16	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	219	193
1186	2024-12-16 16:06:27.482982	2024-12-16 16:06:27.482991	0	2024-12-16 16:06:27.452939	2024-12-25	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	45.67	234	194
1187	2024-12-16 16:06:27.484267	2024-12-16 16:06:27.484274	0	2024-12-16 16:06:27.460458	2024-12-25	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	93.48	234	193
1188	2024-12-16 16:06:27.526109	2024-12-16 16:06:27.52612	0	2024-12-16 16:06:27.510979	2025-01-15	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	118.43	230	195
1189	2024-12-16 16:06:27.5271	2024-12-16 16:06:27.527107	0	2024-12-16 16:06:27.512958	2025-01-15	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	110.43	230	193
1190	2024-12-16 16:06:27.547274	2024-12-16 16:06:27.547278	0	2024-12-16 16:06:27.54039	2025-01-15	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	36.05	224	196
1191	2024-12-16 16:06:27.547872	2024-12-16 16:06:27.547875	0	2024-12-16 16:06:27.541112	2025-01-15	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	28.05	224	193
1192	2024-12-16 16:06:27.565086	2024-12-16 16:06:27.565092	0	2024-12-16 16:06:27.558129	2025-01-15	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	48.76	220	197
1193	2024-12-16 16:06:27.565652	2024-12-16 16:06:27.565655	0	2024-12-16 16:06:27.558879	2025-01-15	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	220	193
1194	2024-12-16 16:06:27.588035	2024-12-16 16:06:27.588041	0	2024-12-16 16:06:27.580878	2025-01-24	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	101.48	235	198
1195	2024-12-16 16:06:27.588587	2024-12-16 16:06:27.588591	0	2024-12-16 16:06:27.581578	2025-01-24	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	93.48	235	193
1196	2024-12-16 16:06:27.606254	2024-12-16 16:06:27.606258	0	2024-12-16 16:06:27.598398	2025-02-14	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	118.43	231	199
1197	2024-12-16 16:06:27.606681	2024-12-16 16:06:27.606684	0	2024-12-16 16:06:27.599022	2025-02-14	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	110.43	231	193
1198	2024-12-16 16:06:27.626638	2024-12-16 16:06:27.626644	0	2024-12-16 16:06:27.614918	2025-02-14	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	36.05	225	200
1199	2024-12-16 16:06:27.627537	2024-12-16 16:06:27.627541	0	2024-12-16 16:06:27.61553	2025-02-14	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	28.05	225	193
1200	2024-12-16 16:06:27.651176	2024-12-16 16:06:27.651183	0	2024-12-16 16:06:27.638323	2025-02-14	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	48.76	221	201
1201	2024-12-16 16:06:27.652579	2024-12-16 16:06:27.652587	0	2024-12-16 16:06:27.639848	2025-02-14	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	40.76	221	193
1202	2024-12-16 16:06:27.673898	2024-12-16 16:06:27.673904	0	2024-12-16 16:06:27.665168	2025-02-23	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	101.48	236	202
1203	2024-12-16 16:06:27.674429	2024-12-16 16:06:27.674433	0	2024-12-16 16:06:27.66588	2025-02-23	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	93.48	236	193
1204	2024-12-16 16:06:27.691207	2024-12-16 16:06:27.691211	0	2024-12-16 16:06:27.682496	2025-03-16	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	114.43	232	203
1205	2024-12-16 16:06:27.691727	2024-12-16 16:06:27.69173	0	2024-12-16 16:06:27.683104	2025-03-16	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	110.43	232	193
1206	2024-12-16 16:06:27.713933	2024-12-16 16:06:27.713936	0	2024-12-16 16:06:27.705179	2025-03-16	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	36.05	226	204
1207	2024-12-16 16:06:27.714415	2024-12-16 16:06:27.714417	0	2024-12-16 16:06:27.706828	2025-03-16	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	28.05	226	193
1208	2024-12-16 16:06:27.73092	2024-12-16 16:06:27.730922	0	2024-12-16 16:06:27.724123	2025-03-25	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	101.48	237	205
1209	2024-12-16 16:06:27.731302	2024-12-16 16:06:27.731304	0	2024-12-16 16:06:27.72475	2025-03-25	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	93.48	237	193
1210	2024-12-16 16:06:27.759079	2024-12-16 16:06:27.759084	0	2024-12-16 16:06:27.744136	2025-04-15	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	36.05	227	206
1211	2024-12-16 16:06:27.759815	2024-12-16 16:06:27.759819	0	2024-12-16 16:06:27.745839	2025-04-15	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	28.05	227	193
1212	2024-12-16 16:06:27.776501	2024-12-16 16:06:27.776503	0	2024-12-16 16:06:27.768059	2025-04-24	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	101.48	238	207
1213	2024-12-16 16:06:27.776962	2024-12-16 16:06:27.776963	0	2024-12-16 16:06:27.768848	2025-04-24	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	93.48	238	193
1214	2024-12-16 16:06:27.788953	2024-12-16 16:06:27.788959	0	2024-12-16 16:06:27.784048	2025-05-24	0.00	0.00	0.00	0.00	36-LANCAMENTO AJUSTE CREDITO	PENDENTE_PAGAMENTO	101.48	239	208
1215	2024-12-16 16:06:27.78977	2024-12-16 16:06:27.789775	0	2024-12-16 16:06:27.784881	2025-05-24	0.00	0.00	0.00	0.00	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	93.48	239	193
1216	2024-12-16 16:13:13.177743	2024-12-16 16:13:13.177746	0	2024-12-16 16:13:13.168002	2025-01-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	196.34	240	209
1217	2024-12-16 16:13:13.179706	2024-12-16 16:13:13.179711	0	2024-12-16 16:13:13.168027	2025-02-14	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	196.34	241	209
1218	2024-12-16 16:13:13.182437	2024-12-16 16:13:13.182447	0	2024-12-16 16:13:13.168044	2025-03-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	196.34	242	209
1219	2024-12-16 16:14:27.035057	2024-12-16 16:14:27.035066	0	2024-12-16 16:14:27.027517	2025-01-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	196.34	240	210
1220	2024-12-16 16:14:27.03708	2024-12-16 16:14:27.037088	0	2024-12-16 16:14:27.027543	2025-02-14	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	196.34	241	210
1221	2024-12-16 16:14:27.038595	2024-12-16 16:14:27.038604	0	2024-12-16 16:14:27.02755	2025-03-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	196.34	242	210
1222	2024-12-16 16:15:31.843373	2024-12-16 16:15:31.843385	0	2024-12-16 16:15:31.82186	2025-01-15	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	196.34	240	211
1223	2024-12-16 16:15:31.845801	2024-12-16 16:15:31.845832	0	2024-12-16 16:15:31.821893	2025-02-14	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	196.34	241	211
1224	2024-12-16 16:15:31.848066	2024-12-16 16:15:31.848075	0	2024-12-16 16:15:31.821902	2025-03-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	196.34	242	211
1225	2024-12-16 16:15:44.56813	2024-12-16 16:15:44.568139	0	2024-12-16 16:15:44.558626	2025-01-15	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	196.34	240	212
1226	2024-12-16 16:15:44.570164	2024-12-16 16:15:44.57017	0	2024-12-16 16:15:44.560387	2025-02-14	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	196.34	241	212
1227	2024-12-16 16:15:44.571839	2024-12-16 16:15:44.571845	0	2024-12-16 16:15:44.562003	2025-03-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	196.34	242	212
1228	2024-12-16 16:23:51.805273	2024-12-16 16:23:51.805279	0	2024-12-16 16:23:51.795541	2024-11-15	0.00	0.00	10.86	1.64	07-PAGAMENTO CADASTRO	PENDENTE_PAGAMENTO	82.05	64	213
1233	2024-12-16 16:25:23.593181	2024-12-16 16:25:23.593192	0	2024-12-16 16:25:23.588263	2025-01-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	178.49	243	216
1229	2024-12-16 16:24:08.539449	2024-12-16 16:24:08.539454	0	2024-12-16 16:24:08.532309	2024-11-15	0.00	0.00	10.86	1.64	08-PAGAMENTO CADASTRO CONFIRMADO	PAGO	82.05	64	214
1230	2024-12-16 16:25:06.047983	2024-12-16 16:25:06.047985	0	2024-12-16 16:25:06.039695	2025-01-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	178.49	243	215
1231	2024-12-16 16:25:06.049512	2024-12-16 16:25:06.049514	0	2024-12-16 16:25:06.039728	2025-02-14	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	178.49	244	215
1232	2024-12-16 16:25:06.051144	2024-12-16 16:25:06.051151	0	2024-12-16 16:25:06.039752	2025-03-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	178.49	245	215
1234	2024-12-16 16:25:23.594961	2024-12-16 16:25:23.594967	0	2024-12-16 16:25:23.588288	2025-02-14	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	178.49	244	216
1235	2024-12-16 16:25:23.596571	2024-12-16 16:25:23.596577	0	2024-12-16 16:25:23.588294	2025-03-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	178.49	245	216
1236	2024-12-16 17:08:00.631777	2024-12-16 17:08:00.631781	0	2024-12-16 17:08:00.611042	2025-01-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	136.00	246	217
1237	2024-12-16 17:08:00.634079	2024-12-16 17:08:00.634087	0	2024-12-16 17:08:00.611049	2025-02-14	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	136.00	247	217
1238	2024-12-16 17:08:00.636295	2024-12-16 17:08:00.636299	0	2024-12-16 17:08:00.611054	2025-03-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	136.00	248	217
1239	2024-12-16 17:08:00.638149	2024-12-16 17:08:00.638153	0	2024-12-16 17:08:00.611059	2025-04-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	136.00	249	217
1240	2024-12-16 17:08:08.67573	2024-12-16 17:08:08.675736	0	2024-12-16 17:08:08.669886	2025-01-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	136.00	246	218
1241	2024-12-16 17:08:08.676659	2024-12-16 17:08:08.676663	0	2024-12-16 17:08:08.670385	2025-02-14	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	136.00	247	218
1242	2024-12-16 17:08:08.677359	2024-12-16 17:08:08.677363	0	2024-12-16 17:08:08.670393	2025-03-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	136.00	248	218
1243	2024-12-16 17:08:08.677995	2024-12-16 17:08:08.677999	0	2024-12-16 17:08:08.670395	2025-04-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	136.00	249	218
1244	2024-12-16 18:33:05.674738	2024-12-16 18:33:05.674749	0	2024-12-16 18:33:05.657836	2024-12-16	0.00	0.00	0.00	0.00	22-EMISSAO DE BOLETO	ATIVO	178.49	243	219
1245	2024-12-16 18:34:05.734633	2024-12-16 18:34:05.734643	0	2024-12-16 18:34:05.718438	2024-12-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	178.49	243	220
1246	2024-12-16 18:34:05.736295	2024-12-16 18:34:05.736304	0	2024-12-16 18:34:05.718458	2025-02-14	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	178.49	244	220
1247	2024-12-16 18:34:05.73759	2024-12-16 18:34:05.737597	0	2024-12-16 18:34:05.718468	2025-03-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	178.49	245	220
1248	2024-12-16 18:34:15.5586	2024-12-16 18:34:15.558613	0	2024-12-16 18:34:14.459368	2024-12-16	0.00	0.00	0.00	0.00	25-BOLETO CANCELADO	PENDENTE_ESTORNO	178.49	243	222
1249	2024-12-16 18:34:15.560827	2024-12-16 18:34:15.560839	0	2024-12-16 18:34:15.541724	2024-12-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	178.49	243	221
1250	2024-12-16 18:34:15.562519	2024-12-16 18:34:15.56253	0	2024-12-16 18:34:15.543732	2025-02-14	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	178.49	244	221
1251	2024-12-16 18:34:15.564124	2024-12-16 18:34:15.564134	0	2024-12-16 18:34:15.545697	2025-03-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	178.49	245	221
1252	2024-12-17 09:23:51.552737	2024-12-17 09:23:51.552744	0	2024-12-17 09:23:51.515772	2025-01-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	53.55	250	223
1253	2024-12-17 09:23:51.555428	2024-12-17 09:23:51.555433	0	2024-12-17 09:23:51.51581	2025-02-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	53.55	251	223
1254	2024-12-17 09:23:51.556959	2024-12-17 09:23:51.556964	0	2024-12-17 09:23:51.515845	2025-03-17	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	53.55	252	223
1255	2024-12-17 09:24:09.295819	2024-12-17 09:24:09.295828	0	2024-12-17 09:24:09.284674	2025-01-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	53.55	250	224
1256	2024-12-17 09:24:09.297375	2024-12-17 09:24:09.297384	0	2024-12-17 09:24:09.285745	2025-02-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	53.55	251	224
1257	2024-12-17 09:24:09.299697	2024-12-17 09:24:09.29971	0	2024-12-17 09:24:09.285764	2025-03-17	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	53.55	252	224
1258	2024-12-17 09:28:12.265843	2024-12-17 09:28:12.265851	0	2024-12-17 09:28:12.255837	2024-12-10	0.00	0.00	1.84	1.23	22-EMISSAO DE BOLETO	ATIVO	53.55	250	225
1259	2024-12-17 09:35:20.53671	2024-12-17 09:35:20.536723	0	2024-12-17 09:35:20.509926	2024-12-10	0.00	0.00	1.84	1.23	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	53.55	250	226
1260	2024-12-17 09:35:20.538593	2024-12-17 09:35:20.5386	0	2024-12-17 09:35:20.509966	2025-02-15	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	53.55	251	226
1261	2024-12-17 09:35:20.539463	2024-12-17 09:35:20.53949	0	2024-12-17 09:35:20.509977	2025-03-17	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	53.55	252	226
1262	2024-12-17 09:37:36.726302	2024-12-17 09:37:36.726315	0	2024-12-17 09:37:36.09013	2024-12-10	0.00	0.00	1.84	1.23	25-BOLETO CANCELADO	PENDENTE_ESTORNO	53.55	250	228
1263	2024-12-17 09:37:36.729315	2024-12-17 09:37:36.729326	0	2024-12-17 09:37:36.705474	2024-12-10	0.00	0.00	1.84	1.23	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	53.55	250	227
1264	2024-12-17 09:37:36.730886	2024-12-17 09:37:36.730895	0	2024-12-17 09:37:36.706973	2025-02-15	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	53.55	251	227
1265	2024-12-17 09:37:36.732243	2024-12-17 09:37:36.732252	0	2024-12-17 09:37:36.708451	2025-03-17	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	53.55	252	227
1266	2024-12-17 14:41:46.754983	2024-12-17 14:41:46.755004	0	2024-12-17 14:41:46.673945	2025-01-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.80	253	229
1267	2024-12-17 14:41:46.765289	2024-12-17 14:41:46.765304	0	2024-12-17 14:41:46.673999	2025-02-15	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.80	254	229
1268	2024-12-17 14:41:46.771858	2024-12-17 14:41:46.771874	0	2024-12-17 14:41:46.67404	2025-03-17	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.80	255	229
1269	2024-12-17 14:41:46.778388	2024-12-17 14:41:46.778403	0	2024-12-17 14:41:46.67408	2025-04-16	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	40.80	256	229
1270	2024-12-17 14:42:15.78469	2024-12-17 14:42:15.784715	0	2024-12-17 14:42:15.770976	2025-01-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.80	253	230
1271	2024-12-17 14:42:15.787394	2024-12-17 14:42:15.787418	0	2024-12-17 14:42:15.771993	2025-02-15	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.80	254	230
1272	2024-12-17 14:42:15.789684	2024-12-17 14:42:15.789695	0	2024-12-17 14:42:15.772009	2025-03-17	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.80	255	230
1273	2024-12-17 14:42:15.791631	2024-12-17 14:42:15.791647	0	2024-12-17 14:42:15.772015	2025-04-16	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	40.80	256	230
1274	2024-12-17 14:51:07.376602	2024-12-17 14:51:07.376616	0	2024-12-17 14:51:07.331118	2025-01-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	40.80	253	231
1275	2024-12-17 14:51:07.379274	2024-12-17 14:51:07.379285	0	2024-12-17 14:51:07.331141	2025-02-15	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	40.80	254	231
1276	2024-12-17 14:51:07.381843	2024-12-17 14:51:07.381874	0	2024-12-17 14:51:07.331148	2025-03-17	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	40.80	255	231
1277	2024-12-17 14:51:07.384941	2024-12-17 14:51:07.384957	0	2024-12-17 14:51:07.331154	2025-04-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO	PENDENTE_ESTORNO	40.80	256	231
1278	2024-12-17 14:53:46.031751	2024-12-17 14:53:46.031763	0	2024-12-17 14:53:46.020656	2025-01-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	40.80	253	232
1279	2024-12-17 14:53:46.03424	2024-12-17 14:53:46.034249	0	2024-12-17 14:53:46.021873	2025-02-15	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	40.80	254	232
1280	2024-12-17 14:53:46.036099	2024-12-17 14:53:46.036108	0	2024-12-17 14:53:46.022989	2025-03-17	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	40.80	255	232
1281	2024-12-17 14:53:46.03806	2024-12-17 14:53:46.03807	0	2024-12-17 14:53:46.024081	2025-04-16	0.00	0.00	0.00	0.00	04-VENDA CADASTRO ESTORNO CONFIRMADO	ESTORNADO	40.80	256	232
1282	2024-12-24 10:11:33.439552	2024-12-24 10:11:33.43957	0	2024-12-24 10:11:33.401191	2025-01-23	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	149.60	257	233
1283	2024-12-24 10:11:33.450951	2024-12-24 10:11:33.450977	0	2024-12-24 10:11:33.401235	2025-02-22	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	149.60	258	233
1284	2024-12-24 10:11:33.45729	2024-12-24 10:11:33.457315	0	2024-12-24 10:11:33.401289	2025-03-24	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	149.60	259	233
1285	2024-12-24 10:11:33.467083	2024-12-24 10:11:33.467101	0	2024-12-24 10:11:33.401329	2025-04-23	0.00	0.00	0.00	0.00	01-VENDA CADASTRO	PENDENTE	149.60	260	233
1286	2024-12-24 10:11:42.214833	2024-12-24 10:11:42.21484	0	2024-12-24 10:11:42.202904	2025-01-23	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	149.60	257	234
1287	2024-12-24 10:11:42.216833	2024-12-24 10:11:42.216841	0	2024-12-24 10:11:42.203803	2025-02-22	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	149.60	258	234
1288	2024-12-24 10:11:42.218205	2024-12-24 10:11:42.218212	0	2024-12-24 10:11:42.203818	2025-03-24	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	149.60	259	234
1289	2024-12-24 10:11:42.219201	2024-12-24 10:11:42.219209	0	2024-12-24 10:11:42.203828	2025-04-23	0.00	0.00	0.00	0.00	02-VENDA CADASTRO CONFIRMADO	ATIVO	149.60	260	234
\.


--
-- Data for Name: t_classificacao_reversao_pagamento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_classificacao_reversao_pagamento (id_classificacao, insert_date, update_date, version, codigo_contabil, descricao) FROM stdin;
1	2024-06-19 01:38:11.680713	2024-06-19 01:38:11.680713	0	4397	Reversão Pagamento por Óbito
2	2024-06-19 01:38:11.680713	2024-06-19 01:38:11.680713	0	4389	Reversão Pagamento por Fraude
\.


--
-- Data for Name: t_classificador; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_classificador (id_classificador, insert_date, update_date, version, descricao) FROM stdin;
1	2024-06-19 01:38:11.680713	2024-06-19 01:38:11.680713	0	Consumidor
\.


--
-- Data for Name: t_classificador_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_classificador_aud (id_classificador, rev, revtype, descricao) FROM stdin;
\.


--
-- Data for Name: t_cobransaas; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_cobransaas (id_cobransaas, insert_date, update_date, version, agrupador, ambiente, auth, produto, token, url_acordo_confirmar_abatimento, url_acordo_pagamento, url_acordo_vincular_contrato, url_consumidor_cadastrar, url_consumidor_visualizar, url_contrato_cadastrar, url_contrato_excluir, url_contrato_visualizar, url_contrato_visualizar_parcelas, url_login) FROM stdin;
\.


--
-- Data for Name: t_consumidor; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor (id_consumidor, insert_date, update_date, version, atividade_primaria, cargo_solicitante, cidade_natal, cpf_cnpj, data_emissao_rg, data_nascimento, email, escolaridade, estado_civil, estado_natal, faturamento_data, faturamento_valor, inscricao_estadual, nacionalidade, nome, nome_mae, nome_pai, observacao, ocupacao, orgao_emissorrg, profissao, razao_social, renda, responsavel_financeiro, rg, sexo, status, tipo, tributacao_tipo, tributacao_valor, vinculo_empregaticio, id_classificador, id_endereco_residencial, id_user) FROM stdin;
3	2024-09-05 11:25:11.572232	2024-11-05 03:44:10.938458	3	Exemplo	Exemplo	\N	07533648404004	\N	\N	exemplo@gmail.com	\N	OUTRO	\N	\N	0.00	exemplo	\N	Midas Bnpl Parcelepag Apollo	\N	\N	BNPL - 05/09/2024, 11:25: Cadastro avulso de consumidor	\N	\N	\N	Exemplo	\N	Exemplo	\N	\N	ATIVO	JURIDICA	Exemplo	0.00	f	1	7	5
1	2024-06-20 14:28:28.18448	2024-12-16 18:32:51.976382	15	\N	\N	Cabedelo City	26629231058	2001-01-01	1989-05-25	bnpl@rpe.tech	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Apollo Bnpl Parcelepag Midas	Maria	José	Peter Costa - 11/10/2024, 01:45:\nCliente Ativado\nPeter Costa - 11/10/2024, 01:44:\nCliente Bloqueado	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3087182	M	ATIVO	FISICA	\N	0.00	f	1	3	1
2	2024-06-25 11:32:40.096932	2024-12-18 09:37:08.857953	4	\N	\N	Cabedelo	06359389010	2008-06-14	1999-06-15	exemplo@gmail.com	Superior	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa	Maria	João	BNPL - 19/08/2024, 17:16: Cliente AtivadoBNPL - 19/08/2024, 17:15: Cliente BloqueadoBNPL - 25/06/2024, 11:32: Cadastro avulso de consumidor	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	2147182	M	ATIVO	FISICA	\N	0.00	f	1	4	2
4	2024-10-11 01:49:25.704403	2024-12-18 09:38:17.739305	1	\N	\N	Cabedelo	48707874073	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior Incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa 2	Claudia	Romualdo	Peter Costa - 11/10/2024, 01:49:\nCadastro avulso de consumidor	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f	1	8	6
\.


--
-- Data for Name: t_consumidor_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_aud (id_consumidor, rev, revtype, atividade_primaria, cargo_solicitante, cidade_natal, cpf_cnpj, data_emissao_rg, data_nascimento, email, escolaridade, estado_civil, estado_natal, faturamento_data, faturamento_valor, inscricao_estadual, nacionalidade, nome, nome_mae, nome_pai, ocupacao, orgao_emissorrg, profissao, razao_social, renda, responsavel_financeiro, rg, sexo, status, tipo, tributacao_tipo, tributacao_valor, vinculo_empregaticio) FROM stdin;
1	9	0	\N	\N	Cabedelo	07532648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
2	11	0	\N	\N	Cabedelo	07532648403	2008-06-14	1999-06-15	petersvcosta@gmail.com	Peter	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Peter	Peter	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
1	151	1	\N	\N	Cabedelo	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	BLOQUEADO	FISICA	\N	0.00	f
1	152	1	\N	\N	Cabedelo	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
2	181	1	\N	\N	Cabedelo	07532648403	2008-06-14	1999-06-15	petersvcosta@gmail.com	Peter	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Peter	Peter	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	BLOQUEADO	FISICA	\N	0.00	f
2	182	1	\N	\N	Cabedelo	07532648403	2008-06-14	1999-06-15	petersvcosta@gmail.com	Peter	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Peter	Peter	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
1	191	1	\N	\N	Cabedelo	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	BLOQUEADO	FISICA	\N	0.00	f
1	192	1	\N	\N	Cabedelo	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
1	220	1	\N	\N	Cabedelo	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	BLOQUEADO	FISICA	\N	0.00	f
1	221	1	\N	\N	Cabedelo City	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	BLOQUEADO	FISICA	\N	0.00	f
1	222	1	\N	\N	Cabedelo City	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
3	260	0	Exemplo	Exemplo	\N	07533648404004	\N	\N	petersvcosta@gmail.com	\N	OUTRO	\N	\N	0.00	Exemplo	\N	Exemplo	\N	\N	\N	\N	\N	Exemplo	\N	Exemplo	\N	\N	ATIVO	JURIDICA	Exemplo	0.00	f
1	266	1	\N	\N	Cabedelo City	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	BLOQUEADO	FISICA	\N	0.00	f
1	267	1	\N	\N	Cabedelo City	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
1	348	1	\N	\N	Cabedelo City	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
1	360	1	\N	\N	Cabedelo City	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	BLOQUEADO	FISICA	\N	0.00	f
1	361	1	\N	\N	Cabedelo City	07533648404	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
1	362	1	\N	\N	Cabedelo City	07533648404	2001-01-01	1989-05-02	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
4	363	0	\N	\N	Cabedelo	07533648405	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior Incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa 2	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
1	376	1	\N	\N	Cabedelo City	04531645409	2001-01-01	1989-05-25	petersvcosta@gmail.com	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Apollo Bnpl Parcelepag Midas	Maria	José	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3087182	M	ATIVO	FISICA	\N	0.00	f
3	377	1	Exemplo	Exemplo	\N	07533648404004	\N	\N	exemplo@gmail.com	\N	OUTRO	\N	\N	0.00	Midas Bnpl Parcelepag Apollo	\N	Exemplo	\N	\N	\N	\N	\N	Exemplo	\N	Exemplo	\N	\N	ATIVO	JURIDICA	Exemplo	0.00	f
3	378	1	Exemplo	Exemplo	\N	07533648404004	\N	\N	exemplo@gmail.com	\N	OUTRO	\N	\N	0.00	exemplo	\N	Exemplo	\N	\N	\N	\N	\N	Midas Bnpl Parcelepag Apollo	\N	Exemplo	\N	\N	ATIVO	JURIDICA	Exemplo	0.00	f
3	379	1	Exemplo	Exemplo	\N	07533648404004	\N	\N	exemplo@gmail.com	\N	OUTRO	\N	\N	0.00	exemplo	\N	Midas Bnpl Parcelepag Apollo	\N	\N	\N	\N	\N	Exemplo	\N	Exemplo	\N	\N	ATIVO	JURIDICA	Exemplo	0.00	f
2	380	1	\N	\N	Cabedelo	09562613403	2008-06-14	1999-06-15	exemplo@gmail.com	Superior	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa	Maria	João	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	2147182	M	ATIVO	FISICA	\N	0.00	f
1	425	1	\N	\N	Cabedelo City	26629231058	2001-01-01	1989-05-25	bnpl@rpe.tech	Superior incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Apollo Bnpl Parcelepag Midas	Maria	José	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3087182	M	ATIVO	FISICA	\N	0.00	f
2	426	1	\N	\N	Cabedelo	06359389010	2008-06-14	1999-06-15	exemplo@gmail.com	Superior	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa	Maria	João	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	2147182	M	ATIVO	FISICA	\N	0.00	f
4	427	1	\N	\N	Cabedelo	48707874073	2000-01-01	1989-05-02	petersvcosta@gmail.com	Superior Incompleto	SOLTEIRO	PB	\N	0.00	\N	Brasileiro	Peter Simon Veríssimo da Costa 2	Claudia	Romualdo	Empregado	SSP	Desenvolvedor de Software	\N	2000.00	\N	3197182	M	ATIVO	FISICA	\N	0.00	f
\.


--
-- Data for Name: t_consumidor_conjuge; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_conjuge (id_consumidor_conjuge, insert_date, update_date, version, cpf, data_emissao_rg, data_nascimento, nome, orgao_emissor, rg, sexo, id_consumidor) FROM stdin;
\.


--
-- Data for Name: t_consumidor_conjuge_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_conjuge_aud (id_consumidor_conjuge, rev, revtype, cpf, data_emissao_rg, data_nascimento, nome, orgao_emissor, rg, sexo) FROM stdin;
\.


--
-- Data for Name: t_consumidor_dependente; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_dependente (id_consumidor_dependente, insert_date, update_date, version, area, cpf, nome, status, telefone, id_consumidor) FROM stdin;
\.


--
-- Data for Name: t_consumidor_dependente_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_dependente_aud (id_consumidor_dependente, rev, revtype, area, cpf, nome, status, telefone) FROM stdin;
\.


--
-- Data for Name: t_consumidor_referencia; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_referencia (id_consumidor_referencia, insert_date, update_date, version, grau_parentesco, nome, id_consumidor) FROM stdin;
\.


--
-- Data for Name: t_consumidor_referencia_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_referencia_aud (id_consumidor_referencia, rev, revtype, grau_parentesco, nome) FROM stdin;
\.


--
-- Data for Name: t_consumidor_socio; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_socio (id_consumidor_socio, insert_date, update_date, version, cargo, cidade_natal, cpf, data_nascimento, estado_civil, nacionalidade, nome, orgao_emissorrg, rg, sexo, uf, id_consumidor) FROM stdin;
\.


--
-- Data for Name: t_consumidor_socio_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_socio_aud (id_consumidor_socio, rev, revtype, cargo, cidade_natal, cpf, data_nascimento, estado_civil, nacionalidade, nome, orgao_emissorrg, rg, sexo, uf) FROM stdin;
\.


--
-- Data for Name: t_consumidor_telefone; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_telefone (id_consumidor_telefone, insert_date, update_date, version, area, ramal, sms, telefone, tipo, id_consumidor, id_conjuge, id_consumidor_referencia, id_consumidor_socio) FROM stdin;
2	2024-06-25 11:32:40.106829	2024-06-25 11:32:40.106845	0	83	\N	t	98888888	CELULAR	2	\N	\N	\N
3	2024-09-05 11:25:11.576596	2024-09-05 11:25:11.576608	0	83	\N	t	98888888	CELULAR	3	\N	\N	\N
4	2024-10-11 01:49:25.709	2024-10-11 01:49:25.709018	0	83	\N	t	988546372	CELULAR	4	\N	\N	\N
5	2024-10-11 17:05:36.506944	2024-10-11 17:05:36.506962	0	83	\N	t	988922562	CELULAR	1	\N	\N	\N
\.


--
-- Data for Name: t_consumidor_telefone_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_consumidor_telefone_aud (id_consumidor_telefone, rev, revtype, area, ramal, sms, telefone, tipo, id_consumidor, id_conjuge, id_consumidor_referencia, id_consumidor_socio) FROM stdin;
1	9	0	83	\N	t	98888888	CELULAR	1	\N	\N	\N
2	11	0	83	\N	t	98888888	CELULAR	2	\N	\N	\N
3	260	0	83	\N	t	98888888	CELULAR	3	\N	\N	\N
4	363	0	83	\N	t	988546372	CELULAR	4	\N	\N	\N
5	364	0	83	\N	t	988922562	CELULAR	1	\N	\N	\N
1	364	1	83	\N	f	98888888	CELULAR	1	\N	\N	\N
1	365	2	83	\N	f	98888888	CELULAR	1	\N	\N	\N
\.


--
-- Data for Name: t_contato; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_contato (idcontato, insert_date, update_date, version, tipo_contato, valor) FROM stdin;
1	2024-06-19 01:39:50.032298	2024-06-19 01:39:50.032322	0	TELEFONE_RESIDENCIAL	8398888888
2	2024-06-26 14:36:22.374278	2024-06-26 14:36:22.374293	0	TELEFONE_CELULAR	8398777777
3	2024-08-16 15:23:47.697114	2024-08-16 15:23:47.697135	0	TELEFONE_CELULAR	83988922562
4	2024-08-19 17:17:17.914283	2024-08-19 17:17:17.91429	0	TELEFONE_CELULAR	8398777777
5	2024-08-26 13:35:08.719718	2024-08-26 13:35:08.719864	0	TELEFONE_CELULAR	83988922562
6	2024-08-26 13:37:46.951154	2024-08-26 13:37:46.95116	0	TELEFONE_CELULAR	83988922562
7	2024-08-26 13:38:05.055924	2024-08-26 13:38:05.055945	0	TELEFONE_CELULAR	83988922562
8	2024-08-26 14:14:04.992303	2024-08-26 14:14:04.992308	0	TELEFONE_CELULAR	83988922562
9	2024-08-26 14:15:32.019504	2024-08-26 14:15:32.019518	0	TELEFONE_CELULAR	83989898989
10	2024-08-26 17:13:11.108801	2024-08-26 17:13:11.108826	0	TELEFONE_RESIDENCIAL	83988777777
\.


--
-- Data for Name: t_contato_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_contato_aud (idcontato, rev, revtype, tipo_contato, valor) FROM stdin;
1	1	0	TELEFONE_RESIDENCIAL	8398888888
2	12	0	TELEFONE_CELULAR	8398777777
3	156	0	TELEFONE_CELULAR	83988922562
4	185	0	TELEFONE_CELULAR	8398777777
5	211	0	TELEFONE_CELULAR	83988922562
6	212	0	TELEFONE_CELULAR	83988922562
7	213	0	TELEFONE_CELULAR	83988922562
8	224	0	TELEFONE_CELULAR	83988922562
9	227	0	TELEFONE_CELULAR	83989898989
10	233	0	TELEFONE_RESIDENCIAL	83988777777
\.


--
-- Data for Name: t_contrato; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_contrato (id_contrato, insert_date, update_date, version, adicional_financeiro, ajuste_deiof, aliquota, cobranca, codigo_barra, coeficiente_financeiro, data, dias_de_ajuste, elegivel_vendor, iof_do_salto, nsu, pgto, pgtoiof, pgto_principal, potencia, quantidade_de_parcelas, quociente, serie, status, tipo, valor, valor_com_adicional_financeiro, valoriofadicional, valoriofdiario, valor_parcela, valor_taxa_operacao, valor_total, valor_total_comiof, id_acordo, id_consumidor, id_estabelecimento, id_estorno, id_plano_pagamento, id_user_conclusao, id_user_solicitacao, cet_total, cet_mensal, cet_anual, taxa_juros_parcela, dias_carencia, ajuste_credito, ajuste_debito) FROM stdin;
9	2024-07-29 16:35:54.916404	2024-07-29 16:35:55.376343	1	0.0000	0.0000	0.0000	f	1722281722075	0.0000	2024-07-29 16:34:45.736085	0.0000	f	0.0000	\N	0.0000	0.0000	0.0000	0.0000	1	0.0000	0.0000	PENDENTE_RENEGOCIACAO	RENEGOCIACAO	57.03	0.0000	0.0000	0.0000	0.00	0.00	57.03	0.0000	1	1	1	\N	\N	\N	\N	0.00	0.00	0.00	0.00	0	0.00	0.00
8	2024-07-15 09:39:46.171231	2024-07-30 14:19:43.888189	2	145.9800	0.0000	0.8822	f	1721047186461	0.1846	2024-07-15 09:39:46.090925	0.0000	f	0.0000	157107	224.3304	2.8134	221.5170	0.1941	6	3.5862	23.1968	PAGO	VENDA	1200.00	1345.9800	4.5600	10.6806	224.33	0.00	1200.00	1215.2406	\N	1	1	\N	8	-99	-99	\N	\N	\N	\N	0	0.00	0.00
10	2024-08-25 15:21:07.07424	2024-08-25 15:21:40.696304	1	411.2824	0.0000	0.0000	f	1724610069806	0.0000	2024-08-25 15:21:07.025344	0.0000	f	0.0000	251625	205.1800	4.2358	200.9424	0.0000	12	0.0000	0.0000	ATIVO	VENDA	2000.00	2411.2824	7.6001	33.7065	205.18	0.00	2000.00	2041.3066	\N	1	1	\N	8	-99	-99	23.00	3.29	48.19	3.00	0	0.00	0.00
11	2024-08-25 20:00:40.795981	2024-08-25 20:00:40.795996	0	14.9861	0.0000	0.0000	f	1724626844705	0.0000	2024-08-25 20:00:40.768525	0.0000	f	0.0000	257655	518.2300	3.2440	514.9861	0.0000	1	0.0000	0.0000	PENDENTE	VENDA	500.00	514.9861	1.9000	1.2300	518.23	0.00	500.00	503.1300	\N	1	1	\N	8	\N	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
12	2024-08-26 22:31:11.263539	2024-08-26 22:31:28.059111	1	102.8756	0.0000	0.0000	f	1724722274266	0.0000	2024-08-26 22:31:11.157419	0.0000	f	0.0000	261479	51.2900	1.0588	50.2356	0.0000	12	0.0000	0.0000	ATIVO	VENDA	500.00	602.8756	1.8999	8.4254	51.29	0.00	500.00	510.3253	\N	1	1	\N	8	-99	-99	23.00	3.29	48.19	3.00	0	0.00	0.00
13	2024-08-27 17:49:17.064971	2024-08-27 17:49:26.198031	1	41.0842	0.0000	0.0000	f	1724791757534	0.0000	2024-08-27 17:49:16.992394	0.0000	f	0.0000	279740	20.5200	0.4237	20.0942	0.0000	12	0.0000	0.0000	ATIVO	VENDA	200.00	241.0842	0.7600	3.3713	20.52	0.00	200.00	204.1313	\N	1	1	\N	8	-99	-99	23.00	3.29	48.19	3.00	0	0.00	0.00
14	2024-08-27 17:57:25.325308	2024-08-27 18:01:53.968388	1	102.8756	0.0000	0.0000	f	1724792245815	0.0000	2024-08-27 17:57:25.256242	0.0000	f	0.0000	272400	51.2900	1.0588	50.2356	0.0000	12	0.0000	0.0000	ATIVO	VENDA	500.00	602.8756	1.8999	8.4254	51.29	0.00	500.00	510.3253	\N	1	1	\N	8	-99	-99	23.00	3.29	48.19	3.00	0	0.00	0.00
15	2024-08-27 18:01:40.587203	2024-08-28 00:05:33.889444	2	4.5203	0.0000	0.0000	f	1724792500866	0.0000	2024-08-27 18:01:40.54993	0.0000	f	0.0000	275410	52.6600	0.3953	52.2603	0.0000	2	0.0000	0.0000	PAGO	VENDA	100.00	104.5203	0.3800	0.3708	52.66	16.00	116.00	100.7508	\N	1	1	\N	10	-99	-99	5.00	3.50	51.89	3.00	0	0.00	0.00
16	2024-09-02 14:52:03.326678	2024-09-02 14:57:01.918854	1	102.8756	0.0000	0.0000	f	1725299523436	0.0000	2024-09-02 14:52:03.270246	0.0000	f	0.0000	022548	51.2900	1.0588	50.2356	0.0000	12	0.0000	0.0000	ATIVO	VENDA	500.00	602.8756	1.8999	8.4254	51.29	96.00	596.00	510.3253	\N	1	1	\N	10	-99	-99	23.00	3.29	48.19	3.00	0	0.00	0.00
17	2024-09-05 11:26:53.665797	2024-09-05 11:27:11.057599	1	1675.0017	0.0000	0.0000	f	1725546416007	0.0000	2024-09-05 11:26:53.637984	0.0000	f	0.0000	056177	5978.7800	60.0255	5918.7517	0.0000	4	0.0000	0.0000	ATIVO	VENDA	22000.00	23675.0017	83.5999	137.2968	5978.78	32.00	22032.00	22220.8967	\N	3	1	\N	10	-99	-99	9.00	3.39	50.01	3.00	0	0.00	0.00
18	2024-09-05 14:32:09.035307	2024-09-05 14:32:31.112386	1	86.2001	0.0000	0.0000	f	1725557532534	0.0000	2024-09-05 14:32:08.990563	0.0000	f	0.0000	059811	59.6900	1.0698	58.6201	0.0000	10	0.0000	0.0000	ATIVO	VENDA	500.00	586.2001	1.9001	7.0640	59.69	80.00	580.00	508.9641	\N	1	1	\N	10	-99	-99	19.00	3.30	48.41	3.00	0	0.00	0.00
19	2024-09-05 17:23:38.48832	2024-09-06 13:51:46.474128	1	69.8432	0.0000	0.0000	f	1725567819262	0.0000	2024-09-05 17:23:38.461535	0.0000	f	0.0000	054561	72.3400	1.1030	71.2332	0.0000	8	0.0000	0.0000	ATIVO	VENDA	500.00	569.8432	1.9000	5.7257	72.34	64.00	564.00	507.6257	\N	1	1	\N	10	-99	-99	15.00	3.32	48.72	3.00	0	0.00	0.00
20	2024-09-08 22:12:55.910419	2024-09-08 22:13:26.517441	1	38.0771	0.0000	0.0000	f	1725844377024	0.0000	2024-09-08 22:12:55.886068	0.0000	f	0.0000	088694	135.8800	1.3642	134.5171	0.0000	4	0.0000	0.0000	ATIVO	VENDA	500.00	538.0771	1.9000	3.1203	135.88	32.00	532.00	505.0203	\N	3	3	\N	10	-99	-99	9.00	3.39	50.01	3.00	0	0.00	0.00
23	2024-09-10 17:49:00.943284	2024-09-10 17:49:06.353715	1	5.9944	0.0000	0.0000	f	1726001343788	0.0000	2024-09-10 17:49:00.926066	0.0000	f	0.0000	109205	207.2900	1.2976	205.9944	0.0000	1	0.0000	0.0000	ATIVO	VENDA	200.00	205.9944	0.7600	0.4920	207.29	8.00	208.00	201.2520	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
25	2024-09-11 02:16:04.395173	2024-09-11 02:16:41.839886	1	2.9972	0.0000	0.0000	f	1726031765134	0.0000	2024-09-11 02:16:04.38708	0.0000	f	0.0000	113756	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	ATIVO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
22	2024-09-10 17:48:19.254077	2024-09-11 15:30:29.486153	2	2.9972	0.0000	0.0000	f	1726001303630	0.0000	2024-09-10 17:48:19.241759	0.0000	f	0.0000	102359	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
24	2024-09-10 17:57:50.832097	2024-09-25 11:06:15.887242	3	2.9972	0.0000	0.0000	f	1726001873850	0.0000	2024-09-10 17:57:50.818614	0.0000	f	0.0000	108108	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	ESTORNADO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	1	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
31	2024-09-11 03:41:38.887341	2024-10-10 14:34:22.038633	2	2.9972	0.0000	0.0000	f	1726036901966	0.0000	2024-09-11 03:41:38.847198	0.0000	f	0.0000	118366	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
26	2024-09-11 02:28:13.201945	2024-09-13 14:41:25.088098	4	2.9972	0.0000	0.0000	f	1726032497583	0.0000	2024-09-11 02:28:13.186242	0.0000	f	0.0000	111799	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	136.43	56.43
28	2024-09-11 02:56:16.558023	2024-10-10 14:34:22.04474	2	2.9972	0.0000	0.0000	f	1726034178422	0.0000	2024-09-11 02:56:16.503369	0.0000	f	0.0000	114944	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
43	2024-10-11 16:47:11.196501	2024-10-11 16:47:17.579181	1	2.9972	0.0000	0.0000	f	1728676032361	0.0000	2024-10-11 16:47:11.166721	0.0000	f	0.0000	111613	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	CANCELADO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	4	4	4.00	3.63	54.24	3.00	0	0.00	0.00
37	2024-09-27 14:06:50.369681	2024-09-27 14:45:41.353922	2	11.4351	0.0000	0.0000	f	1727456810800	0.0000	2024-09-27 14:06:50.341131	0.0000	f	0.0000	273303	40.7600	0.4092	40.3551	0.0000	4	0.0000	0.0000	PAGO	VENDA	150.00	161.4351	0.5701	0.9359	40.76	32.00	182.00	151.5060	\N	1	1	\N	10	-99	-99	9.00	3.39	50.01	3.00	0	0.00	0.00
38	2024-09-27 14:52:56.189	2024-09-27 15:56:59.595776	2	11.4351	0.0000	0.0000	f	1727459578710	0.0000	2024-09-27 14:52:56.176198	0.0000	f	0.0000	271705	40.7600	0.4092	40.3551	0.0000	4	0.0000	0.0000	PAGO	VENDA	150.00	161.4351	0.5701	0.9359	40.76	32.00	182.00	151.5060	\N	1	1	\N	10	-99	-99	9.00	3.39	50.01	3.00	0	0.00	0.00
21	2024-09-10 16:42:04.876645	2024-10-10 14:34:22.049547	2	205.6412	0.0000	0.0000	f	1725997326299	0.0000	2024-09-10 16:42:04.861788	0.0000	f	0.0000	108506	102.5900	2.1180	100.4712	0.0000	12	0.0000	0.0000	PAGO	VENDA	1000.00	1205.6412	3.7999	16.8537	102.59	96.00	1096.00	1020.6536	\N	1	1	\N	10	-99	-99	23.00	3.29	48.19	3.00	0	0.00	0.00
30	2024-09-11 03:22:50.335367	2024-10-10 14:34:22.069053	2	2.9972	0.0000	0.0000	f	1726035774187	0.0000	2024-09-11 03:22:50.300141	0.0000	f	0.0000	112946	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
7	2024-07-10 21:41:23.470866	2024-12-16 16:24:08.548509	4	184.6000	0.0000	1.6855	f	1720658487704	0.1005	2024-07-10 21:41:23.358644	0.0000	f	0.0000	103374	82.0529	1.6832	80.3697	0.4258	12	6.8515	97.2367	PAGO	VENDA	800.00	984.6000	3.0400	13.7149	82.05	0.00	800.00	816.7549	\N	1	1	\N	8	-99	-99	\N	\N	\N	\N	0	0.00	0.00
35	2024-09-12 11:26:36.379916	2024-10-10 14:34:22.023626	2	4.5203	0.0000	0.0000	f	1726151199349	0.0000	2024-09-12 11:26:36.335348	0.0000	f	0.0000	123234	52.6600	0.3949	52.2603	0.0000	2	0.0000	0.0000	PAGO	VENDA	100.00	104.5203	0.3800	0.3708	52.66	16.00	116.00	100.7508	\N	1	1	\N	10	-99	-99	5.00	3.49	51.88	3.00	0	0.00	0.00
36	2024-09-25 18:55:23.172908	2024-10-10 14:34:22.030973	4	18.1795	0.0000	0.0000	f	1727301325783	0.0000	2024-09-25 18:55:23.158504	0.0000	f	0.0000	251546	107.0000	0.9381	106.0595	0.0000	3	0.0000	0.0000	PAGO	VENDA	300.00	318.1795	1.1400	1.4906	107.00	24.00	324.00	302.6306	\N	1	1	\N	10	-99	-99	7.00	3.43	50.72	3.00	0	5.00	0.00
32	2024-09-11 03:44:18.317015	2024-10-10 14:34:22.073066	2	2.9972	0.0000	0.0000	f	1726037058741	0.0000	2024-09-11 03:44:18.308485	0.0000	f	0.0000	113050	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
39	2024-09-27 15:59:20.434783	2024-10-10 14:34:22.076207	5	11.4351	0.0000	0.0000	f	1727463561030	0.0000	2024-09-27 15:59:20.416695	0.0000	f	0.0000	274018	40.7600	0.4092	40.3551	0.0000	4	0.0000	0.0000	PAGO	VENDA	150.00	161.4351	0.5701	0.9359	40.76	32.00	146.28	151.5060	\N	1	1	\N	10	-99	-99	9.00	3.39	50.01	3.00	0	62.24	5.00
34	2024-09-11 13:29:04.984292	2024-10-10 14:34:22.079868	6	2.9972	0.0000	0.0000	f	1726072148333	0.0000	2024-09-11 13:29:04.956355	0.0000	f	0.0000	119494	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
29	2024-09-11 03:11:59.786044	2024-10-10 14:34:22.083038	2	2.9972	0.0000	0.0000	f	1726035124236	0.0000	2024-09-11 03:11:59.763406	0.0000	f	0.0000	117545	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
27	2024-09-11 02:50:31.755433	2024-10-10 14:34:22.087788	3	2.9972	0.0000	0.0000	f	1726033835985	0.0000	2024-09-11 02:50:31.727936	0.0000	f	0.0000	117188	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	117.00	0.00
33	2024-09-11 03:51:17.927119	2024-10-10 14:34:22.092244	2	2.9972	0.0000	0.0000	f	1726037478995	0.0000	2024-09-11 03:51:17.91841	0.0000	f	0.0000	119140	103.6500	0.6488	102.9972	0.0000	1	0.0000	0.0000	PAGO	VENDA	100.00	102.9972	0.3800	0.2460	103.65	8.00	108.00	100.6260	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
42	2024-10-10 17:27:44.955079	2024-10-10 17:28:03.574606	1	14.9861	0.0000	0.0000	f	1728592069067	0.0000	2024-10-10 17:27:44.931476	0.0000	f	0.0000	109240	518.2300	3.2440	514.9861	0.0000	1	0.0000	0.0000	CANCELADO	VENDA	500.00	514.9861	1.9000	1.2300	518.23	8.00	508.00	503.1300	\N	1	1	\N	10	4	4	4.00	3.63	54.24	3.00	0	0.00	0.00
41	2024-10-10 16:54:30.482355	2024-10-10 17:28:06.535948	1	4.4958	0.0000	0.0000	f	1728590071569	0.0000	2024-10-10 16:54:30.446533	0.0000	f	0.0000	104401	155.4700	0.9732	154.4958	0.0000	1	0.0000	0.0000	CANCELADO	VENDA	150.00	154.4958	0.5700	0.3690	155.47	8.00	158.00	150.9390	\N	1	1	\N	10	4	-99	4.00	3.63	54.24	3.00	0	0.00	0.00
47	2024-10-30 09:24:08.463519	2024-10-30 09:24:08.46356	0	0.0000	0.0000	0.0000	f	1730291051535	0.0000	2024-10-30 09:24:08.419262	0.0000	f	0.0000	\N	0.0000	0.0000	0.0000	0.0000	1	0.0000	0.0000	PENDENTE_ANTECIPACAO	ANTECIPACAO	216.19	0.0000	0.0000	0.0000	216.19	0.00	216.19	0.0000	\N	1	3	\N	\N	\N	\N	0.00	0.00	0.00	0.00	0	0.00	0.00
40	2024-10-10 15:05:11.347672	2024-12-16 16:06:27.380731	12	4.4958	0.0000	0.0000	f	1728583512523	0.0000	2024-10-10 15:05:11.329318	0.0000	f	0.0000	103212	155.4700	0.9732	154.4958	0.0000	1	0.0000	0.0000	PAGO	VENDA	150.00	154.4958	0.5700	0.3690	155.47	8.00	158.00	150.9390	\N	1	1	\N	10	-99	-99	4.00	3.63	54.24	3.00	0	168.48	100.00
44	2024-10-17 20:39:34.682202	2024-12-16 16:06:27.656065	4	11.4351	0.0000	0.0000	f	1729208379464	0.0000	2024-10-17 20:39:34.618221	0.0000	f	0.0000	176077	40.7600	0.4092	40.3551	0.0000	4	0.0000	0.0000	PAGO	VENDA	150.00	161.4351	0.5701	0.9359	40.76	32.00	182.00	151.5060	\N	1	1	\N	10	-99	-99	9.00	3.39	50.01	3.00	0	97.52	0.00
46	2024-10-17 20:54:47.582343	2024-12-16 16:06:27.694183	6	45.9022	0.0000	0.0000	f	1729209292303	0.0000	2024-10-17 20:54:47.568437	0.0000	f	0.0000	175644	110.4300	1.2505	109.1822	0.0000	5	0.0000	0.0000	PAGO	VENDA	500.00	545.9022	1.9000	3.7626	110.43	40.00	540.00	505.6626	\N	1	3	\N	10	-99	-99	10.00	3.36	49.54	3.00	0	355.29	0.00
45	2024-10-17 20:54:10.775796	2024-12-16 16:06:27.761335	6	16.1411	0.0000	0.0000	f	1729209254072	0.0000	2024-10-17 20:54:10.761838	0.0000	f	0.0000	177578	28.0500	0.3539	27.6911	0.0000	6	0.0000	0.0000	PAGO	VENDA	150.00	166.1411	0.5700	1.3230	28.05	48.00	198.00	151.8930	\N	1	1	\N	10	-99	-99	12.00	3.34	49.19	3.00	0	144.20	0.00
48	2024-11-25 11:32:03.019089	2024-12-16 16:06:27.792478	7	53.8037	0.0000	0.0000	f	1732545124230	0.0000	2024-11-25 11:32:02.965511	0.0000	f	0.0000	259531	93.4800	1.1798	92.3037	0.0000	6	0.0000	0.0000	PAGO	VENDA	500.00	553.8037	1.9000	4.4109	93.48	48.00	548.00	506.3109	\N	1	1	\N	10	-99	-99	12.00	3.34	49.19	3.00	0	553.07	0.00
49	2024-12-16 16:13:13.174606	2024-12-16 16:15:44.573316	3	39.0200	0.0000	0.0000	f	1734376393373	0.0000	2024-12-16 16:13:13.168058	0.0000	f	0.0000	161647	196.3455	1.7241	194.6214	0.0000	3	0.0000	0.0000	ESTORNADO	VENDA	550.00	589.0200	2.1000	2.7300	196.35	24.00	574.00	554.8300	\N	1	1	8	10	-99	-99	7.00	3.43	50.73	3.00	0	0.00	0.00
51	2024-12-16 17:08:00.62877	2024-12-16 17:08:08.679156	1	44.0000	0.0000	0.0000	f	1734379681752	0.0000	2024-12-16 17:08:00.611067	0.0000	f	0.0000	166066	135.9992	1.3626	134.6366	0.0000	4	0.0000	0.0000	ATIVO	VENDA	500.00	544.0000	1.8900	3.1200	136.00	36.00	536.00	505.0100	\N	4	1	\N	11	-99	-99	9.00	3.39	50.00	3.00	0	0.00	0.00
50	2024-12-16 16:25:06.044753	2024-12-16 18:34:15.565791	3	35.4700	0.0000	0.0000	f	1734377109680	0.0000	2024-12-16 16:25:06.039774	0.0000	f	0.0000	163712	178.4920	1.5635	176.9285	0.0000	3	0.0000	0.0000	ESTORNADO	VENDA	500.00	535.4700	1.9000	2.4800	178.49	24.00	524.00	504.3800	\N	1	1	9	10	-99	-99	7.00	3.43	50.71	3.00	0	0.00	0.00
52	2024-12-17 09:23:51.545792	2024-12-17 09:37:36.733573	3	10.6500	0.0000	0.0000	f	1734438235797	0.0000	2024-12-17 09:23:51.515868	0.0000	f	0.0000	175011	53.5498	0.4712	53.0786	0.0000	3	0.0000	0.0000	ESTORNADO	VENDA	150.00	160.6500	0.5700	0.7500	53.55	24.00	174.00	151.3200	\N	1	1	10	10	-99	-99	7.00	3.43	50.75	3.00	0	0.00	0.00
53	2024-12-17 14:41:46.740391	2024-12-17 14:53:46.040119	3	13.2000	0.0000	0.0000	f	1734457307954	0.0000	2024-12-17 14:41:46.674116	0.0000	f	0.0000	176621	40.7989	0.4079	40.3910	0.0000	4	0.0000	0.0000	ESTORNADO	VENDA	150.00	163.2000	0.5700	0.9300	40.80	32.00	182.00	151.5000	\N	1	1	11	10	-99	-99	9.00	3.39	49.98	3.00	0	0.00	0.00
54	2024-12-24 10:11:33.428592	2024-12-24 10:11:42.220501	1	48.4000	0.0000	0.0000	f	1735045895333	0.0000	2024-12-24 10:11:33.401361	0.0000	f	0.0000	243910	149.6016	1.5013	148.1003	0.0000	4	0.0000	0.0000	ATIVO	VENDA	550.00	598.4000	2.0900	3.4300	149.60	32.00	582.00	555.5200	\N	1	1	\N	10	-99	-99	9.00	3.39	50.01	3.00	0	0.00	0.00
\.


--
-- Data for Name: t_contrato_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_contrato_transacao (id_contrato, id_transacao) FROM stdin;
7	7
7	8
8	9
8	10
9	19
10	35
10	36
11	37
12	39
12	40
13	41
13	42
14	43
14	45
15	44
15	46
16	48
16	49
17	51
17	52
18	53
18	54
19	55
19	56
20	57
20	58
21	60
21	61
22	64
22	65
23	66
23	67
25	70
25	71
26	72
26	73
27	74
27	75
28	76
28	77
29	78
29	79
30	80
30	81
31	82
31	83
32	84
32	85
33	86
33	87
34	88
34	89
35	96
35	97
24	68
24	69
24	108
24	111
36	120
36	121
37	128
37	129
38	136
38	137
39	146
39	147
40	158
40	159
42	161
42	162
41	160
41	163
43	164
43	165
44	176
44	177
45	178
45	179
46	180
46	181
47	182
48	185
48	186
49	209
49	210
49	211
49	212
51	217
51	218
50	215
50	216
50	220
50	221
52	223
52	224
52	226
52	227
53	229
53	230
53	231
53	232
54	233
54	234
\.


--
-- Data for Name: t_endereco; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_endereco (id_endereco, insert_date, update_date, version, bairro, cep, cidade, codigo_ibge, complemento, estado, numero, rua) FROM stdin;
1	2024-06-19 01:38:11.680713	2024-06-19 01:38:11.680713	0	CENTRO	69010010	MANAUS	\N	41006771	AM	539	RUA HENRIQUE MARTINS539
2	2024-06-19 01:39:50.009251	2024-06-19 01:39:50.00927	0	Camalaú	58103212	Cabedelo	PB		PB	777	Rua São Miguel
5	2024-06-26 14:36:22.352576	2024-06-26 14:36:22.352616	0	Camalaú	58103212	Cabedelo	PB		PB	841	Rua São Miguel
6	2024-08-26 17:13:11.094391	2024-08-26 17:13:11.094413	0	Camalaú	58103212	Cabedelo	PB		PB	554	Rua São Miguel
7	2024-09-05 11:25:11.56489	2024-11-05 03:44:10.941794	3	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
3	2024-06-20 14:28:28.180222	2024-12-16 18:32:51.994805	8	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
4	2024-06-25 11:32:40.083186	2024-12-18 09:37:08.872492	2	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
8	2024-10-11 01:49:25.696628	2024-12-18 09:38:17.743041	1	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
\.


--
-- Data for Name: t_endereco_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_endereco_aud (id_endereco, rev, revtype, bairro, cep, cidade, codigo_ibge, complemento, estado, numero, rua) FROM stdin;
2	1	0	Camalaú	58103212	Cabedelo	PB		PB	777	Rua São Miguel
3	9	0	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
4	11	0	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
5	12	0	Camalaú	58103212	Cabedelo	PB		PB	841	Rua São Miguel
3	221	1	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
6	233	0	Camalaú	58103212	Cabedelo	PB		PB	554	Rua São Miguel
7	260	0	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
8	363	0	Camalaú	58103212	Cabedelo	\N		PB	777	Rua São Miguel
\.


--
-- Data for Name: t_estabelecimento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_estabelecimento (id_estabelecimento, insert_date, update_date, version, cnpj, codigo_externo, nome_fantasia, razao_social, status, id_administradora_rede, id_endereco) FROM stdin;
1	2024-06-19 01:39:50.0271	2024-08-19 17:41:03.270895	7	11243020000100	5	Malta 	Malta Frigoríficos LTDA	ATIVO	1	2
3	2024-08-26 17:13:11.101186	2024-09-09 10:33:00.834183	3	11243020001001	7	Malta 2	Malta Frigoríficos LTDA 2	ATIVO	1	6
2	2024-06-26 14:36:22.364782	2024-10-09 15:04:48.833419	9	49018829000100	4	Mateus das Carnes	Frigorífico Mateus	ATIVO	2	5
\.


--
-- Data for Name: t_estabelecimento_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_estabelecimento_aud (id_estabelecimento, rev, revtype, cnpj, codigo_externo, nome_fantasia, razao_social, status, id_administradora_rede, id_endereco) FROM stdin;
1	1	0	11243020000100	5	Malta 	Malta Frigoríficos LTDA	ATIVO	1	2
2	12	0	49018829000100	3	Mateus das Carnes	Frigorífico Mateus	ATIVO	1	5
1	153	1	11243020000100	5	Malta 	Malta Frigoríficos LTDA	CANCELADO	1	2
1	154	1	11243020000100	5	Malta 	Malta Frigoríficos LTDA	CANCELADO	1	2
1	155	1	11243020000100	5	Malta 	Malta Frigoríficos LTDA	ATIVO	1	2
1	183	1	11243020000100	5	Malta 	Malta Frigoríficos LTDA	CANCELADO	1	2
1	184	1	11243020000100	5	Malta 	Malta Frigoríficos LTDA	ATIVO	1	2
2	185	1	49018829000100	3	Mateus das Carnes	Frigorífico Mateus	ATIVO	1	5
2	186	1	49018829000100	3	Mateus das Carnes	Frigorífico Mateus	CANCELADO	1	5
2	187	1	49018829000100	3	Mateus das Carnes	Frigorífico Mateus	CANCELADO	1	5
2	188	1	49018829000100	3	Mateus das Carnes	Frigorífico Mateus	ATIVO	1	5
1	189	1	11243020000100	5	Malta 	Malta Frigoríficos LTDA	CANCELADO	1	2
1	190	1	11243020000100	5	Malta 	Malta Frigoríficos LTDA	ATIVO	1	2
2	226	1	49018829000100	3	Mateus das Carnes	Frigorífico Mateus	CANCELADO	1	5
2	227	1	49018829000100	4	Mateus das Carnes	Frigorífico Mateus	CANCELADO	1	5
3	233	0	11243020001001	7	Malta 2	Malta Frigoríficos LTDA 2	ATIVO	1	6
2	258	1	49018829000100	4	Mateus das Carnes	Frigorífico Mateus	ATIVO	1	5
2	259	1	49018829000100	4	Mateus das Carnes	Frigorífico Mateus	ATIVO	1	5
3	263	1	11243020001001	7	Malta 2	Malta Frigoríficos LTDA 2	CANCELADO	1	6
3	264	1	11243020001001	7	Malta 2	Malta Frigoríficos LTDA 2	CANCELADO	1	6
3	265	1	11243020001001	7	Malta 2	Malta Frigoríficos LTDA 2	ATIVO	1	6
2	356	1	49018829000100	4	Mateus das Carnes	Frigorífico Mateus	ATIVO	2	5
\.


--
-- Data for Name: t_estabelecimento_contato; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_estabelecimento_contato (id_estabelecimento, id_contato) FROM stdin;
\.


--
-- Data for Name: t_estabelecimento_contato_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_estabelecimento_contato_aud (rev, id_estabelecimento, id_contato, revtype) FROM stdin;
1	1	1	0
12	2	2	0
154	1	1	2
185	2	2	2
185	2	4	0
187	2	4	2
227	2	9	0
233	3	10	0
259	2	9	2
264	3	10	2
\.


--
-- Data for Name: t_estorno; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_estorno (id_estorno, insert_date, update_date, version, data, nsu, observacao, origem, status, valor, id_contrato, id_pagamento, id_user_conclusao, id_user_solicitacao) FROM stdin;
1	2024-09-25 02:18:20.509056	2024-09-25 11:06:15.896201	1	2024-09-25 02:18:20.476663	254435	lolookoklolkolololololololololo	BACKOFFICE	ATIVO	108.0000	24	\N	-99	-99
2	2024-09-25 11:39:37.454879	2024-09-25 11:40:48.426109	1	2024-09-25 11:39:37.443648	254387	teste estorno do bnpl-548	BACKOFFICE	ATIVO	117.5100	\N	10	-99	-99
3	2024-09-25 13:29:55.849424	2024-09-25 17:57:45.188625	1	2024-09-25 13:29:55.833257	258238	uauooaosoasoasaosasoaso	BACKOFFICE	ATIVO	117.5100	\N	11	-99	-99
4	2024-09-25 19:37:45.2369	2024-09-25 19:38:25.862399	1	2024-09-25 19:37:45.229374	252231	lllllllllllllllllllllllllllllllllllllllllllllllllllllll	BACKOFFICE	ATIVO	122.7000	\N	12	-99	-99
5	2024-09-27 14:32:45.112521	2024-09-27 14:33:38.874083	1	2024-09-27 14:32:45.10012	279346	teste test teste teste teste	BACKOFFICE	ATIVO	56.1900	\N	13	-99	-99
6	2024-09-27 15:30:45.871507	2024-09-27 15:31:03.225965	1	2024-09-27 15:30:45.853336	278368	gggggkkspodakpodakpdoakodpaopd	BACKOFFICE	ATIVO	56.6100	\N	15	-99	-99
7	2024-09-27 16:18:05.309161	2024-09-27 16:18:14.779443	1	2024-09-27 16:18:05.290577	272839	llllllllllllllllllllllllllllllllllllllllllllllllllll	BACKOFFICE	ATIVO	56.6100	\N	18	-99	-99
8	2024-12-16 16:15:31.839787	2024-12-16 16:15:44.577224	1	2024-12-16 16:15:31.822966	168182	uasuasushuasahusausasuashuashsauashuashuasasuahsua	BACKOFFICE	ATIVO	574.0000	49	\N	-99	-99
9	2024-12-16 18:34:05.73273	2024-12-16 18:34:15.568547	1	2024-12-16 18:34:05.71948	167059	yaushasuhasuahsuashuashuashasuhasuahsuashuas	BACKOFFICE	ATIVO	524.0000	50	\N	-99	-99
10	2024-12-17 09:35:20.534081	2024-12-17 09:37:36.736661	1	2024-12-17 09:35:20.512735	175024	llllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllllll	BACKOFFICE	ATIVO	174.0000	52	\N	-99	-99
11	2024-12-17 14:51:07.371618	2024-12-17 14:53:46.042869	1	2024-12-17 14:51:07.331173	173227	Estorno total de venda. Cpf/Cnpj: 26629231058 Código de Barra: 1734457307954 NSU: 176621	PDV	ATIVO	182.0000	53	\N	-99	-99
\.


--
-- Data for Name: t_estorno_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_estorno_transacao (id_estorno, id_transacao) FROM stdin;
1	108
1	111
2	114
2	115
3	118
3	119
4	126
4	127
5	132
5	133
6	140
6	141
7	152
7	153
8	211
8	212
9	220
9	221
10	226
10	227
11	231
11	232
\.


--
-- Data for Name: t_execucao_job_agenda_repasse; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_execucao_job_agenda_repasse (id_execucao_job_agenda_repasse, insert_date, update_date, version, data_referencia, url_s3_arquivo_recebiveis_lojas) FROM stdin;
\.


--
-- Data for Name: t_feriado; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_feriado (id_feriado, insert_date, update_date, version, data, descricao, status) FROM stdin;
2	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-01-01	Ano Novo	ATIVO
3	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-02-12	Carnaval	ATIVO
4	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-02-13	Carnaval	ATIVO
7	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-05-01	Dia do Trabalhador	ATIVO
8	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-06-20	Corpus Christi	ATIVO
11	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-11-02	Finados	ATIVO
12	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-11-15	Proclamação da República	ATIVO
14	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-08-15	Assunção de Nossa Senhora	ATIVO
15	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-07-09	Revolução Constitucionalista	ATIVO
16	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-06-24	São João	ATIVO
17	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-01-20	São Sebastião	ATIVO
18	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-02-24	Dia de São João	ATIVO
19	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-03-08	Dia Internacional da Mulher	ATIVO
20	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-03-19	Dia de São José	ATIVO
22	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-05-13	Abolição da Escravatura	ATIVO
24	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-06-29	Dia de São Pedro	ATIVO
25	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-07-16	Nossa Senhora do Carmo	ATIVO
26	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-07-25	São Cristóvão	ATIVO
27	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-08-11	Dia do Advogado	ATIVO
28	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-09-20	Dia do Gaúcho	ATIVO
29	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-10-04	Dia de São Francisco	ATIVO
30	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-10-28	Dia do Servidor Público	ATIVO
31	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-11-20	Dia da Consciência Negra	ATIVO
32	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-12-08	Dia de Nossa Senhora da Conceição	ATIVO
33	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-01-25	Aniversário de São Paulo	ATIVO
34	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-02-02	Dia de Iemanjá	ATIVO
35	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-05-08	Dia da Vitória	ATIVO
36	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-08-22	Dia do Folclore	ATIVO
37	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-09-15	Dia do Cliente	ATIVO
38	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-12-26	Boxing Day	ATIVO
39	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-03-01	Carnaval (Pós-Quarta-Feira de Cinzas)	ATIVO
40	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-11-04	Dia do Escoteiro	ATIVO
41	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-12-31	Véspera de Ano Novo	ATIVO
6	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-04-21	Tiradentes	CANCELADO
9	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-09-07	Independência do Brasil	CANCELADO
13	2024-08-15 15:57:26.955173	2024-08-15 15:57:26.955173	1	2024-12-25	Natal	CANCELADO
21	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-04-23	Dia de São Jorge	CANCELADO
23	2024-08-15 16:24:31.409461	2024-08-15 16:24:31.409461	1	2024-06-13	Dia de Santo Antônio	CANCELADO
1	2024-08-15 15:41:57.260549	2024-08-16 03:30:46.3382	1	2024-08-15	1	CANCELADO
10	2024-08-15 15:57:26.955173	2024-08-16 03:30:52.010105	2	2024-10-12	Nossa Senhora Aparecida	CANCELADO
5	2024-08-15 15:57:26.955173	2024-08-19 07:35:10.473427	2	2024-03-29	Sexta-feira Santa	CANCELADO
\.


--
-- Data for Name: t_feriado_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_feriado_aud (id_feriado, rev, revtype, data, descricao, status) FROM stdin;
1	114	0	2024-08-15	1	ATIVO
1	144	1	2024-08-15	1	CANCELADO
10	145	1	2024-10-12	Nossa Senhora Aparecida	CANCELADO
5	165	1	2024-03-29	Sexta-feira Santa	CANCELADO
\.


--
-- Data for Name: t_funcionario; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_funcionario (id_funcionario, insert_date, update_date, version, cpf, email, nome, status, id_estabelecimento, id_user) FROM stdin;
2	2024-08-26 13:38:05.052066	2024-08-26 14:14:12.264686	3	07533748404	peter.costa@rpe.tech	Peter Costa	ATIVO	1	4
1	2024-08-16 15:23:47.690163	2024-09-09 10:32:48.653528	4	60533801052	bnpl@rpe.tech	BNPL	ATIVO	2	3
\.


--
-- Data for Name: t_funcionario_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_funcionario_aud (id_funcionario, rev, revtype, cpf, email, nome, status) FROM stdin;
1	156	0	07533648404	petersvcosta@gmail.com	Peter	ATIVO
1	211	1	07533648404	peter.costa@rpe.tech	Peter	ATIVO
1	212	1	07533648404	petersvcosta@gmail.com	Peter	ATIVO
2	213	0	07533748404	peter.costa@rpe.tech	Peter 2	ATIVO
2	223	1	07533748404	peter.costa@rpe.tech	Peter 2	CANCELADO
2	224	1	07533748404	peter.costa@rpe.tech	Peter Costa	CANCELADO
2	225	1	07533748404	peter.costa@rpe.tech	Peter Costa	ATIVO
1	261	1	07533648404	petersvcosta@gmail.com	Peter	CANCELADO
1	262	1	07533648404	petersvcosta@gmail.com	Peter	ATIVO
\.


--
-- Data for Name: t_funcionario_contato; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_funcionario_contato (id_funcionario, id_contato) FROM stdin;
1	6
2	8
\.


--
-- Data for Name: t_funcionario_contato_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_funcionario_contato_aud (rev, id_funcionario, id_contato, revtype) FROM stdin;
156	1	3	0
211	1	3	2
211	1	5	0
212	1	5	2
212	1	6	0
213	2	7	0
224	2	7	2
224	2	8	0
\.


--
-- Data for Name: t_horizon; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_horizon (id_horizon, insert_date, update_date, version, ambiente, authorization_token, client, content_type, grant_type, password, path_token, token, url, username) FROM stdin;
\.


--
-- Data for Name: t_horizon_servico; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_horizon_servico (id_horizon_servico, insert_date, update_date, version, content_type, path_servico, servico, id_horizon) FROM stdin;
\.


--
-- Data for Name: t_informacao_banco; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_informacao_banco (id_informacao_banco, insert_date, update_date, version, agencia, banco, cnpj, conta, digito_agencia, razao, status) FROM stdin;
\.


--
-- Data for Name: t_integracao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_integracao (id_integracao, insert_date, update_date, version, ambiente, key_webhook, servico, url_base) FROM stdin;
2	2024-07-16 23:19:47.098383	2024-07-16 23:19:47.098383	0	DEV	\N	PORTUNO	https://portuno.herokuapp.com/api/1.0/
4	2024-12-16 19:49:20.417663	2024-12-16 19:49:20.417663	0	DEV	8d9f6a35076f7e9d76eb53adaadfd824bebdf6e7f357e10f5bf4231a1bb8d475	BOLETO_SIMPLES	https://api-sandbox.kobana.com.br/v1
\.


--
-- Data for Name: t_integracao_header; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_integracao_header (id_integracao_header, insert_date, update_date, version, header, valor, id_integracao) FROM stdin;
7	2024-07-16 23:20:05.407044	2024-07-16 23:20:05.407044	0	Content-Type	application/json	2
8	2024-07-16 23:20:05.407044	2024-07-16 23:20:05.407044	0	Authorization	Bearer eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MTU4MTQ1NjMsInVzZXJJRCI6MSwidGVuYW50IjoicHVibGljIiwidmVyc2lvbiI6MH0.K8Uqn1gfgANZw8L7u4sWu_SIaHe5SHC6Qs7vVTXppCY	2
12	2024-12-16 19:49:20.417663	2024-12-16 19:49:20.417663	0	Content-Type	application/json	4
14	2024-12-16 19:49:20.417663	2024-12-16 19:49:20.417663	0	User-Agent	Korporate (alex@kamaleon.com.br)	4
13	2024-12-16 19:49:20.417663	2024-12-16 19:49:20.417663	0	Authorization	Bearer djyfomzFDcSSELrSsMVtD8pEohNHqLvcnr-CZhFQPQ8	4
\.


--
-- Data for Name: t_lancamento_ajuste; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_lancamento_ajuste (id_lancamento_ajuste, insert_date, update_date, version, valor, id_tipo_lancamento_ajuste, id_cdc, id_consumidor, id_user, id_estabelecimento, data_lancamento) FROM stdin;
326	2024-09-11 13:32:55.272482	2024-09-11 13:32:55.272498	0	4.93	3	196	1	-99	2	2024-09-11
327	2024-09-11 14:43:24.121227	2024-09-11 14:43:24.121241	0	14.75	3	185	1	-99	2	2024-09-11
328	2024-09-11 14:44:17.611292	2024-09-11 14:44:17.611312	0	25.00	3	185	1	-99	2	2024-09-11
329	2024-09-11 15:17:40.614432	2024-09-11 15:17:40.614448	0	25.00	3	185	1	-99	2	2024-09-11
330	2024-09-11 15:18:19.130854	2024-09-11 15:18:19.130862	0	43.56	4	185	1	-99	2	2024-09-11
331	2024-09-11 15:20:49.175106	2024-09-11 15:20:49.175116	0	41.00	4	172	1	-99	2	2024-09-11
332	2024-09-11 15:21:29.901394	2024-09-11 15:21:29.901411	0	41.00	3	172	1	-99	2	2024-09-11
333	2024-09-11 15:23:22.733306	2024-09-11 15:23:22.733316	0	58.00	3	186	1	-99	2	2024-09-11
334	2024-09-11 15:24:58.648752	2024-09-11 15:24:58.648779	0	63.44	4	186	1	-99	2	2024-09-11
335	2024-09-11 15:26:02.967604	2024-09-11 15:26:02.967612	0	83.27	4	184	1	-99	2	2024-09-11
336	2024-09-11 15:26:44.594661	2024-09-11 15:26:44.594673	0	190.20	3	184	1	-99	2	2024-09-11
337	2024-09-11 15:38:17.318134	2024-09-11 15:38:17.318151	0	9.77	3	187	1	-99	2	2024-09-11
338	2024-09-11 15:38:30.901682	2024-09-11 15:38:30.901696	0	82.43	4	187	1	-99	2	2024-09-11
339	2024-09-13 14:39:51.146345	2024-09-13 14:39:51.146361	0	56.43	4	188	1	-99	2	2024-09-13
340	2024-09-13 14:40:12.036642	2024-09-13 14:40:12.036652	0	136.43	3	188	1	-99	2	2024-09-13
346	2024-09-13 17:10:45.321217	2024-09-13 17:10:45.321255	0	117.00	3	189	1	-99	2	2024-09-13
347	2024-09-25 19:19:33.790216	2024-09-25 19:19:33.790229	0	0.05	27	199	1	-99	1	2024-09-25
348	2024-09-25 19:21:07.906855	2024-09-25 19:21:07.906866	0	4.95	62	199	1	-99	1	2024-09-25
349	2024-09-27 16:05:56.212433	2024-09-27 16:05:56.212443	0	5.00	65	210	1	-99	1	2024-09-27
350	2024-09-27 16:06:54.693847	2024-09-27 16:06:54.693857	0	5.00	64	210	1	-99	1	2024-09-27
351	2024-09-30 09:25:25.62228	2024-09-30 09:25:25.622303	0	57.24	64	210	1	-99	1	2024-09-30
352	2024-10-16 08:58:32.148857	2024-10-16 08:58:32.148885	0	57.24	64	214	1	-99	1	2024-10-30
353	2024-10-16 09:03:50.953755	2024-10-16 09:03:50.953774	0	57.24	63	214	1	-99	1	2024-10-30
354	2024-10-16 09:05:03.867963	2024-10-16 09:05:03.867971	0	2.00	63	214	1	-99	1	2024-10-30
355	2024-10-16 09:05:25.15339	2024-10-16 09:05:25.153397	0	2.00	63	214	1	-99	1	2024-10-30
356	2024-10-16 09:05:35.570799	2024-10-16 09:05:35.57081	0	25.00	64	214	1	-99	1	2024-10-30
357	2024-10-16 09:06:29.482286	2024-10-16 09:06:29.482295	0	25.00	65	214	1	-99	1	2024-10-30
358	2024-10-16 09:06:33.92929	2024-10-16 09:06:33.929309	0	25.00	65	214	1	-99	1	2024-10-30
359	2024-10-16 09:06:35.342193	2024-10-16 09:06:35.342205	0	25.00	65	214	1	-99	1	2024-10-30
360	2024-10-16 09:06:36.490611	2024-10-16 09:06:36.49062	0	25.00	65	214	1	-99	1	2024-10-30
361	2024-10-16 09:06:41.930944	2024-10-16 09:06:41.930958	0	25.00	64	214	1	-99	1	2024-10-30
362	2024-10-31 12:02:20.854523	2024-10-31 12:02:20.854568	0	2.00	64	232	1	-99	1	2024-10-31
363	2024-10-31 12:24:28.773132	2024-10-31 12:24:28.773151	0	2.00	64	232	1	-99	1	2024-10-31
364	2024-12-16 16:06:27.427802	2024-12-16 16:06:27.427814	0	45.67	-2	234	1	-99	1	2024-12-16
365	2024-12-16 16:06:27.500336	2024-12-16 16:06:27.500346	0	118.43	-2	230	1	-99	1	2024-12-16
366	2024-12-16 16:06:27.537829	2024-12-16 16:06:27.537835	0	36.05	-2	224	1	-99	1	2024-12-16
367	2024-12-16 16:06:27.555168	2024-12-16 16:06:27.555174	0	48.76	-2	220	1	-99	1	2024-12-16
368	2024-12-16 16:06:27.577073	2024-12-16 16:06:27.577076	0	101.48	-2	235	1	-99	1	2024-12-16
369	2024-12-16 16:06:27.596331	2024-12-16 16:06:27.596334	0	118.43	-2	231	1	-99	1	2024-12-16
370	2024-12-16 16:06:27.613298	2024-12-16 16:06:27.613303	0	36.05	-2	225	1	-99	1	2024-12-16
371	2024-12-16 16:06:27.635079	2024-12-16 16:06:27.635087	0	48.76	-2	221	1	-99	1	2024-12-16
372	2024-12-16 16:06:27.663375	2024-12-16 16:06:27.663383	0	101.48	-2	236	1	-99	1	2024-12-16
373	2024-12-16 16:06:27.68091	2024-12-16 16:06:27.680913	0	114.43	-2	232	1	-99	1	2024-12-16
374	2024-12-16 16:06:27.701189	2024-12-16 16:06:27.7012	0	36.05	-2	226	1	-99	1	2024-12-16
375	2024-12-16 16:06:27.721999	2024-12-16 16:06:27.722005	0	101.48	-2	237	1	-99	1	2024-12-16
376	2024-12-16 16:06:27.74203	2024-12-16 16:06:27.742037	0	36.05	-2	227	1	-99	1	2024-12-16
377	2024-12-16 16:06:27.766317	2024-12-16 16:06:27.766321	0	101.48	-2	238	1	-99	1	2024-12-16
378	2024-12-16 16:06:27.782455	2024-12-16 16:06:27.782457	0	101.48	-2	239	1	-99	1	2024-12-16
\.


--
-- Data for Name: t_pagamento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_pagamento (id_pagamento, insert_date, update_date, version, data, iof_adicional_atraso, iof_diario_atraso, mora, multa, nsu, status, tipo, valor, valor_taxa_operacao, valor_total, id_boleto, id_consumidor, id_estabelecimento, id_estorno, id_user_conclusao, id_user_solicitacao, ajuste_credito, ajuste_debito, desconto_pagamento_antecipado) FROM stdin;
1	2024-07-16 15:03:29.806496	2024-07-16 15:05:36.24872	1	2024-07-16 15:03:29.744712	0.00	0.00	0.00	0.00	167376	ATIVO	PDV	224.33	0.00	224.33	\N	1	1	\N	-99	-99	0.00	0.00	0.00
2	2024-08-03 03:13:18.00385	2024-08-03 03:13:18.00388	0	2024-08-03 03:13:17.983016	0.00	0.00	19.97	1.64	039732	PENDENTE	PDV	82.05	0.00	103.66	\N	1	1	\N	\N	-99	0.00	0.00	0.00
3	2024-08-03 03:26:10.376171	2024-08-03 03:26:10.376201	0	2024-08-03 03:26:10.324981	0.00	0.00	19.97	1.64	033206	PENDENTE	PDV	103.05	0.00	124.66	\N	1	1	\N	\N	-99	0.00	0.00	0.00
4	2024-09-02 03:50:33.972126	2024-09-02 03:50:33.972135	0	2024-09-02 03:50:33.89747	0.00	0.00	119.40	4.77	028850	PENDENTE	PDV	4408.09	26.00	4558.26	\N	1	1	\N	\N	-99	0.00	0.00	0.00
5	2024-09-08 22:14:12.551984	2024-09-08 22:14:12.551992	0	2024-09-08 22:14:12.545095	0.00	0.00	0.00	0.00	085435	PENDENTE	PDV	72.34	8.00	80.34	\N	1	1	\N	\N	-99	0.00	0.00	0.00
6	2024-09-10 16:44:50.131032	2024-09-10 16:45:28.312203	1	2024-09-10 16:44:50.118796	0.00	0.00	0.00	0.00	101159	ATIVO	PDV	102.59	8.00	110.59	\N	1	1	\N	-99	-99	0.00	0.00	0.00
7	2024-09-11 15:28:11.840632	2024-09-11 15:29:08.01798	1	2024-09-11 15:28:11.82385	0.00	0.00	2.21	2.07	118132	CANCELADO	PDV	103.65	8.00	115.93	\N	1	1	\N	-99	-99	0.00	0.00	0.00
8	2024-09-11 15:29:41.913736	2024-09-11 15:30:29.478125	1	2024-09-11 15:29:41.901001	0.00	0.00	2.21	2.07	118977	ATIVO	PDV	103.65	8.00	115.93	\N	1	1	\N	-99	-99	0.00	0.00	0.00
9	2024-09-13 14:41:12.613286	2024-09-13 14:41:25.073504	1	2024-09-13 14:41:12.60171	0.00	0.00	0.95	0.63	135950	ATIVO	PDV	103.65	8.00	33.23	\N	1	1	\N	-99	-99	136.43	56.43	0.00
10	2024-09-25 11:32:12.570239	2024-09-25 11:40:48.424084	3	2024-09-25 11:32:12.538662	0.00	0.00	8.66	2.13	255324	ESTORNADO	PDV	103.65	8.00	117.51	\N	1	1	2	-99	-99	4.93	0.00	0.00
11	2024-09-25 13:28:27.132627	2024-09-25 17:57:45.186154	3	2024-09-25 13:28:27.09255	0.00	0.00	8.66	2.13	258499	ESTORNADO	PDV	103.65	8.00	117.51	\N	1	1	3	-99	-99	4.93	0.00	0.00
12	2024-09-25 19:33:27.374429	2024-09-25 19:38:25.860386	3	2024-09-25 19:33:27.362695	0.00	0.00	5.40	2.30	253580	ESTORNADO	PDV	107.00	8.00	122.70	\N	1	1	4	-99	-99	0.00	0.00	0.00
13	2024-09-27 14:28:03.125758	2024-09-27 14:33:38.872247	3	2024-09-27 14:28:03.107773	0.00	0.00	6.45	0.98	271020	ESTORNADO	PDV	40.76	8.00	56.19	\N	1	1	5	-99	-99	0.00	0.00	0.00
14	2024-09-27 14:45:31.675603	2024-09-27 14:45:41.339134	1	2024-09-27 14:45:31.656674	0.00	0.00	6.45	0.98	276543	ATIVO	PDV	163.04	32.00	202.47	\N	1	1	\N	-99	-99	0.00	0.00	0.00
15	2024-09-27 15:26:01.002396	2024-09-27 15:31:03.223823	3	2024-09-27 15:26:00.986626	0.00	0.00	6.87	0.98	279841	ESTORNADO	PDV	40.76	8.00	56.61	\N	1	1	6	-99	-99	0.00	0.00	0.00
16	2024-09-27 15:40:23.947263	2024-09-27 15:42:44.300327	1	2024-09-27 15:40:23.941989	0.00	0.00	6.87	0.98	279409	ATIVO	PDV	40.76	8.00	56.61	\N	1	1	\N	-99	-99	0.00	0.00	0.00
17	2024-09-27 15:56:48.095831	2024-09-27 15:56:59.581741	1	2024-09-27 15:56:48.046674	0.00	0.00	0.00	0.00	273537	ATIVO	PDV	122.28	24.00	146.28	\N	1	1	\N	-99	-99	0.00	0.00	0.00
18	2024-09-27 16:12:18.182381	2024-09-27 16:18:14.777387	3	2024-09-27 16:12:18.173017	0.00	0.00	6.87	0.98	271717	ESTORNADO	PDV	40.76	8.00	56.61	\N	1	1	7	-99	-99	5.00	5.00	0.00
19	2024-09-30 09:25:25.699101	2024-09-30 09:25:25.699116	0	2024-09-30 09:25:25.670599	0.00	0.00	7.50	0.98	\N	ATIVO	AJUSTE	40.76	8.00	0.00	\N	1	1	\N	-99	-99	62.24	5.00	0.00
20	2024-10-10 14:33:56.974578	2024-10-10 14:34:21.989494	1	2024-10-10 14:33:56.884055	0.00	0.00	-0.09	-0.11	108688	ATIVO	PDV	2608.88	224.00	2705.75	\N	1	1	\N	-99	-99	167.93	41.00	0.00
26	2024-12-16 16:05:41.18565	2024-12-16 16:06:27.790453	16	2024-12-16 16:05:41.159692	0.00	0.00	25.88	3.60	161567	ATIVO	PDV	1378.98	160.00	349.90	\N	1	1	\N	-99	-99	1318.56	100.00	1146.08
27	2024-12-16 16:23:51.799517	2024-12-16 16:24:08.541108	1	2024-12-16 16:23:51.789064	0.00	0.00	10.86	1.64	167868	ATIVO	PDV	82.05	0.00	94.55	\N	1	1	\N	-99	-99	0.00	0.00	0.00
\.


--
-- Data for Name: t_pagamento_item; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_pagamento_item (id_pagamento_item, insert_date, update_date, version, data, iof_adicional_atraso, iof_diario_atraso, mora, multa, status, valor, valor_taxa_operacao, valor_total, id_cdc, id_pagamento, ajuste_credito, ajuste_debito, desconto_pagamento_antecipado) FROM stdin;
58	2024-09-10 16:44:50.135078	2024-09-10 16:45:28.314556	1	2024-09-10 16:44:50.118796	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	172	6	0.00	0.00	0.00
59	2024-09-11 15:28:11.845612	2024-09-11 15:29:08.020252	1	2024-09-11 15:28:11.82385	0.00	\N	2.21	2.07	CANCELADO	103.65	8.00	115.93	184	7	0.00	0.00	0.00
60	2024-09-11 15:29:41.919598	2024-09-11 15:30:29.480832	1	2024-09-11 15:29:41.901001	0.00	\N	2.21	2.07	ATIVO	103.65	8.00	115.93	184	8	0.00	0.00	0.00
61	2024-09-13 14:41:12.617647	2024-09-13 14:41:25.077272	1	2024-09-13 14:41:12.60171	0.00	\N	0.95	0.63	ATIVO	103.65	8.00	33.23	188	9	136.43	56.43	0.00
62	2024-09-25 11:32:12.57217	2024-09-25 11:40:48.427849	3	2024-09-25 11:32:12.538662	0.00	\N	8.66	2.13	ESTORNADO	103.65	8.00	117.51	196	10	4.93	0.00	0.00
63	2024-09-25 13:28:27.136455	2024-09-25 17:57:45.190509	3	2024-09-25 13:28:27.09255	0.00	\N	8.66	2.13	ESTORNADO	103.65	8.00	117.51	196	11	4.93	0.00	0.00
64	2024-09-25 19:33:27.379912	2024-09-25 19:38:25.864122	3	2024-09-25 19:33:27.362695	0.00	\N	5.40	2.30	ESTORNADO	107.00	8.00	122.70	200	12	0.00	0.00	0.00
65	2024-09-27 14:28:03.127309	2024-09-27 14:33:38.875654	3	2024-09-27 14:28:03.107773	0.00	\N	6.45	0.98	ESTORNADO	40.76	8.00	56.19	202	13	0.00	0.00	0.00
66	2024-09-27 14:45:31.680642	2024-09-27 14:45:41.341362	1	2024-09-27 14:45:31.656674	0.00	\N	6.45	0.98	ATIVO	40.76	8.00	56.19	202	14	0.00	0.00	0.00
67	2024-09-27 14:45:31.68615	2024-09-27 14:45:41.342914	1	2024-09-27 14:45:31.656674	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	203	14	0.00	0.00	0.00
68	2024-09-27 14:45:31.68862	2024-09-27 14:45:41.344418	1	2024-09-27 14:45:31.656674	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	204	14	0.00	0.00	0.00
69	2024-09-27 14:45:31.690894	2024-09-27 14:45:41.345771	1	2024-09-27 14:45:31.656674	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	205	14	0.00	0.00	0.00
70	2024-09-27 15:26:01.009989	2024-09-27 15:31:03.228189	3	2024-09-27 15:26:00.986626	0.00	\N	6.87	0.98	ESTORNADO	40.76	8.00	56.61	209	15	0.00	0.00	0.00
71	2024-09-27 15:40:23.950012	2024-09-27 15:42:44.302742	1	2024-09-27 15:40:23.941989	0.00	\N	6.87	0.98	ATIVO	40.76	8.00	56.61	209	16	0.00	0.00	0.00
72	2024-09-27 15:56:48.103452	2024-09-27 15:56:59.583314	1	2024-09-27 15:56:48.046674	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	206	17	0.00	0.00	0.00
73	2024-09-27 15:56:48.113779	2024-09-27 15:56:59.584798	1	2024-09-27 15:56:48.046674	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	207	17	0.00	0.00	0.00
74	2024-09-27 15:56:48.11816	2024-09-27 15:56:59.586038	1	2024-09-27 15:56:48.046674	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	208	17	0.00	0.00	0.00
75	2024-09-27 16:12:18.183412	2024-09-27 16:18:14.781081	3	2024-09-27 16:12:18.173017	0.00	\N	6.87	0.98	ESTORNADO	40.76	8.00	56.61	210	18	5.00	5.00	0.00
76	2024-09-30 09:25:25.70334	2024-09-30 09:25:25.703356	0	2024-09-30 09:25:25.670599	0.00	\N	7.50	0.98	ATIVO	40.76	8.00	0.00	210	19	62.24	5.00	0.00
79	2024-10-10 14:33:57.010506	2024-10-10 14:34:21.991176	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	52.66	8.00	60.66	197	20	0.00	0.00	0.00
80	2024-10-10 14:33:57.017553	2024-10-10 14:34:21.992246	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	107.00	8.00	110.00	199	20	5.00	0.00	0.00
81	2024-10-10 14:33:57.036708	2024-10-10 14:34:21.993507	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	103.65	8.00	111.65	193	20	0.00	0.00	0.00
82	2024-10-10 14:33:57.044908	2024-10-10 14:34:21.994617	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	103.65	8.00	111.65	190	20	0.00	0.00	0.00
83	2024-10-10 14:33:57.053653	2024-10-10 14:34:21.995646	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	173	20	0.00	0.00	0.00
84	2024-10-10 14:33:57.060827	2024-10-10 14:34:21.996865	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	52.66	8.00	60.66	198	20	0.00	0.00	0.00
85	2024-10-10 14:33:57.066564	2024-10-10 14:34:21.997786	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	103.65	8.00	111.65	192	20	0.00	0.00	0.00
86	2024-10-10 14:33:57.069884	2024-10-10 14:34:21.998712	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	103.65	8.00	111.65	194	20	0.00	0.00	0.00
87	2024-10-10 14:33:57.072222	2024-10-10 14:34:21.999668	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	211	20	0.00	0.00	0.00
88	2024-10-10 14:33:57.074519	2024-10-10 14:34:22.000595	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	103.65	8.00	106.72	196	20	4.93	0.00	0.00
89	2024-10-10 14:33:57.077818	2024-10-10 14:34:22.001555	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	103.65	8.00	111.65	191	20	0.00	0.00	0.00
90	2024-10-10 14:33:57.081321	2024-10-10 14:34:22.002516	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	174	20	0.00	0.00	0.00
77	2024-10-10 14:33:56.988083	2024-10-10 14:34:22.003347	1	2024-10-10 14:33:56.884055	0.00	\N	-0.09	-0.11	ATIVO	103.65	8.00	-5.55	189	20	117.00	0.00	0.00
78	2024-10-10 14:33:57.003051	2024-10-10 14:34:22.004188	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	172	20	41.00	41.00	0.00
91	2024-10-10 14:33:57.083842	2024-10-10 14:34:22.005285	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	103.65	8.00	111.65	195	20	0.00	0.00	0.00
92	2024-10-10 14:33:57.086031	2024-10-10 14:34:22.006255	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	107.00	8.00	115.00	201	20	0.00	0.00	0.00
93	2024-10-10 14:33:57.088476	2024-10-10 14:34:22.007431	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	212	20	0.00	0.00	0.00
94	2024-10-10 14:33:57.090633	2024-10-10 14:34:22.008229	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	175	20	0.00	0.00	0.00
95	2024-10-10 14:33:57.092709	2024-10-10 14:34:22.009081	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	107.00	8.00	115.00	200	20	0.00	0.00	0.00
96	2024-10-10 14:33:57.094984	2024-10-10 14:34:22.009919	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	213	20	0.00	0.00	0.00
97	2024-10-10 14:33:57.09732	2024-10-10 14:34:22.010832	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	176	20	0.00	0.00	0.00
98	2024-10-10 14:33:57.099652	2024-10-10 14:34:22.0117	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	177	20	0.00	0.00	0.00
99	2024-10-10 14:33:57.101821	2024-10-10 14:34:22.01253	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	178	20	0.00	0.00	0.00
100	2024-10-10 14:33:57.103663	2024-10-10 14:34:22.013356	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	179	20	0.00	0.00	0.00
101	2024-10-10 14:33:57.105432	2024-10-10 14:34:22.01418	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	180	20	0.00	0.00	0.00
102	2024-10-10 14:33:57.107136	2024-10-10 14:34:22.015006	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	181	20	0.00	0.00	0.00
103	2024-10-10 14:33:57.108914	2024-10-10 14:34:22.015786	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	182	20	0.00	0.00	0.00
104	2024-10-10 14:33:57.110677	2024-10-10 14:34:22.01655	1	2024-10-10 14:33:56.884055	0.00	\N	0.00	0.00	ATIVO	102.59	8.00	110.59	183	20	0.00	0.00	0.00
147	2024-12-16 16:05:41.188909	2024-12-16 16:06:27.375534	1	2024-12-16 16:05:41.159692	0.00	\N	15.01	1.90	ATIVO	155.47	8.00	111.90	214	26	168.48	100.00	0.00
148	2024-12-16 16:05:41.208618	2024-12-16 16:06:27.376276	1	2024-12-16 16:05:41.159692	0.00	\N	4.62	0.72	ATIVO	28.05	8.00	41.39	222	26	0.00	0.00	0.00
149	2024-12-16 16:05:41.214438	2024-12-16 16:06:27.376943	1	2024-12-16 16:05:41.159692	0.00	\N	6.25	0.98	ATIVO	40.76	8.00	55.99	218	26	0.00	0.00	0.00
150	2024-12-16 16:05:41.219145	2024-12-16 16:06:27.377587	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	28.05	8.00	36.05	223	26	0.00	0.00	0.00
151	2024-12-16 16:05:41.22269	2024-12-16 16:06:27.378257	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	48.76	219	26	0.00	0.00	0.00
152	2024-12-16 16:05:41.226302	2024-12-16 16:06:27.487729	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	93.48	8.00	55.81	234	26	45.67	0.00	45.67
153	2024-12-16 16:05:41.230842	2024-12-16 16:06:27.529434	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	110.43	8.00	0.00	230	26	118.43	0.00	118.43
154	2024-12-16 16:05:41.234146	2024-12-16 16:06:27.549028	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	28.05	8.00	0.00	224	26	36.05	0.00	36.05
155	2024-12-16 16:05:41.237389	2024-12-16 16:06:27.567356	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	0.00	220	26	48.76	0.00	48.76
156	2024-12-16 16:05:41.241138	2024-12-16 16:06:27.589931	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	93.48	8.00	0.00	235	26	101.48	0.00	101.48
157	2024-12-16 16:05:41.247952	2024-12-16 16:06:27.607634	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	110.43	8.00	0.00	231	26	118.43	0.00	118.43
158	2024-12-16 16:05:41.252089	2024-12-16 16:06:27.629074	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	28.05	8.00	0.00	225	26	36.05	0.00	36.05
159	2024-12-16 16:05:41.255993	2024-12-16 16:06:27.655021	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	40.76	8.00	0.00	221	26	48.76	0.00	48.76
160	2024-12-16 16:05:41.260101	2024-12-16 16:06:27.67551	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	93.48	8.00	0.00	236	26	101.48	0.00	101.48
161	2024-12-16 16:05:41.263795	2024-12-16 16:06:27.692992	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	110.43	8.00	0.00	232	26	118.43	0.00	114.43
162	2024-12-16 16:05:41.266678	2024-12-16 16:06:27.715297	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	28.05	8.00	0.00	226	26	36.05	0.00	36.05
163	2024-12-16 16:05:41.269017	2024-12-16 16:06:27.732752	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	93.48	8.00	0.00	237	26	101.48	0.00	101.48
164	2024-12-16 16:05:41.270911	2024-12-16 16:06:27.760914	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	28.05	8.00	0.00	227	26	36.05	0.00	36.05
165	2024-12-16 16:05:41.272728	2024-12-16 16:06:27.777841	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	93.48	8.00	0.00	238	26	101.48	0.00	101.48
166	2024-12-16 16:05:41.274505	2024-12-16 16:06:27.791704	1	2024-12-16 16:05:41.159692	0.00	\N	0.00	0.00	ATIVO	93.48	8.00	0.00	239	26	101.48	0.00	101.48
167	2024-12-16 16:23:51.801573	2024-12-16 16:24:08.543259	1	2024-12-16 16:23:51.789064	0.00	\N	10.86	1.64	ATIVO	82.05	0.00	94.55	64	27	0.00	0.00	0.00
\.


--
-- Data for Name: t_pagamento_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_pagamento_transacao (id_pagamento, id_transacao) FROM stdin;
1	11
1	12
2	25
3	26
4	47
5	59
6	62
6	63
7	90
7	91
8	92
8	93
9	102
9	103
10	112
10	113
10	114
10	115
11	116
11	117
11	118
11	119
12	124
12	125
12	126
12	127
13	130
13	131
13	132
13	133
14	134
14	135
15	138
15	139
15	140
15	141
16	142
16	143
17	144
17	145
18	150
18	151
18	152
18	153
19	155
20	156
20	157
26	192
26	193
27	213
27	214
\.


--
-- Data for Name: t_parametro; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_parametro (id, descricao, tipo, valor, visivel) FROM stdin;
1	Nome do Emissor	STRING	Farmácias São João	t
2	Data inicial Contábil	DATE	2024-06-19	t
4	Label utilizado para identificar o produto na exportação do sistema contábil da Conductor	STRING		t
5	Utiliza bloqueio de usuário por tentativas erradas de login	BOOLEAN	false	t
6	Quantidade de tentativas erradas de login para bloqueio de usuário	INTEIRO	3	t
8	Enviar senha do consumidor via SMS	BOOLEAN	false	t
9	Gerar senha Aleatória para o Consumidor	BOOLEAN	false	t
10	Utilizar Classificador no Plano de Pagamento	BOOLEAN	false	t
12	Gerar e enviar senha aleatória por SMS	BOOLEAN	false	t
13	Utiliza código externo do estabelecimento no contábil  	BOOLEAN	false	t
14	Dias para expiração de senha do usuário	DIA	0	t
100	Quantidade de dias até a proposta do consumidor expirar. Utilizado apenas quando este prazo é omitido no cadastro da Proposta (Capana)	DIA	1825	t
102	Leva em consideração proposta ativa pro Capana. Se consumidor possui proposta ativa, retorna negado. Se consumidor possui proposta expirada, segue para o motor de crédito.	BOOLEAN	false	t
103	Criar usuário e senha do Consumidor de forma automática quando o Kappta cadastrar um novo consumidor no sistema	BOOLEAN	true	t
104	Leva em consideração proposta ativa pro Kappta. Se o consumidor possui proposta ativa, retorna negado. Se consumidor possui proposta expirada, segue para o motor de crédito.	BOOLEAN	false	t
105	Criar usuário e senha do Consumidor de forma automática quando o Smilego cadastrar um novo consumidor no sistema	BOOLEAN	false	t
106	Leva em consideração proposta ativa pro Smilego. Se o consumidor possui proposta ativa, retorna negado. Se consumidor possui proposta expirada, segue para o motor de crédito.	BOOLEAN	false	t
201	Percentual da Multa	PERCENTUAL	2	t
203	Percentual (mensal) da Mora	PERCENTUAL	12.8	t
204	Quantidade de dias para a perda (PDD)	DIA	181	t
300	Valor mínimo da parcela	MOEDA	4.99	t
301	Vender para Clientes com Acordo	BOOLEAN	true	t
302	Quantidade de dias em atraso para bloquear venda de Consumidor com apenas um Contrato	DIA	5	t
303	Quantidade de dias em atraso para bloquear venda de Consumidor com mais de um Contrato	DIA	20	t
304	Percentual para estouro de limite	PERCENTUAL	10	t
305	Valor máximo para estouro de limite	MOEDA	100	t
306	Quantidade máxima de contrato por cliente	INTEIRO	0	t
307	Elegível Vendor	BOOLEAN	false	t
308	Quantidade de dias em atraso para bloqueio de venda funcionário	INTEIRO	0	t
400	Quantidade de dias após o vencimento para enviar pra Cobrança	DIA	4	t
403	Bloquear Pagamento Acordo Cobransaas Boleto	BOOLEAN	false	t
500	Quantidade máxima de dias para vencimento do Boleto	DIA	7	t
501	Quantidade de dias para gerar a data de vencimento do Boleto quando o Carnê já está vencido (zero = o boleto é gerado com vencimento no mesmo dia)	DIA	0	t
502	Dias de tolerância para considerar um Boleto vencido como inválido na hora de gerar um novo Boleto	DIA	1	t
503	A data de vencimento do boleto será igual a data de vencimento do CDC	BOOLEAN	false	t
602	CNPJ Estabelecimento usando no Vendor	CNPJ	04561957000168	t
607	Percentual ao ano cédula	PERCENTUAL		t
11	Enviar Boleto por E-mail	BOOLEAN	true	t
402	Estabelecimento padrão para transações vindas do CobranSaas	CNPJ	11243020000100	t
401	Integração CobranSaaS	BOOLEAN	false	t
550	Integração Senior	BOOLEAN	false	t
3	Autoriza transações com token	BOOLEAN	false	t
603	Conta Corrente Movimentação Vendor	STRING	99421-1	t
604	Carteira Movimentação Vendor	STRING	424	t
608	Percentual ao mês cédula	PERCENTUAL		t
101	Criar usuário e senha do consumidor de forma automática quando o Capana cadastrar um novo consumidor no sistema	BOOLEAN	true	t
200	Quantidade de dias para cálculo da Multa (após o vencimento do título)	DIA	3	t
202	Quantidade de dias para cálculo da Mora (após o vencimento do título)	DIA	3	t
600	Quantidade máxima de parcelas para antecipar do contrato	INTEIRO	10	t
606	Devedor Solidário	STRING		t
7	Utilizar e-mail para reset de senha	BOOLEAN	false	f
15	Tipo de geração de senha utilizada na transação de venda	SELECAO	ALEATORIA	t
700	Quantidade de anos de validade do cartão	INTEIRO	5	t
601	Número mínimo de dias para vencimento da transação para geração de arquivo de remessa	DIA	10	t
605	Agência Movimentação Vendor	STRING	686	t
804	Ajuste de desconto por pagamento antecipado	INTEIRO	-2	f
805	Ajuste de estorno do desconto por pagamento antecipado	INTEIRO	-3	f
803	Número mínimo de dias para desconto por pagamento antecipado	DIA	5	t
800	Tipo de desconto padrão por pagamente antecipado	SELECAO	Juros Simples	t
802	Taxa de desconto por juros simples (Parcelas com juros)	PERCENTUAL	150	t
801	Taxa de desconto por juros simples (Parcelas sem juros)	PERCENTUAL	150	t
701	Chave NSK	STRING	3645424A47444D4647423435344446334331353042314532313638334C393534	f
\.


--
-- Data for Name: t_parametro_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_parametro_aud (id, rev, revtype, descricao, tipo, valor) FROM stdin;
401	344	1	Integração CobranSaaS	BOOLEAN	false
700	349	1	Quantidade de anos de validade do cartão	INTEIRO	3
700	350	1	Quantidade de anos de validade do cartão	INTEIRO	5
700	369	1	Quantidade de anos de validade do cartão	INTEIRO	3
608	373	1	Percentual ao mês cédula	PERCENTUAL	5
608	374	1	Percentual ao mês cédula	PERCENTUAL	0
15	381	1	Tipo de geração de senha utilizada na transação de venda	SELECAO	ALEATORIA
15	382	1	Tipo de geração de senha utilizada na transação de venda	SELECAO	CPF
15	383	1	Tipo de geração de senha utilizada na transação de venda	SELECAO	ALEATORIA
15	384	1	Tipo de geração de senha utilizada na transação de venda	SELECAO	CPF
800	395	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	JUROS_SIMPLES
15	396	1	Tipo de geração de senha utilizada na transação de venda	SELECAO	ALEATORIA
15	397	1	Tipo de geração de senha utilizada na transação de venda	SELECAO	CPF
800	398	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	VALOR_PRESENTE
800	399	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	SEM_DESCONTO
801	400	1	Taxa de desconto por juros simples (Parcelas sem juros)	PERCENTUAL	1
801	401	1	Taxa de desconto por juros simples (Parcelas sem juros)	PERCENTUAL	0
802	402	1	Taxa de desconto por juros simples (Parcelas com juros)	PERCENTUAL	4.00
802	403	1	Taxa de desconto por juros simples (Parcelas com juros)	PERCENTUAL	0.00
803	404	1	Número mínimo de dias para desconto por pagamento antecipado	DIA	7
803	405	1	Número mínimo de dias para desconto por pagamento antecipado	DIA	0
800	406	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	JUROS_SIMPLES
800	407	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	VALOR_PRESENTE
800	408	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	SEM_DESCONTO
800	409	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	JUROS_SIMPLES
800	410	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	SEM_DESCONTO
800	411	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	Valor Presente
800	412	1	Tipo de desconto padrão por pagamente antecipado	SELECAO	Sem Desconto
700	413	1	Quantidade de anos de validade do cartão	INTEIRO	5
15	414	1	Tipo de geração de senha utilizada na transação de venda	SELECAO	ALEATORIA
\.


--
-- Data for Name: t_plano_pagamento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_plano_pagamento (id_plano_pagamento, insert_date, update_date, version, carencia, juros_parcela, limite_maximo_dias_carencia, parcela_final, parcela_inicial, quantidade_dias_entre_parcelas, quantidade_dias_primeira_parcela, score_consumidor, status, tipo_taxa_operacao, valor_taxa_operacao, valor_taxa_repasse, id_administradora_rede, id_classificador, id_produto) FROM stdin;
4	2024-06-19 09:27:46.014372	2024-06-19 15:01:44.012776	1	f	5.00	0	48	1	30	30	B	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
5	2024-06-19 14:44:39.863905	2024-06-19 15:02:28.694569	1	t	8.00	3	12	1	30	30	C	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
9	2024-08-27 17:48:36.612187	2024-08-27 17:48:36.612207	0	f	10.00	0	60	1	30	30	C	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	5.00	3.00	1	1	1
7	2024-06-19 15:02:28.690721	2024-08-27 17:48:36.628872	1	f	10.00	0	60	1	30	30	C	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
10	2024-08-27 17:59:47.318951	2024-08-27 17:59:47.318987	0	f	3.00	0	12	1	30	30	A	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	8.00	5.00	1	1	1
8	2024-06-20 14:34:27.341507	2024-08-27 17:59:47.334907	1	t	3.00	10	12	1	30	30	A	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
11	2024-08-27 18:00:01.724829	2024-08-27 18:00:01.724852	0	f	3.00	0	48	1	30	30	B	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	9.00	7.00	1	1	1
6	2024-06-19 15:01:44.004568	2024-08-27 18:00:01.730214	1	t	3.00	9	48	1	30	30	B	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
12	2024-08-27 18:00:32.906363	2024-08-27 18:00:32.906379	0	f	5.00	0	48	1	30	30	NAO_INFORMADO	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	4.00	6.00	1	1	1
1	2024-06-19 01:40:45.068939	2024-08-27 18:00:32.910452	1	f	5.00	0	48	1	30	30	NAO_INFORMADO	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
13	2024-10-09 15:06:00.999045	2024-10-09 15:06:00.999063	0	f	1.00	0	72	1	30	30	E	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	2.00	1.00	2	1	1
\.


--
-- Data for Name: t_plano_pagamento_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_plano_pagamento_aud (id_plano_pagamento, rev, revtype, carencia, juros_parcela, limite_maximo_dias_carencia, parcela_final, parcela_inicial, quantidade_dias_entre_parcelas, quantidade_dias_primeira_parcela, score_consumidor, status, tipo_taxa_operacao, valor_taxa_operacao, valor_taxa_repasse, id_administradora_rede, id_classificador, id_produto) FROM stdin;
1	2	0	f	5.00	0	48	1	30	30	NAO_INFORMADO	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
2	3	0	t	5.00	2	48	1	30	30	B	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
3	4	0	t	5.00	3	48	1	30	30	B	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
4	5	0	f	5.00	0	48	1	30	30	B	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
5	6	0	t	8.00	3	12	1	30	30	C	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
6	7	0	f	3.00	0	48	1	30	30	B	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
4	7	1	f	5.00	0	48	1	30	30	B	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
7	8	0	f	10.00	0	12	1	30	30	C	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
5	8	1	t	8.00	3	12	1	30	30	C	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
8	10	0	t	3.00	10	12	1	30	30	A	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
9	236	0	f	10.00	0	60	1	30	30	C	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	5.00	3.00	1	1	1
7	236	1	f	10.00	0	60	1	30	30	C	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
10	237	0	f	3.00	0	12	1	30	30	A	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	8.00	5.00	1	1	1
8	237	1	t	3.00	10	12	1	30	30	A	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
11	238	0	f	3.00	0	48	1	30	30	B	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	9.00	7.00	1	1	1
6	238	1	t	3.00	9	48	1	30	30	B	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
12	239	0	f	5.00	0	48	1	30	30	NAO_INFORMADO	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	4.00	6.00	1	1	1
1	239	1	f	5.00	0	48	1	30	30	NAO_INFORMADO	CANCELADO	REPLICAR_EM_TODAS_AS_PARCELAS	0.00	0.00	1	1	1
13	357	0	f	1.00	0	72	1	30	30	E	ATIVO	REPLICAR_EM_TODAS_AS_PARCELAS	2.00	1.00	2	1	1
\.


--
-- Data for Name: t_produto; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_produto (id_produto, insert_date, update_date, version, codigo_externo, descricao, id_classificador, id_cartao_bin) FROM stdin;
1	2024-06-19 01:38:11.680713	2024-06-19 01:38:11.680713	0	0	CDC	1	3
\.


--
-- Data for Name: t_produto_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_produto_aud (id_produto, rev, revtype, descricao, id_cartao_bin) FROM stdin;
\.


--
-- Data for Name: t_profile; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_profile (id_profile, insert_date, update_date, version, name) FROM stdin;
-99	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	Kamaleon
-5	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	Consumidor - App
-7	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	Senior 
-6	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	SmartNx 
-4	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	Conductor - Capana
-3	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	APP
-2	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	Conductor - Contábil
-1	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	PDV
1	2024-06-19 01:29:51.49729	2024-09-20 17:42:01.87488	9	Funcionario - Backoffice
\.


--
-- Data for Name: t_profile_role; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_profile_role (id_profile, id_role) FROM stdin;
-99	1
-99	2
-99	3
-99	4
-99	5
-99	6
-99	7
-99	8
-99	9
-99	10
-99	11
-99	12
-99	13
-99	14
-99	15
-99	16
-99	17
-99	18
-99	19
-99	20
-99	21
-99	22
-99	23
-99	24
-99	25
-99	26
-99	27
-99	28
-99	29
-99	30
-99	31
-99	32
-99	33
-99	34
-99	35
-99	36
-99	37
-99	38
-99	39
-99	40
-99	41
-99	42
-99	43
-99	44
-99	45
-99	46
-99	47
-99	48
-99	49
-99	50
-99	51
-99	52
-99	53
-99	54
-99	55
-99	56
-99	57
-99	58
-99	59
-99	60
-99	61
-99	62
-99	63
-99	64
-99	65
-99	66
-99	67
-99	68
-99	69
-99	70
-99	71
-99	72
-99	73
-99	74
-99	75
-99	76
-99	77
-99	78
-99	79
-99	80
-99	81
-99	82
-99	83
-99	84
-99	85
-99	86
-99	87
-99	88
-99	89
-99	90
-99	91
-99	92
-99	93
-99	94
-99	95
-99	96
-99	97
-99	98
-99	99
-99	100
-99	101
-99	102
-99	103
-99	104
-99	105
-99	106
-99	107
-99	108
-99	109
-99	110
-99	111
-99	112
-99	113
-99	114
-99	115
-99	116
-99	117
-99	118
-99	119
-99	120
-99	121
-99	122
-99	131
-99	132
-99	133
1	102
1	103
1	104
1	105
1	106
1	107
1	108
1	109
1	115
1	116
1	117
1	118
1	120
1	121
1	122
1	126
1	127
1	128
1	132
-99	134
-99	135
-99	136
-99	137
1	27
-99	142
-99	143
-99	144
1	1
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	25
1	26
1	29
1	32
1	34
1	35
1	38
1	39
1	40
1	41
1	42
1	43
1	44
1	45
-7	83
-7	84
-7	85
-6	82
-4	23
-4	24
-3	3
-3	12
-3	13
-3	26
-3	35
-2	48
-1	1
-1	2
-1	25
-1	26
-1	27
-1	28
-1	29
-1	30
-1	31
-1	32
-1	33
-1	35
-1	36
-1	37
-1	81
-99	123
-99	124
-99	125
-99	126
-99	127
-99	128
-99	129
-99	130
-99	1
-99	2
-99	3
-99	4
-99	5
-99	6
-99	7
-99	8
-99	9
-99	10
-99	11
-99	12
-99	13
-99	14
-99	15
-99	16
-99	17
-99	18
-99	19
-99	20
-99	21
-99	22
-99	23
-99	24
-99	25
-99	26
-99	27
-99	28
-99	29
-99	30
-99	31
-99	32
-99	33
-99	34
-99	35
-99	36
-99	37
-99	38
-99	39
-99	40
-99	41
-99	42
-99	43
-99	44
-99	45
-99	46
-99	47
-99	48
-99	49
-99	50
-99	51
-99	52
-99	53
-99	54
-99	55
-99	56
-99	57
-99	58
-99	59
-99	60
-99	61
-99	62
-99	63
-99	64
-99	65
-99	66
-99	67
-99	68
-99	69
-99	70
-99	71
-99	72
-99	73
-99	74
-99	75
-99	76
-99	77
-99	78
-99	79
-99	80
-99	81
-99	82
-99	83
-99	84
-99	85
-99	86
-99	87
-99	88
-99	89
-99	90
-99	91
-99	92
-99	93
-99	94
-99	95
-99	96
-99	97
-99	98
-99	99
-99	100
-99	101
-99	102
-99	103
-99	104
-99	105
-99	106
-99	107
-99	108
-99	109
-99	110
-99	111
-99	112
-99	113
-99	114
-99	115
-99	116
-99	117
-99	118
-99	119
-99	120
-99	121
-99	122
1	46
1	47
1	53
1	54
1	55
1	56
1	57
1	58
1	59
1	60
1	61
1	62
1	63
1	64
1	65
1	66
1	67
1	68
1	69
1	70
1	71
1	72
1	73
1	74
1	75
1	76
1	77
1	78
1	79
1	86
1	87
1	88
1	89
1	90
1	91
1	96
1	100
1	101
1	102
1	103
1	104
1	105
1	106
1	107
1	108
1	109
1	115
1	116
1	117
1	118
1	120
1	121
1	122
1	1
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	25
1	26
1	29
1	32
1	34
1	35
1	38
1	39
1	40
1	41
1	42
1	43
1	44
1	45
1	46
1	47
1	53
1	54
1	55
1	56
1	57
1	58
1	59
1	60
-7	83
-7	84
-7	85
-6	82
-4	23
-4	24
-3	3
-3	12
-3	13
-3	26
-3	35
-2	48
-1	1
-1	2
-1	25
-1	26
-1	27
-1	28
-1	29
-1	30
-1	31
-1	32
-1	33
-1	35
-1	36
-1	37
-1	81
-99	123
-99	124
-99	125
-99	126
-99	127
-99	128
-99	129
-99	130
-99	1
-99	2
-99	3
-99	4
-99	5
-99	6
-99	7
-99	8
-99	9
-99	10
-99	11
-99	12
-99	13
-99	14
-99	15
-99	16
-99	17
-99	18
-99	19
-99	20
-99	21
-99	22
-99	23
-99	24
-99	25
-99	26
-99	27
-99	28
-99	29
-99	30
-99	31
-99	32
-99	33
-99	34
-99	35
-99	36
-99	37
-99	38
-99	39
-99	40
-99	41
-99	42
-99	43
-99	44
-99	45
-99	46
-99	47
-99	48
-99	49
-99	50
-99	51
-99	52
-99	53
-99	54
-99	55
-99	56
-99	57
-99	58
-99	59
-99	60
-99	61
-99	62
-99	63
-99	64
-99	65
-99	66
-99	67
-99	68
-99	69
-99	70
-99	71
-99	72
-99	73
-99	74
-99	75
-99	76
-99	77
-99	78
-99	79
-99	80
-99	81
-99	82
-99	83
-99	84
-99	85
-99	86
-99	87
-99	88
-99	89
-99	90
-99	91
-99	92
-99	93
-99	94
-99	95
-99	96
-99	97
-99	98
-99	99
-99	100
-99	101
-99	102
-99	103
-99	104
-99	105
-99	106
-99	107
-99	108
-99	109
-99	110
-99	111
-99	112
-99	113
-99	114
-99	115
-99	116
-99	117
-99	118
-99	119
-99	120
-99	121
-99	122
1	61
1	62
1	63
1	64
1	65
1	66
1	67
1	68
1	69
1	70
1	71
1	72
1	73
1	74
1	75
1	76
1	77
1	78
1	79
1	86
1	87
1	88
1	89
1	90
1	91
1	96
1	100
1	101
1	102
1	103
1	104
1	105
1	106
1	107
1	108
1	109
1	115
1	116
1	117
1	118
1	120
1	121
1	122
1	1
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	25
1	26
1	29
1	32
1	34
1	35
1	38
1	39
1	40
1	41
1	42
1	43
1	44
1	45
1	46
1	47
1	53
1	54
1	55
1	56
1	57
1	58
1	59
1	60
1	61
1	62
1	63
1	64
1	65
1	66
1	67
1	68
1	69
1	70
-7	83
-7	84
-7	85
-6	82
-4	23
-4	24
-3	3
-3	12
-3	13
-3	26
-3	35
-2	48
-1	1
-1	2
-1	25
-1	26
-1	27
-1	28
-1	29
-1	30
-1	31
-1	32
-1	33
-1	35
-1	36
-1	37
-1	81
-99	123
-99	124
-99	125
-99	126
-99	127
-99	128
-99	129
-99	130
-99	1
-99	2
-99	3
-99	4
-99	5
-99	6
-99	7
-99	8
-99	9
-99	10
-99	11
-99	12
-99	13
-99	14
-99	15
-99	16
-99	17
-99	18
-99	19
-99	20
-99	21
-99	22
-99	23
-99	24
-99	25
-99	26
-99	27
-99	28
-99	29
-99	30
-99	31
-99	32
-99	33
-99	34
-99	35
-99	36
-99	37
-99	38
-99	39
-99	40
-99	41
-99	42
-99	43
-99	44
-99	45
-99	46
-99	47
-99	48
-99	49
-99	50
-99	51
-99	52
-99	53
-99	54
-99	55
-99	56
-99	57
-99	58
-99	59
-99	60
-99	61
-99	62
-99	63
-99	64
-99	65
-99	66
-99	67
-99	68
-99	69
-99	70
-99	71
-99	72
-99	73
-99	74
-99	75
-99	76
-99	77
-99	78
-99	79
-99	80
-99	81
-99	82
-99	83
-99	84
-99	85
-99	86
-99	87
-99	88
-99	89
-99	90
-99	91
-99	92
-99	93
-99	94
-99	95
-99	96
-99	97
-99	98
-99	99
-99	100
-99	101
-99	102
-99	103
-99	104
-99	105
-99	106
-99	107
-99	108
-99	109
-99	110
-99	111
-99	112
-99	113
-99	114
-99	115
-99	116
-99	117
-99	118
-99	119
-99	120
-99	121
-99	122
1	71
1	72
1	73
1	74
1	75
1	76
1	77
1	78
1	79
1	86
1	87
1	88
1	89
1	90
1	91
1	96
1	100
1	101
1	102
1	103
1	104
1	105
1	106
1	107
1	108
1	109
1	115
1	116
1	117
1	118
1	120
1	121
1	122
1	1
1	14
1	15
1	16
1	17
1	18
1	19
1	20
1	21
1	22
1	25
1	26
1	29
1	32
-7	83
-7	84
-7	85
-6	82
-4	23
-4	24
-3	3
-3	12
-3	13
-3	26
-3	35
-2	48
-1	1
-1	2
-1	25
-1	26
-1	27
-1	28
-1	29
-1	30
-1	31
-1	32
-1	33
-1	35
-1	36
-1	37
-1	81
-99	123
-99	124
-99	125
-99	126
-99	127
-99	128
-99	129
-99	130
1	34
1	35
1	38
1	39
1	40
1	41
1	42
1	43
1	44
1	45
1	46
1	47
1	53
1	54
1	55
1	56
1	57
1	58
1	59
1	60
1	61
1	62
1	63
1	64
1	65
1	66
1	67
1	68
1	69
1	70
1	71
1	72
1	73
1	74
1	75
1	76
1	77
1	78
1	79
1	86
1	87
1	88
1	89
1	90
1	91
1	96
1	100
1	101
1	133
1	131
-99	145
-99	146
\.


--
-- Data for Name: t_proposta; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_proposta (id_proposta, insert_date, update_date, version, data, data_validade_proposta, limite, limite_parcelas, score_consumidor, status, id_consumidor, id_estabelecimento, id_produto, id_user) FROM stdin;
1	2024-06-20 14:28:28.206721	2024-06-20 14:28:28.20673	0	2024-06-20 14:28:28.203516	2029-06-19 14:28:28.203212	5000.00	1500.00	A	ATIVO	1	1	1	-99
2	2024-06-25 11:32:40.18303	2024-06-25 11:32:40.18305	0	2024-06-25 11:32:40.178951	2029-06-24 11:32:40.178856	5000.00	500.00	C	ATIVO	2	1	1	-99
4	2024-10-11 01:49:25.726226	2024-10-11 01:49:25.726233	0	2024-10-11 01:49:25.72333	2029-10-10 01:49:25.72328	4000.00	1000.00	B	ATIVO	4	3	1	4
3	2024-09-05 11:25:11.592833	2024-09-05 11:25:11.592846	0	2024-09-05 11:25:11.58932	2029-09-04 11:25:11.589268	80000.00	80000.00	A	CANCELADO	3	1	1	-99
\.


--
-- Data for Name: t_proposta_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_proposta_aud (id_proposta, rev, revtype, data, data_validade_proposta, limite, limite_parcelas, score_consumidor, status) FROM stdin;
1	9	0	2024-06-20 14:28:28.203516	2029-06-19 14:28:28.203212	5000.00	1500.00	A	ATIVO
2	11	0	2024-06-25 11:32:40.178951	2029-06-24 11:32:40.178856	5000.00	500.00	C	ATIVO
3	260	0	2024-09-05 11:25:11.58932	2029-09-04 11:25:11.589268	80000.00	80000.00	A	ATIVO
4	363	0	2024-10-11 01:49:25.72333	2029-10-10 01:49:25.72328	4000.00	1000.00	B	ATIVO
\.


--
-- Data for Name: t_remessa; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_remessa (id_remessa, insert_date, update_date, version, data_envio, status, taxa_vendor, id_informacao_banco) FROM stdin;
\.


--
-- Data for Name: t_remessa_contrato; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_remessa_contrato (id_remessa_contrato, insert_date, update_date, version, id_contrato, status, id_remessa) FROM stdin;
\.


--
-- Data for Name: t_remessa_contrato_parcela; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_remessa_contrato_parcela (id_remessa_contrato_parcela, insert_date, update_date, version, codigo_ocorrencia_retorno, id_cdc, id_contrato, id_estabelecimento, numero_parcela, status, valor, valor_entregue, valor_total, id_remessa_contrato) FROM stdin;
\.


--
-- Data for Name: t_remessa_contrato_parcela_historico; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_remessa_contrato_parcela_historico (id_remessa_contrato_parcela_historico, insert_date, update_date, version, data, operacao, status, id_remessa_contrato_parcela) FROM stdin;
\.


--
-- Data for Name: t_retorno_cnab; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_retorno_cnab (id_retorno_cnab, insert_date, update_date, version, banco, data_gravacao, data_upload, nome, qtd_total_registros, valor_total_financiado) FROM stdin;
\.


--
-- Data for Name: t_retorno_parcela; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_retorno_parcela (id_retorno_parcela, insert_date, update_date, version, codigo_ocorrencia, status, uso_da_empresa, valor, valor_entregue, valor_financiado, id_remessa_contrato_parcela, id_retorno_cnab) FROM stdin;
\.


--
-- Data for Name: t_reversao_pagamento; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_reversao_pagamento (id_reversao_pagamento, insert_date, update_date, version, data, iof_adicional_atraso, iof_diario_atraso, mora, multa, nsu, observacao, status, valor, valor_taxa_operacao, valor_total, id_classificacao, id_consumidor, id_estabelecimento, id_user_autorizacao, id_user_criacao) FROM stdin;
1	2024-09-11 15:44:20.883637	2024-09-11 15:46:31.646711	1	2024-09-11 15:44:20.869563	0.00	0.00	0.00	0.00	118676	Testando a reversão de pagamento por fraude.	ATIVO	103.65	8.00	111.65	2	1	1	-99	-99
2	2024-09-12 15:46:56.909787	2024-09-12 15:47:52.320136	1	2024-09-12 15:46:56.89433	0.00	0.00	0.00	0.00	128920	bahsaysasyuahsuashaushsgagsyagsyasgaygsaygasasassaas	ATIVO	207.29	8.00	215.29	2	1	1	-99	-99
\.


--
-- Data for Name: t_reversao_pagamento_item; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_reversao_pagamento_item (id_reversao_pagamento_item, insert_date, update_date, version, codigo_barra, data, data_vencimento, id_contrato, iof_adicional_atraso, iof_diario_atraso, mora, multa, numero_parcela, status, valor, valor_taxa_operacao, valor_total, id_cdc, id_reversao_pagamento) FROM stdin;
1	2024-09-11 15:44:20.894576	2024-09-11 15:46:31.648829	1	1726031765134-1	2024-09-11 15:44:20.869563	2024-09-06	25	0.00	0.00	0.00	0.00	1	ATIVO	103.65	8.00	111.66	187	1
2	2024-09-12 15:46:56.915642	2024-09-12 15:47:52.322135	1	1726001343788-1	2024-09-12 15:46:56.89433	2024-09-05	23	0.00	0.00	0.00	0.00	1	ATIVO	207.29	8.00	215.31	185	2
\.


--
-- Data for Name: t_reversao_pagamento_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_reversao_pagamento_transacao (id_reversao_pagamento, id_transacao) FROM stdin;
1	94
1	95
2	98
2	99
\.


--
-- Data for Name: t_role; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_role (id_role, insert_date, update_date, version, alteravel_backoffice, descricao, module, name) FROM stdin;
1	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar acordo	TRANSACAO	ROLE_ACORDO_LISTAR
2	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Visualizar acordo	TRANSACAO	ROLE_ACORDO_VISUALIZAR
3	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Visualizar CDC no App	TRANSACAO	ROLE_APP_CDC_VISUALIZAR
4	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Visualizar consumidor no App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_VISUALIZAR
5	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar CPF/CNPJ do consumidor App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_VALIDAR_CPFCNPJ
6	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar telefone do consumidor App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_VALIDAR_TELEFONE
7	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar token do consumidor App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_VALIDAR_TOKEN
8	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar respostar do consumidor App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_VALIDAR_RESPOSTAS
9	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cadastrar usuário do consumidor no App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_CADASTRAR_USUARIO
10	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Resetar senha do consumidor no App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_RESETAR_SENHA
11	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cadastrar nova senha para o consumidor no App	CONSUMIDOR	ROLE_APP_CONSUMIDOR_CADASTRAR_NOVA_SENHA
12	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Visualizar contrato no App	TRANSACAO	ROLE_APP_CONTRATO_LISTAR
13	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Listar pagamento no App	TRANSACAO	ROLE_APP_PAGAMENTO_LISTAR
14	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Estornar venda no Backoffice	BACKOFFICE	ROLE_BACKOFFICE_VENDA_ESTORNAR
15	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Estornar pagamento no Backoffice	BACKOFFICE	ROLE_BACKOFFICE_PAGAMENTO_ESTORNAR
16	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar estorno no Backoffice	BACKOFFICE	ROLE_BACKOFFICE_ESTORNO_LISTAR
17	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Acesso a tela de Cadastrar Venda e Pagamento no Backoffice	BACKOFFICE	ROLE_BACKOFFICE_REALIZAR_TRANSACAO
18	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar Venda sem senha (se aplica apenas no Backoffice)	BACKOFFICE	ROLE_BACKOFFICE_REALIZAR_VENDA_SEM_SENHA
19	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Gerar Boleto pelo Backoffice	BACKOFFICE	ROLE_BACKOFFICE_GERAR_BOLETO
20	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar CDC calculando o juros atual no CobranSaaS	BACKOFFICE	ROLE_BACKOFFICE_LISTAR_CDC_PARA_PAGAMENTO
21	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Autorizar estorno no Backoffice	TRANSACAO	ROLE_BACKOFFICE_ESTORNO_AUTORIZAR
22	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Auditar estorno no Backoffice	TRANSACAO	ROLE_BACKOFFICE_ESTORNO_AUDITAR
23	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar consumidor pelo Capana	CONSUMIDOR	ROLE_CAPANA_CONSUMIDOR_VALIDAR
24	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cadastrar proposta pelo Capana	TRANSACAO	ROLE_CAPANA_PROPOSTA_CADASTRAR
26	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar CDC para pagamento	TRANSACAO	ROLE_CDC_LISTAR_PARA_PAGAMENTO
28	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Listar venda pelo PDV	TRANSACAO	ROLE_PDV_VENDA_LISTAR
30	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Estornar venda pelo PDV	TRANSACAO	ROLE_PDV_VENDA_ESTORNAR
31	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Listar pagamento pelo PDV	TRANSACAO	ROLE_PDV_PAGAMENTO_LISTAR
32	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar pagamento pelo PDV	TRANSACAO	ROLE_PDV_PAGAMENTO_CADASTRAR
33	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Estornar pagamento pelo PDV	TRANSACAO	ROLE_PDV_PAGAMENTO_ESTORNAR
34	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_LISTAR
35	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_VISUALIZAR
36	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar senha do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_VALIDAR_SENHA
37	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Resetar senha do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_RESETAR_SENHA
38	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_CADASTRAR
39	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_ALTERAR
40	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar todos os dados do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_ALTERAR_COMPLETO
41	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar limite do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_LIMITE_ALTERAR
42	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar contato padrão para SMS do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_ALTERAR_FLAG_SMS
43	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Ativar ou bloquear consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_ATIVAR_BLOQUEAR
44	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar boleto	CONSUMIDOR	ROLE_CONSUMIDOR_BOLETO_LISTAR
45	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar Demonstrativo	DEMONSTRATIVO	ROLE_DEMONSTRATIVO_VISUALIZAR
46	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar Demonstrativo de Vendas	DEMONSTRATIVO	ROLE_DEMONSTRATIVO_VENDA
47	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar propostas do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_PROPOSTA_LISTAR
48	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Integrações do Contábil	INTEGRACOES	ROLE_CONTABIL
49	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Listar contratos	TRANSACAO	ROLE_CONTRATO_LISTAR
50	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cadastrar administradora	ADMINISTRADORA	ROLE_ADMINISTRADORA_CADASTRAR
51	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Visualizar administradora	ADMINISTRADORA	ROLE_ADMINISTRADORA_VISUALIZAR
52	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cancelar administradora	ADMINISTRADORA	ROLE_ADMINISTRADORA_CANCELAR
53	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar redes de lojas	REDE	ROLE_ADMINISTRADORA_REDE_LISTAR
54	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar rede de lojas	REDE	ROLE_ADMINISTRADORA_REDE_CADASTRAR
55	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar rede de lojas	REDE	ROLE_ADMINISTRADORA_REDE_VISUALIZAR
56	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Adicionar estabelecimento a rede de lojas	REDE	ROLE_ADMINISTRADORA_REDE_ADICIONAR_ESTABELECIMENTO
57	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar estabelecimento	ESTABELECIMENTO	ROLE_ESTABELECIMENTO_CADASTRAR
58	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar estabelecimento	ESTABELECIMENTO	ROLE_ESTABELECIMENTO_ALTERAR
60	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar estabelecimento	ESTABELECIMENTO	ROLE_ESTABELECIMENTO_VISUALIZAR
25	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar CDC	TRANSACAO	ROLE_CDC_LISTAR
29	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar venda pelo PDV	TRANSACAO	ROLE_PDV_VENDA_CADASTRAR
27	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Simular venda pelo PDV	TRANSACAO	ROLE_PDV_VENDA_SIMULAR
61	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar plano de pagamento	PLANO_PAGAMENTO	ROLE_PLANO_PAGAMENTO_CADASTRAR
62	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar plano de pagamento	PLANO_PAGAMENTO	ROLE_PLANO_PAGAMENTO_VISUALIZAR
63	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar planos de pagamento	PLANO_PAGAMENTO	ROLE_PLANO_PAGAMENTO_LISTAR
64	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar plano de pagamento	PLANO_PAGAMENTO	ROLE_PLANO_PAGAMENTO_ALTERAR
65	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_CADASTRAR
66	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_VISUALIZAR
67	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_LISTAR
68	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_ALTERAR
69	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Atualizar senha do funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_SENHA_ATUALIZAR
70	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar grupo de usuários do funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_PROFILE_ALTERAR
71	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Resetar senha do funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_SENHA_RESETAR
72	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar parâmetro	CONFIGURACAO	ROLE_PARAMETRO_ALTERAR
73	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar parâmetro	CONFIGURACAO	ROLE_PARAMETRO_LISTAR
74	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar grupo de usuário	CONFIGURACAO	ROLE_PROFILE_LISTAR
75	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar grupo de usuário	CONFIGURACAO	ROLE_PROFILE_CADASTRAR
76	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar grupo de usuário	CONFIGURACAO	ROLE_PROFILE_VISUALIZAR
77	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar grupo de usuário	CONFIGURACAO	ROLE_PROFILE_ALTERAR
79	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar transações no backoffice	TRANSACAO	ROLE_BACKOFFICE_TRANSACAO_VISUALIZAR
80	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar vendas pelo Backoffice	TRANSACAO	ROLE_BACKOFFICE_TRANSACAO_VENDA_LISTAR
81	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Listar transações pelo PDV	TRANSACAO	ROLE_PDV_TRANSACAO_LISTAR
82	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar consumidor	CONSUMIDOR	ROLE_SMARTNX_CONSUMIDOR_VISUALIZAR
83	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Realizar pagamento/baixa CDC pela Senior	SENIOR	ROLE_SENIOR_PAGAMENTO_CDC
84	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Consultar o limite consumidor na Senior	SENIOR	ROLE_SENIOR_CONSULTAR_LIMITE
85	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Consultar integração Senior	SENIOR	ROLE_SENIOR_CONSULTAR_INTEGRACAO
86	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar cadastro de remessa para o vendor	VENDOR	ROLE_REMESSA_CADASTRAR
87	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar alteração da remessa	VENDOR	ROLE_REMESSA_ALTERAR
88	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar o cancelamento das remessa	VENDOR	ROLE_REMESSA_CANCELAR
89	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar a listagem das remessa	VENDOR	ROLE_REMESSA_LISTAR
90	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar upload do arquivo de retorno para o vendor	VENDOR	ROLE_RETORNO_CADASTRAR
91	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar arquivos de retorno	VENDOR	ROLE_RETORNO_LISTAR
92	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar dependente do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_DEPENDENTE_CADASTRAR
93	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar dependente do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_DEPENDENTE_ALTERAR
94	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar dependente do consumidor	CONSUMIDOR	ROLE_CONSUMIDOR_DEPENDENTE_LISTAR
95	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cadastrar Biometria	TRANSACAO	ROLE_BIOMETRIA_CADASTRAR
96	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar requisições feitas a APIs externas	INTEGRACAO	ROLE_INTEGRACAO_AUDITAR
97	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar Pessoa Fisica para Emprestimo FGTS	EMPRESTIMO	ROLE_HORIZON_CADASTRO_PESSOA_FISICA_EMPRESTIMO_FGTS
98	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar consumidor pelo Smilego	CONSUMIDOR	ROLE_SMILEGO_CONSUMIDOR_VALIDAR
99	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cadastrar proposta pelo Smilego	TRANSACAO	ROLE_SMILEGO_PROPOSTA_CADASTRAR
100	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar títulos em Reversão de Pagamento (Chargeback)	REVERSAO_PAGAMENTO	ROLE_REVERSAO_PAGAMENTO_CADASTRAR
101	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Autorizar títulos em Reversão de Pagamento (Chargeback)	REVERSAO_PAGAMENTO	ROLE_REVERSAO_PAGAMENTO_AUTORIZAR
102	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar títulos em Reversão de Pagamento (Chargeback)	REVERSAO_PAGAMENTO	ROLE_REVERSAO_PAGAMENTO_LISTAR
103	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar CDC para reversão de pagamento (Chargeback)	REVERSAO_PAGAMENTO	ROLE_CDC_LISTAR_PARA_REVERSAO_PAGAMENTO
104	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar Demonstrativo de Reversão de Pagamento (Chargeback)	DEMONSTRATIVO	ROLE_DEMONSTRATIVO_REVERSAO_PAGAMENTO
105	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar Perda Item	REVERSAO_PAGAMENTO	ROLE_REVERSAO_PAGAMENTO_ITEM_LISTAR
106	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar Feriado	FERIADO	ROLE_FERIADO_LISTAR
107	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar Feriado	FERIADO	ROLE_FERIADO_CADASTRAR
108	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar Feriado	FERIADO	ROLE_FERIADO_ALTERAR
109	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cancelar Feriado	FERIADO	ROLE_FERIADO_CANCELAR
110	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Validar Consumidor pelo Kappta	CONSUMIDOR	ROLE_KAPPTA_CONSUMIDOR_VALIDAR
111	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	f	Cadastrar Proposta pelo Kappta	TRANSACAO	ROLE_KAPPTA_PROPOSTA_CADASTRAR
112	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Visualizar menu de Ajustes	TRANSACAO	ROLE_AJUSTE
113	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar ajustes em acordos	TRANSACAO	ROLE_AJUSTE_ACORDO
114	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Realizar ajustes em CDCs	TRANSACAO	ROLE_AJUSTE_CDC
115	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar Produtos	REDE	ROLE_PRODUTO_LISTAR
116	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar Produtos	REDE	ROLE_PRODUTO_CADASTRAR
117	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Cadastrar Classificadores	CONSUMIDOR	ROLE_CLASSIFICADOR_CADASTRAR
118	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar Classificadores	CONSUMIDOR	ROLE_CLASSIFICADOR_LISTAR
119	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar Boleto Consumidor Kobana	BACKOFFICE	ROLE_BACKOFFICE_LISTAR_BOLETO_KOBANA
120	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Remover contato do estabelecimento	ESTABELECIMENTO	ROLE_ESTABELECIMENTO_CONTATO_REMOVER
121	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Remover contato do funcionário	FUNCIONARIO	ROLE_FUNCIONARIO_CONTATO_REMOVER
122	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Alterar data de vencimento do CDC	TRANSACAO	ROLE_CDC_ALTERAR_DATA_VENCIMENTO
123	2024-06-28 13:24:06.831094	2024-06-28 13:24:06.831094	0	t	Listar Tipos de Lancamento de Ajustes pelo Backoffice	AJUSTE	ROLE_BACKOFFICE_TIPO_LANCAMENTO_AJUSTE_LISTAR1
124	2024-07-04 14:23:54.938849	2024-07-04 14:23:54.938849	0	t	Cadastrar Tipos de Lancamento de Ajustes pelo Backoffice	AJUSTE	ROLE_BACKOFFICE_TIPO_LANCAMENTO_AJUSTE_CADASTRAR1
125	2024-07-04 14:23:54.938849	2024-07-04 14:23:54.938849	0	t	Alterar Tipos de Lancamento de Ajustes pelo Backoffice	AJUSTE	ROLE_BACKOFFICE_TIPO_LANCAMENTO_AJUSTE_ALTERAR1
126	2024-07-04 14:40:58.842852	2024-07-04 14:40:58.842852	0	t	Listar Tipos de Lancamento de Ajustes	AJUSTE	ROLE_TIPO_LANCAMENTO_AJUSTE_LISTAR
59	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar estabelecimento	ESTABELECIMENTO	ROLE_ESTABELECIMENTO_LISTAR
78	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	t	Listar transações no Backoffice	TRANSACAO	ROLE_BACKOFFICE_TRANSACAO_LISTAR
129	2024-07-18 12:01:03.8718	2024-07-18 12:01:03.8718	0	t	Cadastrar Lancamento de Ajuste	AJUSTE	ROLE_LANCAMENTO_AJUSTE_CADASTRAR
132	2024-09-18 13:38:49.8889	2024-09-18 13:38:49.8889	0	t	Listar Tipos de Bloqueio de Cartão	CARTAO	ROLE_CARTAO_TIPO_BLOQUEIO_LISTAR
130	2024-07-22 09:01:33.022782	2024-07-22 09:01:33.022782	0	t	Listar Lancamento de Ajuste	AJUSTE	ROLE_LANCAMENTO_AJUSTE_LISTAR
133	2024-09-18 13:38:49.8889	2024-09-18 13:38:49.8889	0	t	Alterar Tipos de Bloqueio de Cartão	CARTAO	ROLE_CARTAO_TIPO_BLOQUEIO_ALTERAR
131	2024-09-18 13:38:49.8889	2024-09-18 13:38:49.8889	0	t	Cadastrar Tipos de Bloqueio de Cartão	CARTAO	ROLE_CARTAO_TIPO_BLOQUEIO_CADASTRAR
134	2024-09-27 05:46:02.922858	2024-09-27 05:46:02.922858	0	t	Cadastrar BINs de Cartão	CARTAO	ROLE_CARTAO_BIN_CADASTRAR
135	2024-09-27 05:46:02.922858	2024-09-27 05:46:02.922858	0	t	Listar BINs do Cartão	CARTAO	ROLE_CARTAO_BIN_LISTAR
136	2024-09-27 05:46:02.922858	2024-09-27 05:46:02.922858	0	t	Alterar BINs de Cartão	CARTAO	ROLE_CARTAO_BIN_ALTERAR
137	2024-10-02 23:36:29.23987	2024-10-02 23:36:29.23987	0	t	Cadastrar Cartões	CARTAO	ROLE_CARTAO_CADASTRAR
138	2024-10-04 13:35:44.340703	2024-10-04 13:35:44.340703	0	t	Alterar Produtos	REDE	ROLE_PRODUTO_ALTERAR
127	2024-07-04 14:40:58.842852	2024-07-04 14:40:58.842852	0	t	Cadastrar Tipos de Lancamento de Ajustes	AJUSTE	ROLE_TIPO_LANCAMENTO_AJUSTE_CADASTRAR
128	2024-07-04 14:40:58.842852	2024-07-04 14:40:58.842852	0	t	Alterar Tipos de Lancamento de Ajustes	AJUSTE	ROLE_TIPO_LANCAMENTO_AJUSTE_ALTERAR
142	2024-11-22 01:13:26.049187	2024-11-22 01:13:26.049187	0	t	Alterar Cartões	CARTAO	ROLE_CARTAO_ALTERAR
143	2024-11-29 00:09:36.931734	2024-11-29 00:09:36.931734	0	t	Cadastrar tipos de transação	CARTAO	ROLE_TIPO_TRANSACAO_CADASTRAR
144	2024-11-29 00:09:36.931734	2024-11-29 00:09:36.931734	0	t	Listar tipos de transação	CARTAO	ROLE_TIPO_TRANSACAO_LISTAR
145	2024-12-13 12:50:50.707851	2024-12-13 12:50:50.707851	0	t	Trocar Cartões	CARTAO	ROLE_CARTAO_TROCAR
146	2024-12-16 19:05:30.890243	2024-12-16 19:05:30.890243	0	t	Aplicar tipo de desconto para o pagamento	TRANSACAO	ROLE_TIPO_DESCONTO_PAGAMENTO
\.


--
-- Data for Name: t_senior; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_senior (id_senior, insert_date, update_date, version, encryption, end_point, login, password) FROM stdin;
\.


--
-- Data for Name: t_senior_log; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_senior_log (id_senior_log, insert_date, update_date, version, evento, http_method, request_body, request_timestamp, response_body, response_timestamp, result_log, url, id_transacao) FROM stdin;
\.


--
-- Data for Name: t_sms; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_sms (id_sms, insert_date, update_date, version, area, codigo, data_envio, descricao, id_destinatario, id_mensagem, situacao, telefone, tipo_destinatario) FROM stdin;
\.


--
-- Data for Name: t_tipo_lancamento_ajuste; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_tipo_lancamento_ajuste (id_tipo_lancamento_ajuste, insert_date, update_date, version, descricao, tipo_ajuste, tipo_usuario, status) FROM stdin;
3	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 1	C	S	ATIVO
4	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 1	D	S	ATIVO
7	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 2	C	S	CANCELADO
8	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 2	D	S	CANCELADO
9	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Usuário 3	C	U	ATIVO
10	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Usuário 3	D	U	ATIVO
11	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 3	C	S	ATIVO
12	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 3	D	S	ATIVO
13	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Usuário 4	C	U	CANCELADO
14	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Usuário 4	D	U	CANCELADO
15	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 4	C	S	CANCELADO
16	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 4	D	S	CANCELADO
17	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Usuário 5	C	U	ATIVO
18	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Usuário 5	D	U	ATIVO
19	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 5	C	S	ATIVO
20	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 5	D	S	ATIVO
21	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Usuário 6	C	U	CANCELADO
22	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Usuário 6	D	U	CANCELADO
23	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 6	C	S	CANCELADO
24	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 6	D	S	CANCELADO
25	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Usuário 7	C	U	ATIVO
26	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Usuário 7	D	U	ATIVO
27	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 7	C	S	ATIVO
28	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 7	D	S	ATIVO
31	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 8	C	S	CANCELADO
32	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 8	D	S	CANCELADO
33	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Usuário 9	C	U	ATIVO
34	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Usuário 9	D	U	ATIVO
35	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Crédito Sistema 9	C	S	ATIVO
36	2024-08-16 03:57:07.712871	2024-08-16 03:57:07.712871	1	Ajuste Débito Sistema 9	D	S	ATIVO
37	2024-08-16 04:09:00.409603	2024-08-16 04:09:00.409635	0	string25	C	S	ATIVO
38	2024-08-16 04:09:41.628016	2024-08-16 04:09:41.628025	0	string26	C	S	ATIVO
39	2024-08-16 04:09:55.934038	2024-08-16 04:09:55.934058	0	string27	C	S	ATIVO
40	2024-08-16 04:10:05.493855	2024-08-16 04:10:05.493868	0	string28	C	S	ATIVO
41	2024-08-16 04:10:17.940804	2024-08-16 04:10:17.940822	0	string29	C	S	ATIVO
30	2024-08-16 03:57:07.712871	2024-08-19 16:27:39.453364	2	Ajuste Débito Usuário 8	D	U	ATIVO
6	2024-08-16 03:57:07.712871	2024-08-19 23:29:14.861689	6	Ajuste Débito Usuário 2	D	U	ATIVO
29	2024-08-16 03:57:07.712871	2024-09-03 13:01:31.410417	4	Ajuste Crédito Usuário 8	C	U	ATIVO
1	2024-08-16 03:57:07.712871	2024-09-03 13:08:45.017167	13	Ajuste Crédito Usuário 22	C	U	ATIVO
2	2024-08-16 03:57:07.712871	2024-09-03 15:09:23.522475	7	Ajuste Débito Usuário 1	D	U	ATIVO
42	2024-08-18 22:02:49.92781	2024-08-18 22:02:49.927844	0	front crédito 1	C	U	ATIVO
43	2024-08-18 23:47:16.903549	2024-08-18 23:47:16.90363	0	1	C	U	ATIVO
5	2024-08-16 03:57:07.712871	2024-08-19 01:38:12.63256	2	Ajuste Crédito Usuário 2	C	U	ATIVO
48	2024-08-19 16:23:02.80569	2024-08-19 16:23:02.805703	0	teste fp casastrar - débito	D	U	ATIVO
53	2024-08-19 17:04:26.892045	2024-08-19 17:04:55.999943	1	12	C	U	CANCELADO
54	2024-08-20 00:52:50.811402	2024-08-20 00:52:50.811488	0	Teste kamaleon type text	D	U	ATIVO
46	2024-08-18 23:56:28.466205	2024-08-20 00:55:21.424569	1	Teste no alterar	C	U	ATIVO
45	2024-08-18 23:48:27.446825	2024-08-20 00:56:39.632348	1	Teste no altera	D	U	ATIVO
52	2024-08-19 16:58:40.895163	2024-08-20 10:19:54.027472	2	11	D	U	ATIVO
55	2024-08-21 01:12:08.710996	2024-08-21 01:12:08.711009	0	Teste final 1	C	U	ATIVO
56	2024-08-21 01:12:20.381347	2024-08-21 01:12:20.381365	0	teste final 1	C	U	ATIVO
57	2024-08-21 01:13:15.936462	2024-08-21 01:13:15.936485	0	teste final 1	D	U	ATIVO
58	2024-08-21 20:37:36.152618	2024-08-21 20:37:36.152629	0	123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234	C	U	ATIVO
44	2024-08-18 23:47:58.55418	2024-08-22 02:54:07.35078	3	1001	D	U	ATIVO
47	2024-08-19 16:19:08.511639	2024-08-26 13:53:00.174246	3	Teste FP alterar - crédito	C	U	ATIVO
61	2024-08-26 13:55:38.886908	2024-08-26 13:55:38.886932	0	Teste FE 1	C	U	ATIVO
49	2024-08-19 16:32:31.213444	2024-08-26 14:40:05.848244	4	teste fp casastrar - crédito	D	U	ATIVO
62	2024-08-26 16:56:48.914415	2024-08-26 16:56:48.914458	0	Teste 5	C	U	ATIVO
63	2024-08-26 16:58:37.695574	2024-08-26 16:58:37.695587	0	Teste 6	C	U	ATIVO
64	2024-08-26 17:16:48.019286	2024-08-26 17:16:48.019324	0	12345	C	U	ATIVO
65	2024-08-26 17:16:55.911092	2024-08-26 17:16:55.911126	0	15	D	U	ATIVO
66	2024-09-02 16:19:58.742398	2024-09-02 16:19:58.742409	0	Novo ajuste de crédito	C	U	ATIVO
67	2024-09-02 17:14:08.119718	2024-09-02 17:14:08.119742	0	Novo com disabled	C	U	ATIVO
59	2024-08-21 20:39:39.199306	2024-08-21 20:39:39.199311	0	123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345 (Cŕedito)	C	U	ATIVO
68	2024-09-03 15:12:04.001173	2024-09-03 15:12:04.00122	0	Novo ajuste de crédito melhoria	C	U	ATIVO
69	2024-09-03 15:12:22.712224	2024-09-03 15:12:22.712245	0	Novo ajuste de débito melhoria	D	U	ATIVO
60	2024-08-26 13:46:25.995452	2024-09-18 17:52:28.72539	1	string	C	U	ATIVO
-2	2024-11-08 17:32:53.067246	2024-11-08 17:32:53.067246	1	Ajuste de desconto por pagamento antecipado	C	S	ATIVO
-3	2024-11-08 17:32:53.067246	2024-11-08 17:32:53.067246	1	Ajuste de estorno do desconto por pagamento antecipado	D	S	ATIVO
\.


--
-- Data for Name: t_tipo_lancamento_ajuste_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_tipo_lancamento_ajuste_aud (id_tipo_lancamento_ajuste, rev, revtype, descricao, tipo_ajuste, tipo_usuario, status) FROM stdin;
37	146	0	string25	C	S	ATIVO
38	147	0	string26	C	S	ATIVO
39	148	0	string27	C	S	ATIVO
40	149	0	string28	C	S	ATIVO
41	150	0	string29	C	S	ATIVO
42	157	0	front crédito 1	C	U	ATIVO
43	158	0	1	C	U	ATIVO
44	159	0	1	D	U	ATIVO
45	160	0	-	D	U	ATIVO
46	161	0	{	C	U	ATIVO
5	162	1	Ajuste Crédito Usuário 2	C	U	ATIVO
6	163	1	Ajuste Débito Usuário 2	D	U	ATIVO
6	164	1	Ajuste Débito Usuário 2	D	U	CANCELADO
6	166	1	Ajuste Débito Usuário 2	D	U	ATIVO
6	167	1	Ajuste Débito Usuário 2	D	U	CANCELADO
1	168	1	Ajuste Crédito Usuário 1 ------------------------------	C	U	ATIVO
47	169	0	teste fp casastrar - crédito	C	U	ATIVO
48	170	0	teste fp casastrar - débito	D	U	ATIVO
1	171	1	Ajuste Crédito Usuário 1	C	U	ATIVO
1	172	1	Ajuste Crédito Usuário 1	C	U	CANCELADO
30	173	1	Ajuste Débito Usuário 8	D	U	ATIVO
49	174	0	teste fp casastrar - crédito	D	U	ATIVO
50	175	0	Ajuste Crédito Usuário 1\t	C	U	ATIVO
51	176	0	11	C	U	ATIVO
52	177	0	11	D	U	ATIVO
52	178	1	11	D	U	CANCELADO
53	179	0	12	C	U	ATIVO
53	180	1	12	C	U	CANCELADO
49	193	1	teste fp casastrar - crédito	D	U	CANCELADO
49	194	1	teste fp casastrar - crédito	D	U	ATIVO
1	195	1	Ajuste Crédito Usuário 1	C	U	ATIVO
6	196	1	Ajuste Débito Usuário 2	D	U	ATIVO
54	197	0	Teste kamaleon type text	D	U	ATIVO
46	198	1	Teste no alterar	C	U	ATIVO
45	199	1	Teste no altera	D	U	ATIVO
52	200	1	11	D	U	ATIVO
2	201	1	Ajuste Débito Usuário 1	D	U	CANCELADO
2	202	1	Ajuste Débito Usuário 1	D	U	ATIVO
55	203	0	Teste final 1	C	U	ATIVO
56	204	0	teste final 1	C	U	ATIVO
57	205	0	teste final 1	D	U	ATIVO
58	206	0	123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234	C	U	ATIVO
59	207	0	1234512345123451234512345123451234512345123451234512345123451234512345123451234512345123451234512345	C	U	ATIVO
44	208	1	1	D	U	CANCELADO
44	209	1	1001	D	U	CANCELADO
44	210	1	1001	D	U	ATIVO
60	214	0	FP cadastrar novo ajuste	C	U	ATIVO
47	215	1	Teste FP alterar - crédito	C	U	ATIVO
47	216	1	Teste FP alterar - crédito	C	U	CANCELADO
47	217	1	Teste FP alterar - crédito	C	U	ATIVO
29	218	1	Ajuste Crédito Usuário 8	C	U	ATIVO
61	219	0	Teste FE 1	C	U	ATIVO
49	228	1	teste fp casastrar - crédito	D	U	CANCELADO
49	229	1	teste fp casastrar - crédito	D	U	ATIVO
62	230	0	Teste 5	C	U	ATIVO
63	231	0	Teste 6	C	U	ATIVO
64	234	0	12345	C	U	ATIVO
65	235	0	15	D	U	ATIVO
66	240	0	Novo ajuste de crédito	C	U	ATIVO
67	241	0	Novo com disabled	C	U	ATIVO
1	242	1	Ajuste Crédito Usuário 1	C	U	CANCELADO
1	243	1	Ajuste Crédito Usuário 1	C	U	ATIVO
2	244	1	Ajuste Débito Usuário 1	D	U	CANCELADO
2	245	1	Ajuste Débito Usuário 1	D	U	ATIVO
29	246	1	Ajuste Crédito Usuário 8	C	U	CANCELADO
29	247	1	Ajuste Crédito Usuário 8	C	U	ATIVO
1	248	1	Ajuste Crédito Usuário 1-	C	U	ATIVO
1	249	1	Ajuste Crédito Usuário 1	C	U	ATIVO
1	250	1	Ajuste Crédito Usuário 1-	C	U	ATIVO
1	251	1	Ajuste Débito Usuário 2\t	C	U	ATIVO
1	252	1	Ajuste Crédito Usuário 1	C	U	ATIVO
1	253	1	Ajuste Crédito Usuário 22	C	U	ATIVO
2	254	1	Ajuste Débito Usuário 1	D	U	CANCELADO
2	255	1	Ajuste Débito Usuário 1	D	U	ATIVO
68	256	0	Novo ajuste de crédito melhoria	C	U	ATIVO
69	257	0	Novo ajuste de débito melhoria	D	U	ATIVO
60	280	1	string	C	U	ATIVO
\.


--
-- Data for Name: t_tipo_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_tipo_transacao (id_tipo_transacao, insert_date, update_date, version, descricao, letra) FROM stdin;
1	2024-11-28 21:13:06.918545	2024-11-28 21:13:06.918571	0	PDV	P
3	2024-11-29 11:50:14.701162	2024-11-29 11:50:14.701239	0	Bitcoin	B
4	2024-12-02 12:15:10.438555	2024-12-02 12:15:10.438571	0	Bitcoins	b
5	2024-12-02 12:15:38.885671	2024-12-02 12:15:38.885679	0	teste	t
6	2024-12-02 12:15:54.059941	2024-12-02 12:15:54.059951	0	teste 2	T
7	2024-12-02 12:33:25.500092	2024-12-02 12:33:25.500144	0	A teste	A
8	2024-12-02 12:42:46.443547	2024-12-02 12:42:46.443579	0	D teste	D
9	2024-12-02 12:45:04.796355	2024-12-02 12:45:04.796387	0	E teste	E
10	2024-12-02 12:54:59.523721	2024-12-02 12:54:59.523754	0	F teste	e
11	2024-12-02 13:16:34.687175	2024-12-02 13:16:34.687193	0	H teste	h
12	2024-12-02 13:16:52.090241	2024-12-02 13:16:52.090254	0	H teste maiúscula	H
\.


--
-- Data for Name: t_tivea_log; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_tivea_log (id_tivea_log, insert_date, update_date, version, evento, http_method, http_status, id_transacao, request_body, request_timestamp, response_body, response_timestamp, url) FROM stdin;
1	2024-07-29 15:56:54.484464	2024-07-29 15:56:54.484512	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id": 64,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "341",\n            "parcelaId": 341,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 15:56:54.384232	Estabelecimento não cadastrado	2024-07-29 15:56:54.384794	http://localhost:5000/api/1.0/cobranSaas
2	2024-07-29 15:59:15.973789	2024-07-29 15:59:15.973797	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 1, \n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id": 64,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 15:59:15.972735	Estabelecimento não cadastrado	2024-07-29 15:59:15.972741	http://localhost:5000/api/1.0/cobranSaas
3	2024-07-29 15:59:41.649312	2024-07-29 15:59:41.649326	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id": 64,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 15:59:41.6477	Estabelecimento não cadastrado	2024-07-29 15:59:41.647708	http://localhost:5000/api/1.0/cobranSaas
4	2024-07-29 15:59:56.785117	2024-07-29 15:59:56.785125	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":1,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 15:59:56.784098	Estabelecimento não cadastrado	2024-07-29 15:59:56.784105	http://localhost:5000/api/1.0/cobranSaas
5	2024-07-29 16:06:45.626099	2024-07-29 16:06:45.626104	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":1,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:06:45.625319	Estabelecimento não cadastrado	2024-07-29 16:06:45.625323	http://localhost:5000/api/1.0/cobranSaas
6	2024-07-29 16:06:52.105973	2024-07-29 16:06:52.105981	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:06:52.105006	Estabelecimento não cadastrado	2024-07-29 16:06:52.105011	http://localhost:5000/api/1.0/cobranSaas
7	2024-07-29 16:07:03.886867	2024-07-29 16:07:03.886886	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "2",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:07:03.884842	Estabelecimento não cadastrado	2024-07-29 16:07:03.884852	http://localhost:5000/api/1.0/cobranSaas
8	2024-07-29 16:07:10.212678	2024-07-29 16:07:10.212685	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "1",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:07:10.211251	Estabelecimento não cadastrado	2024-07-29 16:07:10.211257	http://localhost:5000/api/1.0/cobranSaas
9	2024-07-29 16:10:53.683634	2024-07-29 16:10:53.68369	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:10:53.61917	Estabelecimento não cadastrado	2024-07-29 16:10:53.619284	http://localhost:5000/api/1.0/cobranSaas
10	2024-07-29 16:13:14.768486	2024-07-29 16:13:14.768572	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:13:14.586265	Estabelecimento não cadastrado	2024-07-29 16:13:14.586399	http://localhost:5000/api/1.0/cobranSaas
11	2024-07-29 16:20:06.436538	2024-07-29 16:20:06.436573	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:20:06.422446	Transação não autorizada! Consumidor não encontrado	2024-07-29 16:20:06.422477	http://localhost:5000/api/1.0/cobranSaas
12	2024-07-29 16:22:07.26913	2024-07-29 16:22:07.269186	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 14,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:22:07.093083	Transação não autorizada! Consumidor não encontrado	2024-07-29 16:22:07.093124	http://localhost:5000/api/1.0/cobranSaas
13	2024-07-29 16:24:35.059217	2024-07-29 16:24:35.059252	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 1,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:24:35.051106	Transação não autorizada! Consumidor não encontrado	2024-07-29 16:24:35.051165	http://localhost:5000/api/1.0/cobranSaas
14	2024-07-29 16:33:02.42849	2024-07-29 16:33:02.428595	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 1,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:33:02.399476	Transação não autorizada! Consumidor não encontrado	2024-07-29 16:33:02.399501	http://localhost:5000/api/1.0/cobranSaas
15	2024-07-29 16:34:13.212398	2024-07-29 16:34:13.212493	0	webhook.acordo.inclusao	POST	500	0	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 1,\n        "cliente": "CDC-CLI-42",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:34:12.949611	Transação não autorizada! Consumidor não encontrado	2024-07-29 16:34:12.949667	http://localhost:5000/api/1.0/cobranSaas
16	2024-07-29 16:35:55.600593	2024-07-29 16:35:55.60063	0	webhook.acordo.inclusao	POST	200	19	{\n        "tipo": "RENEGOCIACAO",\n        "situacao": "PENDENTE",\n        "id": 1,\n        "cliente": "CDC-CLI-1",\n        "numeroAcordo": 14,\n        "numeroParcelas": 3,\n        "dataOperacao": "2022-06-06",\n        "dataEmissao": "2022-06-06",\n        "dataVencimento": "2022-06-09",\n        "taxaOperacao": 10.00,\n        "valorPrincipal": 57.03,\n        "valorJuros": 17.03,\n        "valorTarifa": 0,\n        "valorTotal": 57.03,\n        "parcelas": [{\n            "situacao": "ABERTO",\n            "numeroParcela": 0,\n            "dataVencimento": "2022-06-09",\n            "valorPrincipal": 57.03,\n            "valorJuros": 17.03,\n            "valorTarifa": 0,\n            "valorAdicionado": 0,\n            "valorTotal": 57.03,\n            "valorTributo": 0,\n            "valorBaseTributo": 0,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoAtual": 57.03,\n            "registrado": true\n        }],\n        "origens": [{\n            "id":7,\n            "contrato": "Contrato",\n            "contratoId": 7,\n            "numeroContrato": "7",\n            "parcela": "64",\n            "parcelaId": 64,\n            "numeroParcela": 1,\n            "diasAtraso": 95,\n            "dataVencimento": "2022-03-03",\n            "valorPrincipal": 40.00,\n            "valorTotal": 57.03,\n            "valorPermanencia": 0,\n            "valorMora": 16.23,\n            "valorMulta": 0.80,\n            "valorOutros": 0.00,\n            "valorDesconto": 0,\n            "valorJuros": 0.00,\n            "valorTarifa": 10.00,\n            "valorAdicionado": 0.00,\n            "valorAtual": 57.03,\n            "saldoPrincipal": 57.03,\n            "saldoTotal": 57.03,\n            "saldoPermanencia": 57.03,\n            "saldoMora": 16.23,\n            "saldoMulta": 0.80,\n            "saldoOutros": 0,\n            "saldoDesconto": 0,\n            "saldoJuros": 0,\n            "saldoTarifa": 0,\n            "saldoAdicionado": 0,\n            "saldoAtual": 57.03,\n            "descontoPrincipal": 0,\n            "descontoJuros": 0,\n            "descontoMora": 0,\n            "descontoMulta": 0,\n            "descontoOutros": 0,\n            "descontoPermanencia": 0,\n            "descontoTotal": 0\n        }],\n        "meioPagamento": {\n            "id": 1,\n            "tipo": "DINHEIRO",\n            "nome": "Dinheiro Loja"\n        }\n    }	2024-07-29 16:35:55.529463	A requisição foi um sucesso.	2024-07-29 16:35:55.529605	http://localhost:5000/api/1.0/cobranSaas
\.


--
-- Data for Name: t_token_acesso; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_token_acesso (id_token_acesso, insert_date, update_date, version, status, telefone, token, id_consumidor) FROM stdin;
\.


--
-- Data for Name: t_token_acesso_aud; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_token_acesso_aud (id_token_acesso, rev, revtype, status, telefone, token) FROM stdin;
\.


--
-- Data for Name: t_transacao; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_transacao (id_transacao, insert_date, update_date, version, data, identificador, ip, nsu, operacao, origem, terminal_origem, valor_transacao, id_consumidor, id_estabelecimento, id_user) FROM stdin;
7	2024-07-10 21:41:23.455161	2024-07-10 21:41:23.455198	0	2024-07-10 21:41:23.337305	backoffice-0001-60533801052-2024-07-11T00:41:23.156Z	127.0.0.1	103374	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	800.00	1	1	-99
8	2024-07-10 21:42:03.591512	2024-07-10 21:42:03.591533	0	2024-07-10 21:42:03.554421	backoffice-0001-60533801052-2024-07-11T00:41:23.156Z	127.0.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	800.00	1	1	-99
9	2024-07-15 09:39:46.15606	2024-07-15 09:39:46.156235	0	2024-07-15 09:39:46.070976	backoffice-0001-60533801052-2024-07-15T12:39:45.918Z	127.0.0.1	157107	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	1200.00	1	1	-99
10	2024-07-15 09:40:55.122609	2024-07-15 09:40:55.122626	0	2024-07-15 09:40:55.101176	backoffice-0001-60533801052-2024-07-15T12:39:45.918Z	127.0.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	1200.00	1	1	-99
11	2024-07-16 15:03:29.790194	2024-07-16 15:03:29.790233	0	2024-07-16 15:03:29.737601	backoffice-0001-60533801052-2024-07-16T18:03:29.616Z	127.0.0.1	167376	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	224.33	1	1	-99
12	2024-07-16 15:05:36.245977	2024-07-16 15:05:36.245985	0	2024-07-16 15:05:36.228207	backoffice-0001-60533801052-2024-07-16T18:03:29.616Z	127.0.0.1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	224.33	1	1	-99
13	2024-07-16 23:54:07.898219	2024-07-16 23:54:07.898271	0	2024-07-16 23:54:07.851227	657277	127.0.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	82.05	1	\N	\N
14	2024-07-17 00:20:27.388848	2024-07-17 00:20:27.388868	0	2024-07-17 00:20:27.364766	657277	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	82.05	1	\N	\N
15	2024-07-25 13:39:29.680414	2024-07-25 13:39:29.68045	0	2024-07-25 13:39:29.647466	657277	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	82.05	1	\N	\N
16	2024-07-25 13:41:26.017729	2024-07-25 13:41:26.017736	0	2024-07-25 13:41:26.010068	657277	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	82.05	1	\N	\N
17	2024-07-25 13:47:04.699436	2024-07-25 13:47:04.699457	0	2024-07-25 13:47:04.685412	658001	127.0.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	164.00	1	\N	\N
18	2024-07-26 15:26:20.763326	2024-07-26 15:26:20.763349	0	2024-07-26 15:26:20.708169	658001	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	164.00	1	\N	\N
19	2024-07-29 16:35:55.10918	2024-07-29 16:35:55.109252	0	2024-07-29 16:35:18.883768	TIVEA-RENEG-1	0:0:0:0:0:0:0:1	\N	SOLICITACAO_RENEGOCIACAO	COBRANSAAS	\N	57.03	1	1	\N
20	2024-08-03 02:22:53.456288	2024-08-03 02:22:53.456294	0	2024-08-03 02:22:53.433678	659580	127.0.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	82.05	1	\N	\N
21	2024-08-03 02:46:26.488433	2024-08-03 02:46:26.488473	0	2024-08-03 02:46:26.423853	659580	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	82.05	1	\N	\N
22	2024-08-03 02:49:42.485164	2024-08-03 02:49:42.485172	0	2024-08-03 02:49:42.477074	659581	127.0.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	102.05	1	\N	\N
23	2024-08-03 03:03:04.79716	2024-08-03 03:03:04.797165	0	2024-08-03 03:03:04.790977	659581	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	102.05	1	\N	\N
24	2024-08-03 03:04:12.316527	2024-08-03 03:04:12.31653	0	2024-08-03 03:04:12.311268	659582	127.0.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	124.66	1	\N	\N
25	2024-08-03 03:13:18.000215	2024-08-03 03:13:18.000231	0	2024-08-03 03:13:17.972742	backoffice-0001-60533801052-2024-08-03T06:13:17.886Z	127.0.0.1	039732	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	103.66	1	1	-99
26	2024-08-03 03:26:10.368294	2024-08-03 03:26:10.36833	0	2024-08-03 03:26:10.320434	backoffice-0001-60533801052-2024-08-03T06:26:09.974Z	127.0.0.1	033206	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	124.66	1	1	-99
27	2024-08-06 12:59:31.824413	2024-08-06 12:59:31.824432	0	2024-08-06 12:59:31.789797	659852	127.0.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	125.71	1	\N	\N
30	2024-08-06 13:24:24.89756	2024-08-06 13:24:24.897587	0	2024-08-06 13:24:24.873453	659852	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	125.71	1	\N	\N
31	2024-08-06 13:27:22.106445	2024-08-06 13:27:22.106465	0	2024-08-06 13:27:22.085521	659855	127.0.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	130.71	1	\N	\N
33	2024-08-09 17:35:37.105471	2024-08-09 17:35:37.105492	0	2024-08-09 17:35:37.091894	659855	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	130.71	1	\N	\N
34	2024-08-25 04:34:39.674878	2024-08-25 04:34:39.674926	0	2024-08-25 04:34:39.597809	661172	0:0:0:0:0:0:0:1	\N	EMISSAO_BOLETO	BOLETO	\N	110.37	1	\N	\N
35	2024-08-25 15:21:07.065125	2024-08-25 15:21:07.065155	0	2024-08-25 15:21:07.016199	backoffice-0001-60533801052-2024-08-25T18:21:06.943Z	0:0:0:0:0:0:0:1	251625	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	2000.00	1	1	-99
36	2024-08-25 15:21:40.669833	2024-08-25 15:21:40.669844	0	2024-08-25 15:21:40.641501	backoffice-0001-60533801052-2024-08-25T18:21:06.943Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	2000.00	1	1	-99
37	2024-08-25 20:00:40.784315	2024-08-25 20:00:40.784333	0	2024-08-25 20:00:40.765528	backoffice-0001-60533801052-2024-08-25T23:00:40.701Z	0:0:0:0:0:0:0:1	257655	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	500.00	1	1	-99
38	2024-08-25 21:30:17.78282	2024-08-25 21:30:17.782849	0	2024-08-25 21:30:17.740163	661172	0:0:0:0:0:0:0:1	\N	BOLETO_CANCELADO	BOLETO	\N	110.37	1	\N	\N
39	2024-08-26 22:31:11.236163	2024-08-26 22:31:11.236244	0	2024-08-26 22:31:11.147357	backoffice-0001-60533801052-2024-08-27T01:31:11.084Z	0:0:0:0:0:0:0:1	261479	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	500.00	1	1	-99
40	2024-08-26 22:31:28.04392	2024-08-26 22:31:28.043929	0	2024-08-26 22:31:28.027469	backoffice-0001-60533801052-2024-08-27T01:31:11.084Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	500.00	1	1	-99
41	2024-08-27 17:49:17.047248	2024-08-27 17:49:17.047275	0	2024-08-27 17:49:16.973982	backoffice-0001-60533801052-2024-08-27T20:49:16.852Z	0:0:0:0:0:0:0:1	279740	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	200.00	1	1	-99
42	2024-08-27 17:49:26.171804	2024-08-27 17:49:26.171814	0	2024-08-27 17:49:26.1455	backoffice-0001-60533801052-2024-08-27T20:49:16.852Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	200.00	1	1	-99
43	2024-08-27 17:57:25.315249	2024-08-27 17:57:25.315266	0	2024-08-27 17:57:25.239991	backoffice-0001-60533801052-2024-08-27T20:57:25.133Z	0:0:0:0:0:0:0:1	272400	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	500.00	1	1	-99
44	2024-08-27 18:01:40.568583	2024-08-27 18:01:40.568603	0	2024-08-27 18:01:40.540991	backoffice-0001-60533801052-2024-08-27T21:01:40.467Z	0:0:0:0:0:0:0:1	275410	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	116.00	1	1	-99
45	2024-08-27 18:01:53.945484	2024-08-27 18:01:53.945495	0	2024-08-27 18:01:53.908117	backoffice-0001-60533801052-2024-08-27T20:57:25.133Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	500.00	1	1	-99
46	2024-08-27 18:01:55.381278	2024-08-27 18:01:55.381295	0	2024-08-27 18:01:55.368968	backoffice-0001-60533801052-2024-08-27T21:01:40.467Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	116.00	1	1	-99
47	2024-09-02 03:50:33.960818	2024-09-02 03:50:33.96083	0	2024-09-02 03:50:33.884757	backoffice-0001-60533801052-2024-09-02T06:50:33.658Z	0:0:0:0:0:0:0:1	028850	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	4558.26	1	1	-99
48	2024-09-02 14:52:03.317833	2024-09-02 14:52:03.317848	0	2024-09-02 14:52:03.254602	backoffice-0001-60533801052-2024-09-02T17:52:03.143Z	0:0:0:0:0:0:0:1	022548	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	596.00	1	1	-99
49	2024-09-02 14:57:01.889241	2024-09-02 14:57:01.88926	0	2024-09-02 14:57:01.857347	backoffice-0001-60533801052-2024-09-02T17:52:03.143Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	596.00	1	1	-99
51	2024-09-05 11:26:53.660848	2024-09-05 11:26:53.660858	0	2024-09-05 11:26:53.617489	backoffice-0001-60533801052-2024-09-05T14:26:53.527Z	0:0:0:0:0:0:0:1	056177	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	22032.00	3	1	-99
52	2024-09-05 11:27:11.045293	2024-09-05 11:27:11.045304	0	2024-09-05 11:27:11.019911	backoffice-0001-60533801052-2024-09-05T14:26:53.527Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	22032.00	3	1	-99
53	2024-09-05 14:32:09.025111	2024-09-05 14:32:09.025126	0	2024-09-05 14:32:08.981083	backoffice-0001-60533801052-2024-09-05T17:32:08.904Z	0:0:0:0:0:0:0:1	059811	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	580.00	1	1	-99
54	2024-09-05 14:32:31.096666	2024-09-05 14:32:31.096675	0	2024-09-05 14:32:31.079537	backoffice-0001-60533801052-2024-09-05T17:32:08.904Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	580.00	1	1	-99
55	2024-09-05 17:23:38.477729	2024-09-05 17:23:38.477738	0	2024-09-05 17:23:38.45614	backoffice-0001-60533801052-2024-09-05T20:23:38.388Z	0:0:0:0:0:0:0:1	054561	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	564.00	1	1	-99
56	2024-09-06 13:51:46.459384	2024-09-06 13:51:46.459396	0	2024-09-06 13:51:46.44016	backoffice-0001-60533801052-2024-09-05T20:23:38.388Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	564.00	1	1	-99
57	2024-09-08 22:12:55.904767	2024-09-08 22:12:55.90478	0	2024-09-08 22:12:55.86917	backoffice-0001-60533801052-2024-09-09T01:12:55.789Z	0:0:0:0:0:0:0:1	088694	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	532.00	3	3	-99
58	2024-09-08 22:13:26.506175	2024-09-08 22:13:26.506187	0	2024-09-08 22:13:26.491645	backoffice-0001-60533801052-2024-09-09T01:12:55.789Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	532.00	3	3	-99
59	2024-09-08 22:14:12.549859	2024-09-08 22:14:12.549863	0	2024-09-08 22:14:12.543542	backoffice-0001-60533801052-2024-09-09T01:14:12.506Z	0:0:0:0:0:0:0:1	085435	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	80.34	1	1	-99
60	2024-09-10 16:42:04.874389	2024-09-10 16:42:04.8744	0	2024-09-10 16:42:04.850617	backoffice-0001-60533801052-2024-09-10T19:42:04.757Z	0:0:0:0:0:0:0:1	108506	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	1096.00	1	1	-99
61	2024-09-10 16:42:18.176138	2024-09-10 16:42:18.176156	0	2024-09-10 16:42:18.147786	backoffice-0001-60533801052-2024-09-10T19:42:04.757Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	1096.00	1	1	-99
62	2024-09-10 16:44:50.128269	2024-09-10 16:44:50.128279	0	2024-09-10 16:44:50.115918	backoffice-0001-60533801052-2024-09-10T19:44:50.045Z	0:0:0:0:0:0:0:1	101159	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	110.59	1	1	-99
63	2024-09-10 16:45:28.306788	2024-09-10 16:45:28.3068	0	2024-09-10 16:45:28.276597	backoffice-0001-60533801052-2024-09-10T19:44:50.045Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	110.59	1	1	-99
64	2024-09-10 17:48:19.249902	2024-09-10 17:48:19.24992	0	2024-09-10 17:48:19.23591	backoffice-0001-60533801052-2024-09-10T20:48:19.174Z	0:0:0:0:0:0:0:1	102359	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
65	2024-09-10 17:48:26.865292	2024-09-10 17:48:26.865296	0	2024-09-10 17:48:26.862382	backoffice-0001-60533801052-2024-09-10T20:48:19.174Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
66	2024-09-10 17:49:00.937802	2024-09-10 17:49:00.937824	0	2024-09-10 17:49:00.920555	backoffice-0001-60533801052-2024-09-10T20:49:00.847Z	0:0:0:0:0:0:0:1	109205	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	208.00	1	1	-99
67	2024-09-10 17:49:06.348059	2024-09-10 17:49:06.348078	0	2024-09-10 17:49:06.337347	backoffice-0001-60533801052-2024-09-10T20:49:00.847Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	208.00	1	1	-99
68	2024-09-10 17:57:50.828659	2024-09-10 17:57:50.828683	0	2024-09-10 17:57:50.810783	backoffice-0001-60533801052-2024-09-10T20:57:50.739Z	0:0:0:0:0:0:0:1	108108	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
69	2024-09-10 17:57:55.151988	2024-09-10 17:57:55.151994	0	2024-09-10 17:57:55.149342	backoffice-0001-60533801052-2024-09-10T20:57:50.739Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
70	2024-09-11 02:16:04.392605	2024-09-11 02:16:04.392612	0	2024-09-11 02:16:04.375588	backoffice-0001-60533801052-2024-09-11T05:16:04.240Z	0:0:0:0:0:0:0:1	113756	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
71	2024-09-11 02:16:41.832562	2024-09-11 02:16:41.832577	0	2024-09-11 02:16:41.824415	backoffice-0001-60533801052-2024-09-11T05:16:04.240Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
72	2024-09-11 02:28:13.196879	2024-09-11 02:28:13.196892	0	2024-09-11 02:28:13.179931	backoffice-0001-60533801052-2024-09-11T05:28:13.112Z	0:0:0:0:0:0:0:1	111799	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
73	2024-09-11 02:29:19.061039	2024-09-11 02:29:19.061046	0	2024-09-11 02:29:19.054509	backoffice-0001-60533801052-2024-09-11T05:28:13.112Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
74	2024-09-11 02:50:31.746949	2024-09-11 02:50:31.74697	0	2024-09-11 02:50:31.718778	backoffice-0001-60533801052-2024-09-11T05:50:31.628Z	0:0:0:0:0:0:0:1	117188	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
75	2024-09-11 02:50:36.09365	2024-09-11 02:50:36.093657	0	2024-09-11 02:50:36.083945	backoffice-0001-60533801052-2024-09-11T05:50:31.628Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
76	2024-09-11 02:56:16.536058	2024-09-11 02:56:16.536099	0	2024-09-11 02:56:16.494362	backoffice-0001-60533801052-2024-09-11T05:56:16.388Z	0:0:0:0:0:0:0:1	114944	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
77	2024-09-11 02:56:21.318853	2024-09-11 02:56:21.318864	0	2024-09-11 02:56:21.301939	backoffice-0001-60533801052-2024-09-11T05:56:16.388Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
78	2024-09-11 03:11:59.778366	2024-09-11 03:11:59.778384	0	2024-09-11 03:11:59.754489	backoffice-0001-60533801052-2024-09-11T06:11:59.687Z	0:0:0:0:0:0:0:1	117545	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
79	2024-09-11 03:12:03.559875	2024-09-11 03:12:03.559886	0	2024-09-11 03:12:03.544675	backoffice-0001-60533801052-2024-09-11T06:11:59.687Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
80	2024-09-11 03:22:50.319684	2024-09-11 03:22:50.319976	0	2024-09-11 03:22:50.294609	backoffice-0001-60533801052-2024-09-11T06:22:50.214Z	0:0:0:0:0:0:0:1	112946	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
81	2024-09-11 03:22:55.912216	2024-09-11 03:22:55.912224	0	2024-09-11 03:22:55.903419	backoffice-0001-60533801052-2024-09-11T06:22:50.214Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
82	2024-09-11 03:41:38.872027	2024-09-11 03:41:38.872063	0	2024-09-11 03:41:38.836631	backoffice-0001-60533801052-2024-09-11T06:41:38.739Z	0:0:0:0:0:0:0:1	118366	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
83	2024-09-11 03:41:49.872321	2024-09-11 03:41:49.872335	0	2024-09-11 03:41:49.856615	backoffice-0001-60533801052-2024-09-11T06:41:38.739Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
84	2024-09-11 03:44:18.314637	2024-09-11 03:44:18.314645	0	2024-09-11 03:44:18.305012	backoffice-0001-60533801052-2024-09-11T06:44:18.242Z	0:0:0:0:0:0:0:1	113050	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
85	2024-09-11 03:44:30.875041	2024-09-11 03:44:30.875048	0	2024-09-11 03:44:30.870578	backoffice-0001-60533801052-2024-09-11T06:44:18.242Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
86	2024-09-11 03:51:17.923833	2024-09-11 03:51:17.923842	0	2024-09-11 03:51:17.914037	backoffice-0001-60533801052-2024-09-11T06:51:17.829Z	0:0:0:0:0:0:0:1	119140	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
87	2024-09-11 03:51:22.955264	2024-09-11 03:51:22.955272	0	2024-09-11 03:51:22.949268	backoffice-0001-60533801052-2024-09-11T06:51:17.829Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
88	2024-09-11 13:29:04.973493	2024-09-11 13:29:04.973524	0	2024-09-11 13:29:04.949381	backoffice-0001-60533801052-2024-09-11T16:29:04.853Z	0:0:0:0:0:0:0:1	119494	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
89	2024-09-11 13:29:11.773481	2024-09-11 13:29:11.773488	0	2024-09-11 13:29:11.764971	backoffice-0001-60533801052-2024-09-11T16:29:04.853Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	-99
90	2024-09-11 15:28:11.83747	2024-09-11 15:28:11.837482	0	2024-09-11 15:28:11.813148	backoffice-0001-60533801052-2024-09-11T18:28:11.728Z	0:0:0:0:0:0:0:1	118132	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	115.93	1	1	-99
91	2024-09-11 15:29:08.014044	2024-09-11 15:29:08.014052	0	2024-09-11 15:29:08.007117	backoffice-0001-60533801052-2024-09-11T18:28:11.728Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	115.93	1	1	-99
92	2024-09-11 15:29:41.90738	2024-09-11 15:29:41.907397	0	2024-09-11 15:29:41.897701	backoffice-0001-60533801052-2024-09-11T18:29:41.826Z	0:0:0:0:0:0:0:1	118977	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	115.93	1	1	-99
93	2024-09-11 15:30:29.472501	2024-09-11 15:30:29.472511	0	2024-09-11 15:30:29.453446	backoffice-0001-60533801052-2024-09-11T18:29:41.826Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	115.93	1	1	-99
94	2024-09-11 15:44:20.875224	2024-09-11 15:44:20.875233	0	2024-09-11 15:44:20.867625	backoffice-0001-60533801052-2024-09-11T18:44:20.804Z	0:0:0:0:0:0:0:1	118676	SOLCITACAO_REVERSAO_PAGAMENTO_POR_FRAUDE	BACKOFFICE	backoffice-0001	111.65	1	1	-99
95	2024-09-11 15:46:31.642074	2024-09-11 15:46:31.642081	0	2024-09-11 15:46:31.635769	backoffice-0001-60533801052-2024-09-11T18:44:20.804Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_REVERSAO_PAGAMENTO_POR_FRAUDE	BACKOFFICE	backoffice-0001	111.65	1	1	-99
96	2024-09-12 11:26:36.367714	2024-09-12 11:26:36.367734	0	2024-09-12 11:26:36.323447	backoffice-0001-60533801052-2024-09-12T14:26:36.243Z	0:0:0:0:0:0:0:1	123234	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	116.00	1	1	-99
97	2024-09-12 11:26:43.023496	2024-09-12 11:26:43.023505	0	2024-09-12 11:26:43.01433	backoffice-0001-60533801052-2024-09-12T14:26:36.243Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	116.00	1	1	-99
98	2024-09-12 15:46:56.902635	2024-09-12 15:46:56.902657	0	2024-09-12 15:46:56.892048	backoffice-0001-60533801052-2024-09-12T18:46:56.823Z	0:0:0:0:0:0:0:1	128920	SOLCITACAO_REVERSAO_PAGAMENTO_POR_FRAUDE	BACKOFFICE	backoffice-0001	215.29	1	1	-99
99	2024-09-12 15:47:52.316871	2024-09-12 15:47:52.316879	0	2024-09-12 15:47:52.306293	backoffice-0001-60533801052-2024-09-12T18:46:56.823Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_REVERSAO_PAGAMENTO_POR_FRAUDE	BACKOFFICE	backoffice-0001	215.29	1	1	-99
100	2024-09-13 14:39:51.191922	2024-09-13 14:39:51.191932	0	2024-09-13 14:39:51.177067	ajuste-debito-0001-60533801052-2024-09-13T14:39:51.177Z	0:0:0:0:0:0:0:1	\N	AJUSTE_DEBITO	AJUSTE	AJUSTE	56.43	1	2	-99
101	2024-09-13 14:40:12.044617	2024-09-13 14:40:12.044625	0	2024-09-13 14:40:12.042109	ajuste-credito-0001-60533801052-2024-09-13T14:40:12.042Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	136.43	1	2	-99
102	2024-09-13 14:41:12.611364	2024-09-13 14:41:12.611374	0	2024-09-13 14:41:12.595004	backoffice-0001-60533801052-2024-09-13T17:41:12.542Z	0:0:0:0:0:0:0:1	135950	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	33.23	1	1	-99
103	2024-09-13 14:41:25.066861	2024-09-13 14:41:25.066878	0	2024-09-13 14:41:25.031788	backoffice-0001-60533801052-2024-09-13T17:41:12.542Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	33.23	1	1	-99
104	2024-09-13 14:45:44.515758	2024-09-13 14:45:44.515769	0	2024-09-13 14:45:44.512645	ajuste-credito-0001-60533801052-2024-09-13T14:45:44.512Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	117.00	1	2	-99
105	2024-09-13 15:47:32.519006	2024-09-13 15:47:32.519012	0	2024-09-13 15:47:32.508675	ajuste-credito-0001-60533801052-2024-09-13T15:47:32.508Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	117.00	1	2	-99
106	2024-09-13 15:58:40.405527	2024-09-13 15:58:40.405536	0	2024-09-13 15:58:40.391146	ajuste-credito-0001-60533801052-2024-09-13T15:58:40.391Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	117.00	1	2	-99
107	2024-09-13 17:10:45.398554	2024-09-13 17:10:45.398578	0	2024-09-13 17:10:45.371138	ajuste-credito-0001-60533801052-2024-09-13T17:10:45.371Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	117.00	1	2	-99
108	2024-09-25 02:18:20.499449	2024-09-25 02:18:20.499469	0	2024-09-25 02:18:20.443487	backoffice-estorno-20240925021820	0:0:0:0:0:0:0:1	254435	SOLICITACAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
111	2024-09-25 11:06:15.863078	2024-09-25 11:06:15.863102	0	2024-09-25 11:06:15.846831	backoffice-estorno-20240925021820	0:0:0:0:0:0:0:1	\N	CONCLUSAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	-99
112	2024-09-25 11:32:12.562942	2024-09-25 11:32:12.56296	0	2024-09-25 11:32:12.532454	backoffice-0001-60533801052-2024-09-25T14:32:12.441Z	0:0:0:0:0:0:0:1	255324	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	117.51	1	1	-99
113	2024-09-25 11:35:01.709666	2024-09-25 11:35:01.709676	0	2024-09-25 11:35:01.697028	backoffice-0001-60533801052-2024-09-25T14:32:12.441Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	117.51	1	1	-99
114	2024-09-25 11:39:37.453145	2024-09-25 11:39:37.453153	0	2024-09-25 11:39:37.438774	backoffice-estorno-20240925113937	0:0:0:0:0:0:0:1	254387	SOLICITACAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	117.51	1	1	-99
115	2024-09-25 11:40:48.420378	2024-09-25 11:40:48.420388	0	2024-09-25 11:40:48.401066	backoffice-estorno-20240925113937	0:0:0:0:0:0:0:1	\N	CONCLUSAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	117.51	1	1	-99
116	2024-09-25 13:28:27.124582	2024-09-25 13:28:27.124599	0	2024-09-25 13:28:27.084952	backoffice-0001-60533801052-2024-09-25T16:28:26.974Z	0:0:0:0:0:0:0:1	258499	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	117.51	1	1	-99
117	2024-09-25 13:28:37.581479	2024-09-25 13:28:37.58149	0	2024-09-25 13:28:37.55931	backoffice-0001-60533801052-2024-09-25T16:28:26.974Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	117.51	1	1	-99
118	2024-09-25 13:29:55.846805	2024-09-25 13:29:55.84682	0	2024-09-25 13:29:55.823822	backoffice-estorno-20240925132955	0:0:0:0:0:0:0:1	258238	SOLICITACAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	117.51	1	1	-99
119	2024-09-25 17:57:45.181087	2024-09-25 17:57:45.181098	0	2024-09-25 17:57:45.159596	backoffice-estorno-20240925132955	0:0:0:0:0:0:0:1	\N	CONCLUSAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	117.51	1	1	-99
120	2024-09-25 18:55:23.167904	2024-09-25 18:55:23.167913	0	2024-09-25 18:55:23.154598	backoffice-0001-60533801052-2024-09-25T21:55:23.100Z	0:0:0:0:0:0:0:1	251546	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	324.00	1	1	-99
121	2024-09-25 18:55:48.692137	2024-09-25 18:55:48.692145	0	2024-09-25 18:55:48.682869	backoffice-0001-60533801052-2024-09-25T21:55:23.100Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	324.00	1	1	-99
122	2024-09-25 19:19:33.817387	2024-09-25 19:19:33.817397	0	2024-09-25 19:19:33.806397	ajuste-credito-0001-60533801052-2024-09-25T19:19:33.806Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	0.05	1	1	-99
123	2024-09-25 19:21:07.92093	2024-09-25 19:21:07.92094	0	2024-09-25 19:21:07.916138	ajuste-credito-0001-60533801052-2024-09-25T19:21:07.916Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	4.95	1	1	-99
124	2024-09-25 19:33:27.369778	2024-09-25 19:33:27.369785	0	2024-09-25 19:33:27.35798	backoffice-0001-60533801052-2024-09-25T22:33:27.272Z	0:0:0:0:0:0:0:1	253580	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	122.70	1	1	-99
125	2024-09-25 19:33:48.572003	2024-09-25 19:33:48.572013	0	2024-09-25 19:33:48.559711	backoffice-0001-60533801052-2024-09-25T22:33:27.272Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	122.70	1	1	-99
126	2024-09-25 19:37:45.23322	2024-09-25 19:37:45.233229	0	2024-09-25 19:37:45.223149	backoffice-estorno-20240925193745	0:0:0:0:0:0:0:1	252231	SOLICITACAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	122.70	1	1	-99
127	2024-09-25 19:38:25.85672	2024-09-25 19:38:25.856728	0	2024-09-25 19:38:25.842289	backoffice-estorno-20240925193745	0:0:0:0:0:0:0:1	\N	CONCLUSAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	122.70	1	1	-99
128	2024-09-27 14:06:50.356344	2024-09-27 14:06:50.356357	0	2024-09-27 14:06:50.330323	backoffice-0001-60533801052-2024-09-27T17:06:50.224Z	0:0:0:0:0:0:0:1	273303	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	182.00	1	1	-99
129	2024-09-27 14:08:20.961666	2024-09-27 14:08:20.961678	0	2024-09-27 14:08:20.946193	backoffice-0001-60533801052-2024-09-27T17:06:50.224Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	182.00	1	1	-99
130	2024-09-27 14:28:03.121092	2024-09-27 14:28:03.121107	0	2024-09-27 14:28:03.102017	backoffice-0001-60533801052-2024-09-27T17:28:03.000Z	0:0:0:0:0:0:0:1	271020	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.19	1	1	-99
131	2024-09-27 14:29:26.194147	2024-09-27 14:29:26.194152	0	2024-09-27 14:29:26.184671	backoffice-0001-60533801052-2024-09-27T17:28:03.000Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	56.19	1	1	-99
132	2024-09-27 14:32:45.110853	2024-09-27 14:32:45.110861	0	2024-09-27 14:32:45.093454	backoffice-estorno-20240927143245	0:0:0:0:0:0:0:1	279346	SOLICITACAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.19	1	1	-99
133	2024-09-27 14:33:38.868859	2024-09-27 14:33:38.868869	0	2024-09-27 14:33:38.855155	backoffice-estorno-20240927143245	0:0:0:0:0:0:0:1	\N	CONCLUSAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.19	1	1	-99
134	2024-09-27 14:45:31.670269	2024-09-27 14:45:31.670287	0	2024-09-27 14:45:31.654338	backoffice-0001-60533801052-2024-09-27T17:45:31.596Z	0:0:0:0:0:0:0:1	276543	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	202.47	1	1	-99
135	2024-09-27 14:45:41.329606	2024-09-27 14:45:41.329616	0	2024-09-27 14:45:41.312851	backoffice-0001-60533801052-2024-09-27T17:45:31.596Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	202.47	1	1	-99
136	2024-09-27 14:52:56.186754	2024-09-27 14:52:56.186765	0	2024-09-27 14:52:56.170512	backoffice-0001-60533801052-2024-09-27T17:52:56.102Z	0:0:0:0:0:0:0:1	271705	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	182.00	1	1	-99
137	2024-09-27 14:53:33.7223	2024-09-27 14:53:33.722308	0	2024-09-27 14:53:33.712132	backoffice-0001-60533801052-2024-09-27T17:52:56.102Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	182.00	1	1	-99
138	2024-09-27 15:26:00.994418	2024-09-27 15:26:00.99443	0	2024-09-27 15:26:00.98414	backoffice-0001-60533801052-2024-09-27T18:26:00.931Z	0:0:0:0:0:0:0:1	279841	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.61	1	1	-99
139	2024-09-27 15:26:15.579071	2024-09-27 15:26:15.579079	0	2024-09-27 15:26:15.568001	backoffice-0001-60533801052-2024-09-27T18:26:00.931Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	56.61	1	1	-99
140	2024-09-27 15:30:45.86563	2024-09-27 15:30:45.865641	0	2024-09-27 15:30:45.836823	backoffice-estorno-20240927153045	0:0:0:0:0:0:0:1	278368	SOLICITACAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.61	1	1	-99
141	2024-09-27 15:31:03.220203	2024-09-27 15:31:03.220211	0	2024-09-27 15:31:03.202211	backoffice-estorno-20240927153045	0:0:0:0:0:0:0:1	\N	CONCLUSAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.61	1	1	-99
142	2024-09-27 15:40:23.945277	2024-09-27 15:40:23.945284	0	2024-09-27 15:40:23.940965	backoffice-0001-60533801052-2024-09-27T18:40:23.883Z	0:0:0:0:0:0:0:1	279409	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.61	1	1	-99
143	2024-09-27 15:42:44.296434	2024-09-27 15:42:44.296444	0	2024-09-27 15:42:44.283462	backoffice-0001-60533801052-2024-09-27T18:40:23.883Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	56.61	1	1	-99
144	2024-09-27 15:56:48.081299	2024-09-27 15:56:48.08132	0	2024-09-27 15:56:48.03534	backoffice-0001-60533801052-2024-09-27T18:56:47.938Z	0:0:0:0:0:0:0:1	273537	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	146.28	1	1	-99
145	2024-09-27 15:56:59.576139	2024-09-27 15:56:59.576148	0	2024-09-27 15:56:59.552655	backoffice-0001-60533801052-2024-09-27T18:56:47.938Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	146.28	1	1	-99
146	2024-09-27 15:59:20.431064	2024-09-27 15:59:20.431078	0	2024-09-27 15:59:20.401822	backoffice-0001-60533801052-2024-09-27T18:59:20.066Z	0:0:0:0:0:0:0:1	274018	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	182.00	1	1	-99
147	2024-09-27 15:59:27.015883	2024-09-27 15:59:27.015894	0	2024-09-27 15:59:26.996467	backoffice-0001-60533801052-2024-09-27T18:59:20.066Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	182.00	1	1	-99
148	2024-09-27 16:05:56.231794	2024-09-27 16:05:56.231807	0	2024-09-27 16:05:56.226035	ajuste-debito-0001-60533801052-2024-09-27T16:05:56.226Z	0:0:0:0:0:0:0:1	\N	AJUSTE_DEBITO	AJUSTE	AJUSTE	5.00	1	1	-99
149	2024-09-27 16:06:54.709169	2024-09-27 16:06:54.709179	0	2024-09-27 16:06:54.703886	ajuste-credito-0001-60533801052-2024-09-27T16:06:54.704Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	5.00	1	1	-99
153	2024-09-27 16:18:14.774005	2024-09-27 16:18:14.774016	0	2024-09-27 16:18:14.75824	backoffice-estorno-20240927161805	0:0:0:0:0:0:0:1	\N	CONCLUSAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.61	1	1	-99
150	2024-09-27 16:12:18.18065	2024-09-27 16:12:18.180659	0	2024-09-27 16:12:18.171696	backoffice-0001-60533801052-2024-09-27T19:12:18.111Z	0:0:0:0:0:0:0:1	271717	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.61	1	1	-99
151	2024-09-27 16:12:27.321738	2024-09-27 16:12:27.321747	0	2024-09-27 16:12:27.313028	backoffice-0001-60533801052-2024-09-27T19:12:18.111Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	56.61	1	1	-99
152	2024-09-27 16:18:05.302658	2024-09-27 16:18:05.302669	0	2024-09-27 16:18:05.283893	backoffice-estorno-20240927161805	0:0:0:0:0:0:0:1	272839	SOLICITACAO_ESTORNO_PAGAMENTO	BACKOFFICE	backoffice-0001	56.61	1	1	-99
154	2024-09-30 09:25:25.686864	2024-09-30 09:25:25.68688	0	2024-09-30 09:25:25.649169	ajuste-credito-0001-60533801052-2024-09-30T09:25:25.649Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	57.24	1	1	-99
155	2024-09-30 09:25:25.696028	2024-09-30 09:25:25.696049	0	2024-09-30 09:25:25.670574	ajuste-pagamento-0001-60533801052-2024-09-30T09:25:25.670Z	0:0:0:0:0:0:0:1	\N	PAGAMENTO_AJUSTE	AJUSTE	AJUSTE	57.24	1	1	-99
156	2024-10-10 14:33:56.963465	2024-10-10 14:33:56.963476	0	2024-10-10 14:33:56.868784	backoffice-0001-60533801052-2024-10-10T17:33:56.680Z	0:0:0:0:0:0:0:1	108688	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	2705.75	1	1	-99
157	2024-10-10 14:34:21.960844	2024-10-10 14:34:21.960853	0	2024-10-10 14:34:21.846027	backoffice-0001-60533801052-2024-10-10T17:33:56.680Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	2705.75	1	1	-99
158	2024-10-10 15:05:11.34273	2024-10-10 15:05:11.342745	0	2024-10-10 15:05:11.321196	backoffice-0001-60533801052-2024-10-10T18:05:11.249Z	0:0:0:0:0:0:0:1	103212	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	158.00	1	1	-99
159	2024-10-10 15:05:30.816763	2024-10-10 15:05:30.816769	0	2024-10-10 15:05:30.811824	backoffice-0001-60533801052-2024-10-10T18:05:11.249Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	158.00	1	1	-99
160	2024-10-10 16:54:30.471655	2024-10-10 16:54:30.471668	0	2024-10-10 16:54:30.440087	backoffice-0001-60533801052-2024-10-10T19:54:30.348Z	0:0:0:0:0:0:0:1	104401	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	158.00	1	1	-99
161	2024-10-10 17:27:44.946026	2024-10-10 17:27:44.946037	0	2024-10-10 17:27:44.924039	backoffice-0001-07533748404-2024-10-10T20:27:44.842Z	0:0:0:0:0:0:0:1	109240	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	508.00	1	1	4
162	2024-10-10 17:28:03.570226	2024-10-10 17:28:03.570236	0	2024-10-10 17:28:03.554579	backoffice-0001-07533748404-2024-10-10T20:27:44.842Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	508.00	1	1	4
163	2024-10-10 17:28:06.524843	2024-10-10 17:28:06.524855	0	2024-10-10 17:28:06.511963	backoffice-0001-60533801052-2024-10-10T19:54:30.348Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	158.00	1	1	4
164	2024-10-11 16:47:11.184872	2024-10-11 16:47:11.184884	0	2024-10-11 16:47:11.161373	backoffice-0001-07533748404-2024-10-11T19:47:11.094Z	0:0:0:0:0:0:0:1	111613	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	108.00	1	1	4
165	2024-10-11 16:47:17.572077	2024-10-11 16:47:17.572086	0	2024-10-11 16:47:17.56344	backoffice-0001-07533748404-2024-10-11T19:47:11.094Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	108.00	1	1	4
166	2024-10-16 08:58:32.205722	2024-10-16 08:58:32.205736	0	2024-10-16 08:58:32.188702	ajuste-credito-0001-60533801052-2024-10-16T08:58:32.188Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	57.24	1	1	-99
167	2024-10-16 09:03:50.96577	2024-10-16 09:03:50.965785	0	2024-10-16 09:03:50.961578	ajuste-credito-0001-60533801052-2024-10-16T09:03:50.961Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	57.24	1	1	-99
168	2024-10-16 09:05:03.876234	2024-10-16 09:05:03.87624	0	2024-10-16 09:05:03.873992	ajuste-credito-0001-60533801052-2024-10-16T09:05:03.874Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	2.00	1	1	-99
169	2024-10-16 09:05:25.161259	2024-10-16 09:05:25.161266	0	2024-10-16 09:05:25.158576	ajuste-credito-0001-60533801052-2024-10-16T09:05:25.158Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	2.00	1	1	-99
170	2024-10-16 09:05:35.58454	2024-10-16 09:05:35.584548	0	2024-10-16 09:05:35.58006	ajuste-credito-0001-60533801052-2024-10-16T09:05:35.580Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	25.00	1	1	-99
171	2024-10-16 09:06:29.489341	2024-10-16 09:06:29.489348	0	2024-10-16 09:06:29.487077	ajuste-debito-0001-60533801052-2024-10-16T09:06:29.487Z	0:0:0:0:0:0:0:1	\N	AJUSTE_DEBITO	AJUSTE	AJUSTE	25.00	1	1	-99
172	2024-10-16 09:06:33.944224	2024-10-16 09:06:33.944232	0	2024-10-16 09:06:33.936647	ajuste-debito-0001-60533801052-2024-10-16T09:06:33.936Z	0:0:0:0:0:0:0:1	\N	AJUSTE_DEBITO	AJUSTE	AJUSTE	25.00	1	1	-99
173	2024-10-16 09:06:35.354536	2024-10-16 09:06:35.354546	0	2024-10-16 09:06:35.349854	ajuste-debito-0001-60533801052-2024-10-16T09:06:35.349Z	0:0:0:0:0:0:0:1	\N	AJUSTE_DEBITO	AJUSTE	AJUSTE	25.00	1	1	-99
174	2024-10-16 09:06:36.498554	2024-10-16 09:06:36.498561	0	2024-10-16 09:06:36.495758	ajuste-debito-0001-60533801052-2024-10-16T09:06:36.495Z	0:0:0:0:0:0:0:1	\N	AJUSTE_DEBITO	AJUSTE	AJUSTE	25.00	1	1	-99
175	2024-10-16 09:06:41.942129	2024-10-16 09:06:41.94214	0	2024-10-16 09:06:41.937142	ajuste-credito-0001-60533801052-2024-10-16T09:06:41.937Z	0:0:0:0:0:0:0:1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	25.00	1	1	-99
176	2024-10-17 20:39:34.660029	2024-10-17 20:39:34.660057	0	2024-10-17 20:39:34.6077	backoffice-0001-60533801052-2024-10-17T23:39:34.483Z	0:0:0:0:0:0:0:1	176077	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	182.00	1	1	-99
177	2024-10-17 20:39:46.309931	2024-10-17 20:39:46.309941	0	2024-10-17 20:39:46.286432	backoffice-0001-60533801052-2024-10-17T23:39:34.483Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	182.00	1	1	-99
178	2024-10-17 20:54:10.772608	2024-10-17 20:54:10.772621	0	2024-10-17 20:54:10.757882	backoffice-0001-60533801052-2024-10-17T23:54:10.706Z	0:0:0:0:0:0:0:1	177578	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	198.00	1	1	-99
179	2024-10-17 20:54:24.597544	2024-10-17 20:54:24.597553	0	2024-10-17 20:54:24.581917	backoffice-0001-60533801052-2024-10-17T23:54:10.706Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	198.00	1	1	-99
180	2024-10-17 20:54:47.579916	2024-10-17 20:54:47.57993	0	2024-10-17 20:54:47.564462	backoffice-0001-60533801052-2024-10-17T23:54:47.530Z	0:0:0:0:0:0:0:1	175644	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	540.00	1	3	-99
181	2024-10-17 20:54:51.202318	2024-10-17 20:54:51.202332	0	2024-10-17 20:54:51.183492	backoffice-0001-60533801052-2024-10-17T23:54:47.530Z	0:0:0:0:0:0:0:1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	540.00	1	3	-99
182	2024-10-30 09:24:08.500332	2024-10-30 09:24:08.500351	0	2024-10-30 09:24:08.417593	ANTECIPACAO-1730291051535	172.18.0.1	\N	SOLICITACAO_ANTECIPACAO	ANTECIPACAO	\N	216.19	1	3	-99
183	2024-10-31 12:02:20.899978	2024-10-31 12:02:20.89999	0	2024-10-31 12:02:20.882471	ajuste-credito-0001-60533801052-2024-10-31T12:02:20.882Z	127.0.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	2.00	1	1	-99
184	2024-10-31 12:24:28.828969	2024-10-31 12:24:28.829008	0	2024-10-31 12:24:28.803386	ajuste-credito-0001-60533801052-2024-10-31T12:24:28.803Z	127.0.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	2.00	1	1	-99
185	2024-11-25 11:32:03.002575	2024-11-25 11:32:03.0026	0	2024-11-25 11:32:02.953061	backoffice-0001-60533801052-2024-11-25T14:32:02.859Z	172.19.0.1	259531	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	548.00	1	1	-99
186	2024-11-25 11:32:42.344626	2024-11-25 11:32:42.344639	0	2024-11-25 11:32:42.317225	backoffice-0001-60533801052-2024-11-25T14:32:02.859Z	172.19.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	548.00	1	1	-99
192	2024-12-16 16:05:41.183523	2024-12-16 16:05:41.183537	0	2024-12-16 16:05:41.156736	backoffice-0001-60533801052-2024-12-16T19:05:41.067Z	172.19.0.1	161567	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	349.90	1	1	-99
193	2024-12-16 16:06:27.37102	2024-12-16 16:06:27.371026	0	2024-12-16 16:06:27.314471	backoffice-0001-60533801052-2024-12-16T19:05:41.067Z	172.19.0.1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	349.90	1	1	-99
194	2024-12-16 16:06:27.48124	2024-12-16 16:06:27.481252	0	2024-12-16 16:06:27.445695	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.445Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	45.67	1	1	-99
195	2024-12-16 16:06:27.524947	2024-12-16 16:06:27.524954	0	2024-12-16 16:06:27.510775	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.510Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	118.43	1	1	-99
196	2024-12-16 16:06:27.546667	2024-12-16 16:06:27.546674	0	2024-12-16 16:06:27.540326	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.540Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	36.05	1	1	-99
197	2024-12-16 16:06:27.564136	2024-12-16 16:06:27.564145	0	2024-12-16 16:06:27.558073	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.558Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	48.76	1	1	-99
198	2024-12-16 16:06:27.587176	2024-12-16 16:06:27.587187	0	2024-12-16 16:06:27.580819	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.580Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	101.48	1	1	-99
199	2024-12-16 16:06:27.605612	2024-12-16 16:06:27.605619	0	2024-12-16 16:06:27.598339	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.598Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	118.43	1	1	-99
200	2024-12-16 16:06:27.625513	2024-12-16 16:06:27.625523	0	2024-12-16 16:06:27.614858	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.614Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	36.05	1	1	-99
201	2024-12-16 16:06:27.650002	2024-12-16 16:06:27.650013	0	2024-12-16 16:06:27.638232	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.638Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	48.76	1	1	-99
202	2024-12-16 16:06:27.673151	2024-12-16 16:06:27.67316	0	2024-12-16 16:06:27.665094	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.665Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	101.48	1	1	-99
203	2024-12-16 16:06:27.690389	2024-12-16 16:06:27.690395	0	2024-12-16 16:06:27.682434	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.682Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	114.43	1	1	-99
204	2024-12-16 16:06:27.713013	2024-12-16 16:06:27.713019	0	2024-12-16 16:06:27.705059	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.705Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	36.05	1	1	-99
205	2024-12-16 16:06:27.730303	2024-12-16 16:06:27.730308	0	2024-12-16 16:06:27.724062	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.724Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	101.48	1	1	-99
206	2024-12-16 16:06:27.756562	2024-12-16 16:06:27.756569	0	2024-12-16 16:06:27.744047	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.744Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	36.05	1	1	-99
207	2024-12-16 16:06:27.775804	2024-12-16 16:06:27.77582	0	2024-12-16 16:06:27.767998	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.768Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	101.48	1	1	-99
208	2024-12-16 16:06:27.788008	2024-12-16 16:06:27.788014	0	2024-12-16 16:06:27.783988	ajuste-credito-0001-60533801052-2024-12-16T16:06:27.784Z	172.19.0.1	\N	AJUSTE_CREDITO	AJUSTE	AJUSTE	101.48	1	1	-99
209	2024-12-16 16:13:13.173397	2024-12-16 16:13:13.173407	0	2024-12-16 16:13:13.164781	backoffice-0001-60533801052-2024-12-16T19:13:13.060Z	172.19.0.1	161647	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	574.00	1	1	-99
210	2024-12-16 16:14:27.03268	2024-12-16 16:14:27.032685	0	2024-12-16 16:14:27.021394	backoffice-0001-60533801052-2024-12-16T19:13:13.060Z	172.19.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	574.00	1	1	-99
211	2024-12-16 16:15:31.83766	2024-12-16 16:15:31.83767	0	2024-12-16 16:15:31.818235	backoffice-estorno-20241216161531	172.19.0.1	168182	SOLICITACAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	574.00	1	1	-99
212	2024-12-16 16:15:44.565925	2024-12-16 16:15:44.565931	0	2024-12-16 16:15:44.548795	backoffice-estorno-20241216161531	172.19.0.1	\N	CONCLUSAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	574.00	1	1	-99
214	2024-12-16 16:24:08.537764	2024-12-16 16:24:08.53777	0	2024-12-16 16:24:08.527652	backoffice-0001-60533801052-2024-12-16T19:23:51.737Z	172.19.0.1	\N	CONCLUSAO_PAGAMENTO	PDV	backoffice-0001	94.55	1	1	-99
216	2024-12-16 16:25:23.591724	2024-12-16 16:25:23.591728	0	2024-12-16 16:25:23.585455	backoffice-0001-60533801052-2024-12-16T19:25:05.997Z	172.19.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	524.00	1	1	-99
213	2024-12-16 16:23:51.797986	2024-12-16 16:23:51.797989	0	2024-12-16 16:23:51.78687	backoffice-0001-60533801052-2024-12-16T19:23:51.737Z	172.19.0.1	167868	SOLICITACAO_PAGAMENTO	BACKOFFICE	backoffice-0001	94.55	1	1	-99
215	2024-12-16 16:25:06.043247	2024-12-16 16:25:06.043252	0	2024-12-16 16:25:06.037111	backoffice-0001-60533801052-2024-12-16T19:25:05.997Z	172.19.0.1	163712	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	524.00	1	1	-99
217	2024-12-16 17:08:00.624004	2024-12-16 17:08:00.624014	0	2024-12-16 17:08:00.606574	backoffice-0001-60533801052-2024-12-16T20:08:00.530Z	172.19.0.1	166066	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	536.00	4	1	-99
218	2024-12-16 17:08:08.674698	2024-12-16 17:08:08.674703	0	2024-12-16 17:08:08.668502	backoffice-0001-60533801052-2024-12-16T20:08:00.530Z	172.19.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	536.00	4	1	-99
219	2024-12-16 18:33:05.672921	2024-12-16 18:33:05.672931	0	2024-12-16 18:33:05.657767	678754	172.19.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	186.49	1	\N	\N
220	2024-12-16 18:34:05.730387	2024-12-16 18:34:05.730397	0	2024-12-16 18:34:05.705952	backoffice-estorno-20241216183405	172.19.0.1	167059	SOLICITACAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	524.00	1	1	-99
221	2024-12-16 18:34:15.552753	2024-12-16 18:34:15.55277	0	2024-12-16 18:34:14.447815	backoffice-estorno-20241216183405	172.19.0.1	\N	CONCLUSAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	524.00	1	1	-99
222	2024-12-16 18:34:15.55639	2024-12-16 18:34:15.556421	0	2024-12-16 18:34:14.456033	678754	172.19.0.1	\N	BOLETO_CANCELADO	BOLETO	\N	186.49	1	\N	\N
223	2024-12-17 09:23:51.536207	2024-12-17 09:23:51.536229	0	2024-12-17 09:23:51.50108	backoffice-0001-60533801052-2024-12-17T12:23:51.413Z	172.19.0.1	175011	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	174.00	1	1	-99
224	2024-12-17 09:24:09.293956	2024-12-17 09:24:09.293968	0	2024-12-17 09:24:09.281445	backoffice-0001-60533801052-2024-12-17T12:23:51.413Z	172.19.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	174.00	1	1	-99
225	2024-12-17 09:28:12.26412	2024-12-17 09:28:12.264129	0	2024-12-17 09:28:12.255807	678784	172.19.0.1	\N	EMISSAO_BOLETO	BOLETO	\N	64.62	1	\N	\N
226	2024-12-17 09:35:20.529705	2024-12-17 09:35:20.529724	0	2024-12-17 09:35:20.502451	backoffice-estorno-20241217093520	172.19.0.1	175024	SOLICITACAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	174.00	1	1	-99
227	2024-12-17 09:37:36.717983	2024-12-17 09:37:36.718009	0	2024-12-17 09:37:36.062116	backoffice-estorno-20241217093520	172.19.0.1	\N	CONCLUSAO_ESTORNO_VENDA	BACKOFFICE	backoffice-0001	174.00	1	1	-99
228	2024-12-17 09:37:36.724222	2024-12-17 09:37:36.724238	0	2024-12-17 09:37:36.084166	678784	172.19.0.1	\N	BOLETO_CANCELADO	BOLETO	\N	64.62	1	\N	\N
229	2024-12-17 14:41:46.720277	2024-12-17 14:41:46.720326	0	2024-12-17 14:41:46.6621	backoffice-0001-60533801052-2024-12-17T17:41:46.568Z	172.19.0.1	176621	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	182.00	1	1	-99
230	2024-12-17 14:42:15.781821	2024-12-17 14:42:15.781834	0	2024-12-17 14:42:15.767066	backoffice-0001-60533801052-2024-12-17T17:41:46.568Z	172.19.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	182.00	1	1	-99
231	2024-12-17 14:51:07.367478	2024-12-17 14:51:07.367496	0	2024-12-17 14:51:07.322726	backoffice-0001-60533801052-2024-12-17T17:41:48.568Z	172.19.0.1	173227	SOLICITACAO_ESTORNO_VENDA	PDV	01	182.00	1	1	-99
232	2024-12-17 14:53:46.029364	2024-12-17 14:53:46.029373	0	2024-12-17 14:53:46.010649	backoffice-0001-60533801052-2024-12-17T17:41:48.568Z	172.19.0.1	\N	CONCLUSAO_ESTORNO_VENDA	BACKOFFICE	01	182.00	1	1	-99
233	2024-12-24 10:11:33.420994	2024-12-24 10:11:33.421006	0	2024-12-24 10:11:33.39098	backoffice-0001-60533801052-2024-12-24T13:11:33.278Z	172.19.0.1	243910	SOLICITACAO_VENDA	BACKOFFICE	backoffice-0001	582.00	1	1	-99
234	2024-12-24 10:11:42.213019	2024-12-24 10:11:42.21303	0	2024-12-24 10:11:42.200002	backoffice-0001-60533801052-2024-12-24T13:11:33.278Z	172.19.0.1	\N	CONCLUSAO_VENDA	PDV	backoffice-0001	582.00	1	1	-99
\.


--
-- Data for Name: t_user; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_user (id_user, insert_date, update_date, version, access_attempt_count, access_attempt_date, data_validade_senha, email, login, name, password, status, tag, token_version, update_password) FROM stdin;
-7	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	0	2024-06-19	\N	hermano@parcelepag.digital	\N	Sênior	\N	ATIVO	SENIOR	0	f
-6	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	0	2024-06-19	\N	hermano@parcelepag.digital	\N	SmartNX	\N	ATIVO	SMARTNX	0	f
-4	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	0	2024-06-19	\N	jarddel@conductor.com.br	\N	Capana	\N	ATIVO	CAPANA	0	f
-3	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	0	2024-06-19	\N	contato@mob4pay.com	\N	Mob4Pay	\N	ATIVO	APP	0	f
-2	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	0	2024-06-19	\N	contabil@conductor.com.br	\N	Contábil	\N	ATIVO	CONTABIL	0	f
-1	2024-06-19 01:29:51.49729	2024-06-19 01:29:51.49729	0	0	2024-06-19	\N	tiago@kamaleon.com.br	\N	PDV	\N	ATIVO	PDV	0	f
2	2024-06-25 11:32:40.069796	2024-06-25 11:32:40.06983	0	0	2024-06-19	\N	petersvcosta@gmail.com	07532648403	Peter	$2a$10$.k.8.a4gPaS8.ZSvLiK0IuzJr9hVON3M/n5aggPW4o0bRbBlrGXiy	ATIVO	CONSUMIDOR	0	f
0	2024-07-16 23:38:08.48901	2024-07-16 23:38:08.48901	0	0	2024-07-16	\N	dev@kamaleon.com.br	dev	dev	$2a$10$g0AEuN8XzOwiHy4uNMLdZ.JPNCWhq4sW3kVZ5SZn0r1/1S/tgFbHC	ATIVO	KAMALEON	0	f
-99	2024-06-19 01:29:51.49729	2024-06-19 01:36:27.882799	1	0	2024-06-19	\N	bnpl@rpe.tech	60533801052	BNPL	$2a$10$Kw8ytDIgsmlgPTrqu0lJUuSUEjZnJeRObxQFkc518Qaz9zzJbOxXC	ATIVO	KAMALEON	0	f
3	2024-08-16 15:23:47.684207	2024-09-09 10:32:48.655409	4	0	2024-09-09	2024-08-16	bnpl@rpe.tech	60533801052	BNPL	$2a$10$ggMf6L7g8FxzPON/1ehwneMBP.62E6BYwlVS5FdutBJ4PSx0hBxr2	ATIVO	FUNCIONARIO	0	t
1	2024-06-20 14:28:28.177052	2024-10-11 17:06:09.954371	2	0	2024-06-19	2024-10-11	bnpl@rpe.tech	04531645409	Apollo Bnpl Parcelepag Midas	$2a$10$Q7jLoj8sEj1yPuaAMRpCyedtPFf5lx7m/OBiO3fnLO2iBKfZxs3bG	ATIVO	CONSUMIDOR	0	t
5	2024-09-05 11:25:11.554711	2024-09-05 11:25:11.554736	0	0	\N	\N	petersvcosta@gmail.com	07533648404004	Exemplo	$2a$10$UnmOCDqXHq8/DaouipTn..KjAhFQLwwQDfrdXbdRWoWqeA8WSAIoa	ATIVO	CONSUMIDOR	0	f
6	2024-10-11 01:49:25.691243	2024-10-11 01:49:25.691257	0	0	\N	\N	petersvcosta@gmail.com	07533648405	Peter Simon Veríssimo da Costa 2	$2a$10$iVduuA3KR7SSBBWaxXQgIeSGzgeKy1SXbOUeWsGofg2CoSfg5zlAu	ATIVO	CONSUMIDOR	0	f
4	2024-08-26 13:38:05.048382	2024-10-16 15:32:24.464404	9	0	2024-08-26	2024-10-16	peter.costa@rpe.tech	07533748404	Peter Costa	$2a$10$8Bpex49aHRN8YpFHMElxq.Anx0X.D.WGyaThhvvAvl.h3YpdnqtpW	ATIVO	FUNCIONARIO	0	f
\.


--
-- Data for Name: t_user_profile; Type: TABLE DATA; Schema: tvlar; Owner: postgres
--

COPY tvlar.t_user_profile (id_user, id_profile) FROM stdin;
-99	-99
-7	-7
-6	-6
-4	-4
-3	-3
-2	-2
-1	-1
1	-5
2	-5
0	-99
-99	-99
-7	-7
-6	-6
-4	-4
-3	-3
-2	-2
-1	-1
1	-5
2	-5
0	-99
3	1
-99	-99
-7	-7
-6	-6
-4	-4
-3	-3
-2	-2
-1	-1
1	-5
2	-5
0	-99
-99	-99
-7	-7
-6	-6
-4	-4
-3	-3
-2	-2
-1	-1
1	-5
2	-5
0	-99
3	1
4	1
5	-5
6	-5
\.


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.hibernate_sequence', 427, true);


--
-- Name: s_acordo; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_acordo', 1, true);


--
-- Name: s_acordo_abatimento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_acordo_abatimento', 1, false);


--
-- Name: s_acordo_origem; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_acordo_origem', 1, true);


--
-- Name: s_acordo_pagamento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_acordo_pagamento', 1, false);


--
-- Name: s_acordo_parcela; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_acordo_parcela', 1, true);


--
-- Name: s_administradora; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_administradora', 1, false);


--
-- Name: s_administradora_rede; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_administradora_rede', 2, true);


--
-- Name: s_antecipacao; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_antecipacao', 1, true);


--
-- Name: s_antecipacao_item; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_antecipacao_item', 2, true);


--
-- Name: s_boleto; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_boleto', 10, true);


--
-- Name: s_boleto_formato; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_boleto_formato', 10, true);


--
-- Name: s_broker_sms; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_broker_sms', 1, false);


--
-- Name: s_cartao; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cartao', 73, true);


--
-- Name: s_cartao_bin; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cartao_bin', 6, true);


--
-- Name: s_cartao_historico; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cartao_historico', 13, true);


--
-- Name: s_cartao_tipo_bloqueio; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cartao_tipo_bloqueio', 30, true);


--
-- Name: s_cdc; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cdc', 260, true);


--
-- Name: s_cdc_abatimento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cdc_abatimento', 169, true);


--
-- Name: s_cdc_historico; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cdc_historico', 1289, true);


--
-- Name: s_classificacao_reversao_pagamento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_classificacao_reversao_pagamento', 1, false);


--
-- Name: s_cobransaas; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_cobransaas', 1, false);


--
-- Name: s_consumidor; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_consumidor', 4, true);


--
-- Name: s_consumidor_conjuge; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_consumidor_conjuge', 1, false);


--
-- Name: s_consumidor_dependente; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_consumidor_dependente', 1, false);


--
-- Name: s_consumidor_referencia; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_consumidor_referencia', 1, false);


--
-- Name: s_consumidor_socio; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_consumidor_socio', 1, false);


--
-- Name: s_consumidor_telefone; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_consumidor_telefone', 5, true);


--
-- Name: s_contato; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_contato', 10, true);


--
-- Name: s_contrato; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_contrato', 54, true);


--
-- Name: s_endereco; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_endereco', 8, true);


--
-- Name: s_estabelecimento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_estabelecimento', 3, true);


--
-- Name: s_estorno; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_estorno', 11, true);


--
-- Name: s_execucao_job_agenda_repasse; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_execucao_job_agenda_repasse', 1, false);


--
-- Name: s_feriado; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_feriado', 41, true);


--
-- Name: s_funcionario; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_funcionario', 2, true);


--
-- Name: s_horizon; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_horizon', 1, false);


--
-- Name: s_horizon_servico; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_horizon_servico', 1, false);


--
-- Name: s_informacao_banco; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_informacao_banco', 1, false);


--
-- Name: s_integracao; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_integracao', 4, true);


--
-- Name: s_integracao_header; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_integracao_header', 14, true);


--
-- Name: s_lancamento_ajuste; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_lancamento_ajuste', 378, true);


--
-- Name: s_pagamento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_pagamento', 27, true);


--
-- Name: s_pagamento_item; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_pagamento_item', 167, true);


--
-- Name: s_plano_pagamento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_plano_pagamento', 13, true);


--
-- Name: s_produto; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_produto', 1, false);


--
-- Name: s_profile; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_profile', 1, true);


--
-- Name: s_proposta; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_proposta', 4, true);


--
-- Name: s_remessa; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_remessa', 1, false);


--
-- Name: s_remessa_contrato; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_remessa_contrato', 1, false);


--
-- Name: s_remessa_contrato_parcela; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_remessa_contrato_parcela', 1, false);


--
-- Name: s_remessa_contrato_parcela_historico; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_remessa_contrato_parcela_historico', 1, false);


--
-- Name: s_retorno_cnab; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_retorno_cnab', 1, false);


--
-- Name: s_retorno_parcela; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_retorno_parcela', 1, false);


--
-- Name: s_reversao_pagamento; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_reversao_pagamento', 2, true);


--
-- Name: s_reversao_pagamento_item; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_reversao_pagamento_item', 2, true);


--
-- Name: s_role; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_role', 146, true);


--
-- Name: s_senior; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_senior', 1, false);


--
-- Name: s_senior_log; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_senior_log', 1, false);


--
-- Name: s_sms; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_sms', 1, false);


--
-- Name: s_tipo_lancamento_ajuste; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_tipo_lancamento_ajuste', 69, true);


--
-- Name: s_tipo_transacao; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_tipo_transacao', 12, true);


--
-- Name: s_tivea_log; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_tivea_log', 16, true);


--
-- Name: s_token_acesso; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_token_acesso', 1, false);


--
-- Name: s_transacao; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_transacao', 234, true);


--
-- Name: s_user; Type: SEQUENCE SET; Schema: tvlar; Owner: postgres
--

SELECT pg_catalog.setval('tvlar.s_user', 6, true);


--
-- Name: t_cartao_bin pk_t_cartao_bin; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_bin
    ADD CONSTRAINT pk_t_cartao_bin PRIMARY KEY (id_cartao_bin);


--
-- Name: revinfo revinfo_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.revinfo
    ADD CONSTRAINT revinfo_pkey PRIMARY KEY (id);


--
-- Name: t_acordo_abatimento t_acordo_abatimento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_abatimento
    ADD CONSTRAINT t_acordo_abatimento_pkey PRIMARY KEY (id_acordo_abatimento);


--
-- Name: t_acordo_origem t_acordo_origem_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_origem
    ADD CONSTRAINT t_acordo_origem_pkey PRIMARY KEY (id_acordo_origem);


--
-- Name: t_acordo_pagamento t_acordo_pagamento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_pagamento
    ADD CONSTRAINT t_acordo_pagamento_pkey PRIMARY KEY (id_acordo_pagamento);


--
-- Name: t_acordo_parcela t_acordo_parcela_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_parcela
    ADD CONSTRAINT t_acordo_parcela_pkey PRIMARY KEY (id_acordo_parcela);


--
-- Name: t_acordo t_acordo_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo
    ADD CONSTRAINT t_acordo_pkey PRIMARY KEY (id_acordo);


--
-- Name: t_administradora_aud t_administradora_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_aud
    ADD CONSTRAINT t_administradora_aud_pkey PRIMARY KEY (id_administradora, rev);


--
-- Name: t_administradora_contato_aud t_administradora_contato_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_contato_aud
    ADD CONSTRAINT t_administradora_contato_aud_pkey PRIMARY KEY (rev, id_administradora, id_contato);


--
-- Name: t_administradora t_administradora_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora
    ADD CONSTRAINT t_administradora_pkey PRIMARY KEY (id_administradora);


--
-- Name: t_administradora_rede_aud t_administradora_rede_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_rede_aud
    ADD CONSTRAINT t_administradora_rede_aud_pkey PRIMARY KEY (id_administradora_rede, rev);


--
-- Name: t_administradora_rede t_administradora_rede_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_rede
    ADD CONSTRAINT t_administradora_rede_pkey PRIMARY KEY (id_administradora_rede);


--
-- Name: t_antecipacao_item t_antecipacao_item_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_antecipacao_item
    ADD CONSTRAINT t_antecipacao_item_pkey PRIMARY KEY (id_antecipacao_item);


--
-- Name: t_antecipacao t_antecipacao_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_antecipacao
    ADD CONSTRAINT t_antecipacao_pkey PRIMARY KEY (id_antecipacao);


--
-- Name: t_boleto_formato t_boleto_formato_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto_formato
    ADD CONSTRAINT t_boleto_formato_pkey PRIMARY KEY (id_boleto_formato);


--
-- Name: t_boleto t_boleto_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto
    ADD CONSTRAINT t_boleto_pkey PRIMARY KEY (id_boleto);


--
-- Name: t_broker_sms t_broker_sms_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_broker_sms
    ADD CONSTRAINT t_broker_sms_pkey PRIMARY KEY (id_broker_sms);


--
-- Name: t_cartao_historico t_cartao_historico_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_historico
    ADD CONSTRAINT t_cartao_historico_pkey PRIMARY KEY (id_cartao_historico);


--
-- Name: t_cartao t_cartao_numero_unico; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao
    ADD CONSTRAINT t_cartao_numero_unico UNIQUE (numero_cartao);


--
-- Name: t_cartao t_cartao_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao
    ADD CONSTRAINT t_cartao_pkey PRIMARY KEY (id_cartao);


--
-- Name: t_cartao_tipo_bloqueio_aud t_cartao_tipo_bloqueio_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_tipo_bloqueio_aud
    ADD CONSTRAINT t_cartao_tipo_bloqueio_aud_pkey PRIMARY KEY (id_cartao_tipo_bloqueio, rev);


--
-- Name: t_cartao_tipo_bloqueio t_cartao_tipo_bloqueio_descricao_unica; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_tipo_bloqueio
    ADD CONSTRAINT t_cartao_tipo_bloqueio_descricao_unica UNIQUE (descricao);


--
-- Name: t_cartao_tipo_bloqueio t_cartao_tipo_bloqueio_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_tipo_bloqueio
    ADD CONSTRAINT t_cartao_tipo_bloqueio_pkey PRIMARY KEY (id_cartao_tipo_bloqueio);


--
-- Name: t_cdc_abatimento t_cdc_abatimento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_abatimento
    ADD CONSTRAINT t_cdc_abatimento_pkey PRIMARY KEY (id_cdc_abatimento);


--
-- Name: t_cdc_historico t_cdc_historico_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_historico
    ADD CONSTRAINT t_cdc_historico_pkey PRIMARY KEY (id_cdc_historico);


--
-- Name: t_cdc t_cdc_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc
    ADD CONSTRAINT t_cdc_pkey PRIMARY KEY (id_cdc);


--
-- Name: t_classificacao_reversao_pagamento t_classificacao_reversao_pagamento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_classificacao_reversao_pagamento
    ADD CONSTRAINT t_classificacao_reversao_pagamento_pkey PRIMARY KEY (id_classificacao);


--
-- Name: t_classificador_aud t_classificador_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_classificador_aud
    ADD CONSTRAINT t_classificador_aud_pkey PRIMARY KEY (id_classificador, rev);


--
-- Name: t_classificador t_classificador_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_classificador
    ADD CONSTRAINT t_classificador_pkey PRIMARY KEY (id_classificador);


--
-- Name: t_cobransaas t_cobransaas_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cobransaas
    ADD CONSTRAINT t_cobransaas_pkey PRIMARY KEY (id_cobransaas);


--
-- Name: t_consumidor_aud t_consumidor_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_aud
    ADD CONSTRAINT t_consumidor_aud_pkey PRIMARY KEY (id_consumidor, rev);


--
-- Name: t_consumidor_conjuge_aud t_consumidor_conjuge_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_conjuge_aud
    ADD CONSTRAINT t_consumidor_conjuge_aud_pkey PRIMARY KEY (id_consumidor_conjuge, rev);


--
-- Name: t_consumidor_conjuge t_consumidor_conjuge_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_conjuge
    ADD CONSTRAINT t_consumidor_conjuge_pkey PRIMARY KEY (id_consumidor_conjuge);


--
-- Name: t_consumidor_dependente_aud t_consumidor_dependente_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_dependente_aud
    ADD CONSTRAINT t_consumidor_dependente_aud_pkey PRIMARY KEY (id_consumidor_dependente, rev);


--
-- Name: t_consumidor_dependente t_consumidor_dependente_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_dependente
    ADD CONSTRAINT t_consumidor_dependente_pkey PRIMARY KEY (id_consumidor_dependente);


--
-- Name: t_consumidor t_consumidor_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor
    ADD CONSTRAINT t_consumidor_pkey PRIMARY KEY (id_consumidor);


--
-- Name: t_consumidor_referencia_aud t_consumidor_referencia_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_referencia_aud
    ADD CONSTRAINT t_consumidor_referencia_aud_pkey PRIMARY KEY (id_consumidor_referencia, rev);


--
-- Name: t_consumidor_referencia t_consumidor_referencia_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_referencia
    ADD CONSTRAINT t_consumidor_referencia_pkey PRIMARY KEY (id_consumidor_referencia);


--
-- Name: t_consumidor_socio_aud t_consumidor_socio_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_socio_aud
    ADD CONSTRAINT t_consumidor_socio_aud_pkey PRIMARY KEY (id_consumidor_socio, rev);


--
-- Name: t_consumidor_socio t_consumidor_socio_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_socio
    ADD CONSTRAINT t_consumidor_socio_pkey PRIMARY KEY (id_consumidor_socio);


--
-- Name: t_consumidor_telefone_aud t_consumidor_telefone_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_telefone_aud
    ADD CONSTRAINT t_consumidor_telefone_aud_pkey PRIMARY KEY (id_consumidor_telefone, rev);


--
-- Name: t_consumidor_telefone t_consumidor_telefone_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_telefone
    ADD CONSTRAINT t_consumidor_telefone_pkey PRIMARY KEY (id_consumidor_telefone);


--
-- Name: t_contato_aud t_contato_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contato_aud
    ADD CONSTRAINT t_contato_aud_pkey PRIMARY KEY (idcontato, rev);


--
-- Name: t_contato t_contato_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contato
    ADD CONSTRAINT t_contato_pkey PRIMARY KEY (idcontato);


--
-- Name: t_contrato t_contrato_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT t_contrato_pkey PRIMARY KEY (id_contrato);


--
-- Name: t_endereco_aud t_endereco_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_endereco_aud
    ADD CONSTRAINT t_endereco_aud_pkey PRIMARY KEY (id_endereco, rev);


--
-- Name: t_endereco t_endereco_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_endereco
    ADD CONSTRAINT t_endereco_pkey PRIMARY KEY (id_endereco);


--
-- Name: t_estabelecimento_aud t_estabelecimento_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento_aud
    ADD CONSTRAINT t_estabelecimento_aud_pkey PRIMARY KEY (id_estabelecimento, rev);


--
-- Name: t_estabelecimento_contato_aud t_estabelecimento_contato_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento_contato_aud
    ADD CONSTRAINT t_estabelecimento_contato_aud_pkey PRIMARY KEY (rev, id_estabelecimento, id_contato);


--
-- Name: t_estabelecimento t_estabelecimento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento
    ADD CONSTRAINT t_estabelecimento_pkey PRIMARY KEY (id_estabelecimento);


--
-- Name: t_estorno t_estorno_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno
    ADD CONSTRAINT t_estorno_pkey PRIMARY KEY (id_estorno);


--
-- Name: t_execucao_job_agenda_repasse t_execucao_job_agenda_repasse_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_execucao_job_agenda_repasse
    ADD CONSTRAINT t_execucao_job_agenda_repasse_pkey PRIMARY KEY (id_execucao_job_agenda_repasse);


--
-- Name: t_feriado_aud t_feriado_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_feriado_aud
    ADD CONSTRAINT t_feriado_aud_pkey PRIMARY KEY (id_feriado, rev);


--
-- Name: t_feriado t_feriado_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_feriado
    ADD CONSTRAINT t_feriado_pkey PRIMARY KEY (id_feriado);


--
-- Name: t_funcionario_aud t_funcionario_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario_aud
    ADD CONSTRAINT t_funcionario_aud_pkey PRIMARY KEY (id_funcionario, rev);


--
-- Name: t_funcionario_contato_aud t_funcionario_contato_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario_contato_aud
    ADD CONSTRAINT t_funcionario_contato_aud_pkey PRIMARY KEY (rev, id_funcionario, id_contato);


--
-- Name: t_funcionario t_funcionario_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario
    ADD CONSTRAINT t_funcionario_pkey PRIMARY KEY (id_funcionario);


--
-- Name: t_horizon t_horizon_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_horizon
    ADD CONSTRAINT t_horizon_pkey PRIMARY KEY (id_horizon);


--
-- Name: t_horizon_servico t_horizon_servico_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_horizon_servico
    ADD CONSTRAINT t_horizon_servico_pkey PRIMARY KEY (id_horizon_servico);


--
-- Name: t_informacao_banco t_informacao_banco_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_informacao_banco
    ADD CONSTRAINT t_informacao_banco_pkey PRIMARY KEY (id_informacao_banco);


--
-- Name: t_integracao_header t_integracao_header_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_integracao_header
    ADD CONSTRAINT t_integracao_header_pkey PRIMARY KEY (id_integracao_header);


--
-- Name: t_integracao t_integracao_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_integracao
    ADD CONSTRAINT t_integracao_pkey PRIMARY KEY (id_integracao);


--
-- Name: t_lancamento_ajuste t_lancamento_ajuste_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_lancamento_ajuste
    ADD CONSTRAINT t_lancamento_ajuste_pkey PRIMARY KEY (id_lancamento_ajuste);


--
-- Name: t_pagamento_item t_pagamento_item_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento_item
    ADD CONSTRAINT t_pagamento_item_pkey PRIMARY KEY (id_pagamento_item);


--
-- Name: t_pagamento t_pagamento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento
    ADD CONSTRAINT t_pagamento_pkey PRIMARY KEY (id_pagamento);


--
-- Name: t_parametro_aud t_parametro_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_parametro_aud
    ADD CONSTRAINT t_parametro_aud_pkey PRIMARY KEY (id, rev);


--
-- Name: t_parametro t_parametro_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_parametro
    ADD CONSTRAINT t_parametro_pkey PRIMARY KEY (id);


--
-- Name: t_plano_pagamento_aud t_plano_pagamento_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_plano_pagamento_aud
    ADD CONSTRAINT t_plano_pagamento_aud_pkey PRIMARY KEY (id_plano_pagamento, rev);


--
-- Name: t_plano_pagamento t_plano_pagamento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_plano_pagamento
    ADD CONSTRAINT t_plano_pagamento_pkey PRIMARY KEY (id_plano_pagamento);


--
-- Name: t_produto_aud t_produto_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_produto_aud
    ADD CONSTRAINT t_produto_aud_pkey PRIMARY KEY (id_produto, rev);


--
-- Name: t_produto t_produto_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_produto
    ADD CONSTRAINT t_produto_pkey PRIMARY KEY (id_produto);


--
-- Name: t_profile t_profile_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_profile
    ADD CONSTRAINT t_profile_pkey PRIMARY KEY (id_profile);


--
-- Name: t_proposta_aud t_proposta_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_proposta_aud
    ADD CONSTRAINT t_proposta_aud_pkey PRIMARY KEY (id_proposta, rev);


--
-- Name: t_proposta t_proposta_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_proposta
    ADD CONSTRAINT t_proposta_pkey PRIMARY KEY (id_proposta);


--
-- Name: t_remessa_contrato_parcela_historico t_remessa_contrato_parcela_historico_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa_contrato_parcela_historico
    ADD CONSTRAINT t_remessa_contrato_parcela_historico_pkey PRIMARY KEY (id_remessa_contrato_parcela_historico);


--
-- Name: t_remessa_contrato_parcela t_remessa_contrato_parcela_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa_contrato_parcela
    ADD CONSTRAINT t_remessa_contrato_parcela_pkey PRIMARY KEY (id_remessa_contrato_parcela);


--
-- Name: t_remessa_contrato t_remessa_contrato_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa_contrato
    ADD CONSTRAINT t_remessa_contrato_pkey PRIMARY KEY (id_remessa_contrato);


--
-- Name: t_remessa t_remessa_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa
    ADD CONSTRAINT t_remessa_pkey PRIMARY KEY (id_remessa);


--
-- Name: t_retorno_cnab t_retorno_cnab_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_retorno_cnab
    ADD CONSTRAINT t_retorno_cnab_pkey PRIMARY KEY (id_retorno_cnab);


--
-- Name: t_retorno_parcela t_retorno_parcela_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_retorno_parcela
    ADD CONSTRAINT t_retorno_parcela_pkey PRIMARY KEY (id_retorno_parcela);


--
-- Name: t_reversao_pagamento_item t_reversao_pagamento_item_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento_item
    ADD CONSTRAINT t_reversao_pagamento_item_pkey PRIMARY KEY (id_reversao_pagamento_item);


--
-- Name: t_reversao_pagamento t_reversao_pagamento_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento
    ADD CONSTRAINT t_reversao_pagamento_pkey PRIMARY KEY (id_reversao_pagamento);


--
-- Name: t_role t_role_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_role
    ADD CONSTRAINT t_role_pkey PRIMARY KEY (id_role);


--
-- Name: t_senior_log t_senior_log_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_senior_log
    ADD CONSTRAINT t_senior_log_pkey PRIMARY KEY (id_senior_log);


--
-- Name: t_senior t_senior_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_senior
    ADD CONSTRAINT t_senior_pkey PRIMARY KEY (id_senior);


--
-- Name: t_sms t_sms_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_sms
    ADD CONSTRAINT t_sms_pkey PRIMARY KEY (id_sms);


--
-- Name: t_tipo_lancamento_ajuste_aud t_tipo_lancamento_ajuste_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_tipo_lancamento_ajuste_aud
    ADD CONSTRAINT t_tipo_lancamento_ajuste_aud_pkey PRIMARY KEY (id_tipo_lancamento_ajuste, rev);


--
-- Name: t_tipo_lancamento_ajuste t_tipo_lancamento_ajuste_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_tipo_lancamento_ajuste
    ADD CONSTRAINT t_tipo_lancamento_ajuste_pkey PRIMARY KEY (id_tipo_lancamento_ajuste);


--
-- Name: t_tipo_transacao t_tipo_transacao_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_tipo_transacao
    ADD CONSTRAINT t_tipo_transacao_pkey PRIMARY KEY (id_tipo_transacao);


--
-- Name: t_tivea_log t_tivea_log_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_tivea_log
    ADD CONSTRAINT t_tivea_log_pkey PRIMARY KEY (id_tivea_log);


--
-- Name: t_token_acesso_aud t_token_acesso_aud_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_token_acesso_aud
    ADD CONSTRAINT t_token_acesso_aud_pkey PRIMARY KEY (id_token_acesso, rev);


--
-- Name: t_token_acesso t_token_acesso_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_token_acesso
    ADD CONSTRAINT t_token_acesso_pkey PRIMARY KEY (id_token_acesso);


--
-- Name: t_transacao t_transacao_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_transacao
    ADD CONSTRAINT t_transacao_pkey PRIMARY KEY (id_transacao);


--
-- Name: t_user t_user_pkey; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (id_user);


--
-- Name: t_cartao_bin uc_t_cartao_bin_descricao; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_bin
    ADD CONSTRAINT uc_t_cartao_bin_descricao UNIQUE (descricao);


--
-- Name: t_cartao_bin uc_t_cartao_bin_numero_bin; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_bin
    ADD CONSTRAINT uc_t_cartao_bin_numero_bin UNIQUE (numero_bin);


--
-- Name: t_user uk2w69mogeqkkhft7dku61pm2ah; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_user
    ADD CONSTRAINT uk2w69mogeqkkhft7dku61pm2ah UNIQUE (login, tag);


--
-- Name: t_acordo_transacao uk_36ljvxycj8hpou57s17snjfhm; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_transacao
    ADD CONSTRAINT uk_36ljvxycj8hpou57s17snjfhm UNIQUE (id_transacao);


--
-- Name: t_funcionario_contato uk_3hqwcclikt020ciqjim43ua7c; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario_contato
    ADD CONSTRAINT uk_3hqwcclikt020ciqjim43ua7c UNIQUE (id_contato);


--
-- Name: t_reversao_pagamento_transacao uk_cxiajjiy89dwmas9xyvdl60mh; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento_transacao
    ADD CONSTRAINT uk_cxiajjiy89dwmas9xyvdl60mh UNIQUE (id_transacao);


--
-- Name: t_estorno_transacao uk_e5dqw2xhq9t9crmduuf4p1j52; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno_transacao
    ADD CONSTRAINT uk_e5dqw2xhq9t9crmduuf4p1j52 UNIQUE (id_transacao);


--
-- Name: t_pagamento_transacao uk_ng7tykrm012jouq7a6brvxn0n; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento_transacao
    ADD CONSTRAINT uk_ng7tykrm012jouq7a6brvxn0n UNIQUE (id_transacao);


--
-- Name: t_administradora_contato uk_q91j1oavrpsd1aqxda8fexulg; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_contato
    ADD CONSTRAINT uk_q91j1oavrpsd1aqxda8fexulg UNIQUE (id_contato);


--
-- Name: t_estabelecimento_contato uk_sgypdvm5ypl03q5wkqm51aaby; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento_contato
    ADD CONSTRAINT uk_sgypdvm5ypl03q5wkqm51aaby UNIQUE (id_contato);


--
-- Name: t_contrato_transacao uk_staj5yu1gwbwd7qxvw1nu3i6i; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato_transacao
    ADD CONSTRAINT uk_staj5yu1gwbwd7qxvw1nu3i6i UNIQUE (id_transacao);


--
-- Name: t_boleto_transacao uk_tlst9kj2619m9p1tir13h8m27; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto_transacao
    ADD CONSTRAINT uk_tlst9kj2619m9p1tir13h8m27 UNIQUE (id_transacao);


--
-- Name: t_classificacao_reversao_pagamento ukb3vhxhj4sbonc955s2jjqih2e; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_classificacao_reversao_pagamento
    ADD CONSTRAINT ukb3vhxhj4sbonc955s2jjqih2e UNIQUE (descricao, codigo_contabil);


--
-- Name: t_classificador ukcn8fi54o8ugudjdi96mvjnd1e; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_classificador
    ADD CONSTRAINT ukcn8fi54o8ugudjdi96mvjnd1e UNIQUE (descricao);


--
-- Name: t_produto ukcxn265032i5utwfkyycm767f5; Type: CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_produto
    ADD CONSTRAINT ukcxn265032i5utwfkyycm767f5 UNIQUE (descricao);


--
-- Name: idx_acordo_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_id_consumidor ON tvlar.t_acordo USING btree (id_consumidor);


--
-- Name: idx_acordo_id_contrato; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_id_contrato ON tvlar.t_acordo USING btree (id_contrato);


--
-- Name: idx_acordo_origem_id_acordo; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_origem_id_acordo ON tvlar.t_acordo_origem USING btree (id_acordo);


--
-- Name: idx_acordo_origem_id_cdc; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_origem_id_cdc ON tvlar.t_acordo_origem USING btree (id_cdc);


--
-- Name: idx_acordo_parcela_id_acordo; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_parcela_id_acordo ON tvlar.t_acordo_parcela USING btree (id_acordo);


--
-- Name: idx_acordo_parcela_id_cdc; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_parcela_id_cdc ON tvlar.t_acordo_parcela USING btree (id_cdc);


--
-- Name: idx_acordo_parcela_numero_parcela; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_parcela_numero_parcela ON tvlar.t_acordo_parcela USING btree (numero_parcela);


--
-- Name: idx_acordo_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_acordo_status ON tvlar.t_acordo USING btree (status);


--
-- Name: idx_administradora_contato_id_administradora; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_administradora_contato_id_administradora ON tvlar.t_administradora_contato USING btree (id_administradora);


--
-- Name: idx_boleto_codigo_externo; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_boleto_codigo_externo ON tvlar.t_boleto USING btree (codigo_externo);


--
-- Name: idx_boleto_formato_id_boleto; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_boleto_formato_id_boleto ON tvlar.t_boleto_formato USING btree (id_boleto);


--
-- Name: idx_boleto_id_boleto_formato; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_boleto_id_boleto_formato ON tvlar.t_boleto USING btree (id_boleto_formato);


--
-- Name: idx_boleto_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_boleto_id_consumidor ON tvlar.t_boleto USING btree (id_consumidor);


--
-- Name: idx_boleto_transacao_id_boleto; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_boleto_transacao_id_boleto ON tvlar.t_boleto_transacao USING btree (id_boleto);


--
-- Name: idx_boleto_transacao_id_transacao; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_boleto_transacao_id_transacao ON tvlar.t_boleto_transacao USING btree (id_transacao);


--
-- Name: idx_cartao_historico_id_cartao; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cartao_historico_id_cartao ON tvlar.t_cartao_historico USING btree (id_cartao);


--
-- Name: idx_cartao_historico_id_cartao_tipo_bloqueio; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cartao_historico_id_cartao_tipo_bloqueio ON tvlar.t_cartao_historico USING btree (id_cartao_tipo_bloqueio);


--
-- Name: idx_cartao_historico_id_user; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cartao_historico_id_user ON tvlar.t_cartao_historico USING btree (id_user);


--
-- Name: idx_cdc_abatimento_id_cdc; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_abatimento_id_cdc ON tvlar.t_cdc_abatimento USING btree (id_cdc);


--
-- Name: idx_cdc_abatimento_id_pagamento_item; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_abatimento_id_pagamento_item ON tvlar.t_cdc_abatimento USING btree (id_pagamento_item);


--
-- Name: idx_cdc_boleto_id_boleto; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_boleto_id_boleto ON tvlar.t_cdc_boleto USING btree (id_boleto);


--
-- Name: idx_cdc_boleto_id_cdc; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_boleto_id_cdc ON tvlar.t_cdc_boleto USING btree (id_cdc);


--
-- Name: idx_cdc_cobranca; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_cobranca ON tvlar.t_cdc USING btree (cobranca);


--
-- Name: idx_cdc_codigo_barra; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_codigo_barra ON tvlar.t_cdc USING btree (codigo_barra);


--
-- Name: idx_cdc_data_perdido; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_data_perdido ON tvlar.t_cdc USING btree (data_perdido);


--
-- Name: idx_cdc_data_vencimento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_data_vencimento ON tvlar.t_cdc USING btree (data_vencimento);


--
-- Name: idx_cdc_historico_id_cdc; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_historico_id_cdc ON tvlar.t_cdc_historico USING btree (id_cdc);


--
-- Name: idx_cdc_historico_id_transacao; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_historico_id_transacao ON tvlar.t_cdc_historico USING btree (id_transacao);


--
-- Name: idx_cdc_id_contrato; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_id_contrato ON tvlar.t_cdc USING btree (id_contrato);


--
-- Name: idx_cdc_numero_parcela; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_numero_parcela ON tvlar.t_cdc USING btree (numero_parcela);


--
-- Name: idx_cdc_renegociado; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_renegociado ON tvlar.t_cdc USING btree (renegociado);


--
-- Name: idx_cdc_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_cdc_status ON tvlar.t_cdc USING btree (status);


--
-- Name: idx_consumidor_conjuge_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_conjuge_id_consumidor ON tvlar.t_consumidor_conjuge USING btree (id_consumidor);


--
-- Name: idx_consumidor_cpf_cnpj; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_cpf_cnpj ON tvlar.t_consumidor USING btree (cpf_cnpj);


--
-- Name: idx_consumidor_data_nascimento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_data_nascimento ON tvlar.t_consumidor USING btree (data_nascimento);


--
-- Name: idx_consumidor_id_endereco_residencial; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_id_endereco_residencial ON tvlar.t_consumidor USING btree (id_endereco_residencial);


--
-- Name: idx_consumidor_id_user; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_id_user ON tvlar.t_consumidor USING btree (id_user);


--
-- Name: idx_consumidor_nome; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_nome ON tvlar.t_consumidor USING btree (nome);


--
-- Name: idx_consumidor_referencia_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_referencia_id_consumidor ON tvlar.t_consumidor_referencia USING btree (id_consumidor);


--
-- Name: idx_consumidor_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_status ON tvlar.t_consumidor USING btree (status);


--
-- Name: idx_consumidor_telefone_id_conjuge; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_telefone_id_conjuge ON tvlar.t_consumidor_telefone USING btree (id_conjuge);


--
-- Name: idx_consumidor_telefone_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_telefone_id_consumidor ON tvlar.t_consumidor_telefone USING btree (id_consumidor);


--
-- Name: idx_consumidor_telefone_id_consumidor_referencia; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_consumidor_telefone_id_consumidor_referencia ON tvlar.t_consumidor_telefone USING btree (id_consumidor_referencia);


--
-- Name: idx_contrato_data; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_data ON tvlar.t_contrato USING btree (((data)::date));


--
-- Name: idx_contrato_id_acordo; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_id_acordo ON tvlar.t_contrato USING btree (id_acordo);


--
-- Name: idx_contrato_id_codigo_barra; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_id_codigo_barra ON tvlar.t_contrato USING btree (codigo_barra);


--
-- Name: idx_contrato_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_id_consumidor ON tvlar.t_contrato USING btree (id_consumidor);


--
-- Name: idx_contrato_id_estabelecimento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_id_estabelecimento ON tvlar.t_contrato USING btree (id_estabelecimento);


--
-- Name: idx_contrato_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_status ON tvlar.t_contrato USING btree (status);


--
-- Name: idx_contrato_tipo; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_tipo ON tvlar.t_contrato USING btree (tipo);


--
-- Name: idx_contrato_transacao_id_contrato; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_transacao_id_contrato ON tvlar.t_contrato_transacao USING btree (id_contrato);


--
-- Name: idx_contrato_transacao_id_transacao; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_contrato_transacao_id_transacao ON tvlar.t_contrato_transacao USING btree (id_transacao);


--
-- Name: idx_estabelecimento_cnpj; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_estabelecimento_cnpj ON tvlar.t_estabelecimento USING btree (cnpj);


--
-- Name: idx_estabelecimento_contato_id_estabelecimento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_estabelecimento_contato_id_estabelecimento ON tvlar.t_estabelecimento_contato USING btree (id_estabelecimento);


--
-- Name: idx_estabelecimento_id_endereco; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_estabelecimento_id_endereco ON tvlar.t_estabelecimento USING btree (id_endereco);


--
-- Name: idx_estorno_data; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_estorno_data ON tvlar.t_estorno USING btree (data);


--
-- Name: idx_estorno_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_estorno_status ON tvlar.t_estorno USING btree (status);


--
-- Name: idx_estorno_transacao_id_estorno; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_estorno_transacao_id_estorno ON tvlar.t_estorno_transacao USING btree (id_estorno);


--
-- Name: idx_funcionario_contato_id_funcionario; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_funcionario_contato_id_funcionario ON tvlar.t_funcionario_contato USING btree (id_funcionario);


--
-- Name: idx_funcionario_id_user; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_funcionario_id_user ON tvlar.t_funcionario USING btree (id_user);


--
-- Name: idx_pagamento_data; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_data ON tvlar.t_pagamento USING btree (((data)::date));


--
-- Name: idx_pagamento_id_boleto; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_id_boleto ON tvlar.t_pagamento USING btree (id_boleto);


--
-- Name: idx_pagamento_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_id_consumidor ON tvlar.t_pagamento USING btree (id_consumidor);


--
-- Name: idx_pagamento_id_estabelecimento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_id_estabelecimento ON tvlar.t_pagamento USING btree (id_estabelecimento);


--
-- Name: idx_pagamento_id_estorno; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_id_estorno ON tvlar.t_pagamento USING btree (id_estorno);


--
-- Name: idx_pagamento_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_status ON tvlar.t_pagamento USING btree (status);


--
-- Name: idx_pagamento_tipo; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_tipo ON tvlar.t_pagamento USING btree (tipo);


--
-- Name: idx_pagamento_transacao_id_pagamento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_transacao_id_pagamento ON tvlar.t_pagamento_transacao USING btree (id_pagamento);


--
-- Name: idx_pagamento_transacao_id_transacao; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_pagamento_transacao_id_transacao ON tvlar.t_pagamento_transacao USING btree (id_transacao);


--
-- Name: idx_profile_role_id_profile; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_profile_role_id_profile ON tvlar.t_profile_role USING btree (id_profile);


--
-- Name: idx_profile_role_id_role; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_profile_role_id_role ON tvlar.t_profile_role USING btree (id_role);


--
-- Name: idx_proposta_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_proposta_consumidor ON tvlar.t_proposta USING btree (id_consumidor);


--
-- Name: idx_proposta_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_proposta_status ON tvlar.t_proposta USING btree (status);


--
-- Name: idx_t_pagamento_item_cdc; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_t_pagamento_item_cdc ON tvlar.t_pagamento_item USING btree (id_cdc);


--
-- Name: idx_t_pagamento_item_id_pagamento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_t_pagamento_item_id_pagamento ON tvlar.t_pagamento_item USING btree (id_pagamento);


--
-- Name: idx_tivea_log_http_status; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_tivea_log_http_status ON tvlar.t_tivea_log USING btree (http_status);


--
-- Name: idx_tivea_log_id_transacao; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_tivea_log_id_transacao ON tvlar.t_tivea_log USING btree (id_transacao);


--
-- Name: idx_transacao_data; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_transacao_data ON tvlar.t_transacao USING btree (((data)::date));


--
-- Name: idx_transacao_id_consumidor; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_transacao_id_consumidor ON tvlar.t_transacao USING btree (id_consumidor);


--
-- Name: idx_transacao_id_estabelecimento; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_transacao_id_estabelecimento ON tvlar.t_transacao USING btree (id_estabelecimento);


--
-- Name: idx_transacao_identificador; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_transacao_identificador ON tvlar.t_transacao USING btree (identificador);


--
-- Name: idx_transacao_nsu; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_transacao_nsu ON tvlar.t_transacao USING btree (nsu);


--
-- Name: idx_transacao_operacao; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_transacao_operacao ON tvlar.t_transacao USING btree (operacao);


--
-- Name: idx_user_login; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_user_login ON tvlar.t_user USING btree (login);


--
-- Name: idx_user_profile_id_profile; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_user_profile_id_profile ON tvlar.t_user_profile USING btree (id_profile);


--
-- Name: idx_user_profile_id_user; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_user_profile_id_user ON tvlar.t_user_profile USING btree (id_user);


--
-- Name: idx_user_tag; Type: INDEX; Schema: tvlar; Owner: postgres
--

CREATE INDEX idx_user_tag ON tvlar.t_user USING btree (tag);


--
-- Name: t_lancamento_ajuste apos_cadastrar_lancamento_ajuste; Type: TRIGGER; Schema: tvlar; Owner: postgres
--

CREATE TRIGGER apos_cadastrar_lancamento_ajuste AFTER INSERT ON tvlar.t_lancamento_ajuste FOR EACH ROW EXECUTE FUNCTION tvlar.atualizar_cdc_ajuste();


--
-- Name: t_cdc fk15ecnh190o97pp1qr0hndx4hk; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc
    ADD CONSTRAINT fk15ecnh190o97pp1qr0hndx4hk FOREIGN KEY (id_contrato) REFERENCES tvlar.t_contrato(id_contrato);


--
-- Name: t_funcionario_aud fk1mptha3qelnr2a4d63txfdfoh; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario_aud
    ADD CONSTRAINT fk1mptha3qelnr2a4d63txfdfoh FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_token_acesso_aud fk1n3co8r56s7avs9cldahy926u; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_token_acesso_aud
    ADD CONSTRAINT fk1n3co8r56s7avs9cldahy926u FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_integracao_header fk1xs9d19oi78277cewvjld52gt; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_integracao_header
    ADD CONSTRAINT fk1xs9d19oi78277cewvjld52gt FOREIGN KEY (id_integracao) REFERENCES tvlar.t_integracao(id_integracao);


--
-- Name: t_contrato fk20svornu9iwriyl81prhn1xf2; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT fk20svornu9iwriyl81prhn1xf2 FOREIGN KEY (id_plano_pagamento) REFERENCES tvlar.t_plano_pagamento(id_plano_pagamento);


--
-- Name: t_horizon_servico fk27j1xjujgpu465487uokvmii6; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_horizon_servico
    ADD CONSTRAINT fk27j1xjujgpu465487uokvmii6 FOREIGN KEY (id_horizon) REFERENCES tvlar.t_horizon(id_horizon);


--
-- Name: t_cdc_abatimento fk29ehrcs5683bodc0h9fdnwgy2; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_abatimento
    ADD CONSTRAINT fk29ehrcs5683bodc0h9fdnwgy2 FOREIGN KEY (id_pagamento_item) REFERENCES tvlar.t_pagamento_item(id_pagamento_item);


--
-- Name: t_endereco_aud fk2fkj9f5h0rom9hww3awuof2om; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_endereco_aud
    ADD CONSTRAINT fk2fkj9f5h0rom9hww3awuof2om FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_estorno_transacao fk2l04c2ke8w1vglm12upyb0r1n; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno_transacao
    ADD CONSTRAINT fk2l04c2ke8w1vglm12upyb0r1n FOREIGN KEY (id_estorno) REFERENCES tvlar.t_estorno(id_estorno);


--
-- Name: t_administradora fk2qld8dlg7sst4utbihpyrfma7; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora
    ADD CONSTRAINT fk2qld8dlg7sst4utbihpyrfma7 FOREIGN KEY (id_endereco) REFERENCES tvlar.t_endereco(id_endereco);


--
-- Name: t_proposta_aud fk2r94e688jetap9bvmhbugvpbk; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_proposta_aud
    ADD CONSTRAINT fk2r94e688jetap9bvmhbugvpbk FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_proposta fk2x9dg1owsir1qdqmq76gl2xsw; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_proposta
    ADD CONSTRAINT fk2x9dg1owsir1qdqmq76gl2xsw FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_parametro_aud fk2yq53rnx76uwku90fib80o5aw; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_parametro_aud
    ADD CONSTRAINT fk2yq53rnx76uwku90fib80o5aw FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_estabelecimento_aud fk35iewwg0qt2row0jeluu6lajr; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento_aud
    ADD CONSTRAINT fk35iewwg0qt2row0jeluu6lajr FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_estabelecimento_contato fk3iykeeotyt8ad0wxlcjxvmsqa; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento_contato
    ADD CONSTRAINT fk3iykeeotyt8ad0wxlcjxvmsqa FOREIGN KEY (id_contato) REFERENCES tvlar.t_contato(idcontato);


--
-- Name: t_consumidor fk41691g1e9vhtec2i28ep01diu; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor
    ADD CONSTRAINT fk41691g1e9vhtec2i28ep01diu FOREIGN KEY (id_endereco_residencial) REFERENCES tvlar.t_endereco(id_endereco);


--
-- Name: t_contrato_transacao fk41cplocnkwmhwynu0rgli6bdw; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato_transacao
    ADD CONSTRAINT fk41cplocnkwmhwynu0rgli6bdw FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_reversao_pagamento fk480rcprrcqee4frmmhotdaqv; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento
    ADD CONSTRAINT fk480rcprrcqee4frmmhotdaqv FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_estabelecimento_contato_aud fk48txi8brm49kyse5kx2n2to3g; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento_contato_aud
    ADD CONSTRAINT fk48txi8brm49kyse5kx2n2to3g FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_contrato fk48wa8m3lqmb2u8q8d884sc04t; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT fk48wa8m3lqmb2u8q8d884sc04t FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_consumidor_dependente_aud fk4b12ibfwkkgkfm22edo8wdgai; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_dependente_aud
    ADD CONSTRAINT fk4b12ibfwkkgkfm22edo8wdgai FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_plano_pagamento fk4ch2skbwle4gbhfxebevmrj8u; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_plano_pagamento
    ADD CONSTRAINT fk4ch2skbwle4gbhfxebevmrj8u FOREIGN KEY (id_produto) REFERENCES tvlar.t_produto(id_produto);


--
-- Name: t_contrato fk4jkmmjpclysi33fufydnme5pe; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT fk4jkmmjpclysi33fufydnme5pe FOREIGN KEY (id_estorno) REFERENCES tvlar.t_estorno(id_estorno);


--
-- Name: t_estabelecimento_contato fk4x8196gsav7cpq9j514h25yu2; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento_contato
    ADD CONSTRAINT fk4x8196gsav7cpq9j514h25yu2 FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_acordo_transacao fk523ha6qm2nx1wtgo4vijxg040; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_transacao
    ADD CONSTRAINT fk523ha6qm2nx1wtgo4vijxg040 FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_administradora_contato_aud fk56jwik9b97oexg7aledr3ifuv; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_contato_aud
    ADD CONSTRAINT fk56jwik9b97oexg7aledr3ifuv FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_classificador_aud fk581rnvldp9q322rtk7tgecdp1; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_classificador_aud
    ADD CONSTRAINT fk581rnvldp9q322rtk7tgecdp1 FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_pagamento fk5rf1vl977i6w9fojntolcf6ca; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento
    ADD CONSTRAINT fk5rf1vl977i6w9fojntolcf6ca FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_contrato fk5s60lfmg6nhfovftwtkskxwia; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT fk5s60lfmg6nhfovftwtkskxwia FOREIGN KEY (id_acordo) REFERENCES tvlar.t_acordo(id_acordo);


--
-- Name: t_contrato fk620fa5hoypn9wkk01c2epe400; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT fk620fa5hoypn9wkk01c2epe400 FOREIGN KEY (id_user_conclusao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_reversao_pagamento fk658fymxxedesthvmo0jgdhv4i; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento
    ADD CONSTRAINT fk658fymxxedesthvmo0jgdhv4i FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_boleto_transacao fk67f203y7lqtw5k5socq3q2sie; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto_transacao
    ADD CONSTRAINT fk67f203y7lqtw5k5socq3q2sie FOREIGN KEY (id_boleto) REFERENCES tvlar.t_boleto(id_boleto);


--
-- Name: t_boleto fk691evvb7172lqssc4v17gt6be; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto
    ADD CONSTRAINT fk691evvb7172lqssc4v17gt6be FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_acordo fk6c2xqncxrc94uia4vjw9ehx40; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo
    ADD CONSTRAINT fk6c2xqncxrc94uia4vjw9ehx40 FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_acordo_abatimento fk6egmq7wccww6sp27jaartg4qg; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_abatimento
    ADD CONSTRAINT fk6egmq7wccww6sp27jaartg4qg FOREIGN KEY (id_acordo_pagamento) REFERENCES tvlar.t_acordo_pagamento(id_acordo_pagamento);


--
-- Name: t_pagamento_item fk6wmruaqati0uil6730gtqqsc8; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento_item
    ADD CONSTRAINT fk6wmruaqati0uil6730gtqqsc8 FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_consumidor_telefone fk6yfu128p6t1ui6yxf9stcl1eo; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_telefone
    ADD CONSTRAINT fk6yfu128p6t1ui6yxf9stcl1eo FOREIGN KEY (id_conjuge) REFERENCES tvlar.t_consumidor_conjuge(id_consumidor_conjuge);


--
-- Name: t_pagamento_item fk71tve207g6c7vx5mld6ffuq9q; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento_item
    ADD CONSTRAINT fk71tve207g6c7vx5mld6ffuq9q FOREIGN KEY (id_pagamento) REFERENCES tvlar.t_pagamento(id_pagamento);


--
-- Name: t_reversao_pagamento fk77as6daxd5u5m4sm1nu1sj5n5; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento
    ADD CONSTRAINT fk77as6daxd5u5m4sm1nu1sj5n5 FOREIGN KEY (id_classificacao) REFERENCES tvlar.t_classificacao_reversao_pagamento(id_classificacao);


--
-- Name: t_plano_pagamento fk7fq8mcnft5qhrwsnmld64o2cr; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_plano_pagamento
    ADD CONSTRAINT fk7fq8mcnft5qhrwsnmld64o2cr FOREIGN KEY (id_classificador) REFERENCES tvlar.t_classificador(id_classificador);


--
-- Name: t_acordo_pagamento fk7hwd9uyg46yy2b79purqe00a3; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_pagamento
    ADD CONSTRAINT fk7hwd9uyg46yy2b79purqe00a3 FOREIGN KEY (id_acordo) REFERENCES tvlar.t_acordo(id_acordo);


--
-- Name: t_administradora_aud fk7jv4xfklwyf05850dctjdj5aj; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_aud
    ADD CONSTRAINT fk7jv4xfklwyf05850dctjdj5aj FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_cdc_historico fk7ncbhudy8mlnjttamaysfon44; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_historico
    ADD CONSTRAINT fk7ncbhudy8mlnjttamaysfon44 FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_acordo fk7shdla1y1uuq0uhr2q0wamj1d; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo
    ADD CONSTRAINT fk7shdla1y1uuq0uhr2q0wamj1d FOREIGN KEY (id_contrato) REFERENCES tvlar.t_contrato(id_contrato);


--
-- Name: t_transacao fk801olkju63ybwc95ywk6cr566; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_transacao
    ADD CONSTRAINT fk801olkju63ybwc95ywk6cr566 FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_funcionario_contato_aud fk83rs74653ixfd610e0ejoh6qj; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario_contato_aud
    ADD CONSTRAINT fk83rs74653ixfd610e0ejoh6qj FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_cdc_boleto fk8aqmgdhor61fpd7vovbmem2f0; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_boleto
    ADD CONSTRAINT fk8aqmgdhor61fpd7vovbmem2f0 FOREIGN KEY (id_boleto) REFERENCES tvlar.t_boleto(id_boleto);


--
-- Name: t_lancamento_ajuste fk8di308v8ds8qhqmquhi4w0aa2; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_lancamento_ajuste
    ADD CONSTRAINT fk8di308v8ds8qhqmquhi4w0aa2 FOREIGN KEY (id_tipo_lancamento_ajuste) REFERENCES tvlar.t_tipo_lancamento_ajuste(id_tipo_lancamento_ajuste);


--
-- Name: t_antecipacao_item fk8di308v8ds8qhqmquhi4w0aa2; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_antecipacao_item
    ADD CONSTRAINT fk8di308v8ds8qhqmquhi4w0aa2 FOREIGN KEY (id_antecipacao) REFERENCES tvlar.t_antecipacao(id_antecipacao);


--
-- Name: t_lancamento_ajuste fk8di308v8ds8qhqmquhi4w0aa3; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_lancamento_ajuste
    ADD CONSTRAINT fk8di308v8ds8qhqmquhi4w0aa3 FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_lancamento_ajuste fk8di308v8ds8qhqmquhi4w0aa4; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_lancamento_ajuste
    ADD CONSTRAINT fk8di308v8ds8qhqmquhi4w0aa4 FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_lancamento_ajuste fk8di308v8ds8qhqmquhi4w0aa5; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_lancamento_ajuste
    ADD CONSTRAINT fk8di308v8ds8qhqmquhi4w0aa5 FOREIGN KEY (id_user) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_lancamento_ajuste fk8di308v8ds8qhqmquhi4w0aa6; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_lancamento_ajuste
    ADD CONSTRAINT fk8di308v8ds8qhqmquhi4w0aa6 FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_reversao_pagamento_transacao fk8hugdoorqjaqju46a79tj0ry1; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento_transacao
    ADD CONSTRAINT fk8hugdoorqjaqju46a79tj0ry1 FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_user_profile fk8o9k3ovkw9yyuha1s059dn5g3; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_user_profile
    ADD CONSTRAINT fk8o9k3ovkw9yyuha1s059dn5g3 FOREIGN KEY (id_profile) REFERENCES tvlar.t_profile(id_profile);


--
-- Name: t_senior_log fk8xeq67cop3npqmjkb1oklvqu1; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_senior_log
    ADD CONSTRAINT fk8xeq67cop3npqmjkb1oklvqu1 FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_token_acesso fk90eg32ggwupby60bu1ikoakrt; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_token_acesso
    ADD CONSTRAINT fk90eg32ggwupby60bu1ikoakrt FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_remessa_contrato_parcela_historico fk95tgrk1eu5owf83rffkwtmg97; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa_contrato_parcela_historico
    ADD CONSTRAINT fk95tgrk1eu5owf83rffkwtmg97 FOREIGN KEY (id_remessa_contrato_parcela) REFERENCES tvlar.t_remessa_contrato_parcela(id_remessa_contrato_parcela);


--
-- Name: t_consumidor_conjuge fk9go9pnuii72fxiv6bwtiu23la; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_conjuge
    ADD CONSTRAINT fk9go9pnuii72fxiv6bwtiu23la FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_boleto_formato fk9omf9mtn003mik53da94henii; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto_formato
    ADD CONSTRAINT fk9omf9mtn003mik53da94henii FOREIGN KEY (id_boleto) REFERENCES tvlar.t_boleto(id_boleto);


--
-- Name: t_administradora_contato fk9yc38kigmh7jxj38qmtyf41dd; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_contato
    ADD CONSTRAINT fk9yc38kigmh7jxj38qmtyf41dd FOREIGN KEY (id_administradora) REFERENCES tvlar.t_administradora(id_administradora);


--
-- Name: t_produto_aud fk_produto_aud_rev; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_produto_aud
    ADD CONSTRAINT fk_produto_aud_rev FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_produto fk_produto_cartao_bin; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_produto
    ADD CONSTRAINT fk_produto_cartao_bin FOREIGN KEY (id_cartao_bin) REFERENCES tvlar.t_cartao_bin(id_cartao_bin);


--
-- Name: t_antecipacao_item fka2di308v8ds8qhqmquhi4w0aa2; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_antecipacao_item
    ADD CONSTRAINT fka2di308v8ds8qhqmquhi4w0aa2 FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_acordo_origem fka7xkcgn21j8123r59p3c1dbmb; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_origem
    ADD CONSTRAINT fka7xkcgn21j8123r59p3c1dbmb FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_contrato fkacat6ouj51pgqlbi3kycd7rth; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT fkacat6ouj51pgqlbi3kycd7rth FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_consumidor_referencia fkadlgkpk0gs46q1yly10s7kxkv; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_referencia
    ADD CONSTRAINT fkadlgkpk0gs46q1yly10s7kxkv FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_administradora_rede fkahuliec09le2x96yk0bvtfgxx; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_rede
    ADD CONSTRAINT fkahuliec09le2x96yk0bvtfgxx FOREIGN KEY (id_administradora) REFERENCES tvlar.t_administradora(id_administradora);


--
-- Name: t_estabelecimento fkaomj5hulph34d4ve76gsubly7; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento
    ADD CONSTRAINT fkaomj5hulph34d4ve76gsubly7 FOREIGN KEY (id_administradora_rede) REFERENCES tvlar.t_administradora_rede(id_administradora_rede);


--
-- Name: t_pagamento fkas9g71vyupqj2vsll3hhdklv6; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento
    ADD CONSTRAINT fkas9g71vyupqj2vsll3hhdklv6 FOREIGN KEY (id_user_conclusao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_acordo_transacao fkayhbjliwnlxdr0cafxf1722v7; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_transacao
    ADD CONSTRAINT fkayhbjliwnlxdr0cafxf1722v7 FOREIGN KEY (id_acordo) REFERENCES tvlar.t_acordo(id_acordo);


--
-- Name: t_consumidor_referencia_aud fkbed66u2u6kl0t11xpc7babjk3; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_referencia_aud
    ADD CONSTRAINT fkbed66u2u6kl0t11xpc7babjk3 FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_remessa_contrato_parcela fkbggaxirj1gxithijwacegbtbe; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa_contrato_parcela
    ADD CONSTRAINT fkbggaxirj1gxithijwacegbtbe FOREIGN KEY (id_remessa_contrato) REFERENCES tvlar.t_remessa_contrato(id_remessa_contrato);


--
-- Name: t_consumidor_socio_aud fkbxgw7j9ue8ck0i2dw25jrquae; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_socio_aud
    ADD CONSTRAINT fkbxgw7j9ue8ck0i2dw25jrquae FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_consumidor_telefone fkcaso44wrxhqvyceoqvm90gjc5; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_telefone
    ADD CONSTRAINT fkcaso44wrxhqvyceoqvm90gjc5 FOREIGN KEY (id_consumidor_socio) REFERENCES tvlar.t_consumidor_socio(id_consumidor_socio);


--
-- Name: t_pagamento fkcdrd6jwjaqsiw0ljwo6mmb254; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento
    ADD CONSTRAINT fkcdrd6jwjaqsiw0ljwo6mmb254 FOREIGN KEY (id_boleto) REFERENCES tvlar.t_boleto(id_boleto);


--
-- Name: t_estorno fkcj6e4fuw5tfaja0l0f2p37ppn; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno
    ADD CONSTRAINT fkcj6e4fuw5tfaja0l0f2p37ppn FOREIGN KEY (id_user_conclusao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_consumidor fkco229nvxoyk6ybhvtiknsm3gp; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor
    ADD CONSTRAINT fkco229nvxoyk6ybhvtiknsm3gp FOREIGN KEY (id_user) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_reversao_pagamento_item fkdeqp9bxcdny0g6sp21ojg4nri; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento_item
    ADD CONSTRAINT fkdeqp9bxcdny0g6sp21ojg4nri FOREIGN KEY (id_reversao_pagamento) REFERENCES tvlar.t_reversao_pagamento(id_reversao_pagamento);


--
-- Name: t_cartao_historico fkdjl15k6n2a73i5vxzag41ldp9; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_historico
    ADD CONSTRAINT fkdjl15k6n2a73i5vxzag41ldp9 FOREIGN KEY (id_cartao) REFERENCES tvlar.t_cartao(id_cartao);


--
-- Name: t_proposta fkdsjbglw0kq9w15672t9gq0w7a; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_proposta
    ADD CONSTRAINT fkdsjbglw0kq9w15672t9gq0w7a FOREIGN KEY (id_user) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_pagamento_transacao fke16jmwk8jo6efnr4o2i7f2u3v; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento_transacao
    ADD CONSTRAINT fke16jmwk8jo6efnr4o2i7f2u3v FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_administradora_contato fke2p6k1e3ttdv2ln53vc7315r4; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_contato
    ADD CONSTRAINT fke2p6k1e3ttdv2ln53vc7315r4 FOREIGN KEY (id_contato) REFERENCES tvlar.t_contato(idcontato);


--
-- Name: t_profile_role fkel09m7hwo7koggj98ux72dq5t; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_profile_role
    ADD CONSTRAINT fkel09m7hwo7koggj98ux72dq5t FOREIGN KEY (id_profile) REFERENCES tvlar.t_profile(id_profile);


--
-- Name: t_produto fkess0qph89734hsos5mwy5yj1y; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_produto
    ADD CONSTRAINT fkess0qph89734hsos5mwy5yj1y FOREIGN KEY (id_classificador) REFERENCES tvlar.t_classificador(id_classificador);


--
-- Name: t_consumidor_telefone_aud fkf3045hsvgn00rpmwerqcqp155; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_telefone_aud
    ADD CONSTRAINT fkf3045hsvgn00rpmwerqcqp155 FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_plano_pagamento_aud fkft6k6o09urakdr8lf0dfbj9kv; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_plano_pagamento_aud
    ADD CONSTRAINT fkft6k6o09urakdr8lf0dfbj9kv FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_funcionario fkg59guj9amq4i4l6ervai12v7b; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario
    ADD CONSTRAINT fkg59guj9amq4i4l6ervai12v7b FOREIGN KEY (id_user) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_funcionario fkgodwma27lvxg3ku2lujqfcm4e; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario
    ADD CONSTRAINT fkgodwma27lvxg3ku2lujqfcm4e FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_user_profile fkgt6ofkpc9u328prqk15pea2i6; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_user_profile
    ADD CONSTRAINT fkgt6ofkpc9u328prqk15pea2i6 FOREIGN KEY (id_user) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_contrato_transacao fkgypnv73ea84w88lmd8a9eagns; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato_transacao
    ADD CONSTRAINT fkgypnv73ea84w88lmd8a9eagns FOREIGN KEY (id_contrato) REFERENCES tvlar.t_contrato(id_contrato);


--
-- Name: t_funcionario_contato fkh4q3tl8gxvdmgkiidgp5m6fx9; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario_contato
    ADD CONSTRAINT fkh4q3tl8gxvdmgkiidgp5m6fx9 FOREIGN KEY (id_contato) REFERENCES tvlar.t_contato(idcontato);


--
-- Name: t_consumidor_conjuge_aud fkh9u2m6fj33wa0sip9ti09s8jv; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_conjuge_aud
    ADD CONSTRAINT fkh9u2m6fj33wa0sip9ti09s8jv FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_pagamento fkhd7bv12xhuejno2ohvatvacfo; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento
    ADD CONSTRAINT fkhd7bv12xhuejno2ohvatvacfo FOREIGN KEY (id_user_solicitacao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_consumidor_dependente fkhhbop3209vhwuhoqfi2ehkhk1; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_dependente
    ADD CONSTRAINT fkhhbop3209vhwuhoqfi2ehkhk1 FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_consumidor fkhhwndje01i7ldfccfo294y1jw; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor
    ADD CONSTRAINT fkhhwndje01i7ldfccfo294y1jw FOREIGN KEY (id_classificador) REFERENCES tvlar.t_classificador(id_classificador);


--
-- Name: t_profile_role fkhmcyj4vf6tn8yb4pn56op9ouj; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_profile_role
    ADD CONSTRAINT fkhmcyj4vf6tn8yb4pn56op9ouj FOREIGN KEY (id_role) REFERENCES tvlar.t_role(id_role);


--
-- Name: t_cartao fkhoq67b2t4d18a2ckdhj63kgr7; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao
    ADD CONSTRAINT fkhoq67b2t4d18a2ckdhj63kgr7 FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_estabelecimento fkit2vdlvamtp25caut3fa7it35; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estabelecimento
    ADD CONSTRAINT fkit2vdlvamtp25caut3fa7it35 FOREIGN KEY (id_endereco) REFERENCES tvlar.t_endereco(id_endereco);


--
-- Name: t_consumidor_socio fkjoi3duqdyt7edc4dfih2wvnty; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_socio
    ADD CONSTRAINT fkjoi3duqdyt7edc4dfih2wvnty FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_proposta fkjp3kxvetewjdg2mp74ha2bbwk; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_proposta
    ADD CONSTRAINT fkjp3kxvetewjdg2mp74ha2bbwk FOREIGN KEY (id_estabelecimento) REFERENCES tvlar.t_estabelecimento(id_estabelecimento);


--
-- Name: t_estorno fkk9u3hp4j5bx1knnqg8cr4wuhv; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno
    ADD CONSTRAINT fkk9u3hp4j5bx1knnqg8cr4wuhv FOREIGN KEY (id_pagamento) REFERENCES tvlar.t_pagamento(id_pagamento);


--
-- Name: t_plano_pagamento fkkcyvjifnlwfkqf595f273e80n; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_plano_pagamento
    ADD CONSTRAINT fkkcyvjifnlwfkqf595f273e80n FOREIGN KEY (id_administradora_rede) REFERENCES tvlar.t_administradora_rede(id_administradora_rede);


--
-- Name: t_boleto fkkd1md1npy99178bp60ff2yycb; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto
    ADD CONSTRAINT fkkd1md1npy99178bp60ff2yycb FOREIGN KEY (id_boleto_formato) REFERENCES tvlar.t_boleto_formato(id_boleto_formato);


--
-- Name: t_cdc_abatimento fkkghxvsqatynhyaxtxhl92tha6; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_abatimento
    ADD CONSTRAINT fkkghxvsqatynhyaxtxhl92tha6 FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_consumidor_telefone fkl0cnqg1n7jcsaxeeivujxh3yx; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_telefone
    ADD CONSTRAINT fkl0cnqg1n7jcsaxeeivujxh3yx FOREIGN KEY (id_consumidor_referencia) REFERENCES tvlar.t_consumidor_referencia(id_consumidor_referencia);


--
-- Name: t_estorno fklebtc6wlayxkcfleekc5t96wl; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno
    ADD CONSTRAINT fklebtc6wlayxkcfleekc5t96wl FOREIGN KEY (id_user_solicitacao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_reversao_pagamento_transacao fklo7ci5446lwwr7gcaby7dv1op; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento_transacao
    ADD CONSTRAINT fklo7ci5446lwwr7gcaby7dv1op FOREIGN KEY (id_reversao_pagamento) REFERENCES tvlar.t_reversao_pagamento(id_reversao_pagamento);


--
-- Name: t_cdc_boleto fklugf42uesfjf348sf1odrshwu; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_boleto
    ADD CONSTRAINT fklugf42uesfjf348sf1odrshwu FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_acordo_origem fkmfo8oe1by9r669twj1xut0x0x; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_origem
    ADD CONSTRAINT fkmfo8oe1by9r669twj1xut0x0x FOREIGN KEY (id_acordo) REFERENCES tvlar.t_acordo(id_acordo);


--
-- Name: t_estorno fkn21fnrjv1435w6wq7f7mf3ofk; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno
    ADD CONSTRAINT fkn21fnrjv1435w6wq7f7mf3ofk FOREIGN KEY (id_contrato) REFERENCES tvlar.t_contrato(id_contrato);


--
-- Name: t_acordo_parcela fkn44xuqf2ks87yhnt04q646qcv; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_parcela
    ADD CONSTRAINT fkn44xuqf2ks87yhnt04q646qcv FOREIGN KEY (id_acordo) REFERENCES tvlar.t_acordo(id_acordo);


--
-- Name: t_remessa fkn5dgep0cy3p8t0s37dmgfq1bk; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa
    ADD CONSTRAINT fkn5dgep0cy3p8t0s37dmgfq1bk FOREIGN KEY (id_informacao_banco) REFERENCES tvlar.t_informacao_banco(id_informacao_banco);


--
-- Name: t_acordo_parcela fknbhd2eum7iacing9lq52988uk; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_parcela
    ADD CONSTRAINT fknbhd2eum7iacing9lq52988uk FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_consumidor_telefone fknq17rknpch8ri5v6dwkdk3l3n; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_telefone
    ADD CONSTRAINT fknq17rknpch8ri5v6dwkdk3l3n FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_retorno_parcela fkntr1bq71o1mbd64hbni74ih6p; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_retorno_parcela
    ADD CONSTRAINT fkntr1bq71o1mbd64hbni74ih6p FOREIGN KEY (id_remessa_contrato_parcela) REFERENCES tvlar.t_remessa_contrato_parcela(id_remessa_contrato_parcela);


--
-- Name: t_proposta fko3nvchwm2thqy2xj1nyw4gvxr; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_proposta
    ADD CONSTRAINT fko3nvchwm2thqy2xj1nyw4gvxr FOREIGN KEY (id_produto) REFERENCES tvlar.t_produto(id_produto);


--
-- Name: t_contato_aud fkokju9yhd03u1rm2wlyk8cboa5; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contato_aud
    ADD CONSTRAINT fkokju9yhd03u1rm2wlyk8cboa5 FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_transacao fkolaler5e8jk2lgmwgl7ce9c9v; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_transacao
    ADD CONSTRAINT fkolaler5e8jk2lgmwgl7ce9c9v FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_estorno_transacao fkoo6098k1pb3ku9y1y84rponb3; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_estorno_transacao
    ADD CONSTRAINT fkoo6098k1pb3ku9y1y84rponb3 FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_feriado_aud fkoqdkr4iu0w7ojp2yvg9clbins; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_feriado_aud
    ADD CONSTRAINT fkoqdkr4iu0w7ojp2yvg9clbins FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_transacao fkp8g5gwkxgwrrgb4utn5aodjei; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_transacao
    ADD CONSTRAINT fkp8g5gwkxgwrrgb4utn5aodjei FOREIGN KEY (id_user) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_produto_aud fkpkpxeibnsmr1i738cmnlhanld; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_produto_aud
    ADD CONSTRAINT fkpkpxeibnsmr1i738cmnlhanld FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_boleto_transacao fkq0a7i5jn3j6eh9jbdkqlnmswa; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_boleto_transacao
    ADD CONSTRAINT fkq0a7i5jn3j6eh9jbdkqlnmswa FOREIGN KEY (id_transacao) REFERENCES tvlar.t_transacao(id_transacao);


--
-- Name: t_administradora_rede_aud fkq4rywct5scxh4ilcbgj731ji8; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_administradora_rede_aud
    ADD CONSTRAINT fkq4rywct5scxh4ilcbgj731ji8 FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_pagamento fkqehq8smhh1j5mqb3771nix23d; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento
    ADD CONSTRAINT fkqehq8smhh1j5mqb3771nix23d FOREIGN KEY (id_estorno) REFERENCES tvlar.t_estorno(id_estorno);


--
-- Name: t_cdc_historico fkqh9lo1v01646s08np2n3j0n8m; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cdc_historico
    ADD CONSTRAINT fkqh9lo1v01646s08np2n3j0n8m FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_remessa_contrato fkqmyhbd4r7uc3e6iasxhji3i7w; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_remessa_contrato
    ADD CONSTRAINT fkqmyhbd4r7uc3e6iasxhji3i7w FOREIGN KEY (id_remessa) REFERENCES tvlar.t_remessa(id_remessa);


--
-- Name: t_funcionario_contato fkqo6lo9grse3svt81dklr4c4dj; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_funcionario_contato
    ADD CONSTRAINT fkqo6lo9grse3svt81dklr4c4dj FOREIGN KEY (id_funcionario) REFERENCES tvlar.t_funcionario(id_funcionario);


--
-- Name: t_pagamento fkqqb0meijr8o45m82lvaa1mnqj; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento
    ADD CONSTRAINT fkqqb0meijr8o45m82lvaa1mnqj FOREIGN KEY (id_consumidor) REFERENCES tvlar.t_consumidor(id_consumidor);


--
-- Name: t_reversao_pagamento fkqr3wytvf80uit376lf02rpwt7; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento
    ADD CONSTRAINT fkqr3wytvf80uit376lf02rpwt7 FOREIGN KEY (id_user_criacao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_reversao_pagamento fkqwcrdi31d4k3ger8eq0c8gv94; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento
    ADD CONSTRAINT fkqwcrdi31d4k3ger8eq0c8gv94 FOREIGN KEY (id_user_autorizacao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_contrato fkroahydnmyv165i5xeejo1sji4; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_contrato
    ADD CONSTRAINT fkroahydnmyv165i5xeejo1sji4 FOREIGN KEY (id_user_solicitacao) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_pagamento_transacao fkstlxpkdvkchf2mn3feeie7x35; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_pagamento_transacao
    ADD CONSTRAINT fkstlxpkdvkchf2mn3feeie7x35 FOREIGN KEY (id_pagamento) REFERENCES tvlar.t_pagamento(id_pagamento);


--
-- Name: t_retorno_parcela fksup8u509lcrmgbckstipog7c6; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_retorno_parcela
    ADD CONSTRAINT fksup8u509lcrmgbckstipog7c6 FOREIGN KEY (id_retorno_cnab) REFERENCES tvlar.t_retorno_cnab(id_retorno_cnab);


--
-- Name: t_acordo_abatimento fksyl8nu9bnefvsqacg0hgdw962; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_acordo_abatimento
    ADD CONSTRAINT fksyl8nu9bnefvsqacg0hgdw962 FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_consumidor_aud fktdy3hgb0buavq0ry0vr6tysbw; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_consumidor_aud
    ADD CONSTRAINT fktdy3hgb0buavq0ry0vr6tysbw FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_reversao_pagamento_item fktm3jctx9e4379g6qx8kslmys6; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_reversao_pagamento_item
    ADD CONSTRAINT fktm3jctx9e4379g6qx8kslmys6 FOREIGN KEY (id_cdc) REFERENCES tvlar.t_cdc(id_cdc);


--
-- Name: t_cartao_historico fkudf94g8p7s30o1xnbch64jwq2; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_historico
    ADD CONSTRAINT fkudf94g8p7s30o1xnbch64jwq2 FOREIGN KEY (id_cartao_tipo_bloqueio) REFERENCES tvlar.t_cartao_tipo_bloqueio(id_cartao_tipo_bloqueio);


--
-- Name: t_cartao_historico fkvoq27b9l4d18u2ckdkj63kgr5; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_historico
    ADD CONSTRAINT fkvoq27b9l4d18u2ckdkj63kgr5 FOREIGN KEY (id_user) REFERENCES tvlar.t_user(id_user);


--
-- Name: t_cartao_tipo_bloqueio_aud t_cartao_tipo_bloqueio_aud_fkey; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_cartao_tipo_bloqueio_aud
    ADD CONSTRAINT t_cartao_tipo_bloqueio_aud_fkey FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- Name: t_tipo_lancamento_ajuste_aud t_tipo_lancamento_ajuste_aud_fkey; Type: FK CONSTRAINT; Schema: tvlar; Owner: postgres
--

ALTER TABLE ONLY tvlar.t_tipo_lancamento_ajuste_aud
    ADD CONSTRAINT t_tipo_lancamento_ajuste_aud_fkey FOREIGN KEY (rev) REFERENCES tvlar.revinfo(id);


--
-- PostgreSQL database dump complete
--


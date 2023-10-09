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
-- Name: btree_gin; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gin WITH SCHEMA public;


--
-- Name: EXTENSION btree_gin; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gin IS 'support for indexing common datatypes in GIN';


--
-- Name: btree_gist; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS btree_gist WITH SCHEMA public;


--
-- Name: EXTENSION btree_gist; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION btree_gist IS 'support for indexing common datatypes in GiST';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pg_search_dmetaphone(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.pg_search_dmetaphone(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$ SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\s+')))), ' ') $_$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: client_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_addresses (
    id bigint NOT NULL,
    client_id bigint NOT NULL,
    value character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: client_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.client_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: client_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.client_addresses_id_seq OWNED BY public.client_addresses.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    requests_per_hour integer DEFAULT 0 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    public_key text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: host_rules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.host_rules (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    allowed boolean DEFAULT false NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: host_rules_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.host_rules_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: host_rules_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.host_rules_id_seq OWNED BY public.host_rules.id;


--
-- Name: hosts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hosts (
    id bigint NOT NULL,
    scheme_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    last_crawled_at timestamp without time zone,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: hosts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hosts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hosts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hosts_id_seq OWNED BY public.hosts.id;


--
-- Name: htmls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.htmls (
    id bigint NOT NULL,
    page_id bigint NOT NULL,
    aasm_state character varying NOT NULL,
    content text,
    error text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: htmls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.htmls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: htmls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.htmls_id_seq OWNED BY public.htmls.id;


--
-- Name: page_crawls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.page_crawls (
    id bigint NOT NULL,
    page_id bigint NOT NULL,
    aasm_state character varying NOT NULL,
    error text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: page_crawls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.page_crawls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_crawls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.page_crawls_id_seq OWNED BY public.page_crawls.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pages (
    id bigint NOT NULL,
    query_id bigint NOT NULL,
    title character varying(255),
    blurb text,
    content text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pages_id_seq OWNED BY public.pages.id;


--
-- Name: paths; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.paths (
    id bigint NOT NULL,
    host_id bigint NOT NULL,
    value text NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: paths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.paths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: paths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.paths_id_seq OWNED BY public.paths.id;


--
-- Name: phrases; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.phrases (
    id bigint NOT NULL,
    text character varying(255) NOT NULL,
    length integer NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: phrases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.phrases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phrases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.phrases_id_seq OWNED BY public.phrases.id;


--
-- Name: queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.queries (
    id bigint NOT NULL,
    path_id bigint NOT NULL,
    value text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.queries_id_seq OWNED BY public.queries.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: schemes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schemes (
    id bigint NOT NULL,
    name character varying(8) NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: schemes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.schemes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: schemes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.schemes_id_seq OWNED BY public.schemes.id;


--
-- Name: server_addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.server_addresses (
    id bigint NOT NULL,
    server_id bigint NOT NULL,
    value character varying NOT NULL,
    active boolean DEFAULT true NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: server_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.server_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: server_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.server_addresses_id_seq OWNED BY public.server_addresses.id;


--
-- Name: servers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.servers (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    requests_per_hour integer DEFAULT 0 NOT NULL,
    active boolean DEFAULT true NOT NULL,
    public_key text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: servers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.servers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: servers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.servers_id_seq OWNED BY public.servers.id;


--
-- Name: urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.urls (
    id bigint NOT NULL,
    value character varying NOT NULL,
    aasm_state character varying NOT NULL,
    error text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.urls_id_seq OWNED BY public.urls.id;


--
-- Name: client_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_addresses ALTER COLUMN id SET DEFAULT nextval('public.client_addresses_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: host_rules id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.host_rules ALTER COLUMN id SET DEFAULT nextval('public.host_rules_id_seq'::regclass);


--
-- Name: hosts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hosts ALTER COLUMN id SET DEFAULT nextval('public.hosts_id_seq'::regclass);


--
-- Name: htmls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.htmls ALTER COLUMN id SET DEFAULT nextval('public.htmls_id_seq'::regclass);


--
-- Name: page_crawls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_crawls ALTER COLUMN id SET DEFAULT nextval('public.page_crawls_id_seq'::regclass);


--
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_id_seq'::regclass);


--
-- Name: paths id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paths ALTER COLUMN id SET DEFAULT nextval('public.paths_id_seq'::regclass);


--
-- Name: phrases id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phrases ALTER COLUMN id SET DEFAULT nextval('public.phrases_id_seq'::regclass);


--
-- Name: queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queries ALTER COLUMN id SET DEFAULT nextval('public.queries_id_seq'::regclass);


--
-- Name: schemes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schemes ALTER COLUMN id SET DEFAULT nextval('public.schemes_id_seq'::regclass);


--
-- Name: server_addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_addresses ALTER COLUMN id SET DEFAULT nextval('public.server_addresses_id_seq'::regclass);


--
-- Name: servers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers ALTER COLUMN id SET DEFAULT nextval('public.servers_id_seq'::regclass);


--
-- Name: urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls ALTER COLUMN id SET DEFAULT nextval('public.urls_id_seq'::regclass);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: client_addresses client_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_addresses
    ADD CONSTRAINT client_addresses_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: host_rules host_rules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.host_rules
    ADD CONSTRAINT host_rules_pkey PRIMARY KEY (id);


--
-- Name: hosts hosts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT hosts_pkey PRIMARY KEY (id);


--
-- Name: htmls htmls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.htmls
    ADD CONSTRAINT htmls_pkey PRIMARY KEY (id);


--
-- Name: page_crawls page_crawls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_crawls
    ADD CONSTRAINT page_crawls_pkey PRIMARY KEY (id);


--
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: paths paths_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paths
    ADD CONSTRAINT paths_pkey PRIMARY KEY (id);


--
-- Name: phrases phrases_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.phrases
    ADD CONSTRAINT phrases_pkey PRIMARY KEY (id);


--
-- Name: queries queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queries
    ADD CONSTRAINT queries_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: schemes schemes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schemes
    ADD CONSTRAINT schemes_pkey PRIMARY KEY (id);


--
-- Name: server_addresses server_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_addresses
    ADD CONSTRAINT server_addresses_pkey PRIMARY KEY (id);


--
-- Name: servers servers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.servers
    ADD CONSTRAINT servers_pkey PRIMARY KEY (id);


--
-- Name: urls urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.urls
    ADD CONSTRAINT urls_pkey PRIMARY KEY (id);


--
-- Name: index_client_addresses_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_client_addresses_on_client_id ON public.client_addresses USING btree (client_id);


--
-- Name: index_clients_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_clients_on_name ON public.clients USING btree (name);


--
-- Name: index_host_rules_on_allowed; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_host_rules_on_allowed ON public.host_rules USING btree (allowed);


--
-- Name: index_host_rules_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_host_rules_on_name ON public.host_rules USING btree (name);


--
-- Name: index_hosts_on_scheme_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hosts_on_scheme_id ON public.hosts USING btree (scheme_id);


--
-- Name: index_hosts_on_scheme_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_hosts_on_scheme_id_and_name ON public.hosts USING btree (scheme_id, name);


--
-- Name: index_htmls_on_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_htmls_on_page_id ON public.htmls USING btree (page_id);


--
-- Name: index_page_crawls_on_page_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_page_crawls_on_page_id ON public.page_crawls USING btree (page_id);


--
-- Name: index_pages_on_blurb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_blurb ON public.pages USING gin (blurb);


--
-- Name: index_pages_on_content; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_content ON public.pages USING gin (content);


--
-- Name: index_pages_on_query_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_query_id ON public.pages USING btree (query_id);


--
-- Name: index_pages_on_title; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pages_on_title ON public.pages USING gin (title);


--
-- Name: index_paths_on_host_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_paths_on_host_id ON public.paths USING btree (host_id);


--
-- Name: index_paths_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_paths_on_value ON public.paths USING btree (value);


--
-- Name: index_phrases_on_length; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_phrases_on_length ON public.phrases USING btree (length);


--
-- Name: index_phrases_on_text; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_phrases_on_text ON public.phrases USING btree (text);


--
-- Name: index_queries_on_path_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_queries_on_path_id ON public.queries USING btree (path_id);


--
-- Name: index_queries_on_path_id_and_value; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_queries_on_path_id_and_value ON public.queries USING btree (path_id, value);


--
-- Name: index_schemes_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_schemes_on_name ON public.schemes USING btree (name);


--
-- Name: index_server_addresses_on_server_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_server_addresses_on_server_id ON public.server_addresses USING btree (server_id);


--
-- Name: index_servers_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_servers_on_name ON public.servers USING btree (name);


--
-- Name: index_urls_on_aasm_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_urls_on_aasm_state ON public.urls USING btree (aasm_state);


--
-- Name: index_urls_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_urls_on_value ON public.urls USING btree (value);


--
-- Name: paths fk_rails_41644ce1bd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.paths
    ADD CONSTRAINT fk_rails_41644ce1bd FOREIGN KEY (host_id) REFERENCES public.hosts(id);


--
-- Name: hosts fk_rails_4e4ae6e069; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hosts
    ADD CONSTRAINT fk_rails_4e4ae6e069 FOREIGN KEY (scheme_id) REFERENCES public.schemes(id);


--
-- Name: server_addresses fk_rails_5c8ce9f6e9; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.server_addresses
    ADD CONSTRAINT fk_rails_5c8ce9f6e9 FOREIGN KEY (server_id) REFERENCES public.servers(id);


--
-- Name: page_crawls fk_rails_91681a3ed2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.page_crawls
    ADD CONSTRAINT fk_rails_91681a3ed2 FOREIGN KEY (page_id) REFERENCES public.pages(id);


--
-- Name: pages fk_rails_adcda8fdb2; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT fk_rails_adcda8fdb2 FOREIGN KEY (query_id) REFERENCES public.queries(id);


--
-- Name: queries fk_rails_bcab2453a5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.queries
    ADD CONSTRAINT fk_rails_bcab2453a5 FOREIGN KEY (path_id) REFERENCES public.paths(id);


--
-- Name: client_addresses fk_rails_d74f82be2c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_addresses
    ADD CONSTRAINT fk_rails_d74f82be2c FOREIGN KEY (client_id) REFERENCES public.clients(id);


--
-- Name: htmls fk_rails_db10f0ff12; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.htmls
    ADD CONSTRAINT fk_rails_db10f0ff12 FOREIGN KEY (page_id) REFERENCES public.pages(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('9'),
('8'),
('7'),
('6'),
('5'),
('4'),
('3'),
('2'),
('15'),
('14'),
('13'),
('12'),
('11'),
('10'),
('1');


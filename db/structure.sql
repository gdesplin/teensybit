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
-- Name: field_kind; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.field_kind AS ENUM (
    'string',
    'text',
    'check_boxes',
    'radio_buttons',
    'select_box',
    'file',
    'datetime',
    'date',
    'time'
);


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


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
-- Name: children; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.children (
    id bigint NOT NULL,
    name character varying,
    daycare_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    photo_url character varying
);


--
-- Name: children_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.children_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: children_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.children_id_seq OWNED BY public.children.id;


--
-- Name: children_pictures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.children_pictures (
    child_id bigint NOT NULL,
    picture_id bigint NOT NULL
);


--
-- Name: children_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.children_users (
    child_id bigint,
    user_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: contacts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contacts (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    notes text,
    message text,
    opt_in_emails boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    source integer
);


--
-- Name: contacts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contacts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contacts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contacts_id_seq OWNED BY public.contacts.id;


--
-- Name: daycares; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.daycares (
    id bigint NOT NULL,
    name character varying,
    user_id integer,
    address character varying,
    address_two character varying,
    city character varying,
    state character varying,
    zip character varying,
    phone character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: daycares_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.daycares_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: daycares_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.daycares_id_seq OWNED BY public.daycares.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    daycare_id bigint NOT NULL,
    title character varying,
    description character varying,
    public_to_daycare boolean,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: documents_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.documents_users (
    document_id bigint NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: entered_form_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entered_form_fields (
    id bigint NOT NULL,
    entered_form_id bigint NOT NULL,
    entered_string character varying,
    entered_text text,
    entered_datetime timestamp without time zone,
    entered_date date,
    entered_time time without time zone,
    form_field_option_id bigint,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: entered_form_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.entered_form_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entered_form_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.entered_form_fields_id_seq OWNED BY public.entered_form_fields.id;


--
-- Name: entered_forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.entered_forms (
    id bigint NOT NULL,
    form_id bigint NOT NULL,
    user_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: entered_forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.entered_forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: entered_forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.entered_forms_id_seq OWNED BY public.entered_forms.id;


--
-- Name: form_field_options; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.form_field_options (
    id bigint NOT NULL,
    name character varying,
    form_field_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: form_field_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.form_field_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: form_field_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.form_field_options_id_seq OWNED BY public.form_field_options.id;


--
-- Name: form_fields; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.form_fields (
    id bigint NOT NULL,
    form_id bigint NOT NULL,
    question character varying,
    description text,
    "order" integer,
    required boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    field_kind public.field_kind
);


--
-- Name: form_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.form_fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: form_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.form_fields_id_seq OWNED BY public.form_fields.id;


--
-- Name: forms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forms (
    id bigint NOT NULL,
    daycare_id bigint NOT NULL,
    title character varying,
    description text,
    published_to_daycare boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: forms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.forms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: forms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.forms_id_seq OWNED BY public.forms.id;


--
-- Name: forms_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.forms_users (
    form_id bigint NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: pictures; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pictures (
    id bigint NOT NULL,
    daycare_id bigint NOT NULL,
    title character varying,
    description character varying,
    user_id bigint NOT NULL,
    public_to_daycare boolean DEFAULT false,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: pictures_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pictures_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pictures_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pictures_id_seq OWNED BY public.pictures.id;


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    title character varying,
    body text,
    user_id integer,
    published boolean,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: stripe_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_accounts (
    id bigint NOT NULL,
    stripe_id character varying,
    country character varying,
    charges_enabled boolean,
    details_submitted boolean,
    daycare_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stripe_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_accounts_id_seq OWNED BY public.stripe_accounts.id;


--
-- Name: stripe_billing_portal_configurations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_billing_portal_configurations (
    id bigint NOT NULL,
    stripe_id character varying,
    stripe_account_id character varying,
    features jsonb,
    business_profile jsonb,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stripe_billing_portal_configurations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_billing_portal_configurations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_billing_portal_configurations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_billing_portal_configurations_id_seq OWNED BY public.stripe_billing_portal_configurations.id;


--
-- Name: stripe_customers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_customers (
    id bigint NOT NULL,
    stripe_id character varying,
    email character varying,
    name character varying,
    phone character varying,
    delinquent boolean,
    balance integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stripe_customers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_customers_id_seq OWNED BY public.stripe_customers.id;


--
-- Name: stripe_invoices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_invoices (
    id bigint NOT NULL,
    stripe_customer_id character varying,
    stripe_id character varying,
    hosted_invoice_url character varying,
    total_cents integer DEFAULT 0 NOT NULL,
    total_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    paid boolean,
    invoice_pdf character varying,
    collection_method character varying,
    stripe_subscription_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stripe_invoices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_invoices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_invoices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_invoices_id_seq OWNED BY public.stripe_invoices.id;


--
-- Name: stripe_payment_intents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_payment_intents (
    id bigint NOT NULL,
    amount_received_cents integer DEFAULT 0 NOT NULL,
    amount_received_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    stripe_invoice_id character varying,
    stripe_id character varying,
    stripe_customer_id character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stripe_payment_intents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_payment_intents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_payment_intents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_payment_intents_id_seq OWNED BY public.stripe_payment_intents.id;


--
-- Name: stripe_prices; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_prices (
    id bigint NOT NULL,
    stripe_id character varying,
    stripe_product_id character varying,
    active boolean,
    nickname character varying,
    recurring jsonb,
    kind integer,
    amount_cents integer DEFAULT 0 NOT NULL,
    amount_currency character varying DEFAULT 'USD'::character varying NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    user_id bigint
);


--
-- Name: stripe_prices_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_prices_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_prices_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_prices_id_seq OWNED BY public.stripe_prices.id;


--
-- Name: stripe_products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_products (
    id bigint NOT NULL,
    stripe_id character varying,
    name character varying,
    active boolean,
    description text,
    stripe_account_id text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: stripe_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_products_id_seq OWNED BY public.stripe_products.id;


--
-- Name: stripe_subscriptions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stripe_subscriptions (
    id bigint NOT NULL,
    stripe_customer_id character varying,
    stripe_id character varying,
    current_period_end timestamp without time zone,
    cancel_at_period_end boolean,
    current_period_start timestamp without time zone,
    canceled_at timestamp without time zone,
    ended_at timestamp without time zone,
    next_pending_invoice_item_invoice timestamp without time zone,
    pending_invoice_item_interval jsonb,
    trial_start timestamp without time zone,
    trial_end timestamp without time zone,
    status integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    stripe_price_id character varying
);


--
-- Name: stripe_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.stripe_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stripe_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.stripe_subscriptions_id_seq OWNED BY public.stripe_subscriptions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    failed_attempts integer DEFAULT 0 NOT NULL,
    unlock_token character varying,
    locked_at timestamp without time zone,
    name character varying,
    address character varying,
    address_two character varying,
    city character varying,
    state character varying,
    zip character varying,
    phone character varying,
    kind integer,
    admin boolean,
    daycare_id integer,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id bigint,
    invitations_count integer DEFAULT 0,
    stripe_customer_id character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: children id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.children ALTER COLUMN id SET DEFAULT nextval('public.children_id_seq'::regclass);


--
-- Name: contacts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts ALTER COLUMN id SET DEFAULT nextval('public.contacts_id_seq'::regclass);


--
-- Name: daycares id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daycares ALTER COLUMN id SET DEFAULT nextval('public.daycares_id_seq'::regclass);


--
-- Name: documents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: entered_form_fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entered_form_fields ALTER COLUMN id SET DEFAULT nextval('public.entered_form_fields_id_seq'::regclass);


--
-- Name: entered_forms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entered_forms ALTER COLUMN id SET DEFAULT nextval('public.entered_forms_id_seq'::regclass);


--
-- Name: form_field_options id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_field_options ALTER COLUMN id SET DEFAULT nextval('public.form_field_options_id_seq'::regclass);


--
-- Name: form_fields id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_fields ALTER COLUMN id SET DEFAULT nextval('public.form_fields_id_seq'::regclass);


--
-- Name: forms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forms ALTER COLUMN id SET DEFAULT nextval('public.forms_id_seq'::regclass);


--
-- Name: pictures id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pictures ALTER COLUMN id SET DEFAULT nextval('public.pictures_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: stripe_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_accounts ALTER COLUMN id SET DEFAULT nextval('public.stripe_accounts_id_seq'::regclass);


--
-- Name: stripe_billing_portal_configurations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_billing_portal_configurations ALTER COLUMN id SET DEFAULT nextval('public.stripe_billing_portal_configurations_id_seq'::regclass);


--
-- Name: stripe_customers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_customers ALTER COLUMN id SET DEFAULT nextval('public.stripe_customers_id_seq'::regclass);


--
-- Name: stripe_invoices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_invoices ALTER COLUMN id SET DEFAULT nextval('public.stripe_invoices_id_seq'::regclass);


--
-- Name: stripe_payment_intents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_payment_intents ALTER COLUMN id SET DEFAULT nextval('public.stripe_payment_intents_id_seq'::regclass);


--
-- Name: stripe_prices id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_prices ALTER COLUMN id SET DEFAULT nextval('public.stripe_prices_id_seq'::regclass);


--
-- Name: stripe_products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_products ALTER COLUMN id SET DEFAULT nextval('public.stripe_products_id_seq'::regclass);


--
-- Name: stripe_subscriptions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_subscriptions ALTER COLUMN id SET DEFAULT nextval('public.stripe_subscriptions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: children children_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.children
    ADD CONSTRAINT children_pkey PRIMARY KEY (id);


--
-- Name: contacts contacts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contacts
    ADD CONSTRAINT contacts_pkey PRIMARY KEY (id);


--
-- Name: daycares daycares_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.daycares
    ADD CONSTRAINT daycares_pkey PRIMARY KEY (id);


--
-- Name: documents documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: entered_form_fields entered_form_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entered_form_fields
    ADD CONSTRAINT entered_form_fields_pkey PRIMARY KEY (id);


--
-- Name: entered_forms entered_forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entered_forms
    ADD CONSTRAINT entered_forms_pkey PRIMARY KEY (id);


--
-- Name: form_field_options form_field_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_field_options
    ADD CONSTRAINT form_field_options_pkey PRIMARY KEY (id);


--
-- Name: form_fields form_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_fields
    ADD CONSTRAINT form_fields_pkey PRIMARY KEY (id);


--
-- Name: forms forms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forms
    ADD CONSTRAINT forms_pkey PRIMARY KEY (id);


--
-- Name: pictures pictures_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT pictures_pkey PRIMARY KEY (id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: stripe_accounts stripe_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_accounts
    ADD CONSTRAINT stripe_accounts_pkey PRIMARY KEY (id);


--
-- Name: stripe_billing_portal_configurations stripe_billing_portal_configurations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_billing_portal_configurations
    ADD CONSTRAINT stripe_billing_portal_configurations_pkey PRIMARY KEY (id);


--
-- Name: stripe_customers stripe_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_customers
    ADD CONSTRAINT stripe_customers_pkey PRIMARY KEY (id);


--
-- Name: stripe_invoices stripe_invoices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_invoices
    ADD CONSTRAINT stripe_invoices_pkey PRIMARY KEY (id);


--
-- Name: stripe_payment_intents stripe_payment_intents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_payment_intents
    ADD CONSTRAINT stripe_payment_intents_pkey PRIMARY KEY (id);


--
-- Name: stripe_prices stripe_prices_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_prices
    ADD CONSTRAINT stripe_prices_pkey PRIMARY KEY (id);


--
-- Name: stripe_products stripe_products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_products
    ADD CONSTRAINT stripe_products_pkey PRIMARY KEY (id);


--
-- Name: stripe_subscriptions stripe_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stripe_subscriptions
    ADD CONSTRAINT stripe_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_children_pictures_on_child_id_and_picture_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_children_pictures_on_child_id_and_picture_id ON public.children_pictures USING btree (child_id, picture_id);


--
-- Name: index_children_users_on_child_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_children_users_on_child_id ON public.children_users USING btree (child_id);


--
-- Name: index_children_users_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_children_users_on_user_id ON public.children_users USING btree (user_id);


--
-- Name: index_documents_on_daycare_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_daycare_id ON public.documents USING btree (daycare_id);


--
-- Name: index_documents_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_documents_on_user_id ON public.documents USING btree (user_id);


--
-- Name: index_documents_users_on_document_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_documents_users_on_document_id_and_user_id ON public.documents_users USING btree (document_id, user_id);


--
-- Name: index_entered_form_fields_on_entered_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entered_form_fields_on_entered_form_id ON public.entered_form_fields USING btree (entered_form_id);


--
-- Name: index_entered_form_fields_on_form_field_option_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entered_form_fields_on_form_field_option_id ON public.entered_form_fields USING btree (form_field_option_id);


--
-- Name: index_entered_forms_on_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entered_forms_on_form_id ON public.entered_forms USING btree (form_id);


--
-- Name: index_entered_forms_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_entered_forms_on_user_id ON public.entered_forms USING btree (user_id);


--
-- Name: index_form_field_options_on_form_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_form_field_options_on_form_field_id ON public.form_field_options USING btree (form_field_id);


--
-- Name: index_form_field_options_on_name_and_form_field_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_form_field_options_on_name_and_form_field_id ON public.form_field_options USING btree (name, form_field_id);


--
-- Name: index_form_fields_on_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_form_fields_on_form_id ON public.form_fields USING btree (form_id);


--
-- Name: index_form_fields_on_order_and_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_form_fields_on_order_and_form_id ON public.form_fields USING btree ("order", form_id);


--
-- Name: index_form_fields_on_question_and_form_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_form_fields_on_question_and_form_id ON public.form_fields USING btree (question, form_id);


--
-- Name: index_forms_on_daycare_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_forms_on_daycare_id ON public.forms USING btree (daycare_id);


--
-- Name: index_forms_on_daycare_id_and_title; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_forms_on_daycare_id_and_title ON public.forms USING btree (daycare_id, title);


--
-- Name: index_forms_users_on_form_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_forms_users_on_form_id_and_user_id ON public.forms_users USING btree (form_id, user_id);


--
-- Name: index_pictures_on_daycare_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pictures_on_daycare_id ON public.pictures USING btree (daycare_id);


--
-- Name: index_pictures_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pictures_on_user_id ON public.pictures USING btree (user_id);


--
-- Name: index_stripe_accounts_on_daycare_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_accounts_on_daycare_id ON public.stripe_accounts USING btree (daycare_id);


--
-- Name: index_stripe_accounts_on_stripe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_accounts_on_stripe_id ON public.stripe_accounts USING btree (stripe_id);


--
-- Name: index_stripe_customers_on_stripe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_customers_on_stripe_id ON public.stripe_customers USING btree (stripe_id);


--
-- Name: index_stripe_invoices_on_stripe_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_invoices_on_stripe_customer_id ON public.stripe_invoices USING btree (stripe_customer_id);


--
-- Name: index_stripe_invoices_on_stripe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_invoices_on_stripe_id ON public.stripe_invoices USING btree (stripe_id);


--
-- Name: index_stripe_invoices_on_stripe_subscription_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_invoices_on_stripe_subscription_id ON public.stripe_invoices USING btree (stripe_subscription_id);


--
-- Name: index_stripe_payment_intents_on_stripe_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_payment_intents_on_stripe_customer_id ON public.stripe_payment_intents USING btree (stripe_customer_id);


--
-- Name: index_stripe_payment_intents_on_stripe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_payment_intents_on_stripe_id ON public.stripe_payment_intents USING btree (stripe_id);


--
-- Name: index_stripe_payment_intents_on_stripe_invoice_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_payment_intents_on_stripe_invoice_id ON public.stripe_payment_intents USING btree (stripe_invoice_id);


--
-- Name: index_stripe_prices_on_stripe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_prices_on_stripe_id ON public.stripe_prices USING btree (stripe_id);


--
-- Name: index_stripe_prices_on_stripe_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_prices_on_stripe_product_id ON public.stripe_prices USING btree (stripe_product_id);


--
-- Name: index_stripe_prices_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_prices_on_user_id ON public.stripe_prices USING btree (user_id);


--
-- Name: index_stripe_products_on_stripe_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_products_on_stripe_account_id ON public.stripe_products USING btree (stripe_account_id);


--
-- Name: index_stripe_products_on_stripe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_products_on_stripe_id ON public.stripe_products USING btree (stripe_id);


--
-- Name: index_stripe_subscriptions_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_subscriptions_on_status ON public.stripe_subscriptions USING btree (status);


--
-- Name: index_stripe_subscriptions_on_stripe_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_subscriptions_on_stripe_customer_id ON public.stripe_subscriptions USING btree (stripe_customer_id);


--
-- Name: index_stripe_subscriptions_on_stripe_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_stripe_subscriptions_on_stripe_id ON public.stripe_subscriptions USING btree (stripe_id);


--
-- Name: index_users_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_confirmation_token ON public.users USING btree (confirmation_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invited_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by ON public.users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_users_on_stripe_customer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_stripe_customer_id ON public.users USING btree (stripe_customer_id);


--
-- Name: index_users_on_unlock_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_unlock_token ON public.users USING btree (unlock_token);


--
-- Name: form_field_options fk_rails_076deed05f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_field_options
    ADD CONSTRAINT fk_rails_076deed05f FOREIGN KEY (form_field_id) REFERENCES public.form_fields(id);


--
-- Name: entered_forms fk_rails_0a9dee7691; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entered_forms
    ADD CONSTRAINT fk_rails_0a9dee7691 FOREIGN KEY (form_id) REFERENCES public.forms(id);


--
-- Name: form_fields fk_rails_28fb260032; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.form_fields
    ADD CONSTRAINT fk_rails_28fb260032 FOREIGN KEY (form_id) REFERENCES public.forms(id);


--
-- Name: documents fk_rails_2be0318c46; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_2be0318c46 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: pictures fk_rails_3268570edc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT fk_rails_3268570edc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: entered_form_fields fk_rails_482373e950; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entered_form_fields
    ADD CONSTRAINT fk_rails_482373e950 FOREIGN KEY (entered_form_id) REFERENCES public.entered_forms(id);


--
-- Name: documents fk_rails_4b97d54b1b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT fk_rails_4b97d54b1b FOREIGN KEY (daycare_id) REFERENCES public.daycares(id);


--
-- Name: pictures fk_rails_6b5626d271; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pictures
    ADD CONSTRAINT fk_rails_6b5626d271 FOREIGN KEY (daycare_id) REFERENCES public.daycares(id);


--
-- Name: entered_forms fk_rails_7fbaa21348; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.entered_forms
    ADD CONSTRAINT fk_rails_7fbaa21348 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: forms fk_rails_e450f46f9a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.forms
    ADD CONSTRAINT fk_rails_e450f46f9a FOREIGN KEY (daycare_id) REFERENCES public.daycares(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20210115155931'),
('20210115160130'),
('20210304153317'),
('20210823220801'),
('20210824035606'),
('20210826032859'),
('20210826193451'),
('20210826194049'),
('20210827210423'),
('20210902025310'),
('20210902030408'),
('20210902031612'),
('20210902214602'),
('20210915024044'),
('20210916030217'),
('20210917165245'),
('20210929205459'),
('20210930184237'),
('20211008172242'),
('20211014205903'),
('20211014221359'),
('20211015162125'),
('20211019205155'),
('20211019211809'),
('20211021203345'),
('20211021203611'),
('20211029152808'),
('20211102162343'),
('20211102162421'),
('20211102162458'),
('20211102162953'),
('20211104214849');



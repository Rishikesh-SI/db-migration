-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecules
-- Type: TABLE

-- Name: molecules; Type: TABLE; Schema: lb_wf; Owner: -
--

CREATE TABLE lb_wf.molecules (
    id integer NOT NULL,
    json_id uuid NOT NULL,
    name text NOT NULL,
    properties jsonb NOT NULL,
    styles jsonb NOT NULL,
    additional_config jsonb DEFAULT '{}'::jsonb,
    token_overrides jsonb DEFAULT '{}'::jsonb,
    is_deleted boolean DEFAULT false,
    created_by uuid NOT NULL,
    created_at timestamp without time zone DEFAULT now(),
    updated_by uuid NOT NULL,
    updated_at timestamp without time zone DEFAULT now(),
    deleted_by uuid,
    deleted_at timestamp without time zone
);


--

-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: type_draft_enti
-- Type: TYPE

-- Name: type_draft_enti; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.type_draft_enti AS (
	priority numeric,
	is_visible numeric,
	entity_role_map_id numeric,
	name character varying(200),
	is_linkable numeric
);


--

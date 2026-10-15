-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecule_atom_map
-- Type: TABLE

-- Name: molecule_atom_map; Type: TABLE; Schema: lb_wf; Owner: -
--

CREATE TABLE lb_wf.molecule_atom_map (
    id integer NOT NULL,
    molecule_json_id uuid NOT NULL,
    atom_json_id uuid NOT NULL,
    atom_name text NOT NULL,
    visibility boolean DEFAULT true,
    order_id integer DEFAULT 0
);


--
